/*@Start***********************************************************/
/* spiral sequence.
 *   s2.e 11/9/92   cleaned up @rsp of spiral.e, in order to add movies.
 *   s3.e 11/17/92  added map making.
 *   s4.e 11/27/92  added auto-prescan (from gaw's bl9.e).
 *   s5.e 11/27/92  flow-comped spin-echo sequence.
 *   s6.e 11/30/92  put flow-comp lobe on right side of 180.
 *                  fixed numerous things.  s1-s5.e are now out of date.
 *                  turned on "Gradient Echo" plasma option.
 *                  added fastrecon switch and passthrough filter
 *                  (with > 1 ms increase in "gradient-echo TE").
 *                  added option for longer, minimum-phase pulse.
 *         1/11/93  Changed the plasma around quite a bit.
 *                  Added small-FOV gradients for surface- and head-coil scans.
 *                  Fixed nextra so that physics setup time is either
 *                  3 heartbeats (cardiac gating) or 1.5 seconds.
 *         1/19/93  Revamped cardiac gating to fix bugs and add features.
 *         2/17/93  Added empirical rf1 amplitude fudge factor of 1.4.
 *   s7.e  2/23/93  Added support for Kevin King's tardis routine.
 *                  Got rid of "correct" setting of xres and yres,
 *                  because they need to be 256.  Turned off fids.
 *                  Still calculates gres, but doesn't currently use it.
 *                  Added slice stepping and slice offset.
 *                  Wired up tdel button.
 *   s8.e  3/18/93  Changed to fast, 127-tap filter for short TR's.
 *                  Removed fastrecon cv.  Added fastfilt cv.
 *   sf1.e 4/18/93  Beginnings of a 5.X fluoro/activation sequence.
 *                  Cut down to one gradient set (20-cm, 20-interleaves).
 *                  Kissed off the maps.  Allowed consecutive images
 *                  using nframes.  Removed ncviews stuff.  Changed
 *                  to sf1.*.in parameter file.
 *   C. Meyer, 1992, 1993
 *
 *   sf3.e adding spatial sat pulse and multislice D.M.S
 *   2/22/94 adding multiple gradient sets, DMS
 *   4/20/94 adding fastfilt for shorter tr
 *
 *	sg4.e	3/95	ghg	it does the te and tr right
 *	sg5.e	4/7/95	ghg	relax the 256 image limit by using echoes
 *	     	4/15/95	ghg	add rf spoiling
 *	sg6.e	5/1/95	ghg	add b0 map as first echo shift
 *	sg7.e	5/14/95	ghg	add autoshim
 *	sg8.e	6/9/95	ghg	rf pulse is a sinc2
 *		7/3/95		can do spin echo, sinc1.
 *	sg9.e	7/4/95	ghg	uses sg* gradients.
 *		7/12/95		selects between 20 and 32 cm fov waves
 *		8/9/95		fix create image bug, no longer allocates
 *				can start sequence by aux trig
 *    sprl501	9/29/95	ghg	First shot at 5.5 version
 *    sprl502	10/27/95	fix prescan to chop
 *    sprl503	11/17/95	fix gram duty cycle calc for cardiac
 *    sprl504	11/18/95	fix triggering for gating and aux
 *    sprl505	12/10/95	use filter_gen
 *    sprl507	2/2/96		use fast receiver.  All data is in
 *				single slice
 *    sprl508	2/8/96		back to usual multislice data set
 *    sprl509	3/20/96		add ext trig opuser
 *		4/16/96		add data store opuser
 *    sprl510	7/17/96		move scalerotmats to inner loop
 *    sprl511	11/24/96	new data format: 1 echo, all data in rhnframes
 *   				add support for grev != 5
 *    sprl512	12/18/96	add grev user cv
 *    sprl513	5/23/97		support for grad waves with higher dutycycle
 *		7/16/97		remove artifical limit on nframes
 *    sprl514	2/2/98		support for grev 7
 *		3/25/98		don't do B0 mapping if spin echo
 *    sprl801	5/9/98		first LX version
 *    sprl803	8/23/98		gradient files contain a little hdr at end
 *				to give res_gx, tsp, etc.
 *		9/4/98		for CV1 version, can use setfilter.c with
 *				last argument changed
 *    sprl804	10/1/98		add fast_rec init code for prescan and
*				scan with boffset
*    sprl805	10/26/98	does concat acquisition if rhfrsize >8K
*    sprl806	10/30/98	puts second acq in next view, rather
*				than echo
*    sprl808	1/18/99		put spoilers on the readout axes to
*				fix the hardware hysteresis prob
*    sprl809	1/23/99		real time spiral gen
*    sprl810	2/27/99		add filter delay stuff
*    sprl811	3/3/99		save grad rotator for maxwell correction
*    sprl812	3/31/99		try to get clock to start with aux_trig
*                              also fix aps2 for doconcat
*		4/13/99		ihtr = optr to get the raw header right
*    sprl813	5/8/99		allow slice clustering, remove
*				non-interleave option
*		10/8/99		fix gslew problem
*		10/23/99	rationalize params vs gradients
*		1/20/00		install capability for TTL output pulse
*				on CAP board, J10
*    sprl816	3/10/00		variable bandwidth
*				also remove recon size cv
*    sprl830	5/27/00		make 8.3 version
*				add nextra opuser
*    sprl831	7/27/00		eliminate concat acq because rhfrsize works
*    		8/5/00		put in RT hooks (scancore)
*    		8/14/00		make slow receiver prescan work
*    sprl832	10/14/00	allow new ext trig mode 2
*    sprlio832	10/22/00	spiral out, in, combiner
*    sprlio834 2/10/01         install bmapnav: don't move dacq for first frame
*		12/30/01	don't use bmapnav if gtype != 0
*    sprlio835 5/28/02         put in ss rf pulse
*    sprlio836 7/5/02         	fix prephaser sinusoid amplitude
*		7/15/02		trap over-range in phase for ss pulse
*    sprlio837 7/16/02         make an error message for trap in host
*		8/6/02		add check for rawsize vs cftpssize
*    sprlio838 8/7/02          play out ss pulse on theta board by
*				integrating the frequency offsets
*		8/12/02		remove the nex button
*    sprlio839 9/4/02          fix bug in aps2 for gtype=2
*    sprlio840 9/15/02         add code to switch ACGD transition mode
*              9/23/02         move acgd stuff to prescan
*              11/13/02        acgd_tr = 50ms + 0.036 ms/image
*    sprlio841 11/24/02        use fat sat instead of ss pulse
*		3/21/03		add code to discriminate daqdeloff
*				based on gradient type
*              3/25/03         piimages = 0 to not allocate images
*    sprlio843 11/25/03        make bmapnav work for gtype = 2-
*				move only the spiral-out for first frame
*    sprlio1043 11/25/03       first 10-11x version
*	  	 1/27/04        add opuser to control physio acquisition
*    sprlio1045 9/26/04        offset receiver FOV: search thetrec
*    sprlio1146 1/29/05        add GP3 Gradient mode control
*		 2/23/05	fix a little bug in daqdeloff switch
*		 3/19/05	make optr, ihtr max 24s
*
*    sprlio1246 4/29/05        12.0 version- remove GP3 include and physio
*				cv- included in epic.h
*		 5/5/05		remove numrec from rhrawsize
*		 10/23/05	allow smaller bandwidths
*    sprlio1247 11/14/05       make pw_rf1 9ms if opslthick < 1 mm
*                              This allows thinner slices (600 um).
*               12/18/05       fixed phys_record_flag to work (prescan inline
		*                              was setting it to 0).
*               1/8/06      	Added realtime opuser cv
*    sprlio1248 5/25/06        put in rcvr delay = tsp/2 us.
*    sprlio1249 8/23/06        tighten up tmin timing calc: tlead, psd_rf_wait
*               1/4/08         zone_cntl = 0
*    sprlio1250 1/12/08        check rawsize to exceed 2^31.
*    sprlio2050 2/21/08        make 20x version- don't check rawsize, remove
*				zone control
*    sprlio2051 3/29/08        redo the spoilers to avoid PNS.  Not used if nl=1.
*		 4/5/08		fix bmapnav = 0 (add maps3)
*    sprlio2053 5/11/08        don't do phys record except in scan() entry
*		 7/1/08		add file trig mode- start scan on StartScan exists (opuser2)
*		 8/13/08	add physiochansel CV to select only PPGTrig and RESPData
*               9/6/08         in realtime mode, put wait at end for recon to finish
*               12/19/08       drop slew rate to 150 (sigh)
*    sprlio2054 12/21/08       make obl_method = 1 to shorten ramps
*    sprlio2055 2/23/09        read optional daqdel.off file
*    sprlio2056 3/22/09        set prescan filter to same as scan
*		 3/27/09	add little delay for cluster to deadtime
*    sprlio2057 4/13/09        make prescan filter with oprbw bw, but length psfrsize
*    sprlio2058 7/21/09        20M4- remove phys_record_shannelsel as c
*               8/7/09         make clock run for ext trig = 2
*    sprlio2059 11/5/09        limit time for disdaqs to 6 sec in prescan
*    sprlio2060 11/11/09       change cyc_rf1 to 4  (and a_rf1)
*    sprlio2062 4/4/10        	now fix the quantization error in optr/opslquant
*    sprlio2063 9/3/10        	recompile with Prescan.e that eliminates
*				the noise cal crusher (replaces with wait)
*				add opuser12 to allow short rf1 pulse
*    sprlio2263 11/8/10        for 22x add }; after PSeplist inline
*    sprlio2264 12/1/10        add slice loc phase correction
*    sprlio2265 8/1/11         add variable density code from catie
*		 10/6/11	fix clustered acquisition- add 452us to tmin
*    sprlio2266 12/10/11       add sequential slice order mode
*
*
* (c) Board of Trustees, Leland Stanford Junior University 1993-2011.
*      Gary H. Glover
*
*    pcasl3d06	6/28/12		Using Stanford spiral as the base for importing PCASL sequence
*				from the Signa into the MR750 platform
*				real time support
*				3D acquitision
*    pcasl3d07	12/15/12	Adding two Background suppression pulses during the post inversion delay
* 				and one before labeling
*    pcasl3d08 6/11/13		turning BS off during early time points to get M0 maps and better
*				selection of R1 and R2 gains
*
*    pcasl3d09			this one included the SPINS (or nautilus) readout
*
*    pcasl3d10   1/29/16	back to stack of spirals (derived from pcasl3d08).  implementing
*         			GRAPPA in the kz direction only.
*
*   vsiasl3d03.e 9/27/16	major change:  replacing PCASL train with VSAI pulses
*				these are read externally from text files.
*				essentially merging pcasl3d10 and vsiasl2d05.
*
*   vsiasl3d05.e  11/29/18	major change:  making the stack of spirals in a RARE (3DGRASE)
*				acquistion.  90 - 180 - spiral -180 - spiral ...
*
*   vsasl3dflex01  11/4/19	major change:  making flexible timing fo MRF acquision
*
*   vsasl3dflex02  3/18/20	major change:  Now uses a spiral-in/spiral-out centered on the spin echo
*
*   vsasl3dflex02  5/22/20	major change:  Now uses a ROTATING  spiral-in/spiral-out centered on the spin echo
*
*   vsasl3dflex04 8/20/21	major change:  implementation of fast spin echo rotating in-out spiral
*				retain MRF capability, VSI pulses, background suppression
*				can be used for RF power calibration on the VS preparation pulses
*/
/*@End*************************************************************/

@inline epic.h
@inline intwave2.h

@global
#include <stdio.h>
#include <string.h>

#include "em_psd_ermes.in"
#include "epicconf.h"
#include "epicfuns.h"
#include "epic_error.h"
#include "filter.h"
#include "psd_proto.h"
#include "pulsegen.h"
#include "stddef_ep.h"
#include "epic_loadcvs.h"
#include "InitAdvisories.h"

#include "grad_rf_sprlio.globals.h"

/*#define GRESMAX       21000     /* number of points grad max */
#define GRESMAX       	50000     /* number of points grad max */
#define MAXNUMECHOES	1000	/* number of echoes max */
#define RES_GRAMP       100     /* number of points grad rampdown  */
#define TSP             2.0us   /* slow rcvr sampling 500kHz */
#define MAX_BW		250
#define IRINT(f) ((((f)-(int)(f)) < 0.5) ? ((int) (f)) : (1+(int)(f)))

	/*-------------------------------------------------------------*/
	/* LHG define constants for spin labeling version */

#define GAMMA_H1 26754          /* in (rad/s)/Gauss */
#define LHG_DEBUG 1
	/*-------------------------------------------------------------*/


@inline Prescan.e PSglobal

@cv
@inline loadrheader.e rheadercv
@inline Prescan.e PScvs

int debug = 1 with {0,1,0,INVIS,"1 if debug is on ",};
int nl = 1 with {1,128,,,"number of interleaves",}; /* number of interleaves */
int scluster = 0 with {0,1,,,"1=cluster slices together in time, 0=not",};
int nextra = 2 with {0,,,,"number of disdaqs",};
int nframes = 1 with {1,,,,"number of time frames",};
int total_views;	/*  total shots to gather per slice */
int gating = TRIG_INTERN with {,,,,"1=line,3=ecg,5=aux,7=intern,9=nline",};
int psdseqtime;     /* sequence repetition time */

int t_tipdown_core;	/*time it takes to play out the 90 core */
int t_refocus_core;	/*time it takes to play out the 180 core: spoilers and 180 */
int t_seqcore; 	/* time it takes to play the readout only  */

/* int timessi=400us with {0,,400us,INVIS,"time from eos to ssi in intern trig",};*/
int timessi=120us with {0,,400us,INVIS,"time from eos to ssi in intern trig",};
int trerror;		/* error in TR total */
int nerror;		/* num slices  to take up the TR error */
int gtype = 0 with {0,99,1,VIS, "trajectory: (0) spiral out, (1) spiral in, (2) both",};
/* float gslew = 150.0 with {0.0,3000.0,1,VIS, "readout gradient max slew, mT/m/ms",};  */
float gslew = 150.0 with {0.0,3000.0,1,VIS, "readout gradient max slew, mT/m/ms",};
float gamp = 2.3 with {0.0,50.0,1,VIS, "readout gradient max amp",};
float gfov = 24.0 with {0.0,100.0,1,VIS, "readout gradient design FOV, cm",};
int gres = 0 with {0,32768,1,VIS, "gradient waveform resolution",};
float gmax = 2.4 with {0.0,10.0,1,VIS, "bw-limited readout gradient amp",};
float rtimescale = 2.1 with {0.1,10.0,1,VIS, "grad risetime scale relative to cfsrmode",};
int nramp = RES_GRAMP with {0,4096,1,VIS, "spiral gradient ramp res",};
float agxpre = 0.;      /* calculated x dephasing amplitude for spiral in-out */
float agypre = 0.;      /* calculated y dephasing amplitude for spiral in-out */
float areax = 0;
float areay = 0;
float prefudge = 1.004 with {0.0,2.0,1,VIS, "prephaser fudge fac ",};
int pwgpre = 1ms;       /* calculated dephasing width for spiral in-out */
int tadmax;     /* maximum readout duration  */
int tlead = 160;      /* initial lead time for rf pulse prep*/
float daqdeloff = 0.0us; /* fudge factor, tuned at SRI  */
int daqdel = 128us; /*  gradient delay vs readout */
int thetdeloff = 0us;
int espace = 140us with {0,,1,VIS, "space between echoes",};
int readpos;        /* position of readout gradients, based on oppseq */
int daqpos;        /* position of readout window, based on oppseq */
int minte;
int seqtr = 0 with {0,,1,VIS, "total time to play seq",};
int endtime = 500ms with {0,,,,"time at end of seq in rt mode",};

int vdflag = 0 with {0,1,,VIS, "variable-density flag",};
float alpha = 3.6 with {1.01,200,,VIS, "variable-density parameter alpha",};
float kmaxfrac = 0.5 with {0.05,0.95,,VIS, "fraction of kmax to switch from constant to variable density spiral",};

int slord;

float satBW = 440.0 with {0.0,10000.0,1,VIS, "sat bw, Hz",};
float satoff = -520.0 with {-10000.0,1000.0,1,VIS, "sat center freq, Hz",};
int pwrf0;
float arf0;
int 	fuzz, fatsattime;

int pwrf1 = 6400us;
int cycrf1 = 4;

int pwrf2 = 6400us;
int cycrf2 = 4;

double myflip_rf2 = 180;
double start_rf2 = 120;
float  phs_rf2 =  1.5708; /* the units for setphase() are in radians*/

int domap = 1 with {0,2,1,VIS, "1=do B0 map & recon, 2 = only do B0 map",};
int mapdel = 2ms;   /* variable delay for field map */
int bmapnav = 1 with {0,1,1,VIS, "1=do nav cor for bmap",};

int off_fov = 1 with {0,1,1,VIS, "1 for rcvr offset fov, 0 for fftshift",};

float tsp = 4.0us with {1.0,12.75,,, "A/D sampling interval",};
float bandwidth = 85.0 with {2.0,250.0,1,VIS, "CERD rec low pass freq, kHz",};
float decimation = 1.0;

int filter_aps2 = 1;
int psfrsize = 512 with {0,,,INVIS, "num data acq during APS2",};
int queue_size = 1024 with {0,,,INVIS, "Rsp queue size",};

/* int spgr_flag = 1 with {0,256,,VIS,"Spoiling: 0=no, 1=GEMS, 2=rand, >2 =quad slope",}; */
int seed = 16807 with {0,16807,,VIS,"Spoiled Grass seed value",};
int nbang = 0 with {0,,,,"total rf shots",};
float zref = 1.0 with {,,,VIS, "refocussing pulse amp factor",};

int trigloc = 1ms with {0,,0,VIS, "location of ext trig pulse after RF",};
int triglen = 4ms with {0,,0,VIS, "duration of ext trig pulse",};
int trigfreq = 1 with {1,128,0,VIS, "num views between output trigs",};
int maketrig = 1 with {0,1,0,VIS, "trigger output port (1) or not (0)",};

int ndisdaq = 4;                 /* For Prescan: # of disdaqs ps2*/
int pos_start = 0 with {0,,,INVIS, "Start time for sequence. ",};
int obl_debug = 0; /* for obloptimize, I guess */
int obl_method = 1 with {0,1,0,INVIS,
	"On(=1) to optimize the targets based on actual rotation matrices",};

/***************************************************************************/

/* LHG 9.27.16  ***********************
   CVs for the spin tagging part .....
 ***************************************/
/* int opslquant = 16 with {8,128,,INVIS, "# pixels along z",};*/
int 	t_tag;              /*duration of tagging pulse*/
int 	t_delay;            /*delay after tagging before Aquisition*/
int 	B1tag_offset;       /*frequency offset of tagging pulse*/
int 	astseqtime;         /*duration of a single cycle of ast part of the sequence */
int 	astseqtime2;        /*duration of the total ast part of the sequence */
int 	t_adjust= 1500ms;           /*delay before ast pulse to make up the rest of the TR */
int 	t_adjust_fudge = 14ms;     /* error in the t_adjust (not clear yet why) */
int 	delta1 = 0us;       /* time between flow spoiling gradients */
int 	isLabel=0;           /* variable used to toggle the RF */
int 	mycontrol=0;        /* 0 = toggle RF   1= flip gradients */
int 	xres=64;            /* used in place of opxres to  fix a simulation error */
int	mrf_mode = 0;

int	vsi_controlmode = 5 with {1,,,VIS, "Control Mode: (1) flip the magnitude  (2) no RF  (3) negative vel target (4) flip grads (5) no VelSel grads, (6) monopolar grads", } ;
int	vsi_axis_default = 3  with {1,3,,,"indicates the velocity selection axis, 1,2,3 ---> x,y,z ",};
int	vsi_axis = 3 ;
int	vsi_rotax = 0 ; /* if multiple pulses, rotate the vsi_axis or leave it fixed */
int	vsi_rfdelay = 50; /* allow a little time between RF and gradient */
float 	vsi_flip ;  /* flip angle of each Hanning pulse */
/*int  	myramptime = 120;  *** lhg 9/21/12   ramp times for the pcasl pulses */
int  	myramptime = 260;
double 	vsi_Gmax = 1.5; /* default gradient max aplitude in VSI pulse train */
double 	vsi_Gcontrol = 3.0 ; /* default gradient max aplitude in control pulse train */
double	vel_target ; /* the decceleration rate the we wish to use for labeleing */
		/* calibration of the flip angles is done by starting at max and reducing the RF */
int	vsi_Ncycles = 1;  /* number of VSI pulse bursts */
int 	M0frames = 2;  /* number of images withoug labeling (at the begining) */
int	isOdd = 0;

/* stuff for peak B1 calculations */
double	vsi_RFmax = 234 ; /* 234 mGauss. Peak B1 of the pulse train
				for a 180 deg, 1 ms  hard pulse
				B1max should be 117 mG*/
double vsi_RFmax_calstep = 10;
double 	my_maxB1Seq = 0 ;   /*
				this is what's used in prescan:
				Notes from grepping in the sar_pm.h file:
				sar_pm.h:#define MAX_B1_SINC1_90 0.0732
				sar_pm.h:#define MAX_B1_SINC3_90 0.221
				sar_pm.h:#define MAX_B1_SINC1_180 0.1464
				*/
/*double	dummy_RFmax = 200;*/    /* mGauss.  Peak B1 of reference pulse rfdummy in rf_grad_sprilo.h
				this is the largest pulse, and therefore the 1.0*/
/*int 	dummyRefCal=0;*/

/*LHG 10.2015 */
int	vsi_train_len = 250;  /* number of points in the pulse.
				Note that the external files are named according to the number of points */
int 	Npoints;	   /* the number of points that were read from the RF pulse file.  Should match vsi_train_len */
double 	vsi_velocity = 0;   /* velocity of the spins to target for inversion */
int	vsi_timegap = 1150000;   /* gap between VSI pulses if we are doing mulitple pulsees */

/* arterial suppression by BIR pulses */
double 	ArtSup_Gmax = 1.5; /* default gradient max aplitude in arterial suppression pulse train */
double 	ArtSup_B1max = 234; /* default B1 max aplitude in arterial suppressin pulse train */
int     ArtSup_len = 6850;  /* number of points in the Arterial suppression BIR8 pulse. */

int  	multiFlipFlag = 0;  /* LHG 10.9.14 - Flag for VSI flip angle optimization  */
int  	multiphsFlag = 0;  /* LHG 10.3.12 - Flag for phase correction optimization mode */
int  	nfr_phs = 2; /* Number of frameas collected at each phase correction increment */

/*LHG 10.30.18 : respiratory triggering */

int	vsi_TrigType=3 with {0,3, 3, VIS, "TRIG_LINE=0, TRIG_ECG=1,TRIG_AUX=2,TRIG_INTERN=3"};

/* CV's for 3D imaging JFN 09.29.10     */
int 	spgr_flag = 0 with {0,256,0,VIS,"Spoiling: 0=no, 1=GEMS, 2=rand, 3=RF-spoiling (117), >3 =quad slope",};
int 	rfamp_flag = 0; /* with {0,99,0,VIS,"Flip angle schedule: 0=constant, 99=Gai, >0 = power law",}; */
int 	rf_spoil_seed = 117 with {0,180,,VIS,"RF-spoiling phase increment (degrees)",};

/* LHG 6.29.12 - these are the variables for the kz phase encoding gradient plus some other stuff(?)*/
float 	target;
int 	rtime, ftime;
float 	zfov;   	/* FOV along the z-axis (cm) */
float 	ampGzstep;
float 	areaGzstep;
int 	iampGzstep;
int 	pwGzstep = 100 ; /*plateau of the kz encoding gradient (us) */
int 	dopresat = 0 with {0,1,,VIS, "pre-saturate 3D readout?",};
int	doZgrappa = 0;

float  	rf1maxTime = (456.0 / 500.0);  /* the max of the pulse happens at 456.  the whole pulse has 500 points) */
double  area_gzrf1;
double  area_gzrf1r;
float   rf1_bw;
float   slab_fraction=0.95 with {0,10, , VIS, "fraction of the nominal z FOV with 90 degree pulse"};

/*float	se_slab_fraction = 0.95 with {0,10, , VIS, "fraction of the nominal z FOV excited by 180 degree pulse"};
*/
/*3.18.20: 3D spiral in-out */
double	Kmax;
double	deltaK;
int	FID_len;
int	Grad_len;
int	FID_dur;
float 	R_accel= 0.5;
float 	THETA_accel = 1.0;
int	Ncenter = 20;
float	ramp_frac = 1.0/10.0;
float 	rotAngle;
float 	SLEWMAX = 16000;

float	se_slab_fraction = 1.5 with {0,10, , VIS, "fraction of the nominal z FOV excited by 180 degree pulse"};

int 	time_90_180 = 0;
int	time_180_180 = 0;
int	textra90 = 0;
int	textra180 = 0;

/* LHG: 5.13.20:   trying to control the spiral Grad amplitude */
float	spiralGmax = 2.9; /* G/cm */
float 	myGmax_check = 0.0;
float 	spiralGxmax = 0.0;
float 	spiralGymax = 0.0;
float 	spiralGzmax = 0.0;

/* LHG 7.10.20: zero out RX phase for troubleshoor=ting: */
int	kill_rx_phase = 1;
/*  the 90 can be rotated and used to limit the FOV */
int	doRotated90 = 0 with {0, 3, , VIS, "Forces the 90 degree pulse to the : 1=X axis, 2=Y axis, 3=Z axis "};
float 	yfov = 10.0;	/* LHG 12.22.18: this sequence allows rotation of the 90 degree pulse independently of the 180.  i
			yfov determines the slab width of the 90 (cm) */
float	delta_y = 0.0 with {-100, 100, , VIS, "if the 90 rf is rotated to the Y axis, use this to shift it along the Y axs "};
int	doCAIPI = 1;
int	rf_sign = 1;
float 	rf2_fraction = 0.7;
int	variable_fa = 0;
int	rf_phase_cycle = 0;
int	doXrot = 1;
int	doYrot = 1;  /* rotate around the KY axis after the X-axis*/


/* LHG 12/14/12 : Variables for the backgroun Suppression pulses */
int	BStime = 0;    /* total time needed for background suppresson block */
int	BS1_time = 500000; /* delay between label and second BS inversion pulses */
int 	BS2_time = 50000;  /* delay between first and second BS inversion pulses */
float	rfscalesech;	/* ratio of areas: autoprescan sinc to SECH pulse */
int	doBS = 1;	/* background suppression pulses */
int	doArtSup = 0;	/*arterial suppression pulses */
int	t_preBS;	/* this is the duration of the core containing the first BS pulse (beofre tagging */
int	AStime = 50000; /* time between arterial suppression pulse and fat sat pulse */

/* JS 03/15/2018: Variables for background suppresion before tagging*/
double  area_gzBSOrfspoiler;

/* some variables to adjust timing - leftovers from signa */
float 	slwid180 = 1.2 with {0.0,4.0,,,"180 slice width as fraction of 90",}; /*this is so that the 180 stuff will work */
int	tpre=0;
int	tdel=0;
int	mytpre = 0;
int 	tcs;  /* duration of the chem sat pulses */
/*int	cyc_rf1 = 4;  this seems like it was used by the stanford code, but was missing from declarations */
int 	echoshift = 0us with {,,,,"180 advance for spin echo T2* wting",};

/* int textra_tadjust = 24000;   old number - LHG 9.20.07 */
int 	textra_tadjust = 100;
int 	textra_astcore = 300;
int 	textra_controlcore = textra_astcore;
int 	textra_nothingcore = textra_astcore;
int 	textra_delaycore = 300;
int 	textra_vsi_gapcore = 100;

int textra = 0;  /* adjustment to psdeqtime... don't really need it any more */

/* cv's for chem sat pulse */
int 	fat_chemshift = -440;

/*LHG 2017.01.06:  creating variables for VSI pulse: */
float 	flip_vsitag1 = 180;
int 	wg_vsitag1 =  TYPRHO1 with {0, WF_MAX_PROCESSORS*2-1,
                                           TYPRHO1, VIS, , };

/*LHG 6.14.22: extra gain during background suppressed ASL images*/
int	rgainasl = 4;

float	xmtaddScan;
float	TX_scale = 1.0;
/*
float	flip_dummyrf = 180;
int 	wg_dummyrf =  TYPRHO1 with {0, WF_MAX_PROCESSORS*2-1,
                                           TYPRHO1, VIS, , };
*/
/****************************************/

@ipgexport
@inline Prescan.e PSipgexport
s32 savrot[TRIG_ROT_MAX][9];   /* copy of rotation matrices */

/* DJF 4.25.22 Initialization of pre-computed view parm tables */
float xi[MAXNUMECHOES];
float psi[MAXNUMECHOES];
float phi[MAXNUMECHOES];
float kzf[MAXNUMECHOES];
float rotmatrices[MAXNUMECHOES][9];

RF_PULSE_INFO rfpulseInfo[RF_FREE];
/*3.18.20: 3D spiral in-out */
int Gx[GRESMAX];
int Gy[GRESMAX];	 /*  for spiral waves  */
int Gz[GRESMAX];
float pfGx[GRESMAX];
float pfGy[GRESMAX];
float pfGz[GRESMAX];
	
/* LHG 9.27.16  VSI pulses data arrays */
int vsi_pulse_mag[50000];
int vsi_pulse_phs[50000];
int vsi_pulse_ctl_phs[50000];
int vsi_pulse_grad[50000];
int vsi_pulse_ctl_grad[50000];
/*LHG 10.4.16 BIR pulses for arterial suppression */
int ArtSup_mag[50000];
int ArtSup_phs[50000];
int ArtSup_grad[50000];

/*LHG 6/7/21 : dummy pulse for calibration */
/*
int dummyrf_wave[500];
*/
/* LHG 11/4/19  These are for the fingerpriting timing */
float	t_delay_array[1000];
float	t_adjust_array[1000];
float	AStime_array[1000];
int	isVelocitySelective_array[1000];
int	doArtSuppression_array[1000];

long	out_t_delay_array[1000];
long	out_t_adjust_array[1000];
long	out_t_aq_array[1000];
long	out_isVelocitySelective[1000];
long	ctrl_word;
int	tcounter = 0;


@host
#include "support_func.host.h"	/* new for 28x */
#include <float.h>
#include <math.h>
#include <stdlib.h>
  
#include "epic_iopt_util.h"
#include "psd.h"
#include "psdIF.h"
#include "psdopt.h"
#include "psdutil.h"
#include "psd_receive_chain.h"
#include "rfsspsummary.h"
#include "sar_burst_api.h"
#include "sar_display_api.h"
#include "sar_limit_api.h"
#include "sar_pm.h"
#include "support_func.host.h"
#include "sysDep.h"
#include "sysDepSupport.h"
#include "grad_rf_sprlio.h"
#include "seriosmatx.h"
  
extern "C" {
#include "fudgetargets.c"
}


static char supfailfmt[] = "Support routine %s exploded!";
FILTER_INFO echo1_filt;
FILTER_INFO aps2_filt;

int genspiralcdvd(float D, int N, float Tmax, float dts, float alpha, float kmaxfrac);
int gram_duty(void);

/*LHG 9.27.16 */
int read_vsi_pulse(int *vsi_pulse_mag, int *vsi_pulse_phs, int *vsi_pulse_grad, int vsi_train_len);
int calc_vsi_phs_from_velocity (int* vsi_pulse_mag, int* vsi_pulse_phs, int* vsi_pulse_grad,	float vel_target, int vsi_train_len, double vsi_Gmax);

/*Spiral in-out for Spin Echo  functions from genspiral3d_io.e*/

float genspiral(
	float* gx,
	float* gy,
	float* gz,
	int Grad_len,
	float R_accel,
	float THETA_accel,
	int N_center,
	float ramp_frac,
	int doXrot,
	int doYrot,
	float fov,
	int dim,
	float dt,
	float slthick,
	int N_slices,
	int N_leaves,
	float SLEWMAX,
	float GMAX);

int sph2cart(
        float* pfx,
        float* pfy,
        float* pfz,
        float* pfr,
        float* pftheta,
        float* pfphi,
        int     Npts);


int rotGradWaves(
        float*         gx,
        float*         gy,
        float*         gz,
        float*         gx2,
        float*         gy2,
        float*         gz2,
        int             glen,
        float*         mat);

int euler2mat2(float ang1,float ang2,float ang3,float *tm);

/* DJF 4.25.22 seriosmatx.h function declarations: */
int geneye(int size, float I[]);
int genRyxz(float ax, float ay, float az);
int multiplymatrix(int M, int N, int P, float mat1[], float mat2[], float matr[]);
int printmatrix(int M, int N, float mat[]);
int scalematrix(int M, int N, float mat[], float maxval);

@inline Prescan.e PShostVars
/* start changes for DV26 */
@inline loadrheader.e rheaderhost
/* end changes for DV26 */
abstract("vel. sel. ASL with 3D Fast spin echo, spiral IN-OUT, MRF mode");
psdname("vsasl3dflex02");

int cvinit()
{
	fprintf(stderr,"\nStarting cvint");
    	configSystem(); /* rx28 */
	EpicConf();
	inittargets(&loggrd, &phygrd);
	fudgetargets(&loggrd, &phygrd, rtimescale);
	if (obloptimize(&loggrd, &phygrd, scan_info, exist(opslquant), exist(opplane),
				exist(opcoax), obl_method, obl_debug, &opnewgeo, cfsrmode)==FAILURE)
		return FAILURE;

@inline Prescan.e PScvinit
#include "cvinit.in"	/* Runs the code generated by macros in preproc.*/

	cvmax(optr,24s);
	cvmax(ihtr,24s);

	/* restrict sequence type to gradient echo */
	cvdef(oppseq,2);
	cvmin(oppseq,0);
	cvmax(oppseq,2);

	/* don't make the user even worry about selecting the number of echoes
	   or NEX  */
	piechnub = 0;
	pinexnub = 0;

	/* turn on variable bandwidth button */
	pircbnub = 6;
	pircb2nub = 0;
	pircbval2 = 15.875;
	pircbval3 = 31.75;
	pircbval3 = 62.5;
	pircbval3 = 125.0;
	pircbval4 = 200.0;
	cvmin(oprbw, 15.875);
	cvmax(oprbw, 250);
	cvdef(oprbw, 200);
	oprbw = 200;

	return SUCCESS;

}

@inline InitAdvisories.e InitAdvPnlCVs

int cveval()
{
	int tmptr, entry;

	configSystem();
	InitAdvPnlCVs();

	if (_psd_rf_wait.fixedflag == 0)  { /* sets psd_grd_wait and psd_rf_wait */
		if (setsysparms() == FAILURE)  {
			epic_error(use_ermes,"Support routine setsysparams failed",
					EM_PSD_SUPPORT_FAILURE,1, STRING_ARG,"setsysparms");
			return FAILURE;
		}
	}

	if (obloptimize(&loggrd, &phygrd, scan_info, exist(opslquant), exist(opplane),
				exist(opcoax), obl_method, obl_debug, &opnewgeo, cfsrmode)==FAILURE)
		return FAILURE;

	if (existcv(opcgate) && (opcgate == PSD_ON))

	{
		tmptr = RUP_GRD((int)((float)(exist(ophrep))
					*(60.0/exist(ophrate))* 1e6));
		pitrnub = 0;
	}
	else
	{
		tmptr = optr;
		pitrnub = 6;
		if (oppseq == 2) /* gradient echo */
		{
			pitrval2 = 80ms;
			pitrval3 = 250ms;
			pitrval4 = 500ms;
			pitrval5 = 1s;
			pitrval6 = 2s;
		}
		else
		{
			pitrval2 = 300ms;
			pitrval3 = 500ms;
			pitrval4 = 1s;
			pitrval5 = 1.5s;
			pitrval6 = 2s;
		}
	}
	pisctim1 = nframes*nl*tmptr;
	pisctim2 = pinexval2*pisctim1;
	pisctim3 = pinexval3*pisctim1;
	pisctim4 = pinexval4*pisctim1;
	pisctim5 = pinexval5*pisctim1;
	pisctim6 = pinexval6*pisctim1;

	opflip = 90.0;
	cvdef(opflip, 90.0);
	if (oppseq == 2) /* gradient echo */
	{
		pifanub = 6;
		pifaval2 = 10;
		pifaval3 = 30;
		pifaval4 = 40;
		pifaval5 = 60;
		pifaval6 = 90;
	}
	else /* spin echo */
	{
		pifanub = 0; /* turn off flip angle buttons */
	}

	/* label TE buttons */
	pite1nub = 63; /* apparently a bit mask */
	pite1val2 = PSD_MINIMUMTE;
	pite1val3 = 20ms;
	pite1val4 = 30ms;
	pite1val5 = 40ms;
	pite1val6 = 50ms;

	/* label FOV buttons */
	cvdef(opfov, 200);
	opfov = 200;
	pifovval2 = 200;
	pifovval3 = 220;
	pifovval4 = 240;
	pifovval5 = 360;
	pifovval6 = 480;

	/* turn on user cv page */
	piuset = use0+use1+use2+use3+use4+use5+use6+use10+use11+use12+use13+use14+use15+use16;
	pititle = 1;
	cvdesc(pititle, "Spiral User CV page");

	piuset += use20+use21+use22+use23+use24+use25+use26+use27;
	/*
	   pititle = 2;
	   cvdesc(pititle, "PCASL User CV page");
	 */

	cvdesc(opuser0, "# of interleaves");
	cvdef(opuser0, 1.0);
	opuser0 = 1;
	cvmin(opuser0, 1.0);
	cvmax(opuser0, 128.0);
	nl = opuser0;

	cvdesc(opuser1, "number of temporal frames");
	cvdef(opuser1, 1);
	opuser1 = 4;
	cvmin(opuser1, 1);
	cvmax(opuser1, 16384);
	nframes = opuser1;

	cvdesc(opuser2, "Ext trig: (0)none, start (1)scan, (2)frame, (3)by file");
	cvdef(opuser2, 0);
	opuser2 = 0;
	cvmin(opuser2, 0);
	cvmax(opuser2, 3);
	gating = (((int)opuser2)==1 || ((int)opuser2)==2)? TRIG_AUX : TRIG_INTERN;        /* aux trig */

	cvdesc(opuser3, "Recon script_number or none(0)");
	cvdef(opuser3, 0);
	opuser3 = 0;
	cvmin(opuser3, 0);
	cvmax(opuser3, 999);

	cvdesc(opuser4, "Cluster slice acquisition (1) or not(0)");
	cvdef(opuser4, 0);
	opuser4 = 0;
	cvmin(opuser4, 0);
	cvmax(opuser4, 1);
	scluster = opuser4;

	cvdesc(opuser5, "Number of extra shots before data acq");
	cvdef(opuser5, 2);
	opuser5 = 2;
	cvmin(opuser5, 0);
	cvmax(opuser5, 100);
	nextra = opuser5;

	/* opuer6 used to be gtype */
	cvdesc(opuser6, "Maximum spiral gradient amp (G/cm)");
	cvdef(opuser6, 2.1);
	opuser6 = 2.1;
	cvmin(opuser6, 0);
	cvmax(opuser6, 4);
	spiralGmax = opuser6;

	gtype = 0;
	bmapnav = (gtype == 1)? 0:1;		/* for now */

	cvdesc(opuser10, "Record physio data (1) or not(0)");
	cvdef(opuser10, 0);
	opuser10 = 0;
	cvmin(opuser10, 0);
	cvmax(opuser10, 1);

	cvdesc(opuser11,"Collect Field Map scan? (0=No, 1=Yes");
	cvmin(opuser11,0);
	cvmax(opuser11,1);
	cvdef(opuser11,0);
	opuser11 = 0;

	domap = opuser11;


	cvdesc(opuser12, "short rf pulse (1) or not(0)");
	cvdef(opuser12, 1);
	opuser12 = 1;
	cvmin(opuser12, 0);
	cvmax(opuser12, 1);
	if(((int)opuser12) == 1)  {
		cycrf1 = 2;
		cycrf2 = 2;
		pwrf1 = 3200;
		pwrf2 = 3200;
		res_rf1 = 1600;
		res_rf2 = 1600;
	}  else  {
		cycrf1 = 4;
		cycrf2 = 4;
		pwrf1 = 6400;
		pwrf2 = 6400;
	}

	cvdesc(opuser13, "K-space radial speed factor (1 = linear)");
	cvdef(opuser13, 0.5);
	opuser13 =0.5;
	cvmin(opuser13, 0);
	cvmax(opuser13, 3.0);
	R_accel = opuser13;

	cvdesc(opuser14, "K-space rotation speed factor (2=twice the number of turns)");
	cvdef(opuser14, 1.0);
	opuser14 = 1.0;
	cvmin(opuser14,0.5);
	cvmax(opuser14, 5.0);
	THETA_accel = opuser14;

	cvdesc(opuser15, "kmaxfrac");
	cvdef(opuser15, 0.5);
	opuser15 = 0.5;
	cvmin(opuser15, 0.05);
	cvmax(opuser15, 0.95);
	kmaxfrac = opuser15;

	cvdesc(opuser16, "Background Suppression? (0=no, 1=yes)");
	cvdef(opuser16, 0);
	opuser16 = 0;
	cvmin(opuser16, 0.);
	cvmax(opuser16, 1.0);
	doBS = opuser16;


	cvdesc(opuser17, "Target Velocity of the blood to be labeled. (cm/s)");
	cvdef(opuser17, 0);
	opuser17 = 0;
	cvmin(opuser17, -300);
	cvmax(opuser17, 300);
	vel_target = opuser17;


	cvdesc(opuser19,"Gradient amplitude for VEL Selective Inversion");
	cvmin(opuser19,0);
	cvmax(opuser19,4);
	cvdef(opuser19,3);
	opuser19 = 1.5;
	vsi_Gmax = opuser19;
	vsi_Gcontrol = vsi_Gmax;


	cvdesc(opuser20,"Arterial Suppression Pulse (0=NO  1=YES)");
	cvmin(opuser20,0);
	cvmax(opuser20, 1);
	cvdef(opuser20,0);
	opuser20 = 0;
	doArtSup = opuser20;


	cvdesc(opuser21,"Delay between tagging period and imaging time (ms)");
	cvmin(opuser21,10);
	cvmax(opuser21, 5000);
	cvdef(opuser21,1400);
	opuser21 = 1400;
	t_delay = RUP_GRD(opuser21 * 1000);


	cvdesc(opuser22,"Delay between Arterial Suppression and imaging (ms)");
	cvmin(opuser22,10);
	cvmax(opuser22, 200);
	cvdef(opuser22,100);
	opuser22 = 100;
	AStime = RUP_GRD(opuser22*1000);


	cvdesc(opuser23,"Choice of labeling pulse");
	cvmin(opuser23,0);
	cvmax(opuser23, 999999);
	cvdef(opuser23,15999);
	opuser23 = 6800;
	vsi_train_len = opuser23;


	cvdesc(opuser24,"Do GRAPPA-Z (0=NO  1=YES)");
	cvmin(opuser24,0);
	cvmax(opuser24, 1);
	cvdef(opuser24,0);
	opuser24 = 0;
	doZgrappa = opuser24;

	cvdesc(opuser25,"Stripe center (cm).  AP coord of stripe center ");
	cvmin(opuser25,-100);
	cvmax(opuser25, 100);
	cvdef(opuser25,0);
	opuser25 = 0;
	delta_y= opuser25;

	cvdesc(opuser26,"Stripe width (cm) ");
	cvmin(opuser26,0);
	cvmax(opuser26, 100);
	cvdef(opuser26,10);
	opuser26 = 10;
	yfov= opuser26;

	cvdesc(opuser27,"Stripe axis: 0=no stripe , 1=Y, 2=X, 3=Z ");
	cvmin(opuser27,0);
	cvmax(opuser27, 3);
	cvdef(opuser27,1);
	opuser27 = 0;
	doRotated90 = opuser27;


	slord = TYPNORMORDER;

	piamnub = 7;
	pixresnub = 3;
	cvmin(opxres, 16);
	cvdef(opxres, 64);
	opxres = 64;
	pixresval2 = 64;
	pixresval3 = 96;
	pixresval4 = 128;
	piyresnub = 0;

	/* Duration of whole labeling period : */
	/* LHG 11.7.14:   now includes a gap between five VSI bursts */
	astseqtime = pw_vsitag1 + mytpre + timessi;
	t_tag = vsi_Ncycles*(vsi_timegap + astseqtime );
	/* JG 9.5.2019: modify t_tag to allow correct timing and shorter TR with multiple VSI pulses */
	/* remove the first vsi_gap */
	/* t_tag = vsi_Ncycles*(vsi_timegap + astseqtime ); */
	t_tag = vsi_Ncycles*(vsi_timegap + astseqtime ) - vsi_timegap;

	/*08/14/19 JS activate rfpulse*/
	/*
	rfpulse[RF2_SLOT].activity = PSD_APS2_ON + PSD_MPS2_ON + PSD_SCAN_ON;
	*/
	/*
	rfpulse[RFDUMMY_SLOT].activity = PSD_APS2_ON + PSD_MPS2_ON + PSD_SCAN_ON;
	rfpulse[RFVSI_SLOT].activity = PSD_APS2_ON + PSD_MPS2_ON + PSD_SCAN_ON;
	*/

	rfpulse[RF1_APS1_SLOT].activity = PSD_APS2_ON + PSD_MPS2_ON + PSD_SCAN_ON;
	rfpulse[RF2_APS1_SLOT].activity = PSD_APS2_ON + PSD_MPS2_ON + PSD_SCAN_ON;

	/* ************************************************
	   RF Scaling
	   Scale Pulses to the peak B1 in whole seq.
	 ********************************************** */
	int p;
	fprintf(stderr, "\nAMV Calling findMaxB1 ....");

	fprintf(stderr, "\n\nRF_FREE=%d, MAX_ENTRY_POINTS=%d, maxB1=%.3f", RF_FREE, MAX_ENTRY_POINTS, maxB1);
	fprintf(stderr, "\n\nENTRY_POINT_MAX = %d ", ENTRY_POINT_MAX);
	/*
	fprintf(stderr, "\n\nPrinting max_b1 for each rfpulse struct...");
	for (p=0; p< RF_FREE; p++) {
		fprintf(stderr, "\nmax_b1=%.3f", rfpulse[p].max_b1);
	}

	fprintf(stderr, "\n\nmaxB1 for each entry point before findMaxB1Seq...");
	for (entry=0; entry < MAX_ENTRY_POINTS; entry++) {
		fprintf(stderr, "\nmaxB1=%.3f", maxB1[entry]);
	}
	*/
	maxB1Seq = 0.0;
	for (entry=0; entry < MAX_ENTRY_POINTS; entry++) {
		if (peakB1(&maxB1[entry] ,  entry, RF_FREE, rfpulse) == FAILURE) {
			epic_error(use_ermes,"peakB1 failed",EM_PSD_SUPPORT_FAILURE,1,STRING_ARG,"peakB1");
			return FAILURE;
		}
		if (maxB1[entry] > maxB1Seq)
			maxB1Seq = maxB1[entry];
	}
	/*	
	if( findMaxB1Seq(&maxB1Seq, maxB1, MAX_ENTRY_POINTS, rfpulse, RF_FREE) == FAILURE ) {
		epic_error(use_ermes,supfailfmt,EM_PSD_SUPPORT_FAILURE,EE_ARGS(1),STRING_ARG, "findMaxB1Seq");
		return FAILURE;
	}
	*/
	/*
	for (entry=0; entry < MAX_ENTRY_POINTS; entry++) {
		maxB1[entry] = 0.25;
	}
	maxB1Seq = 0.25;
	*/
	fprintf(stderr, ".... OK!");
	fprintf(stderr, "\n\nmaxB1 for each entry point after findMaxB1Seq...");
	for (entry=0; entry < MAX_ENTRY_POINTS; entry++) {
		fprintf(stderr, "\nmaxB1=%.3f", maxB1[entry]);
	}
	fprintf(stderr, "AMV\n maxB1[L_SCAN]=%0.3f after findMaxB1Seq", maxB1[L_SCAN]);	
	my_maxB1Seq = 1000 * maxB1Seq; // convert from Gauss to mGauss

	// LHG 3/1/2022 :- including new grad_rf_sprlio.h  sets the rf2 amplitude to 294 mG
	// No need for this scaling?

	/* if our pulses are half as wide, then must be twice as tall as in Prescan.
	change values of maxB1Seq so that xmtadd can be recalculateed correctly later */
	
	if(opuser12 == 1){
		my_maxB1Seq = 2*my_maxB1Seq;
		maxB1Seq = 2*maxB1Seq;
	}
	fprintf(stderr, "\nmy_maxB1Seq=%.4f\n", my_maxB1Seq);
	

	if(doZgrappa) slab_fraction = 0.85;
	
	/*---LHG: 09.01.2021 ---*/
	/*SLICESELZ doesn't seem to set these right.  Let's do it manually */
	pw_gzrf1 = pwrf1;
	pw_gzrf2 = pwrf2;
	pw_gzrf1a = myramptime;
	pw_gzrf1d = myramptime;
	pw_gzrf2a = myramptime;
	pw_gzrf2d = myramptime;

	pw_rf1 = pwrf1;
	pw_rf2 = pwrf2;
	/*------*/

	pw_gzrf1ra = myramptime;
	pw_gzrf1rd = myramptime;
	pw_gzrf1r = 200;
	area_gzrf1r = -(double)a_gzrf1 * (pw_gzrf1 + pw_gzrf1d)/2.0;
	a_gzrf1r = (double)area_gzrf1r/(pw_gzrf1r + pw_gzrf1rd);

	/* DJF 4.25.22 hardcoded calculation of rotAngle as GA, eventually make a opuser CV */
	rotAngle = M_PI*(3-sqrt(5));

	/* values for Arterial suppression pulses LHG 10.15.19 */
	if (doArtSup)
	{
		 a_ASrf_mag  = (ArtSup_B1max / my_maxB1Seq);
		 ia_ASrf_mag = a_ASrf_mag * max_pg_iamp;
		 a_ASrf_grad  = ArtSup_Gmax;
		 ia_ASrf_grad = a_ASrf_grad * max_pg_iamp;
	}


	/* ----------------------------------------------------------------------------------------*/
	/* Calculate the  z phase-encode gradient params */
	zfov = (double)opslquant*opslthick/10;  /* in cm ! */
	if (doRotated90==0) yfov = zfov;  /* if we are not rotating the 90, then the slab thickness should be the same as for the 180*/

	ampGzstep = 1 / ((pwGzstep + myramptime) *1e-6 * GAMMA_H1/(2*PI) * zfov);  /* z phase-ecncode readout gradient for this zfov G/cm*/

	/* Turning off the kz  phase encoding gradients: */
	ampGzstep = 0;

	if (doZgrappa)
		ampGzstep *= 2;

	areaGzstep = ampGzstep * (pwGzstep + myramptime) ;        /* max area of z encoding gradient in G/cm*usec */

	/* get the specs of the z gradient */
	gettarget(&target, ZGRAD, &loggrd);
	getramptime(&rtime, &ftime, ZGRAD, &loggrd);

	/* previous code from JFN :
	 *  Use ampwpgrad macro to design a trapezoid given a desired area and the hardware specs
	 if (amppwgrad(	gzphasearea, target,
	 0.0, 0.0,
	 rtime,
	 MIN_PLATEAU_TIME,
	 &a_gzphase, &pw_gzphasea,
	 &pw_gzphase,  &pw_gzphased)
	 == FAILURE)
	 return FAILURE;
	 */
	/* calculate the amplitude of the max. Gz encode gradient in DAC units */
	iampGzstep = 2 * ((ampGzstep / target) * MAX_PG_IAMP / 2.0);

	fprintf(stderr, "predownload(): ampGzstep = %.3f, iampGzstep = %d \n", ampGzstep, iampGzstep);
	/* ----------------------------------------------------------------------------------------*/
	pw_gz0=3000;
	pw_gz0a=400;
	pw_gz0d=400;
	a_gz0 = 2.0;

	rfscalesech = 1.0;  /* Empirically on sphere phantom, I didn't get an inversion unutl 0.65) */

	pw_BS1rf = 5000;
	a_BS1rf = rfscalesech * (float)doBS ; /* the sech is used to generate a 180 */
	res_BS1rf = 2000; /* the number of points in the file */
	res_BS1rf = 500; /* the number of points in the file */

	pw_BS2rf = pw_BS1rf;;
	a_BS2rf = a_BS1rf;
	res_BS2rf = res_BS1rf;

	 /* JS 03/14/2018: Parameters for BS0 pulses*/
        pw_BS0rf = pw_BS1rf/2;
        a_BS0rf = a_BS1rf;
        res_BS0rf = res_BS1rf/2;

        a_gzBS0rfspoiler = 2*(float)doBS;
        pw_gzBS0rfspoiler=3000;
        pw_gzBS0rfspoilera=400;
        pw_gzBS0rfspoilerd=400;
        area_gzBSOrfspoiler = (double)(a_gzBS0rfspoiler*(pw_gzBS0rfspoiler+pw_gzBS0rfspoilera));

	/* LHG 11/15/18: in VSS and VSI, the first saturation BGS pulse is off */
	/*
	a_BS0rf = 0;
	a_gzBS0rfspoiler = 0;
	*/

        t_preBS = pw_BS0rf  + pw_gzBS0rfspoiler + 2*pw_gzBS0rfspoilera +600;
	/***********/

	/*set up times for the butterfly gradient spoilers  */

	a_gz180crush1 = 1.5;
	a_gz180crush2 = a_gz180crush1;

	pw_gz180crush1 = 20;
	pw_gz180crush2 = pw_gz180crush1;


	pw_gz180crush1a = myramptime;
	pw_gz180crush2a = pw_gz180crush1a;


	pw_gz180crush1d = myramptime;
	pw_gz180crush2d = pw_gz180crush1d;


	/*---------------------------*/
	if (mrf_mode) doBS = 0;

	if (doBS==0){
		BS1_time = 10000;
		BS2_time = 10000;
	}

	BStime = BS1_time + BS2_time + pw_BS2rf/2 ; /* + pw_BS0rf + pw_gzBS0 + 2*pw_gzBS0a; */

	BStime = BS1_time + BS2_time + pw_BS2rf; /* + pw_BS0rf + pw_gzBS0 + 2*pw_gzBS0a; */
	/*---------------------------*/

	fatsattime = pw_rf0 + 2*pw_gz0d +pw_gz0 + 2*timessi;
	fuzz = 10000;

	astseqtime2 = t_tag + t_delay;  /*duration of tagging + postabeling delay */

	/* calculate duration of each core in the readout */
	t_tipdown_core = RUP_GRD(opte/2 - pw_gz180crush1 - 2*pw_gz180crush1a + timessi);

	t_refocus_core = RUP_GRD(
		tlead +
		pw_gz180crush1 + 2*pw_gz180crush1a +
		pw_gz180crush2 + 2*pw_gz180crush2a +
		pw_gzrf2 + 2*pw_gzrf2a
		+ timessi);

	t_seqcore = RUP_GRD(
		opte - 2*( pw_gz180crush2 + 2*pw_gz180crush2a) - (pw_gzrf2 + 2*pw_gzrf2a ) + timessi );

	/* duration of the whole readout  */
	seqtr = t_tipdown_core + (t_refocus_core + t_seqcore) * opslquant;

	/* duration of the whole sequence */
	psdseqtime = seqtr + t_tag + t_delay + AStime + textra_astcore + textra_delaycore;

	/* Left over time to fille the TR */
	t_adjust = RUP_GRD(optr - psdseqtime);                 /* LHG 7.18.18 */

	readpos = RUP_GRD(opte/2.0 
			- pw_gzrf2/2.0 - pw_gzrf2a
			- pw_gz180crush2 - 2*pw_gz180crush2a 
			- FID_dur/2);


	fprintf(stderr, "\nreadpos,  t_tipdown_core , t_refocus_core, t_seqcore=  %d   %d  %d  %d", 
			readpos,  t_tipdown_core , t_refocus_core, t_seqcore);
	fprintf(stderr, "\npsdseqtime, seqtr, tmin, optr=  %d   %d  %d  %d", psdseqtime,  seqtr,tmin,optr);
	fprintf(stderr, "\nt_adjust = %d , astseqtime= %d \n", t_adjust, astseqtime);
	/*---------------------------*/

	/* init RF pulses' amplitudes  */
	myflip_rf2 = 180;
	flip_rf2 = myflip_rf2;
	a_vsitag1 = vsi_RFmax / my_maxB1Seq;
	a_vsictl1 = vsi_RFmax / my_maxB1Seq;

	a_rf1 = opflip/180 ;
	a_rf2 = myflip_rf2/180 ;

	ia_rf1 = a_rf1 * max_pg_iamp;
	ia_rf2 = a_rf2 * max_pg_iamp;

	ia_vsitag1 = a_vsitag1 * max_pg_iamp;
	ia_vsictl1 = a_vsictl1 * max_pg_iamp;

	fprintf(stderr, "\nAMV calculated a_vsitag1= %f", a_vsitag1);
	fprintf(stderr, "\n calculated  a_rf1= %f , opflip= %f: , ia_rf1=  %d", a_rf1, opflip, ia_rf1);
	fprintf(stderr, "\ncalculated  a_rf2= %f , myflip_rf2= %f: , ia_rf2=  %d", a_rf2, myflip_rf2, ia_rf2);

	fprintf(stderr,"\nEnded cveval");



@inline Prescan.e PScveval

	return SUCCESS;
}

/*start DV26 changes*/
void getAPxParam(optval *min,
                optval *max,
                optdelta *delta,
                optfix *fix,
                float coverage,
                int algorithm)
{
        /* Need to be filled when APx is supported in this PSD */
}
int getAPxAlgorithm(optparam *optflag, int *algorithm)
{
        return APX_CORE_NONE;
}
/*end DV26 changes*/


int cvcheck()
{
	return SUCCESS;
}

int predownload()
{
	int pdi, pdj;
	int i, k;
	int slicen, leafn, spiraln;
	float max_rbw;
	FILE * fpout;
	FILE *fpin;
	FILE *kviewfile;
	float	tmp;

	/* DJF 4.25.22 Initialize important view rotation matrices: */ 
	float rotmatx_0[9]; /* initial rotation matrix based on Rx */
	float rotmatx_1[9]; /* rotation matrix calculated from view */
	float rotmatx[9]; /* product of all rotations for current view */

	/* DJF 4.25.22 convert savrot to column vector of float values from 0-1 */
	for (k = 0; k<9; k++) rotmatx_0[k] = (float)savrot[0][k]*pow(2,-15);

	/* DJF 4.25.22 Pre-computation of view parameter tables */
	fprintf(stderr, "\nCalculating view parameters ...");
	fprintf(stderr, "\ns: \tl: \tkzf: \txi: \tpsi: \tphi: \tR[9]:");
	kviewfile = fopen("/usr/g/bin/kviews.txt","w");
	for (leafn = 0; leafn<nl; leafn++) {
		for (slicen = 0; slicen<opslquant; slicen++) {
			/* calculate total view index */
			spiraln = leafn*opslquant + slicen;

			/* For SOS, calculate kzf */
			if ((doXrot==1) || (doYrot==1)) /* if rotating about X or Y axis, not SOS */
				kzf[spiraln] = 0;
			else /* if not rotating about X or Y axis, SOS */
				kzf[spiraln] = 2 / (float)opslquant * ( pow(-1,(float)slicen) * floor(((float)slicen+1)/2) + (float)doCAIPI * pow(-1,(float)leafn) * (float)leafn / (float)nl );
	
			/* Calculate the rotation angles for current view */
			xi[spiraln] = (float)doXrot * rotAngle * ( (float)slicen + ((float)doCAIPI * (float)leafn / (float)nl) );
			psi[spiraln] = (float)doYrot * rotAngle * ( (float)slicen + ((float)doCAIPI * (float)leafn / (float)nl) );
			phi[spiraln] = M_PI * (float)leafn / (float)nl;

			/* print slice #, leaf #, kz fraction, and angles */
			fprintf(kviewfile, "\n%d \t%d \t%f \t%f \t%f \t%f",slicen,leafn,kzf[spiraln],xi[spiraln],psi[spiraln],phi[spiraln]);
			fprintf(stderr, "\n%d \t%d \t%f \t%f \t%f \t%f",slicen,leafn,kzf[spiraln],xi[spiraln],psi[spiraln],phi[spiraln]);

			/* Generate a rotation matrix from angles (values from 0-1) */
			genRyxz(xi[spiraln],psi[spiraln],phi[spiraln],rotmatx_1);

			/* multiply current view RM with initial RM to get a total RM */
			multiplymatrix(3,3,3,rotmatx_1,rotmatx_0,rotmatx);
			
			/* store matrix in the global matrix table and print: */
			for (k=0; k<9; k++) {
				rotmatrices[spiraln][k] = rotmatx[k];
				fprintf(stderr, " \t%f", rotmatx[k]);
				fprintf(kviewfile, " \t%f", rotmatx[k]);
			}

		}
	}
	fclose(kviewfile);
	fprintf(stderr,"\nPredownload stuff:");

	/* Load the BIR-8 pulses for Arterial Suppression */
	Npoints = read_vsi_pulse(ArtSup_mag, ArtSup_phs, ArtSup_grad, ArtSup_len);

	/* LHG 9.27.16 : Timing calculation from the VSI sequence... */
	/* Npoints and vsi_train_len should come out the same ... good sanity check */
	Npoints = read_vsi_pulse(vsi_pulse_mag, vsi_pulse_phs, vsi_pulse_grad, vsi_train_len);
	fprintf(stderr,"\nNpoints: %d ... n. segments = %d ", Npoints, (Npoints*4 - 4000)/2000);

	/* LHG 6.7.21 put some numbers into the dummryrf pulse waveform*/
	/*
	for (i=0; i < 500 ; i++){
		dummyrf_wave[i] = 32767;
	}
	*/
	/* note that in some cases, we may want a different phase in the control pulses */
	for (i=0; i<Npoints ; i++){
		vsi_pulse_ctl_phs[i] = vsi_pulse_phs[i];
	}
	/* in some cases, we want the abs of the gradient for the control pulses (redundant code ) */
	for (i=0; i<Npoints ; i++){
		vsi_pulse_ctl_grad[i] = vsi_pulse_grad[i];
		if (vsi_controlmode==6)
			vsi_pulse_ctl_grad[i] = abs(vsi_pulse_grad[i]);
	}


	/*But ... in the label case, we update phase wave form for velocity selectivity */
	calc_vsi_phs_from_velocity (vsi_pulse_mag, vsi_pulse_phs,  vsi_pulse_grad, vel_target, vsi_train_len, vsi_Gmax);

	astseqtime = pw_vsitag1 + mytpre + timessi ;


	opnecho = 1;
	cvdef(opnecho, 1);
	cvmin(opnecho, 1);
	cvmax(opnecho, 1);

	/* image header variables set for correct annotation */
	ihflip = opflip;
	ihnex = opnex;
	ihtr = optr;

	/*  make the end dead time = TR */
	endtime = optr;

	/*  figure out some params depending on system/grads  */
	/* gamp = loggrd.xfs;  NEED to reduce to avoid PNS  */
	/*  gslew = cfsrmode;   can't use it all  */

	if((fpin=fopen("daqdeloff.sprl", "r"))) {     /* look for ext. file */
		fscanf(fpin, "%f", &daqdeloff);
		fclose(fpin);
	}  

	/*  try to make tr check */

	/*---------------------------*/
	/* LHG 6.29.12 - replace their tmin calculation and calculation of psdseqtime:
old:
tmin = RUP_GRD(tlead +pw_rf0 + pw_gz0 + 2*pw_gz0a + pw_gzrf1a +
pw_rf1/2 + opte + pw_gx + daqdel + mapdel + pw_gzspoil +
2*pw_gzspoila);
	 */
	if (doBS==0){
		BS1_time = 10000;
		BS2_time = 10000;
	}


	BStime = BS1_time + BS2_time + pw_BS2rf/2 ; /* + pw_BS0rf + pw_gzBS0 + 2*pw_gzBS0a; */

	BStime = BS1_time + BS2_time + pw_BS2rf; /* + pw_BS0rf + pw_gzBS0 + 2*pw_gzBS0a; */

	fatsattime = pw_rf0 + 2*pw_gz0d +pw_gz0 + 2*timessi;
	fuzz = 10000;

	astseqtime2 = t_tag + t_delay;  /*duration of tagging + postabeling delay */

	fprintf(stderr, "\npsdseqtime, seqtr, tmin, optr=  %d   %d  %d  %d", psdseqtime,  seqtr,tmin,optr);
	/*
	t_adjust = RUP_GRD(optr - seqtr - t_tag - t_delay - t_preBS);           
	t_adjust = RUP_GRD(optr - seqtr - t_tag - t_delay - AStime );           
	*/
	fprintf(stderr, "\nt_adjust = %d , astseqtime= %d \n", t_adjust, astseqtime);
	/*---------------------------*/

	if(gtype==1)  tmin -= pw_gx;
	if(gtype==2)  tmin += espace;

	if(seqtr > optr)  {
		epic_error(use_ermes,"Oops! optr must be > %.1f ms.\n", EM_PSD_SUPPORT_FAILURE,1,FLOAT_ARG,seqtr/1000.0);
		return FAILURE;
	}

	/* adjust grads, tsp, to reflect bandwidth  */

	gfov = opfov*.1;   /*gfov is in cm, opfov is in mm */
	calcvalidrbw((double)oprbw,&bandwidth,&max_rbw,&decimation,OVERWRITE_OPRBW,0);
	gmax = 2e3*bandwidth/(GAM*gfov);    /* max grad allowed for BW */
	gamp = MIN(cfxfs, gmax);
	tsp = TSP*decimation;

	/* readout gradients - calculate 'em here  */

	/* LHG 3.19.20:  Generate XYZ Readout gradients */
	/* figure out how many samples you need and how long it takes to get them */
	Kmax = opxres / gfov;  /* cm^-1*/
	deltaK = 1 / gfov;
	FID_len =(int) (Kmax*Kmax / deltaK/deltaK/4);
	/* covering a circle, not a square:
	area of square= X^2
	area of circle inside:  (X/2)^2 * PI
	so .... */
	FID_len = (int)(FID_len / (3.14259*0.5*0.5));
	/*now adjust for number of interleaves */
	FID_len = FID_len/nl;
	FID_dur = (int)(FID_len*tsp); /* microseconds*/


	/*LHG 5.28.29 force the FID duration to 16 ms */
	/*16 ms seems to work in simulations.  If not, the slowDown factor will
	force it to be higher (below) */
	/* FID_dur = 16000;*/
	fprintf(stderr, "\nInitial  spiral IN-OUT with: ");
	fprintf(stderr,
		"\noprbw: %f \ngfov= %f cm \nKmax= %f \ndeltaK= %f \nFID_len = %d \nFID_dur =%d usec. \nGrad_len = %d \n",
		oprbw, gfov, Kmax, deltaK, FID_len, FID_dur, Grad_len );

	float myGmax = spiralGmax;
	Grad_len = round(FID_dur/4.0);

	float tol_slowDown = 1e-4;
	float slowDown = 1.0;
	int itr_slowDown = 0;
	do {
		for (int n = 0; n < GRESMAX; n++) {
			pfGx[n] = 0;
			pfGy[n] = 0;
			pfGz[n] = 0;
		}
		itr_slowDown++;
		
		Grad_len = round((float)Grad_len * slowDown);
		while (Grad_len % 4 > 0) Grad_len++;
		slowDown = genspiral(pfGx,
				pfGy,
				pfGz,
				Grad_len,
				R_accel,
				THETA_accel,
				Ncenter,
				ramp_frac,
				doXrot,
				doYrot,
				gfov,
				opxres,
				4.0e-6,
				opslthick/10.0,
				opslquant,
				nl,
				SLEWMAX,
				myGmax);
	} while (pow(slowDown - 1.0, 2) > tol_slowDown && itr_slowDown <= 50);

	if (itr_slowDown == 50)
		fprintf(stderr,"warning: max iteration for genspiral slowDown reached, slowDown = %f\n", slowDown);

	FID_dur = 4.0 * (float)Grad_len;

	fprintf(stderr, "\nFinal  spiral IN-OUT is: ");
	fprintf(stderr,
		"\noprbw: %f \ngfov= %f cm \nKmax= %f \ndeltaK= %f \nFID_len = %d \nFID_dur =%d usec. \nGrad_len = %d \n",
		oprbw, gfov, Kmax, deltaK, FID_len, FID_dur, Grad_len );


	pw_gx = (int)(FID_dur);
	pw_gy = (int)(FID_dur);
	pw_gz = (int)(FID_dur);

	/* remember that gfov is in cm. */
	/* Note to self... must ramp down to zero */
	fprintf(stderr,"\nSuccessfully called genspiral ");
	fprintf(stderr,"\n checking Gradient amplitudes... ");

	/* Find the max in each channel... should be myGmax, but making sure */
	for (i=0; i<Grad_len; i++)  {
		if (fabs(pfGx[i])>spiralGxmax) spiralGxmax = fabs(pfGx[i]);
		if (fabs(pfGy[i])>spiralGymax) spiralGymax = fabs(pfGy[i]);
		if (fabs(pfGz[i])>spiralGzmax) spiralGzmax = fabs(pfGz[i]);

		if(pfGx[i]>myGmax) {
			fprintf(stderr,"\nGx gamp violation: %f ", pfGx[i]);
		}
		if(pfGy[i]>myGmax){
			fprintf(stderr,"\nGy gamp violation: %f ", pfGy[i]);
		}
		if(pfGz[i]>myGmax){
			fprintf(stderr,"\nGz gamp violation: %f ", pfGz[i]);
		}
	}
	Gx[0]=0; Gy[0] = 0; Gz[0]=0;

	fprintf(stderr,"\nmyGmax= %f G/cm",  myGmax);
	fprintf(stderr,"\nspiral Gx max= %f G/cm",  spiralGxmax);
	fprintf(stderr,"\nspiral Gy max= %f G/cm",  spiralGymax);
	fprintf(stderr,"\nspiral Gz max= %f G/cm",  spiralGzmax);

	/* find the system's max gradient */
	float XMAX, YMAX, ZMAX;
	gettarget(&XMAX, XGRAD, &loggrd);
	gettarget(&YMAX, YGRAD, &loggrd);
	gettarget(&ZMAX, ZGRAD, &loggrd);

	/* convert to DAC */
	FILE * fid;
	fid = fopen("grad_dac.txt","w");

	fprintf(stderr,"\nTranslating grad waveforms to full scale DAC units ... ");
	for (i=0; i<Grad_len; i++)  {
		Gx[i] = (2*(int)(0.5*pfGx[i]*MAX_PG_WAMP/spiralGxmax));
		Gy[i] = (2*(int)(0.5*pfGy[i]*MAX_PG_WAMP/spiralGymax));
		Gz[i] = (2*(int)(0.5*pfGz[i]*MAX_PG_WAMP/spiralGzmax));
		fprintf(fid , "%d\t%d\t%d\n", Gx[i], Gy[i], Gz[i]);
		}
	fclose(fid);

	fprintf(stderr, "\n...spirals ready ...");

#include "predownload.in"

	/* set up RF pulse  */
	myflip_rf2 = 180;
	flip_rf2 = myflip_rf2;

	a_vsitag1 = vsi_RFmax / my_maxB1Seq;
	a_vsictl1 = vsi_RFmax / my_maxB1Seq;

	/*
	a_rf1 = (opflip/90) * (MAX_B1_SINC1_90/ my_maxB1Seq);
	a_rf2 = (myflip_rf2/180) * (MAX_B1_SINC1_90*2/ my_maxB1Seq); 
	*/
	/***** 5.19.21 : LHG  old code here:
	a_vsitag1 = (myflip_rf2/180) * vsi_RFmax / my_maxB1Seq;
	a_vsictl1 = (myflip_rf2/180) * vsi_RFmax / my_maxB1Seq;
	a_rf1 = opflip/180 ;
	a_rf2 = myflip_rf2/180 ;
	******/
	a_rf1 = opflip/180 ;
	a_rf2 = myflip_rf2/180 ;

	ia_rf1 = a_rf1 * max_pg_iamp;
	ia_rf2 = a_rf2 * max_pg_iamp;

	ia_vsitag1 = a_vsitag1 * max_pg_iamp;
	ia_vsictl1 = a_vsictl1 * max_pg_iamp;

	fprintf(stderr, "\n calculated  a_rf1= %f , opflip= %f: , ia_rf1=  %d", a_rf1, opflip, ia_rf1);
	fprintf(stderr, "\n calculated  a_rf2= %f , myflip_rf2= %f: , ia_rf2=  %d", a_rf2, myflip_rf2, ia_rf2);
	/* set up sat pulse */
	satBW = (cffield==15000)? 220 : 440;
	satoff = (cffield==15000)? -260 : -520;  /* offset  down a little */
	arf0 = 0.5*satBW/1250.0;
	pwrf0 = RUP_GRD((int)(4s*cyc_rf0/satBW));
	fprintf(stderr,"\nsatBW, satoff, arf0, pwrf0 = %f  %f  %f  %d\n", satBW, satoff,
			arf0, pwrf0);

	pw_rf0 = pwrf0;
	a_rf0 = arf0;
	/*LHG 11/155555/2018 */
	a_rf0 = 0.14;



	nbang = (nextra+nl*nframes)*opslquant;
	ndisdaq = MIN(nextra, 6e6/optr);	/* for prescan only  */

	/* set up clock */
	if ((exist(opcgate) == PSD_ON) && existcv(opcgate))
	{
		pidmode = PSD_CLOCK_CARDIAC;
		piviews = nextra+nl*nframes;
		piclckcnt = ophrep;
		pitscan = (float)(optr)*nbang;
		pitslice = seqtr;
	}
	else
	{
		pidmode = PSD_CLOCK_NORM;
		pitslice = seqtr;
		pitscan = (float)(optr)*nbang;
	}
	/*pitscan = (nextra + nframes*nl)*(t_adjust + astseqtime + t_tipdown_core + t_seqcore*opslquant);*/
	pitscan = (nextra + nframes*nl)*optr;
	/////////////////////////////////////////////////////////////
	// LHG 4/12/22 : update clock for MRF
	if(mrf_mode){
		pitscan = 0;
		for(i=0;i<nframes;i++){
			pitscan += (int)(1e6*AStime_array[i] + 0.1);
			pitscan += (int)1e6*t_delay_array[i];
			pitscan += (int)1e6*t_adjust_array[i];
			pitscan += (int)seqtr;
		}
		fpout = fopen("/usr/g/bin/RO_time_scan.txt", "w");
		fprintf(fpout, "%f", 1e-6*seqtr);
		fclose(fpout);
	}
	/////////////////////////////////////////////////////////////


	/* initialize slice sel spoiler gradient. */

	/*  LHG 12/14/12 : replace these for the values we had in the old Signa
	    pw_gzspoil = 800us;
	    a_gzspoil = .5*loggrd.zfs;
	 */

	/*-------------------------------------------------*/
	minte = pw_gzrf2 + 2*pw_gzrf2d;
	minte += pw_gz180crush1 + 2*pw_gz180crush1d;
	minte += pw_gz180crush2 + 2*pw_gz180crush2d;
	minte += FID_dur;
	minte += 4us;
	minte += 2*timessi; /*allow time for the SSI packets in 3 cores */

	if (opte <  minte)
	{
		fprintf(stderr,"\nPrescribed TE (%d) was less than min TE", opte);
		fprintf(stderr,"\nNew TE = %d", minte);
		opte = minte;
	}
	/*-------------------------------------------------*/
	fprintf(stderr, "\npw_gx= %d\tminte= %d", pw_gx, minte);
	fprintf(stderr,
		"\noprbw: %f \tgfov= %f cm \tKmax= %f \tdeltaK= %f \tFID_len = %d \tFID_dur =%d usec. \tGrad_len = %d \n",
		oprbw, gfov, Kmax, deltaK, FID_len, FID_dur, Grad_len );
	fprintf(stderr,"\n---\n");
/*
	cvmin(opte, minte);
	cvdef(opte, minte);
	if ((exist(opautote) == PSD_MINTE)||(exist(opautote) == PSD_MINTEFULL))
		opte = minte;
*/
	ihte1 = opte;

@inline loadrheader.e rheaderinit

	rhimsize = 64;
	while(rhimsize < opxres)  rhimsize *= 2;
	if(off_fov==1)  {
		rhxoff = 0;
		rhyoff = 0;
	}
	else  {
		rhxoff = rhimsize*scan_info[0].oprloc/opfov;
		rhyoff = rhimsize*scan_info[0].opphasoff/opfov;
	}
	rhuser0 = gfov; 	/* grad design fov in cm  */
	rhuser1 = nframes; 	/* number of temporal frames */
	rhuser3 = opxres;		/*  equiv resolution  */
	rhuser4 = nl;   	/* number of interleaves  */
	rhuser5 = gtype;   	/* gradient wavewform rev  */
	rhuser6 = gamp; 	/* grad design ampl  */
	rhuser7 = gslew; 	/* grad slew rate  */
	rhuser9 = bmapnav;  /* if set, keeps dacq fixed in time for ifr=0 */
	rhuser10 = 0;	/* ngap between concat acq's */
	rhuser11 = 0;
	rhuser12 = 0;  	/* receiver center freq, kHz */
	rhuser13 = tsp; 	/* a/d sampling time (us) */
	rhuser14 = (nframes>1 && oppseq==2)? domap : 0;  /* do it if GRE */
	rhuser15 = mapdel;  /* echo difference (us) */
	rhuser21 = alpha;	/* for vd trajectory  */
	rhuser22 = kmaxfrac;
	rhuser23 = vdflag;
	rhuser30 = opslthick;
	rhuser31 = opslspace;

	rhbline = 0;
	rhnecho = (gtype==2)? 2:1;
	rhnslices = opslquant;
	rhrcctrl = 1;
	rhexecctrl = 2; /*  + 16;  save Pfile + make rhrcctrl work */
	/* rhdacqctrl = 0;		LHG: 11/29/13 - take this out in DV 23 */
	rhrecon = opuser3;		/* invoke son of recon */

	acqs = 1;
	slquant1 = rhnslices;

	/* for straight sequential order of slices. */
	if (!orderslice(slord, rhnslices, slquant1, gating))
		epic_error(use_ermes,"orderslice call failed",0,0);

	/* initialize copy of original rotation matrices */
	for (pdi = 0; pdi < rhnslices; pdi++)
		for (pdj = 0; pdj < 9; pdj++)
			savrot[pdi][pdj] = rsprot[pdi][pdj];
	scalerotmats(rsprot, &loggrd, &phygrd, rhnslices, 0);

	/* LHG 19.01.03 scale initial value of savrot matrix, too? */
	/*scalerotmats(savrot, &loggrd, &phygrd, 1, 0);*/

	/* save stuff for maxwell correction */
	rhmaxcoef1a = rsprot[0][0]/(float)cfxfull;	/* save x rotator */
	rhmaxcoef1b = rsprot[0][1]/(float)cfxfull;
	rhmaxcoef2a = rsprot[0][3]/(float)cfyfull; /* y  */
	rhmaxcoef2b = rsprot[0][4]/(float)cfyfull;
	rhmaxcoef3a = rsprot[0][6]/(float)cfzfull; /* z  */
	rhmaxcoef3b = rsprot[0][7]/(float)cfzfull;

	rhdab0s = cfrecvst;
	rhdab0e = cfrecvend;

	if(entrytabinit(entry_point_table, (int)ENTRY_POINT_MAX)
			== FAILURE) {
		epic_error(use_ermes,"Can't initialize entry point table.",0,0);
		return FAILURE;
	}

	/* set up receiver */

	initfilter();

	cvmax(rhfrsize, 32768);		/* for now  */
	/*LHG 7.10.10:  we want the ramp! */
	/*rhfrsize = (res_gx-RES_GRAMP)*4us/tsp;      /* num points sampled */
	rhfrsize = Grad_len;      /* num points sampled */

	total_views=2*((nl*nframes+1)/2);  /* has to be an even number */
	cvmax(rhnframes, total_views);
	rhnframes = total_views;

	if (calcfilter( &echo1_filt,bandwidth,rhfrsize,OVERWRITE_OPRBW ) == FAILURE) {
		epic_error(use_ermes,"%s failed",EM_PSD_SUPPORT_FAILURE,1,STRING_ARG,"calcfilter");
		return FAILURE;
	}
	setfilter( &echo1_filt, SCAN );
	filter_echo1 = echo1_filt.fslot;

	if (calcfilter( &aps2_filt,bandwidth,psfrsize,OVERWRITE_OPRBW ) == FAILURE) {
		epic_error(use_ermes,"%s failed",EM_PSD_SUPPORT_FAILURE,1,STRING_ARG,"calcfilter");
		return FAILURE;
	}
	setfilter( &aps2_filt, PRESCAN );
	filter_aps2 = aps2_filt.fslot;

	rhrawsize = 2*rhptsize*rhfrsize*(rhnframes+1)*rhnslices*rhnecho;
	numrecv = rhdab0e-rhdab0s+1;
	if((float)rhrawsize*numrecv > cftpssize-2e7)  {      /* reserve 20 MB */
		epic_error(use_ermes,"Oops! Tooo much memory requested.\n",0,0);
		return FAILURE;
	}

	strcpy(entry_point_table[L_SCAN].epname, "scan");
	entry_point_table[L_SCAN].epfastrec = 0;
	entry_point_table[L_SCAN].epstartrec = rhdab0s;
	entry_point_table[L_SCAN].ependrec = rhdab0e;
	entry_point_table[L_SCAN].epfilter = (unsigned char)echo1_filt.fslot;
	entry_point_table[L_SCAN].epprexres = rhfrsize;
	entry_point_table[L_SCAN].epxmtadd = getCoilAtten(); 

	entry_point_table[L_APS2] =
		entry_point_table[L_MPS2] =
			entry_point_table[L_SCAN];      /* copy scan into APS2 & MPS2 */

	strcpy(entry_point_table[L_APS2].epname,"aps2");
	strcpy(entry_point_table[L_MPS2].epname,"mps2");
	entry_point_table[L_APS2].epfilter = (unsigned char)aps2_filt.fslot;
	entry_point_table[L_MPS2].epfilter = (unsigned char)aps2_filt.fslot;
	entry_point_table[L_APS2].epprexres = psfrsize;
	entry_point_table[L_MPS2].epprexres = psfrsize;


	/*LHG 7.13.21 */
	/* Set xmtadd according to maximum B1 and rescale for powermon,
	   adding additional (audio) scaling if xmtadd is too big.
	   Add in coilatten, too. */
	fprintf(stderr, "\n Adjusting Transmitter Gain with setScale() ... ");
	fprintf(stderr, "\n maxB1[L_SCAN]=%0.3f before setScale .  L_SCAN is the %d entry", maxB1[L_SCAN], L_SCAN);
	fprintf(stderr, "\n a_rf1 before setScale=%0.3f", a_rf1);

	//-----------------------
	/*	LHG 2.11.22:  turn up the Gain but scale back the FSE pulses */	
	//-----------------------
	//  LHG 3/1/2022 : Removed this section ...
	/*
	xmtaddScan = -200*log10(TX_scale*my_maxB1Seq/maxB1Seq/1000) + getCoilAtten(); 

	if (xmtaddScan > cfdbmax) {
		extraScale = (float) pow(10.0, (cfdbmax - xmtaddScan)/200.0);
		xmtaddScan = cfdbmax;
	} else {
		extraScale = 1.0;
	}

	if( setScale( L_SCAN, RF_FREE, rfpulse, maxB1[L_SCAN],  extraScale) == FAILURE )
	{
		epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE,
				EE_ARGS(1), STRING_ARG, "setScale" );
		return FAILURE;
	}

	a_rf1 /= 2.0;
	a_rf2 /= 2.0;
	ia_rf1 /= 2;
	ia_rf2 /= 2;
	//-----------------------
	fprintf(stderr, "\n ...that's that ");
	fprintf(stderr, "\n maxB1[L_SCAN]=%0.3f AFTER setScale .  L_SCAN is the %d entry", 
			maxB1[L_SCAN], L_SCAN);
	fprintf(stderr, "\n a_rf1 after setScale=%0.3f", a_rf1);
	*/


	daqdel = psd_grd_wait + daqdeloff + 0.5;
	trigfreq = opslquant; /* default for TTL trig is every TR */

	/*  Some prescan stuff  */

	pislquant = opslquant;

@inline Prescan.e PSfilter
@inline Prescan.e PSpredownload

		phys_record_flag = opuser10;        /* put here so it isn't overwritten in predownload */
	phys_record_channelsel = 14;        /* PG wave,trig & RESP */

	/* LHG 11/4/19:  including mrf timing */
	if (mrf_mode)
	{
		M0frames = 0;
		doBS = 0;

		if(fpin=fopen("/usr/g/bin/t_delays.txt", "r")) {     /* look for ext. file */
			i=0;
			while (fscanf(fpin, "%f", &tmp) != EOF)
				t_delay_array[i++] =tmp;
			fclose(fpin);
		}
		else{
			fprintf(stderr, "\n* Didn't find external files t_delays... No fingerprinting mode! *");
			mrf_mode=0;
		}

		if(fpin=fopen("/usr/g/bin/t_adjusts.txt", "r")) {     /* look for ext. file */
			i=0;
			while (fscanf(fpin, "%f", &tmp) != EOF)
				t_adjust_array[i++] =tmp;
			fclose(fpin);
		}
		else{
			fprintf(stderr, "\n* Didn't find external files t_adjusts ... No fingerprinting mode! *");
			mrf_mode=0;
		}
		if(fpin=fopen("/usr/g/bin/isVelocitySelective.txt", "r")) {     /* look for ext. file */
			i=0;
			while (fscanf(fpin, "%f", &tmp) != EOF)
				isVelocitySelective_array[i++] =tmp;
			fclose(fpin);
		}
		else{
			fprintf(stderr, "\n* Didn't find external file isVelocitySelective... No fingerprinting mode! *");
			mrf_mode=0;
		}
		if(fpin=fopen("/usr/g/bin/doArtSuppression.txt", "r")) {     /* look for ext. file */
			i=0;
			while (fscanf(fpin, "%f", &tmp) != EOF)
				doArtSuppression_array[i++] =tmp;
			fclose(fpin);
		}
		else{
			fprintf(stderr, "\n* Didn't find external file isVelocitySelective... No fingerprinting mode! *");
			mrf_mode=0;
		}
		if(fpin=fopen("/usr/g/bin/AS_delays.txt", "r")) {     /* look for ext. file */
			i=0;
			while (fscanf(fpin, "%f", &tmp) != EOF) 
				AStime_array[i++] =tmp;
			fclose(fpin);
		}
		else{
			fprintf(stderr, "\n* Didn't find external file ASdelays ... No fingerprinting mode! *");
			mrf_mode=0;
		}

	}
	return SUCCESS;
} /* End-Of-Predownload */

@inline Prescan.e PShost
/*
#include "genspiral5.e"
#include "genspiralcdvd.e"
*/

/*LHG 9.17.16 */
#include "read_vsi_pulse.e"

/* LHG 3.18.20:  spiral in-out in one shot */
#include "genspiral.h"

@rsp

int pre = 0; /* prescan flag */
short thamp;

const CHAR *entry_name_list[ENTRY_POINT_MAX] = { "scan", "mps2", "aps2",
@inline Prescan.e PSeplist
};

WF_PULSE thetrec = INITPULSE;   /* fov offset */
WF_PULSE *thetrecintl;
WF_HW_WAVEFORM_PTR *thetrecintlp;
WF_PULSE thetrec2 = INITPULSE;   /* fov offset */
WF_PULSE *thetrecintl2;
WF_HW_WAVEFORM_PTR *thetrecintlp2;
int *fxmit, *frec;
int *slcphastab;
int *slordtab;
short ibuf[GRESMAX]; 	/*  for intwave.h  */

/* LHG 9/26/12/ Tables for kz encoding (grad amplitudes and phases) */
int *rfphastab,*rfamptab;
/* LHG 11.18.21 :  varying crusher amplitudes to avoid stimulated echoes*/
float *crusheramptab;

@rspvar


int iv, ifr, isl, kzcount;
int tmp;
int i;
int bangn;
int trig, dtype;

short trigonpkt[3] = {0, SSPOC+DREG, SSPD+DSSPD4};
short trigoffpkt[3] = {0, SSPOC+DREG, SSPD};
short trigonwd, trigoffwd;

/* variables needed for prescan */
short chopamp;
int view, slice, dabop, excitation, ec, rf1Phase, seqCount;
int rspent, rspdda, rspbas, rspvus, rspgy1, rspasl;
int rspesl, rspchp, rspnex, rspslq, rspsct;
int dabmask;
@inline Prescan.e PSrspvar	/* For Prescan */
extern PSD_EXIT_ARG psdexitarg;

@pg
#include "support_func.h"	/* new for 28x */
#include <math.h>
#include <stdio.h>
  
#include "epic_loadcvs.h"
#include "pgen_tmpl.h"
#include "support_func.h"
#include "seriosmatx.h"

long deadtime_tipdown_core;
long deadtime_refocus_core;
long deadtime_seqcore;
/*
long deadtime_dummy_core;
*/
/*----------------------------------
  LHG 6.29.12
  --------------------------------*/
long 	deadtime_astcore;
long 	deadtime_controlcore;
long 	deadtime_nothingcore;
long	deadtime_tadjustcore;
long	deadtime_preBScore;
long	deadtime_tdelaycore;
long	deadtime_art_suppress_core;
long	deadtime_fat_suppress_core;
long	deadtime_vsi_gapcore;

/* LHG 6.29.12:  declaration of pulse waveforms for the kz-phase encode pulses
   WF_PULSE gzphase1a = INITPULSE; WF_PULSE gzphase1 = INITPULSE; WF_PULSE gzphase1d = INITPULSE;
   WF_PULSE gzphase2a = INITPULSE; WF_PULSE gzphase2 = INITPULSE; WF_PULSE gzphase2d = INITPULSE;
/* -----------------------------------------------------*/

/* LHG 6/14/22 : packet words needed for R1 dynamic attenuation from PCASL code*/
short sspwm_dynr1[4]={SSPDS,SSPOC,SSPD,SSPDS};
/*****/

STATUS pulsegen(void)
{
	int waitloc, waitloc2;
	char tstr[40];
	short *ts;
	int j, k;
	int leafn, slicen, spiraln;
	int n, s;
	short debugstate ;
	debugstate = debug;

	sspinit(psd_board_type);
	fprintf(stderr, "my_maxB1Seq=%.4f \n", my_maxB1Seq);

	/* first core is the tip down pulse (90) */
	fprintf(stderr, "\npulsegen: generating RF1 pulse (90) ... ");
	fprintf(stderr, "RUP_GRD(tlead + pw_gzrf1a + psd_rf_wait) = ");
	fprintf(stderr, "RUP_GRD(%f + %f + %f) = ", tlead, pw_gzrf1a, psd_rf_wait);
	fprintf(stderr, "%f\n", RUP_GRD(tlead + pw_gzrf1a + psd_rf_wait));
	SLICESELZ(rf1,
			RUP_GRD(tlead + pw_gzrf1a + psd_rf_wait),
			pwrf1,
			yfov * 10 * slab_fraction,  /* this is for FOV reduction (mm) */
			opflip,
			cycrf1,,
			loggrd);

	fprintf(stderr,"\n pw_gzrf1  = %d",  pw_gzrf1);
	fprintf(stderr,"\n pw_rf1  = %d",  pw_rf1);
	fprintf(stderr,"\n start of gzrf1  = %d",  RUP_GRD(pbegall(&gzrf1,0)));
	fprintf(stderr,"\n start of gzrf1  = %d",  RUP_GRD(pbegall(&gzrf1,0)));
	fprintf(stderr,"\n end of gzrf1 =%d ",  RUP_GRD(pendall(&gzrf1,0)));

	fprintf(stderr, "\npulsegen: generating refocuser for the 90 RF   ... ");
	/*refocuser for slice select pulse*/
	TRAPEZOID(ZGRAD,
			gzrf1r,
			/*pendall(&gzrf1, 0) + pw_gzrf1ra,*/
			RUP_GRD(tlead + psd_rf_wait + 2*pw_gzrf1a + pw_gzrf1 + pw_gzrf1ra ),
			0,
			0,loggrd);

	fprintf(stderr,"\n start of gz refocuser =%d ",  RUP_GRD(pbegall(&gzrf1r,0)));
	fprintf(stderr,"\n end of gz refocuser = %d",  RUP_GRD(pendall(&gzrf1r,0)));
	fprintf(stderr,"\n t_tipdown_core =%d ", t_tipdown_core);

	SEQLENGTH(tipdown_core, t_tipdown_core -timessi , tipdown_core);
	getperiod(&deadtime_tipdown_core, &tipdown_core, 0);
	fprintf(stderr, "\n t_tipdown_core done ... \n" );


	/* Next core is for a fast spin echo train */

	/* first half of crusher pair */
	fprintf(stderr, "\npulsegen: generating first half of crusher pair   ... ");
	TRAPEZOID(ZGRAD,
			gz180crush1,
			RUP_GRD(pw_gz180crush1a ),
			0,
			0,loggrd);


	fprintf(stderr,"\n start of gz180crush1  = %d",  RUP_GRD(pbegall(&gz180crush1,0)));
	fprintf(stderr,"\n end of gz180crush1 =%d ",  RUP_GRD(pendall(&gz180crush1,0)));
	fprintf(stderr,"\n pulsegen: generating RF2 pulse for FSE train   ... ");
	SLICESELZ(rf2,
			pend(&gz180crush1d, "gz180crush1d",0) + pw_gzrf2a + tlead + psd_rf_wait,
			pwrf2, /* use the same pulse as the 90, but double it */
			zfov * 10 * se_slab_fraction,  /* (mm) */
			myflip_rf2, /*flip angle should be a 180*/
			cycrf2,,
			loggrd);

	fprintf(stderr,"\n RF2 starts at : %d",  RUP_GRD(pbegall(&rf2, 0) ));
	fprintf(stderr,"\n pulsegen: generating second half of crusher pair   ... ");
        TRAPEZOID(ZGRAD,
                        gz180crush2,
			pend(&gzrf2d, "gzrf2d",0) + pw_gz180crush2a,
                        0,
                        0,loggrd);

	SEQLENGTH(refocus_core, t_refocus_core + textra - timessi, refocus_core);
	getperiod(&deadtime_refocus_core, &refocus_core, 0);
	fprintf(stderr, "\n t_refocus_core done ... \n" );


	/*LHG 20.3.18: change the location of the spirals to coincide with the spin echo*/
	daqpos = readpos;

	/*waitloc = RUP_GRD(pendall(&gzphase1,0)); */
	waitloc  = readpos;
	fprintf(stderr, "\nreadout core (seqcore) timing:");
	fprintf(stderr, "\npw_rf2 : %d , opte: %d , FID_dur: %d, Grad_len: %d", pw_rf2, opte, FID_dur, Grad_len);
	fprintf(stderr, "\nreadpos = %d , waitloc = %d", readpos, waitloc);

	fprintf(stderr, "\npulsegen: create the spiral gradient waveforms ... ");
	INTWAVE(XGRAD,
			gx,
			readpos,
			spiralGxmax, Grad_len, Grad_len*4, Gx,
			1,
			loggrd);
	INTWAVE(YGRAD,
			gy,
			readpos,
			spiralGymax, Grad_len, Grad_len*4, Gy,
			1,
			loggrd);

	INTWAVE(ZGRAD,
			gz,
			readpos,
			spiralGzmax, Grad_len, Grad_len*4, Gz,
			1,
			loggrd);
	fprintf(stderr, "... done.  ");

	fprintf(stderr, "\npulsegen: create echo buffer ... ");
	ACQUIREDATA(echo1, readpos + daqdel, , ,  );

	fprintf(stderr, "... done. " );

/*LHG 4.23.2020 : don't change the phase waveform in receiver
*/
	fprintf(stderr, "\npulsegen: initializing receiver phase (thetrec) ... ");
	pulsename(&thetrec, "thetrec");
	createreserve(&thetrec, THETA, Grad_len);
	fprintf(stderr, "\nreadpos=%d, daqdel=%d, thetdeloff = %d, pw_gx =%d \n", readpos, daqdel, thetdeloff, pw_gx);
	createinstr(&thetrec, RUP_RF(readpos+daqdel+thetdeloff), pw_gx, max_pg_iamp);
	fprintf(stderr, "... done. " );


	/* DJF 4.25.22 calculation of reciever phase correction for fov offset */
	ts = (short*)AllocNode(Grad_len*sizeof(short));
	thetrecintl = (WF_PULSE *) AllocNode(opslquant*nl*sizeof(WF_PULSE));
	thetrecintlp = (WF_HW_WAVEFORM_PTR *) AllocNode(opslquant*nl*sizeof(WF_HW_WAVEFORM_PTR));	
	float x = off_fov*2.*FS_PI*gamp*GAM*GRAD_UPDATE_TIME*1e-6/(10.0*max_pg_wamp);
	float rdvec[3] = {rsp_info[0].rsprloc, rsp_info[0].rspphasoff, 0.0};
	float Gvec[3];
	float Gvec_rot[3];
	float phsgain[1];
	float rotmatx[9];
	for (leafn = 0; leafn < nl; leafn++) {
		for (slicen = 0; slicen < opslquant; slicen++) {
			/* Determine total view index: */
			spiraln = leafn*opslquant + slicen;

			/* Get rotation matrix for current view */
			for (k=0; k<9; k++) rotmatx[k] = rotmatrices[spiraln][k];
			
			/* Integrate phase gain due to gradient at each point */	
			ts[0] = 0;
			for (j=1; j<Grad_len; j++) {
				/* put gradient into vector form for matrix multiplication: */
				Gvec[0] = (float) Gx[j];
				Gvec[1] = (float) Gy[j];
				Gvec[2] = (float) Gz[j];

				/* multiply gradient vector by rotation matrix: */
				multiplymatrix(3,3,1,rotmatx,Gvec,Gvec_rot);
				
				/* dot product with rd vector to get total phase gain */
				multiplymatrix(1,3,1,Gvec_rot,rdvec,phsgain);

				/* Integrate phase gain */
				if (kill_rx_phase) ts[j] = (short)(0.0) & ~WEOS_BIT;
				else ts[j] = (short) (ts[j-1] + x*IRINT(phsgain[0])) & ~WEOS_BIT;
			}
			ts[Grad_len - 1] |= WEOS_BIT;

			/* Use ts to set waveform: */
			sprintf(tstr, "thetrecint_%d", spiraln);
			pulsename(&thetrecintl[spiraln], tstr);
			createreserve(&thetrecintl[spiraln], THETA, Grad_len);
			movewaveimm(ts, 
				&thetrecintl[spiraln], 
				(int) 0, 
				Grad_len, TOHARDWARE);
			thetrecintlp[spiraln] = thetrecintl[spiraln].wave_addr;

		}
	}
	FreeNode(ts);
	/* initial load */
	setwave(thetrecintlp[0], &thetrec, 0);
	fprintf(stderr, "... done.  ");

	/* spiral rewinders not needed.  Already included in spiral trajectory:
	fprintf(stderr, "\npulsegen: generating spiral rewinders with agxpre = %f... ", agxpre);
	SINUSOID(XGRAD,
			gxpre,
			RUP_GRD(pend(&gx, "gx",0) ),
			pwgpre,
			-prefudge*agxpre,
			0, 0.,
			0.5,
			0., loggrd);
	SINUSOID(YGRAD,
			gypre,
			RUP_GRD(pend(&gx, "gx",0) ),
			pwgpre,
			-prefudge*agypre,
			0,
			0.,
			0.5,
			0., loggrd);
	fprintf(stderr, "... done. " );
	printf("\npwgpre = %d, agxpre = %d, agypre = %d, areax = %d, areay = %d\n", pwgpre,agxpre,agypre,areax,areax);
*/

	/* fprintf(stderr, "\npw_gzphase=%d , pw_gzphasea = %d", pw_gzphase1, pw_gzphase1a);  */
	/*waitloc2 = pend(&gx,"gx",0);*/

	fprintf(stderr, "\n pw_gx =%d , pw_gy = %d", pw_gx, pw_gy);

	/*SEQLENGTH(seqcore, t_seqcore + textra - timessi , seqcore);*/
	SEQLENGTH(seqcore, t_seqcore + textra -timessi  , seqcore);
	getperiod(&deadtime_seqcore, &seqcore, 0);

	fprintf(stderr, "\n...seqcore done. \n" );

	/* dummy core to calibrate RF pulses */
	/*
	
	fprintf(stderr, "\n pulsegen: generating RFDUMMY pulse ... ");
	pw_dummyrf = 500;
	res_dummyrf = 500*4;
	a_dummyrf = 1;
	
	INTWAVE(RHO,
		dummyrf,
		RUP_GRD( psd_rf_wait + tlead),
		1.0,
		500,
		500*4,
		dummyrf_wave,
		1,
		loggrd);
	
	fprintf(stderr, " ... done.");
	
	SEQLENGTH(dummy_core, 10ms, dummy_core);
	getperiod(&deadtime_dummy_core, &dummy_core, 0);
	*/
	/*  pass packet sequence (pass).  */
	PASSPACK(endpass, 49ms);
	SEQLENGTH(pass, 50ms, pass);


	/* LHG 1/14/13:  add an extra inversion pulse to be played before the labeling train: */
	fprintf(stderr, "\npulsegen: generating BS0  ... ");
	EXTWAVE(RHO,
			BS0rf,
			RUP_RF(psd_rf_wait),
			pw_BS0rf, a_BS0rf, res_BS0rf,
			/*/usr/g/bin/myhsec1t.rho,,loggrd);*/
			sech_7360.rho,,loggrd);

	EXTWAVE(THETA,
			BS0rf_theta,
			RUP_RF(psd_rf_wait),
			pw_BS0rf, 1.0, res_BS0rf,
			/* /usr/g/bin/myhsec1t.theta,,loggrd);*/
			sech_7360.theta,,loggrd);

	TRAPEZOID(ZGRAD, 
			gzBS0rfspoiler,
			RUP_GRD(pendall(&BS0rf,0) +  pw_gzBS0rfspoilera),
			0,0,loggrd);


	t_preBS = pw_BS0rf +  pw_gzBS0rfspoiler + 2*pw_gzBS0rfspoilera +600;

	SEQLENGTH(preBScore, RUP_RF(t_preBS -timessi ),preBScore);
	fprintf(stderr, " \n...  ");
	getperiod(&deadtime_preBScore, &preBScore, 0);
	fprintf(stderr, " \n... finisehd the BS core that goes in front of the labeling train ");

	/* LHG 9.27.16 Here is the VSAI tagging pulse */
	/* VSAI labeling core */
        /* these should be in DAC units */
	fprintf(stderr, "\n a_vsitag1= %f", a_vsitag1);
	fprintf(stderr, "\n vsi_train_len  = %d", vsi_train_len);
	INTWAVE(RHO,
			vsitag1,
			RUP_GRD(psd_rf_wait),
			a_vsitag1, 
			vsi_train_len,
			vsi_train_len*4,
			vsi_pulse_mag,
			1,
			loggrd);


        INTWAVE(THETA,
                        vsitag1_theta,
                        RUP_GRD(psd_rf_wait) ,
                        1.0,
                        vsi_train_len,
			vsi_train_len*4,
                        vsi_pulse_phs,
                        1,
                        loggrd);



        fprintf(stderr, "\n ... vsitag1 done ." );


        INTWAVE(ZGRAD,
                        gztag1,
                        0 ,
                        vsi_Gmax,
                        vsi_train_len,
			vsi_train_len*4,
                        vsi_pulse_grad,
                        1,
                        loggrd);

        fprintf(stderr, "\n ... gztag1 done ." );

        fprintf(stderr, "\nastseqtime=  %d , textra_astcore= %d  "
                , astseqtime, textra_astcore);


	SEQLENGTH(astcore, RUP_RF(astseqtime + textra_astcore - timessi)  ,astcore);
	getperiod(&deadtime_astcore, &astcore, 0);
        fprintf(stderr, "\n ... astcore (label) done ." );


	/* VSAI control pulse core */

        INTWAVE(RHO,
                        vsictl1,
                        RUP_GRD(psd_rf_wait)  ,
			a_vsitag1,
                        vsi_train_len,
			vsi_train_len*4,
                        vsi_pulse_mag,
			1,
                        loggrd);


        INTWAVE(THETA,
                        vsictl1_theta,
                        RUP_GRD(psd_rf_wait),
                        1.0,
                        vsi_train_len,
			vsi_train_len*4,
                        vsi_pulse_ctl_phs,
                        1,
                        loggrd);


	fprintf(stderr, "\n ... vsictl1 done ." );

        INTWAVE(ZGRAD,
                        gzctl1,
                        0 ,
                        vsi_Gcontrol,
                        vsi_train_len,
			vsi_train_len*4,
                        vsi_pulse_ctl_grad, /* these should be in DAC units */
                        1,
                        loggrd);


        fprintf(stderr, "\n ... gzctl1 done ." );
        fprintf(stderr, "\n ... controlcore (control pulses) done ." );

	SEQLENGTH(controlcore, RUP_RF(astseqtime + textra_astcore - timessi)  ,controlcore);
	getperiod(&deadtime_controlcore, &controlcore, 0);



	/* tagging delay between tagging pulse and image acquisition */
	/* LHG- 12/14/12 -  add the background suppression pulses (sech) */

	fatsattime = pw_rf0 + 2*pw_gz0d +pw_gz0 + 2*timessi;
	fuzz = 10000;
	/*
	   fprintf(stderr, "\npulsegen: generating PID wait with BS pulses ... ");
	   WAIT(SSP,
	   astdelay1,
	   RUP_GRD(24us + fuzz),
	   RUP_GRD(t_delay - BS1_time - BS2_time - pw_BS1rf/2 - 24us - 2*fuzz ));
	 */

	/* LHG 9.28.16 */
        fprintf(stderr, "\n ... nothingcore (Do nothing) done ." );
	SEQLENGTH(nothingcore, astseqtime + textra_astcore  - timessi ,nothingcore);
	getperiod(&deadtime_nothingcore, &nothingcore, 0);

	/* LHG 6.9.17 */
        fprintf(stderr, "\n ... vsi_gap core (Do nothing between VSI pulses) done ." );
	SEQLENGTH(vsi_gapcore, vsi_timegap + textra_vsi_gapcore - timessi  ,vsi_gapcore);
	getperiod(&deadtime_vsi_gapcore, &vsi_gapcore, 0);


	fprintf(stderr, "\npulsegen: generating BS1  ... ");
	EXTWAVE(RHO,
			BS1rf,
			RUP_RF(BS1_time - pw_BS1rf/2 + psd_rf_wait),
			pw_BS1rf, a_BS1rf, res_BS1rf,
			/*/usr/g/bin/myhsec1t.rho,,loggrd);*/
		sech_7360.rho,,loggrd);

	EXTWAVE(THETA,
			BS1rf_theta,
			RUP_RF(BS1_time - pw_BS1rf/2 + psd_rf_wait),
			pw_BS1rf, 1.0, res_BS1rf,
			/* /usr/g/bin/myhsec1t.theta,,loggrd);*/
		sech_7360.theta,,loggrd);

	fprintf(stderr," start: %d	end: %d",
			RUP_RF(BS1_time - pw_BS1rf/2 + psd_rf_wait),
			RUP_RF(BS1_time - pw_BS1rf/2 + pw_BS1rf  + psd_rf_wait ));
	/*
	   fprintf(stderr, "\npulsegen: generating wait between BS pulses  ... ");
	   WAIT(SSP,
	   astdelay2,
	   RUP_GRD(t_delay - BS1_time - BS2_time +  pw_BS1rf/2 + 2*fuzz ),
	   RUP_GRD(BS1_time -  pw_BS1rf - fuzz ));
	 */
	fprintf(stderr, "\npulsegen: generating BS2  ... ");
	EXTWAVE(RHO,
			BS2rf,
			RUP_RF(BS1_time +  BS2_time - pw_BS2rf/2 + psd_rf_wait),
			pw_BS2rf, a_BS2rf, res_BS2rf,
			/* /usr/g/bin/myhsec1t.rho,,loggrd); */
		sech_7360.rho,,loggrd);


	EXTWAVE(THETA,
			BS2rf_theta,
			RUP_RF(BS1_time +  BS2_time - pw_BS2rf/2 + psd_rf_wait),
			pw_BS2rf, 1.0, res_BS2rf,
			/* /usr/g/bin/myhsec1t.theta,,loggrd);  */
		sech_7360.theta,,loggrd);

	fprintf(stderr," start: %d	end: %d",
			RUP_RF(BS1_time +  BS2_time - pw_BS2rf/2 + psd_rf_wait),
			RUP_RF(BS1_time +  BS2_time - pw_BS2rf/2 + psd_rf_wait + pw_BS2rf));
	/*
	   fprintf(stderr, "\npulsegen: generating wait between BS2 and fatsat pulses  ... ");
	   WAIT(SSP,
	   astdelay3,
	   RUP_GRD(t_delay - BS2_time + pw_BS2rf/2 + fuzz),
	   RUP_GRD(BS2_time - pw_BS2rf/2 - fatsattime - 2*fuzz));
	 */
	SEQLENGTH(tdelaycore,t_delay - timessi, tdelaycore);
	getperiod(&deadtime_tdelaycore, &tdelaycore, 0);
	fprintf(stderr, "\n ...  tdelay core done ." );

        fprintf(stderr, "\nArt Suppress core (and fat sat)... e ." );
	fprintf(stderr, "\npulsegen: generating ASrf_* Arterial Suppression BIR pulses  ... ");
	/* Arterial saturation pulses (preloaded BIR-8 pulses from a file) */
	INTWAVE(RHO,
			ASrf_mag,
			RUP_GRD(psd_rf_wait ),
			/*(float)doArtSup * ArtSup_B1max/my_maxB1Seq ,     LHG 4/1/22*/
			ArtSup_B1max/my_maxB1Seq ,
			ArtSup_len,
			ArtSup_len*4,
			ArtSup_mag ,
			1,
			loggrd);


        INTWAVE(THETA,
                        ASrf_theta,
			RUP_GRD(psd_rf_wait ),
			/* float)doArtSup,    LHG 4/1/22 */
			1.0,
			ArtSup_len,
			ArtSup_len*4,
			ArtSup_phs ,
                        1,
                        loggrd);


        INTWAVE(ZGRAD,
                        ASrf_grad,
			0,
			/*(float)doArtSup * ArtSup_Gmax ,  LHG 4/1/22 */
			ArtSup_Gmax ,
			ArtSup_len,
			ArtSup_len*4,
			ArtSup_grad ,
                        1,
                        loggrd);



        fprintf(stderr, "\n ... ASrf done ." );

	SEQLENGTH(art_suppress_core, AStime - timessi, art_suppress_core);
	getperiod(&deadtime_art_suppress_core, &art_suppress_core, 0);
	fprintf(stderr, "\n ... art_suppress_core done ." );



	/* LHG - 12/14/12 -  fat sat pulse from the scan core
	 * regular interleaved sequence (core).
	 */

	fprintf(stderr, "\npulsegen: generating Fat Sat pulse  ... ");
	SINC2(RHO,
			rf0,
			RUP_GRD( psd_rf_wait ),
			pw_rf0,
			a_rf0,
			,0.5,,,loggrd);
	fprintf(stderr," start: %d	end: %d",
			RUP_GRD(AStime - fatsattime + psd_rf_wait ),
			RUP_GRD(AStime - fatsattime + psd_rf_wait + pw_rf0 ));

	fprintf(stderr, "\npulsegen: generating Fat Sat gradients  ... ");
	TRAPEZOID(ZGRAD,
			gz0,
			RUP_GRD(pwrf0 + pw_gz0a),
			0,
			0, loggrd);

	fprintf(stderr, "\n ...  done ." );


	SEQLENGTH(fat_suppress_core, fatsattime - timessi, fat_suppress_core);
	getperiod(&deadtime_fat_suppress_core, &fat_suppress_core, 0);
	fprintf(stderr, "\n ... fat_suppress_core done ." );



	fprintf(stderr, "\npulsegen: Creating TRdelay adjust core ... ");
	/*  make a little trig on DABOUT6 J12  */
	if(maketrig)  {
		trigonwd = SSPD + DABOUT6;
		trigoffwd = SSPD;
		trigonpkt[0] = SSPDS + EDC;
		trigoffpkt[0] = SSPDS + EDC;
		trigonpkt[2] = trigonwd;
		trigoffpkt[2] = trigoffwd;
		SSPPACKET(trigon, trigloc+waitloc, 3us, trigonpkt, 0);
		SSPPACKET(trigoff, trigloc+waitloc+triglen, 3us, trigoffpkt, 0);
	}


	fprintf(stderr,"\noptr: %d, t_preBS: %d, t_tag: %d,  t_delay: %d",  
			optr, t_preBS, t_tag, t_delay);
	fprintf(stderr,"\nAStime = %d, seqtr: %d, opslquant: %d, t_adjust:  %d",
			AStime, seqtr, opslquant,t_adjust );
/*
	WAIT(SSP,
		TRdelay,
		RUP_GRD(24us),
		5ms);
*/
	/* Note that there is a 3ms fudge factor.  Come back and find where the error is!! */
	fprintf(stderr, "\ntimessi: %d ", timessi );

	/* LHG 6/14/22:   SSP packet for adjusting the R1 gain  (fromPCASL codes) */
   	SSPPACKET(dynr1,
		tlead + 4,
		4,
		sspwm_dynr1,);
	/*** Set Attenuator Lock (SSP Lock Control)***/
	ATTENUATOR( attenuator_key, tlead+10 );
	/**************/

	SEQLENGTH(tadjustcore, RUP_RF(t_adjust - timessi ) ,tadjustcore);
	fprintf(stderr, "\n ...  " );
	getperiod(&deadtime_tadjustcore, &tadjustcore, 0);
	fprintf(stderr, "\n ...  done ." );

	/*-------------------------------------------------*/

	/*  wait_for_scan_to_start sequence */
	WAIT(SSP, waitStart, 24us, 1ms);
	SEQLENGTH(waitpass, 10ms, waitpass);

	/*  wait for scanend for real time */
	WAIT(SSP, waitEnd, 24us, 2us);
	SEQLENGTH(waitend, endtime, waitend);
	
	fprintf(stderr, "\n t_tipdown_core =%d,  t_seqcore =%d, \n seqtr =%d, optr=  %d \n", 
			t_tipdown_core, t_seqcore,  seqtr,optr);

@inline Prescan.e PSpulsegen	/*  prescan sequences  */

		buildinstr();              	/* load the sequencer memory */
	return SUCCESS;

} /* end of pulsegen */

@inline Prescan.e PSipg
/* end of @pg */

@rsp

STATUS scancore(void);
int doleaf(FILE* pfRotMatFile, int leafn, int framen, int slicen, int* trig, int* bangn, int dabop, int dtype); 

void get_rfamp(int ntab, int* rfamp);

/* LHG 6.17.22 : code for chaning values of R1 gain */
void set_dynr1(int r1);


/*---------------------------------------------------------
  LHG 6.29.12 : My function declarations
  ----------------------------------------------------*/
void doast(int* trig, int isLabel);
void dodelay(int* trig);
void doadjust(int* trig);
/*---------------------------------------------------------*/



@inline Prescan.e PScore

/*manual prescan */
STATUS mps2() {
	pre = 2;
	scancore();
	rspexit();
	return SUCCESS;
}
/*auto prescan */
STATUS aps2() {
	pre = 1;
	scancore();
	rspexit();
	return SUCCESS;
}
/*Actual scan*/
STATUS scan()
{
	pre = 0;
	scancore();
	rspexit();
	return SUCCESS;
}

void get_spgr_phase(int ntab, int *rfphase);


STATUS scancore()
{
	int	counter;
#define RESERVED_IPG_MEMORY (0xbfff00)
	int	*comm_buffer;		/* to talk to real time recon */
	FILE  	*fpin;                 /* for StartScan file */
	float 	phi;
	int   	i, j, n;

	int 	*vsi_iphase;
	int 	*vsi_iphase_control;
	double 	*rftag_weights;
	double 	vsi_rfphase=0;
	int	multphs_ctr=0;
	long 	rotmatx90[1][9];
	FILE* 	pfRotMatFile; /* this is a log file to save the rotation matrices for debugginh LHG 7/22/2020 */

	pfRotMatFile = fopen("/usr/g/bin/krotations.txt","wb");

	switch (doRotated90){
		case 3:  /* rotation about the z axis of 90 degreees: z gradient */
			rotmatx90[0][0] = 0;
			rotmatx90[0][1] = 32767;
			rotmatx90[0][2] = 0;
			rotmatx90[0][3] = -32767;
			rotmatx90[0][4] = 0;
			rotmatx90[0][5] = 0;
			rotmatx90[0][6] = 0;
			rotmatx90[0][7] = 0;
			rotmatx90[0][8] = 32767;
			break;

		case 1: /* rotation about the y axis of 90 degreees: x gradient */

			rotmatx90[0][0] = 0;
			rotmatx90[0][1] = 0;
			rotmatx90[0][2] = 32767;
			rotmatx90[0][3] = 0;
			rotmatx90[0][4] = 32767;
			rotmatx90[0][5] = 0;
			rotmatx90[0][6] = -32767;
			rotmatx90[0][7] = 0;
			rotmatx90[0][8] = 0;
			break;

		case 2:/* rotation about the x axis of 90 degreees: y gradient */
			rotmatx90[0][0] = 32767;
			rotmatx90[0][1] = 0;
			rotmatx90[0][2] = 0;
			rotmatx90[0][3] = 0;
			rotmatx90[0][4] = 0;
			rotmatx90[0][5] = -32767;
			rotmatx90[0][6] = 0;
			rotmatx90[0][7] = 32767;
			rotmatx90[0][8] = 0;
			break;
	}
	scalerotmats(rotmatx90, &loggrd, &phygrd, 1, 0);

	printf("\nEntering scancore   pre = %d\n", pre);

	/* ---------------------------------------------------------------*/
	/* LHG 12/24/08:  initialize the interactive Real Time vars: */
	/* ---------------------------------------------------------------*/
	int myrfamp ; /* LHG 6.29.12 used for the variable amplitude 3D excitation pulses */

	printf("\ncalculated  a_rf1= %f , opflip= %f: , ia_rf1=  %d", a_rf1, opflip, ia_rf1);
	printf("\ncalculated  a_rf2= %f , myflip_rf2= %f: , ia_rf2=  %d", a_rf2, myflip_rf2, ia_rf2);

        printf("\n TARDIS_FREQ_RES: %d", TARDIS_FREQ_RES);
        printf("\n AST VARIABLES: ");
        printf("\n Gradient max amplitude (a_gztag1):   %f", a_gztag1);
        printf("\n Gradient Duration  (pw_gztag1):  %d", pw_gztag1);
        printf("\n-------------------\n ");
        printf("\n my_maxB1Seq :  %f", my_maxB1Seq);
        printf("\n-------------------\n ");
        fflush(0);
        /* ---------------------------------------------------------------*/


	/* set the pointer comm_buffer to the 64 ints at the top of ipg memory */
	/*comm_buffer = (int *) RESERVED_IPG_MEMORY;*/
	/* set the first entry to the address, as a handshake to recon client */
	/*comm_buffer[0] = (int) (&(comm_buffer[0]));*/

	if(maketrig==1)  {
		setwamp(trigoffwd, &trigon, 2);  /* no trigs yet */
		counter = 0;
	}
	setrfconfig(ENBL_RHO1 + ENBL_THETA);
	setssitime((LONG)timessi/GRAD_UPDATE_TIME);
	rspqueueinit(queue_size);
	scopeon(&seqcore);
	syncon(&seqcore);
	syncoff(&pass);
	setrotatearray((SHORT)opslquant, rsprot[0]);
	settriggerarray((SHORT)opslquant, rsptrigger);

	dabmask = PSD_LOAD_DAB_ALL;
	if(pre)  {
		setrfltrs(filter_aps2, &echo1);
	}
	else  {
		setrfltrs(filter_echo1, &echo1);
	}

	/* fix the clock for aux trig */

	if (!pre && gating==TRIG_AUX)  {
		setscantimemanual();
		setscantimestop();
		setscantimeimm(pidmode, pitscan, piviews,
				pitslice, opslicecnt);
	}

	/* Allocate memory for RF pulse param tables */
	rfphastab = 	(int *) AllocNode(nbang*sizeof(int));
	fxmit = 	(int *) AllocNode(opslquant*sizeof(int));
	frec  = 	(int *) AllocNode(opslquant*sizeof(int));
	slcphastab  = 	(int *) AllocNode(opslquant*sizeof(int));
	slordtab  = 	(int *) AllocNode((opslquant+1)*sizeof(int));
	rfamptab = 	(int *) AllocNode(opslquant*sizeof(int));

	/* LHG: 11.18.21 make table of crusher amplitudes */
	crusheramptab = 	(float *) AllocNode(opslquant*sizeof(int));
	for (i=0; i<opslquant; i++){
		crusheramptab[i] = 1.0 + 0.2*sin(i*2.399);
		crusheramptab[i] *= pow(-1, i);
		fprintf(stderr,"\ncrusher table ...%f", crusheramptab[i]);
	}

	fprintf(stderr,"\nSetting up slice sel xmit Phase table (for RF spoiling) spgr_flag= %d ...", spgr_flag);
	get_spgr_phase(nbang, rfphastab);

	fprintf(stderr,"\nSetting up the slice sel xmit frequency table ...");
	setupslices(fxmit, rsp_info, opslquant, a_gzrf1, 1.0, opfov, TYPTRANSMIT);
	/* for (i=0; i<opslquant; i++) fprintf(stderr,"\nXmit freq:  fxmit[%d] = %d ", i, fxmit[i]);	*/


	/*LHG 9/26/12 - setting up the amplitudes of the slab select pulses */
	fprintf(stderr,"\nSetting up the slice sel xmit Amplitude table ...");
	get_rfamp(opslquant, rfamptab);

	for (isl = 0; isl < opslquant; isl++)
		rsp_info[isl].rsprloc = 0;
	setupslices(frec, rsp_info, opslquant, 0.0, 1.0, 2.0, TYPREC);
	/*for (i=0; i<opslquant; i++) fprintf(stderr,"\nreceive freq:  frec[%d] = %d ", i, frec[i]);	  */

	/* make table for loaddab slice num */
	fprintf(stderr,"\nSetting up the loaddab table ...");

	for (i=0; i<opslquant; i++)
		slordtab[i] = i;

	/*skip this part:  in a 3D sequence the slice order is not determined here*/
	if(0){
		switch((int)opuser16)  {
			case 0:			/* sequential */
				for (i=0; i<opslquant; i++)
					slordtab[i] = i;
				break;
			case 1:			/* interleaved */
				j = 0;
				for (i=0; i<opslquant; i+=2)  {
					slordtab[j++] = i;
					slordtab[j+(opslquant-1)/2] = i+1;
				}
				break;
		}
	}
	/*------------------------------------------------------------*/
	/* phase shift due to sliceselect freq shift  */
	for (isl = 0; isl < opslquant; isl++)  {
		phi = -4.0*cyc_rf1*rsp_info[isl].rsptloc*(1.0 + psd_rf_wait/(float)pw_rf1)/opslthick;
		phi = -1.0*cyc_rf1*rsp_info[isl].rsptloc*(1.0 + psd_rf_wait/(float)pw_rf1)/opslthick;
		slcphastab[isl] = IRINT(FS_PI*phi);
		/*fprintf(stderr,"\nisl slc loc phaseshifts = %d %f %f\n", isl, rsp_info[isl].rsptloc, phi); */
	}

	/* Frequency for Fat Sat pulse */
	setfrequency(IRINT(satoff/TARDIS_FREQ_RES), &rf0, 0);

	bangn = 0;		/* init spoiler counter */
	dabop = DABSTORE;

	/* prescan loop. */
	/* --------------------------------------------------------*/
	ifr = 0;

	fprintf(stderr,"\nDone with setup stuff, getting into loops ...");

	/* we set up the frequency for the 90 just once */
	int myxmitfreq;
	int myxmitfreq_stripe;
 	myxmitfreq = (int)((fxmit[opslquant/2] + fxmit[opslquant/2-1])/2);
	setfrequency(IRINT(myxmitfreq), &rf1, 0);
	/* in CPMG, the 90 and 180 are perpendicular to each other.   The 90 is applied along X (phase = 0).
	the 180's will be along Y axis (phase = 90 or -90) */
	setiphase(0, &rf1, 0);
	setphase(0.0 , &echo1, 0);

	/* store the values of the encoding gradient amplitudes and set them to zero */


	if(pre)  {
		fprintf(stderr,"\n...PRE-SCAN loop ...");
		/* zero out the  readout grads for Rx gain  */
		setiamp(0, &gx,0);
		setiamp(0, &gy,0);
		setiamp(0, &gz,0);

		for (iv = 0; iv < ndisdaq; iv++) {	/*  disdaqs  */
			trig = (gating==TRIG_AUX)? TRIG_INTERN : gating;

			/* rt_updates(); */
			doadjust(&trig);
			doast(&trig, isLabel);
			dodelay(&trig);

			/*setphase(phs_rf2 , &rf2, 0);*/
			// LHG: setiphase(FS_PI/2 , &rf2, 0); 
			// LHG: setphase(0.0 , &echo1, 0);

			/* execute the tip down (90) */
			setrotate((s32 *)rsprot,0);
			if (doRotated90){
				/*scalerotmats(rotmatx90, &loggrd, &phygrd, 1, 0);*/
				setrotate((s32 *)rotmatx90,0);
				myxmitfreq_stripe =  - (int)(delta_y*a_gzrf1*GAM/TARDIS_FREQ_RES);
				setfrequency(myxmitfreq_stripe , &rf1, 0);
				fprintf(stderr, "\nRotation of 90 deg. RF pulse- calculating offset:  myxmitfreq = %d,  myxmitfreq_stripe = %d ",myxmitfreq, myxmitfreq_stripe);
			}
			fprintf(stderr,"\ntipdown  ...");
			boffset(off_tipdown_core);
			startseq(0, MAY_PAUSE);
			settrigger(TRIG_INTERN,0);

			/* now do the spin echo train (180's) */
			/* center-out z phase-encode order */
			/*for (isl = 0; isl < opslquant/2; isl++) {
			/*	doleaf(0,0, opslquant/2 -1-isl, &trig, &bangn, dabop, DABOFF);
			/*	doleaf(0,0, opslquant/2 +isl,   &trig, &bangn, dabop, DABOFF);
			/*}
			*/
			for (isl = 0; isl < opslquant; isl++)
				doleaf(pfRotMatFile,0,0, isl, &trig, &bangn, dabop, DABOFF);

			getiamp(&chopamp, &rf1, 0);
			setiamp(-chopamp, &rf1, 0);
		}
		for (iv = 0; iv < 10000; iv++) {	/* get data  */
			trig = (gating==TRIG_AUX)? TRIG_INTERN : gating;

			/* rt_updates();*/
			doadjust(&trig);
			doast(&trig, isLabel);
			dodelay(&trig);
			/*
			   if (dopresat) {
			   printf("\nDoing a dummy bang");
			   doleaf(0, 0, opslquant/2-1, &trig, &bangn, dabop, DABOFF);
			   bangn-=1;
			   }
			 */
			/* execute the tip down (90) */
			setrotate((s32 *)rsprot,0);
			if (doRotated90){
				/*scalerotmats(rotmatx90, &loggrd, &phygrd, 1, 0);*/
				setrotate((s32 *)rotmatx90,0);
				myxmitfreq_stripe =  - (int)(delta_y*a_gzrf1*GAM/TARDIS_FREQ_RES);
				setfrequency(myxmitfreq_stripe , &rf1, 0);
				fprintf(stderr, "\nRotation of 90 deg. RF pulse- calculating offset:  myxmitfreq = %d,  myxmitfreq_stripe = %d ",myxmitfreq, myxmitfreq_stripe);
			}
			fprintf(stderr,"\n tipdown  ...");
			boffset(off_tipdown_core);
			startseq(0, MAY_PAUSE);
			settrigger(TRIG_INTERN,0);
			fprintf(stderr,"\n a_gzrf1= %d ", a_gzrf1);

			/* now do the spin echo train (180's) */
			/* center-out z phase-encode order */
			/*for (isl = 0; isl < opslquant/2; isl++) {
			/*	dtype = (pre==1 || isl==0)? DABON:DABOFF;
			/*	doleaf(0,0, opslquant/2-isl-1, &trig, &bangn, dabop, dtype);
			/*	doleaf(0,0, opslquant/2+isl,   &trig, &bangn, dabop, dtype);
			/*}
			*/
			/* No need to skip around in rotation */
			for (isl = 0; isl < opslquant; isl++){
				dtype = (pre==1 || isl==0)? DABON:DABOFF;
		 		doleaf(pfRotMatFile, 0, 0, isl,   &trig, &bangn, dabop, dtype);
			}
			getiamp(&chopamp, &rf1, 0);
			setiamp(-chopamp, &rf1, 0);
		}
		/* restore the gradients here */
		rspexit();
	}
	/* ---------------------------------------------------------*/
	/* disdaq loop. */
	/* ---------------------------------------------------------*/
	fprintf(stderr,"\n....DISDAQ loop ...");

	/* restore readout grads */
	setiamp(ia_gx, &gx, 0);
	setiamp(ia_gy, &gy, 0);
	setiamp(ia_gz, &gz, 0);

	if(opuser2==3)  {           /* wait for StartScan to exist */
		boffset(off_waitpass);
		settrigger(TRIG_INTERN, 0);
		while((fpin=fopen("/usr/g/mrraw/StartScan", "r"))==NULL)
			startseq(0, MAY_PAUSE);     /* spin in a 10 ms wait loop  */
	}

	trig = gating;
	counter = 0;
	for (iv = 0; iv < nextra; iv++)  {

		/* if(maketrig==1 && (counter++)%trigfreq==0)*/
		if(maketrig==1 )
			setwamp(trigonwd, &trigon, 2);
		else if(maketrig==1)
			setwamp(trigoffwd, &trigon, 2);

		/* rt_updates();*/
		doadjust(&trig);
		doast(&trig, isLabel);
		dodelay(&trig);

		setrotate((s32 *)rsprot,0);
		if (doRotated90){
			/*scalerotmats(rotmatx90, &loggrd, &phygrd, 1, 0);*/
			setrotate((s32 *)rotmatx90,0);
			myxmitfreq_stripe =  - (int)(delta_y*a_gzrf1*GAM/TARDIS_FREQ_RES);
			setfrequency(myxmitfreq_stripe , &rf1, 0);
			fprintf(stderr, "\nRotation of 90 deg. RF pulse- calculating offset:  myxmitfreq = %d,  myxmitfreq_stripe = %d ",myxmitfreq, myxmitfreq_stripe);
		}

		/* execute the tip down (90) */
		fprintf(stderr,"\n tipdown  ...");

		/*setphase(phs_rf2 , &rf2, 0); */
		// LHG: setiphase(FS_PI/2 , &echo1, 0); 
		// LHG:// LHG:  setphase(0.0 , &echo1, 0);

		boffset(off_tipdown_core);
		startseq(0, MAY_PAUSE);
		settrigger(TRIG_INTERN,0);
		fprintf(stderr,"\n a_gzrf1= %d ", a_gzrf1);

		/* now do the spin echo train (180's) */
		/* center-out z phase-encode order */
		/*for (isl = 0; isl < opslquant/2; isl++) {
		/*	doleaf(0,0, opslquant/2-isl-1, &trig, &bangn, dabop, DABOFF);
		/*	doleaf(0,0, opslquant/2+isl,   &trig, &bangn, dabop, DABOFF);
		/*}
		 */

		/* No need to skip around in rotation */
		for (isl = 0; isl < opslquant; isl++)
			doleaf(pfRotMatFile,0,0 , isl,   &trig, &bangn, dabop, DABOFF);

		/* ---------------------------------------------------------*/
		if(((int)opuser2) == 2) trig = TRIG_AUX;  	/* wait for trig */

		if (iv==0)
			setwamp(trigoffwd, &trigon, 2); /* end TTL trigger out code by SJP ?*/

	}

	/* ---------------------------------------------------------*/
	/* scan loop */
	/* ---------------------------------------------------------*/
	fprintf(stderr,"\n...SCAN loop ...");
	counter = 0;
	isOdd = 0;

	if (multiFlipFlag)
	{
		vsi_RFmax = 0;
		a_vsitag1 = vsi_RFmax / my_maxB1Seq;
		a_vsictl1 = vsi_RFmax / my_maxB1Seq;
		ia_vsitag1 = a_vsitag1 * max_pg_iamp;
		ia_vsictl1 = a_vsictl1 * max_pg_iamp;

		fprintf(stderr,"\nVelSel RF calibration  Mode = %f", vsi_RFmax);
		domap=0;
		/* LHG : 9.27.16 : we don't want the field map when we're adjusting the phase of pcasl pulses*/
	}
	fprintf(stderr,"\ndomap = %d", domap);
	fprintf(stderr,"\nM0frames = %d", M0frames);

	for (ifr = 0; ifr < nframes; ifr++)  {

		/* LHG: 1/29/16: implementing GRAPPA along the z direction */
		isOdd = !isOdd ;  /* the first frame (ie, when ifr == 0) is not odd */

		/* alternate between control and tag after collecting field map (if field map is used)*/
		if( ifr>1 || domap==0)
			isLabel = !(isLabel);

		/* calibration of the flip angles is done by incrementing the RF for each pair */
		if (multiFlipFlag && isLabel  )
		{
			fprintf(stderr,"\n\nVelSel RF calibration  Mode . Frame = %d , vsi_RFmax = %f\n", ifr, vsi_RFmax );
			if (ifr >= M0frames)
			{
				vsi_RFmax += vsi_RFmax_calstep;
				a_vsitag1 =  vsi_RFmax / my_maxB1Seq;
				a_vsictl1 =  vsi_RFmax / my_maxB1Seq;
				ia_vsitag1 = a_vsitag1 * max_pg_iamp;
				ia_vsictl1 = a_vsictl1 * max_pg_iamp;
			}
		}
		/* LHG 11.4.19 : This is where we update the variables from the array in real time*/
		if (mrf_mode ) {
			doArtSup = (int)(doArtSuppression_array[ifr]);
			isLabel  = (int)(isVelocitySelective_array[ifr]);
			t_delay  = (int)(1e6*t_delay_array[ifr]);
			t_adjust = (int)(1e6*t_adjust_array[ifr]);
			AStime   = (int)(1e6*AStime_array[ifr]);
		}

		for (iv = 0; iv < nl; iv++)  {

			if(maketrig==1 )
				setwamp(trigonwd, &trigon, 2);
			else if(maketrig==1)
				setwamp(trigoffwd, &trigon, 2);

			doadjust(&trig);
			doast(&trig, isLabel);
			dodelay(&trig);

			/* setphase(phs_rf2 , &rf2, 0);*/
			// setiphase(FS_PI/2 , &rf2, 0); 
			// LHG: setphase(0.0 , &echo1, 0);

			/* center-out z phase-encode order */
			kzcount=0;

			if (ifr < M0frames )
				fprintf(stderr,"\ncollecting M0 images (and GRAPPA-Z cal data at the odd frames): ifr=%d isOdd=%d", ifr, isOdd);

			setrotate((s32 *)rsprot,0);
			if (doRotated90){
				/*scalerotmats(rotmatx90, &loggrd, &phygrd, 1, 0);*/
				setrotate((s32 *)rotmatx90,0);
				myxmitfreq_stripe =  - (int)(delta_y*a_gzrf1*GAM/TARDIS_FREQ_RES);
				setfrequency(myxmitfreq_stripe , &rf1, 0);
				fprintf(stderr, "\nRotation of 90 deg. RF pulse- calculating offset:  myxmitfreq = %d,  myxmitfreq_stripe = %d ",myxmitfreq, myxmitfreq_stripe);
			}
			/* execute the tip down (90) */
			fprintf(stderr,"\ntipdown  ...");
			boffset(off_tipdown_core);
			startseq(0, MAY_PAUSE);
			settrigger(TRIG_INTERN,0);
			fprintf(stderr,"\nifr = %d,  a_gzrf1= %f , a_gzrf2= %f",ifr, a_gzrf1, a_gzrf2);

			/* now do the spin echo train (180's) */
			for (isl = 0; isl < opslquant; isl++)
		 		doleaf(pfRotMatFile,iv, ifr, isl,   &trig, &bangn, dabop, DABON);

			if(((int)opuser2) == 2) trig = TRIG_AUX;  	/* wait for trig */

		}

		/*comm_buffer[1] = ifr;*/           /* talk to RT grecons */
	}      /* end frames */


	/*cleaning up:*/
	fclose(pfRotMatFile);

	/*LHG 6.15.22:  restore  R1 gain to its value   
	setwamp(SSPDS+RDC,&dynr1,0);
	setwamp(SSPOC+RFHUBSEL,&dynr1,1);
	setwamp(SSPD+R1IND+pscR1-1,&dynr1,2);

	//setwamp(SSPDS,&dynr1,0);
	attenlockon(&attenuator_key);

	boffset(off_tadjustcore);
	startseq(0, MAY_PAUSE);

	/********************/
	fprintf(stderr,"\nRestoring R1 gain to %d",pscR1);
	set_dynr1(pscR1);

	/* tell 'em it's over */
	boffset(off_pass);
	setwamp(SSPD+DABPASS+DABSCAN, &endpass, 2);
	settrigger(TRIG_INTERN, 0);
	startseq(0, MAY_PAUSE);	/* fat lady sings */

	return SUCCESS;
}

/*-----------------------------------------------------
  LHG 5/11/01

  function doast()

  This function sets up the Arterial Spin Labeling frequencies, amplitudes, ...
  -----------------------------------------------------------------------*/
void doast(int* trig, int isLabel)
{

	int slicen, td, n, m;
	s32 rotmatx[1][9];
	float phi, cphi, sphii, DABphase;
	slicen=0;

	fprintf(stderr,"\ndoast ...");

	/* This is where we do the first background suppression pulse: */
	/*
	fprintf(stderr,"\ndoing the first BS pulse before labeling ...");
	boffset(off_preBScore);
	startseq(0, MAY_PAUSE);
	*/

	/* Set up gradient amplitudes  for VSAI train */
	setiamp((int)(max_pg_iamp*(vsi_Gmax/loggrd.zfs)), &gztag1, 0);
	setiamp(ia_vsitag1, &vsitag1,0);
	setiamp(ia_vsictl1, &vsictl1,0);

	switch (vsi_controlmode){
		case 1:
			/* case 1: alternate the sign of the flip angle */
			setiamp( -ia_vsitag1 , &vsictl1, 0);
			break;

		case 2:
			/* case 2: trurn off the RF pulses */
			setiamp( 0 , &vsictl1, 0);
			break;
		case 3:
			/* case 3: Phase of control pulses targets the negative velocities */
			break;
		case 4:
			/* case 4: gradients are reversed (also target negative velocities */
			setiamp( (int)(max_pg_iamp*(-vsi_Gmax/loggrd.zfs)), &gzctl1, 0);
			break;
		case 5:
			/* case 5: control pulses are NOT velselective. everything gets inverted */
			setiamp( 0 , &gzctl1, 0);
			break;
		case 6:
			/* case 6: the control gradient is the absolute value of the gradient (as in paper by Qin)*/
			for (i=0; i<Npoints ; i++){
				vsi_pulse_ctl_grad[i] = abs(vsi_pulse_grad[i]);
			}
			break;
	}




	vsi_axis= vsi_axis_default ;

	/* LHG: 11.7.14:   we will do N_cycles cycles of pulses */
	for(m=0; m<vsi_Ncycles; m++)
	{

		/*-----------------------------------------------------
		  LHG 5/24/01
		  ( un-do the slice rotation )
		  --------------------------------------------------------*/

		switch(vsi_axis) {
			case 3:  /* rotation about the z axis of 90 degreees: z gradient */
				rotmatx[0][0] = 0;
				rotmatx[0][1] = 32767;
				rotmatx[0][2] = 0;
				rotmatx[0][3] = -32767;
				rotmatx[0][4] = 0;
				rotmatx[0][5] = 0;
				rotmatx[0][6] = 0;
				rotmatx[0][7] = 0;
				rotmatx[0][8] = 32767;
				break;

			case 1: /* rotation about the y axis of 90 degreees: x gradient */

				rotmatx[0][0] = 0;
				rotmatx[0][1] = 0;
				rotmatx[0][2] = 32767;
				rotmatx[0][3] = 0;
				rotmatx[0][4] = 32767;
				rotmatx[0][5] = 0;
				rotmatx[0][6] = -32767;
				rotmatx[0][7] = 0;
				rotmatx[0][8] = 0;
				break;

			case 2:/* rotation about the x axis of 90 degreees: y gradient */
				rotmatx[0][0] = 32767;
				rotmatx[0][1] = 0;
				rotmatx[0][2] = 0;
				rotmatx[0][3] = 0;
				rotmatx[0][4] = 0;
				rotmatx[0][5] = -32767;
				rotmatx[0][6] = 0;
				rotmatx[0][7] = 32767;
				rotmatx[0][8] = 0;
				break;
		}
		scalerotmats(rotmatx, &loggrd, &phygrd, 1, 0);
		/* setrotate(rotmatx,slicen); */
		setrotate((s32 *)rotmatx,0);
		/*-----------------------------------------------------------*/

		/* JG 9.5/2019 Remove the gapcore for the first VSI pulse */
		if (m > 0) {
			fprintf(stderr,"\ncalling vsi_gapcore  ...");
			boffset(off_vsi_gapcore);
			startseq(0, MAY_PAUSE);
			settrigger(TRIG_INTERN,0);
		}
		/*LHG 10.30.18 : adding respiratory gating option */
		if (oprtcgate==1) settrigger( vsi_TrigType,  0);

		/* LHG 7/11/13:  while collecting the M0 images, we want the label icompletely off */
		if (ifr < M0frames)
		{
			fprintf(stderr, "\ncalling nothingcore  ...");
			boffset(off_nothingcore);
			startseq(0, MAY_PAUSE);
			fprintf(stderr,"done");
		}
		else
		{
			if (isLabel==1)
			{
				fprintf(stderr, "\nCalling astcore ...");
				boffset(off_astcore);
				startseq(0, MAY_PAUSE);
				fprintf(stderr,"done");

			}
			if (isLabel==0)
			{

				fprintf(stderr, "\nCalling Control core ...");
				boffset(off_controlcore);
				startseq(0, MAY_PAUSE);
				fprintf(stderr,"done");

			}
			if (isLabel==-1)
			{
				fprintf(stderr, "\ncalling nothingcore  ...");
				boffset(off_nothingcore);
				startseq(0, MAY_PAUSE);
				fprintf(stderr,"done");
			}

			if (vsi_rotax) vsi_axis++ ;
			if (vsi_axis >= 4) vsi_axis=1;
		}
	}
	vsi_axis= vsi_axis_default ;

	/* reset offset and go for it */
	if(*trig == TRIG_AUX)
	{                /*  make clock start  */

		setscantimeimm(pidmode,
				astseqtime,
				piviews,
				pitslice,
				opslicecnt);
		setscantimestart();
	}


	*trig = TRIG_INTERN;
}
/*--------------------------------------------------*/


void dodelay(   int* trig)
{
	/*--------------------------------------------------------*/
	/* LHG 11/4/19 - this is where the t_delay gets updated on the fly  */
	/*--------------------------------------------------------*/
	fprintf(stderr,"\ndodelay ...");
	fprintf(stderr,"\nCalling tdelaycore with %d " , t_delay);
	fprintf(stderr,"\nArtSuppression = %01d" , doArtSup);

	/* adjusting the t_delay to include the labeling pulsee and the BGS pulses */
	setperiod(RUP_GRD(t_delay - timessi - BStime - t_tag) , &tdelaycore, 0);
	//setperiod(RUP_GRD(t_delay - timessi ) , &tdelaycore, 0);
	// LHG 3.24.2022


	if (doArtSup == 1){
		setiamp((int)(max_pg_iamp * (ArtSup_B1max/my_maxB1Seq) ), &ASrf_mag, 0);
		setiamp((int)(max_pg_iamp * (ArtSup_Gmax/loggrd.zfs) ), &ASrf_grad, 0);
		/*
		 LHG 4/1/22
		setiamp(ia_ASrf_mag , &ASrf_mag, 0);
		setiamp(ia_ASrf_grad, &ASrf_grad, 0);
		*/
	}
	if (doArtSup == 0){
		/* setiamp(ia_ASrf_mag , &ASrf_mag, 0);   :HG 4/1/22 */
		setiamp((int)(max_pg_iamp * (ArtSup_B1max/my_maxB1Seq) ), &ASrf_mag, 0);
		setiamp(0 , &ASrf_grad, 0);
	}
	if (doArtSup == -1){
		setiamp(0 , &ASrf_mag, 0);
		setiamp(0, &ASrf_grad, 0);
	}
	//////////////////
	if (ifr<M0frames){
		setiamp(0, &ASrf_mag, 0);
		setiamp(0, &ASrf_grad, 0);
	}

	boffset(off_tdelaycore);
	startseq(0, MAY_PAUSE);


	setperiod(AStime - fatsattime - ArtSup_len*4 , &art_suppress_core, 0);
	boffset(off_art_suppress_core);
	startseq(0, MAY_PAUSE);

	boffset(off_fat_suppress_core);
	startseq(0, MAY_PAUSE);
}


void doadjust(  int* trig)
{

	fprintf(stderr,"\ndoadjust ...");
	fprintf(stderr,"\nCalling tadjust_core with %d : ", t_adjust);
	setperiod(RUP_GRD(t_adjust-timessi - t_adjust_fudge) , &tadjustcore, 0);

	/* LHG 1.11.22 */
	if (ifr>=M0frames && doBS==1)
	{
		setperiod(RUP_GRD(t_adjust-timessi - t_adjust_fudge-t_preBS) , &tadjustcore, 0);
		boffset(off_preBScore);
		startseq(0, MAY_PAUSE);

		/* code from PCASL sequence to adjust the R1 gain dynamically :  /
		setwamp(SSPDS+RDC,&dynr1,0);
		setwamp(SSPOC+RFHUBSEL,&dynr1,1);
		setwamp(SSPD+R1IND+rgainasl-1,&dynr1,2);
		/* reset attenuator locks 
		if (rspent == L_SCAN)
		{
			//setwamp(SSPDS|RDC,&dynr1,0);
			attenlockoff(&attenuator_key);
		}  else {
			//setwamp(SSPDS,&dynr1,0);
			attenlockoff(&attenuator_key);
		/*************/
		fprintf(stderr,"\nReturned pscR1: %d, rgainasl: %d", pscR1, rgainasl);
		if ((int)(rgainasl + pscR1) <= 11)
		{
			fprintf(stderr, "\n--> Setting R1 gain to %d", rgainasl+pscR1);
			set_dynr1(rgainasl + pscR1);
		}
		else
		{
			fprintf(stderr, "\n--> Setting R1 gain to 11 since rgainasl + pscR1 > 11");
			set_dynr1(11);
		}
	}


	boffset(off_tadjustcore);
	startseq(0, MAY_PAUSE);

}

void set_dynr1( int r1 )
{
	attenlockoff(&attenuator_key);
	setwamp(SSPDS+RDC,&dynr1,0);
	setwamp(SSPOC+RFHUBSEL,&dynr1,1);
	setwamp(SSPD+R1IND+r1-1,&dynr1,2);
}


/*
 * function doleaf()
 *
 * this function does most of the things connected with a single
 * spiral excitation.  in keeping with standard epic practices,
 * it secretly uses a variety of global variables, including
 * opslquant, savrot, nl, nframes, fxmit, frec, echo1, omrf1, core
 * and gating.
 *
 * arguments
 *     leafn  -- interleaf number.       0 <= leafn  < nl.
 *     framen -- temporal frame number.  0 <= framen < nframes.
 *     slicen -- slice number.           0 <= slicen < opslquant.
 * 		 LHG: in the 3D version, this is now the kz phase encode position.
 *     bangn  -- rf bang number.         0 <= bangn  < nbang.
 *     dabop  -- dabop for loaddab.
 *     dtype  -- type of data acquisition (DABON or DABOFF).
 *
 */

int doleaf(FILE* pfRotMatFile, int leafn, int framen, int slicen, int* trig, int* bangn, int dabop,  int dtype)
{
	int n, k, viewn;
	int echon;
	short rf2amp;
	float rotmatx[9];
	s32 rotmatxTS[1][9];
	/*int phase;*/
	float  phase1, phase2; 
	int myxmitfreq, myrecfreq;
	float zpeamp;
	int i_zpeamp;
	float mycrush;

	/*fprintf(stderr,"\ndoleaf..."); */
	/* Slab selection for 3D AQ, so it's all different from sprlio */

	/* set the frequency of xmitter and receiver.  The offset is right in between the two middle slicesn*/
	myxmitfreq = (int)((fxmit[opslquant/2] + fxmit[opslquant/2-1])/2);
	setfrequency(myxmitfreq, &rf2, 0);

	myrecfreq = (int)((frec[opslquant/2] + frec[opslquant/2-1])/2);
	setfrequency(myrecfreq , &echo1, 0);
	/* setfrequency(0 , &echo1, 0); */


	/* set xmit  amplitude according to precalcualted table by JFN 2011
	   already in DAC units*/

    	/* LHG 11.18.21 : vary the crusher amplitudes to prevent stimulated echoes */
	mycrush = 1.0 + 0.2*sin(slicen*2.399);
	mycrush *= pow(-1, slicen)/4.0;
	//fprintf(stderr,"\ncrusher table ...%f", mycrush);
	/*	
	setiamp((int)(max_pg_iamp*mycrush), &gz180crush1, 0);
	setiamp((int)(max_pg_iamp*mycrush), &gz180crush2, 0);
    	
	*/
	/*setiamp(rfamptab[slicen], &rf1, 0);	LHG fix for ampl. order 7/11/13 */
	/*kzcount = (int)(fmod((float)*bangn,(float)opslquant));*/
	kzcount++;
	if (kzcount >= opslquant)
		kzcount=0;


	/*LHG 2.2.21 restoring the phase cycling  - alternate between 180y and -180y */
	/*toggle the sign of the RF pulse from echo to echo */
	if (rf_phase_cycle) rf_sign *= -1;

	setphase(0, &rf1, 0);
	setphase(phs_rf2 , &rf2, 0);
 
	if (variable_fa==1){	
		/* use variable flip angle in the spin echo train:
		   rf2_fraction is a percentage of 180, so that we can play a train of pulses from
		   start_rf2 to myflip_rf2 */
		rf2_fraction = start_rf2/myflip_rf2 + 
			((float)slicen/(float)opslquant) * (myflip_rf2-start_rf2) / myflip_rf2;
	}
	setiamp(ia_rf2 * rf2_fraction * rf_sign, &rf2, 0);
	

	/* debug info: */	
	getphase(&phase1 , &rf1, 0);
	getphase(&phase2 , &rf2, 0);
//	fprintf(stderr,"\nslicen = %d , 180-fraction = %f, rf1 phase = %f, rf2 phase = %f, sign= %d", 
//		slicen, rf_fraction,phase1, phase2, rf_sign);


	/* Alternate  Rx phase in CPMG  2/22/21 */
	// 2/23/22:  take out the rx phase change 
	//setiphase(rf_sign * FS_PI/2 , &echo1, 0); /*Bingo!!!!  LHG 7/16/21  */

	/*restore rotations and do the 180 refocusers */	
	setrotate((s32 *)savrot,slicen);
	boffset(off_refocus_core);
	startseq(slicen, MAY_PAUSE);

	/* Incrementing the bang counter    */
	(*bangn)++;
	*bangn = *bangn%nbang;      /*  for mps2  */

	/* set up timing. */
	tmp = deadtime_seqcore;
	if (scluster==1)  {
		if (slicen == opslquant-1)
			tmp = optr - opslquant*seqtr;
	}
	else
		if(slicen < nerror)		/* spread the error ... */
			tmp = deadtime_seqcore - trerror/nerror;	/* ... while keeping the sign */

	/* LHG 8/25/21: this may be a problem? */
	/*setperiod(RUP_GRD(tmp), &seqcore, 0);*/

	settrigger(*trig, slicen);


	/* set up dab */
	viewn = framen*nl + leafn + 1;
	echon = 0;

	loaddab(&echo1, slordtab[slicen], echon, dabop, viewn, (TYPDAB_PACKETS)dtype, dabmask);

	/* DJF 4.27.22 set amplitude of kz gradient */
	if (doXrot == 0 && doYrot == 0)
		setiamp( (int) (max_pg_iamp * kzf[leafn*opslquant + slicen] * spiralGzmax / loggrd.zfs), &gz, 0);

	/* DJF 4.25.22 get rotation matrix for current view, scale it, and set scanner */	
	for (k=0; k<9; k++) rotmatx[k] = rotmatrices[leafn*opslquant + slicen][k];
	for (k=0; k<9; k++) rotmatxTS[0][k] = (s32) IRINT(pow(2,15)*rotmatx[k]);

	scalerotmats(rotmatxTS, &loggrd, &phygrd, 1, 0);
	setrotate((s32 *)rotmatxTS[0],slicen);

	/*adjust receiver phase to account for fov offset */
	setwave(thetrecintlp[leafn*opslquant+slicen], &thetrec, 0);

	/* reset offset and go for it */
	boffset(off_seqcore);
	startseq(slicen, MAY_PAUSE);
	if(*trig == TRIG_AUX && ((int)opuser2) >= 1)  {	/*  make clock start  */
		setscantimestart();
	}
	*trig = TRIG_INTERN;
	/* fprintf(stderr,"\nkzcount = %d  bangn= %d  slicen= %d  viewn= %d leafn=%d ", kzcount, *bangn, slicen, viewn, leafn );*/
	/* fprintf(stderr,"..doleaf done.");  */
	return SUCCESS;

}   /* end of function doleaf() */

void get_spgr_phase(int ntab, int* rfphase)
{

	int IA = 141;         /*  24 bit overflow  */
	int IC = 28411;
	int IM = 134456;
	int i, jran;
	float x;
	float frfphase,ftmp;

	switch (spgr_flag)  {
		case 0:           /* no spoiling  */
			for (i=0;i<ntab;i++)
				rfphase[i] = 0;
			break;
		case 1:           /*  GEMS algorithm  */
			rfphase[0] = 0;
			for (i=1;i<ntab;i++)
				rfphase[i] = ((int)((float)rfphase[i-1] + (float)i*seed + 3L*FS_PI) %
						FS_2PI)-FS_PI;
			break;
		case 2:       /* random number generator (Num. Recipes, p.209  */
			jran = seed;
			for (i=0;i<ntab;i++)  {
				jran = (jran*IA + IC) % IM;
				rfphase[i] = (int)((float)(FS_2PI + 1)*(float)jran/(float)IM) - FS_PI;
			}
			break;
		case 3:           /* LHG add RF spoiling with linear phase increment from JFN 3/11/11 */
			rfphase[0] = 0;
			frfphase = 0;
			for (i=1;i<ntab;i++) {
				frfphase += (float) rf_spoil_seed * M_PI / 180.0 * (float) i;
				frfphase = atan2 (sin(frfphase), cos(frfphase));      /* wrap phase to (-pi,pi) range */
				rfphase[i] = (int)(frfphase/M_PI * (float)FS_PI);
			}
		default:
			break;
	}  /* switch  */

	/*
	   fprintf(stderr, "\nPhase Table: ");
	   for (i=0;i<ntab;i++)
	   fprintf(stderr,"\nget_spgr_phase: rfphase[%d] = %d / ", i, rfphase[i]);
	 */
	return;

}	/*  end get_spgr_phase  */


void get_rfamp(int ntab, int* rfamp)
{
	int i;
	float a0,a,sina,E1;

	E1 = exp(-(float)(seqtr)/(float)1300ms);
	fprintf(stderr,"\nget_rfamp: E1 = %f", E1);

	switch (rfamp_flag)  {
		case 0:           /* constant flip angle */
			for (i=0;i<ntab;i++)
				rfamp[i] = ia_rf1;
			break;
		case 99:          /* Gai schedule */
			a0 = opflip/180.0*M_PI;
			a = a0;
			rfamp[0] = (int) (a0/(M_PI/2.0)*max_pg_iamp);
			for (i=1;i<ntab;i++) {
				sina = sin(a0)*tan(a)/(E1*sin(a0)+(1-E1)*tan(a));
				if (sina < 1)
					a = asin(sina);
				else
					a = (float) (M_PI/2.0);
				rfamp[i] = (int) (a/(M_PI/2.0)*max_pg_iamp);
			}
			break;
		default:           /* some power */
			for (i=0;i<ntab;i++) {
				rfamp[i] = opflip + (int) (pow(i,rfamp_flag)*(90-opflip)/pow(ntab-1,rfamp_flag));
				/* fprintf(stderr,"\nget_rfamp: rfamp[%d] = %d / ", i, rfamp[i]); */
				rfamp[i] = (int) ((float)rfamp[i]/90.0*max_pg_iamp);
				/*fprintf(stderr,"%d", rfamp[i]);*/
			}
			break;
	}  /* switch  */

}       /*  end get_rfamp */



@pg
/********************************************
 * dummylinks
 *
 * This routine just pulls in routines from
 * the archive files by making a dummy call.
 ********************************************/
void dummylinks()
{
	epic_loadcvs("thefile"); /* for downloading CVs */
}
