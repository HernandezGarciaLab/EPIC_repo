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
 * Changes by doug for UM environment
 *    umsp1a	9/22/12        added daqdelr, changed field mapping for both in and out, hide the disdaq
 *    umsp2a	11/5/13        conversion to V23
 *
 *
 * (c) Board of Trustees, Leland Stanford Junior University 1993-2011.
 *      Gary H. Glover
 */
/*@End*************************************************************/

@inline epic.h
@inline intwave1.h

@global
#include <math.h>
#ifndef HW_IO
#include <stdio.h>
#include <stdlib.h>
#else /* HW_IO */
#include <stdioLib.h>
#endif /* !HW_IO */
#include <string.h>

#include "stddef_ep.h"
#include "epicconf.h"
#include "pulsegen.h"
#include "em_psd_ermes.in"
#include "epic_error.h"
#include "support_func.h"
#include "filter.h"
#include "epicfuns.h"
#include "epic_loadcvs.h"
#include "InitAdvisories.h"
#include "psdiopt.h"
#include "epic_iopt_util.h"

#include "grad_rf_sprlio.globals.h"

#define GRESMAX       21000     /* number of points grad max */
#define RES_GRAMP       100     /* number of points grad rampdown  */
#define TSP             2.0us   /* slow rcvr sampling 500kHz */
#define MAX_BW		250
#define IRINT(f) ((((f)-(int)(f)) < 0.5) ? ((int) (f)) : (1+(int)(f)))
#define MAX(a,b) ( (a > b) ? a : b ) 
#define MIN(a,b) ( (a < b) ? a : b ) 
#define ABS(a) ( (a < 0) ? -a : a ) 

/* DV26 */
int debug = 0;

@inline Prescan.e PSglobal	
int debugstate = 1;

@cv
@inline loadrheader.e rheadercv
@inline Prescan.e PScvs   

int nl = 1 with {1,128,,,"number of interleaves",}; /* number of interleaves */
int scluster = 0 with {0,1,,,"1=cluster slices together in time, 0=not",};
int nextra = 2 with {0,,,,"number of disdaqs",};
int nframes = 1 with {1,,,,"number of time frames",};
int total_views;	/*  total shots to gather per slice */
int gating = TRIG_INTERN with {,,,,"1=line,3=ecg,5=aux,7=intern,9=nline",};
int psdseqtime;     /* sequence repetition time */
int psdtottime;     /* actual TR = psdseqtime*opslquant */
int timessi=120 with {0,,400us,INVIS,"time from eos to ssi in intern trig",};
int trerror;		/* error in TR total */
int nerror;		/* num slices  to take up the TR error */
int gtype = 0 with {0,99,1,VIS, "trajectory: (0) spiral out, (1) spiral in, (2) both",};
float gslew = 150.0 with {0.0,3000.0,1,VIS, "readout gradient max slew, mT/m/ms",};
float gamp = 2.3 with {0.0,50.0,1,VIS, "readout gradient max amp",};
float gfov = 20.0 with {0.0,100.0,1,VIS, "readout gradient design FOV, cm",};
int gres = 0 with {0,32768,1,VIS, "gradient waveform resolution",};
float gmax = 2.4 with {0.0,10.0,1,VIS, "bw-limited readout gradient amp",};
float rtimescale = 2.1 with {0.1,10.0,1,VIS, "grad risetime scale relative to cfsrmode",};
int nramp = RES_GRAMP with {0,4096,1,VIS, "spiral gradient ramp res",};
float agxpre = 0.;      /* calculated x dephasing amplitude for spiral in-out */
float agypre = 0.;      /* calculated y dephasing amplitude for spiral in-out */
float prefudge = 1.004 with {0.0,2.0,1,VIS, "prephaser fudge fac ",};
int pwgpre = 1ms;       /* calculated dephasing width for spiral in-out */
int tadmax;     /* maximum readout duration  */
int tlead = 160;      /* initial lead time for rf pulse prep*/
float daqdeloff = 7.0us; /* MR750 */
float daqdelrev = 19.0us; /* MR750 - reverse spiral has diff delay */
int daqdel = 128us; /*  gradient delay vs readout */
int daqdel2 = 128us; /*  gradient delay vs readout */
int thetdeloff = 0us;
int espace = 140us with {0,,1,VIS, "space between echoes",};
int readpos;        /* position of readout gradients, based on oppseq */
int daqpos;        /* position of readout window, based on oppseq */
int minte;
int seqtr = 0 with {0,,1,VIS, "total time to play seq",};
int endtime = 500ms with {0,,,,"time at end of seq in rt mode",};

int vdflag = 1 with {0,1,,VIS, "variable-density flag",};
float alpha = 3.6 with {1.01,200,,VIS, "variable-density parameter alpha",};
float kmaxfrac = 0.5 with {0.05,0.95,,VIS, "fraction of kmax to switch from constant to variable density spiral",};

int slord;

float satBW = 440.0 with {0.0,10000.0,1,VIS, "sat bw, Hz",};
float satoff = -520.0 with {-10000.0,1000.0,1,VIS, "sat center freq, Hz",};
int pwrf0;
float arf0;

int pwrf1 = 6400us;
int cycrf1 = 4;

int domap = 1 with {0,2,1,VIS, "1=do B0 map & recon, 2 = only do B0 map",};
int mapdel = 2ms;   /* variable delay for field map */
int bmapnav = 0 with {0,1,1,VIS, "1=do nav cor for bmap",};

int off_fov = 1 with {0,1,1,VIS, "1 for rcvr offset fov, 0 for fftshift",};

float tsp = 4.0us with {1.0,12.75,,, "A/D sampling interval",};
float bandwidth = 125.0 with {2.0,250.0,1,VIS, "CERD rec low pass freq, kHz",};
float decimation = 1.0;

int filter_aps2 = 1;
int psfrsize = 512 with {0,,,INVIS, "num data acq during APS2",};
int queue_size = 1024 with {0,,,INVIS, "Rsp queue size",};

int spgr_flag = 1 with {0,256,,VIS,"Spoiling: 0=no, 1=GEMS, 2=rand, >2 =quad slope",};
int seed = 16807 with {0,16807,,VIS,"Spoiled Grass seed value",};
int nbang = 0 with {0,,,,"total rf shots",};   
float zref = 1.0 with {,,,VIS, "refocussing pulse amp factor",};

int trigloc = 5.1ms with {0,,0,VIS, "location of ext trig pulse after RF",};
int triglen = 4ms with {0,,0,VIS, "duration of ext trig pulse",};
int trigfreq = 1 with {1,128,0,VIS, "num views between output trigs",};
int maketrig = 1 with {0,1,0,VIS, "trigger output port (1) or not (0)",};

int ndisdaq = 4;                 /* For Prescan: # of disdaqs ps2*/
int pos_start = 0 with {0,,,INVIS, "Start time for sequence. ",};
int obl_debug = 0; /* for obloptimize, I guess */
int obl_method = 1 with {0,1,0,INVIS,
	"On(=1) to optimize the targets based on actual rotation matrices",};

@ipgexport
@inline Prescan.e PSipgexport
long savrot[TRIG_ROT_MAX][9];   /* copy of rotation matrices */
RF_PULSE_INFO rfpulseInfo[RF_FREE];
int Gx[GRESMAX]; 
int Gy[GRESMAX];	 /*  for spiral waves  */

@host
#include "stdio.h"
/* #include "sar_pm.h" */

/*DV26*/
#include "psdopt.h"
#include "sar_burst_api.h"
#include "sar_display_api.h"
#include "sar_limit_api.h"
#include "sar_pm.h"

#include "grad_rf_sprlio.h"
#include "fudgetargets.c"

static char supfailfmt[] = "Support routine %s exploded!";
FILTER_INFO echo1_filt;
FILTER_INFO aps2_filt;

int genspiral(float D, int N, float Tmax, float dts);
int genspiralcdvd(float D, int N, float Tmax, float dts, float alpha, float kmaxfrac);
int gram_duty(void);

@inline Prescan.e PShostVars

@inline loadrheader.e rheaderhost

abstract("Spiral fMRI sequence");
psdname("sprlio2266"); 

int cvinit()
{
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
    cvmin(oppseq,2);
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
    cvdef(oprbw, 125);		
    oprbw = 125.;		

    return SUCCESS;
    
}

int cveval()
{
    int tmptr, entry;

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

    cvdesc(opuser0, "# of interleaves");
    cvdef(opuser0, 1.0);
    opuser0 = 1;
    cvmin(opuser0, 1.0);
    cvmax(opuser0, 128.0);
    nl = opuser0;
    
    cvdesc(opuser1, "number of temporal frames");
    cvdef(opuser1, 1);
    opuser1 = 1;
    cvmin(opuser1, 1);
    cvmax(opuser1, 16384);
    nframes = opuser1;

    cvdesc(opuser2, "Ext trig: (0)none, start (1)scan, (2)frame");
    cvdef(opuser2, 0);
    opuser2 = 0;
    cvmin(opuser2, 0);
    cvmax(opuser2, 2);
    gating = (opuser2==1 || opuser2==2)? TRIG_AUX : TRIG_INTERN;        /* aux trig */
    
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
    /* map acq is hidden as a disdaq, if possible */
    if (opuser5 > 0.5) {
      nextra = opuser5-1;
      nframes = opuser1+1;
    } else {
      nextra = opuser5;
      nframes = opuser1;
    }

    cvdesc(opuser6, "gtype: (0) spiral out, (1) spiral in, (2) both");
    cvdef(opuser6, 2);
    opuser6 = 2;
    cvmin(opuser6, 0);
    cvmax(opuser6, 2);
    gtype = opuser6;

    cvdesc(opuser10, "Record physio data (1) or not(0)");
    cvdef(opuser10, 0);
    opuser10 = 0;
    cvmin(opuser10, 0);
    cvmax(opuser10, 1);

    cvdesc(opuser11, "Realtime mode (1) or not(0)");
    cvdef(opuser11, 0);
    opuser11 = 0;
    cvmin(opuser11, 0);
    cvmax(opuser11, 1);

    cvdesc(opuser12, "short rf pulse (1) or not(0)");
    cvdef(opuser12, 0);
    opuser12 = 0;
    cvmin(opuser12, 0);
    cvmax(opuser12, 1);
    if(opuser12 == 1)  {
      cycrf1 = 2;
      pwrf1 = 3200;
    }  else  {
      cycrf1 = 4;
      pwrf1 = 6400;
    }

    cvdesc(opuser13, "vd (1) or cd (0)");   
    cvdef(opuser13, 0);
    opuser13 = 0;
    cvmin(opuser13, 0);
    cvmax(opuser13, 1);
    vdflag = opuser13;

    cvdesc(opuser14, "alpha");
    cvdef(opuser14, 3.6);
    opuser14 = 3.6;
    cvmin(opuser14, 1.01);
    cvmax(opuser14, 10);
    alpha = opuser14;

    cvdesc(opuser15, "kmaxfrac");
    cvdef(opuser15, 0.5);
    opuser15 = 0.5;
    cvmin(opuser15, 0.05);
    cvmax(opuser15, 0.95);
    kmaxfrac = opuser15;

    cvdesc(opuser16, "slc order: seq (0) or intlvd (1)");
    cvdef(opuser16, 0);
    opuser16 = 0;
    cvmin(opuser16, 0.);
    cvmax(opuser16, 1.);
    switch ((int)opuser16)  {
      case 0:           
        slord = TYPNORMORDER;        
        break;
      case 1:
        slord = TYPNCAT;
        break;
    }

    piamnub = 7;
    pixresnub = 3;
    cvmin(opxres, 16);
    cvdef(opxres, 64);
    opxres = 64;
    pixresval2 = 64;
    pixresval3 = 96;
    pixresval4 = 128;
    piyresnub = 0;

  /* ************************************************
     RF Scaling
     Scale Pulses to the peak B1 in whole seq.
     ********************************************** */
/*  maxB1Seq = 0.0;
  for (entry=0; entry < MAX_ENTRY_POINTS; entry++) {
    if (peakB1(&maxB1[entry], entry, RF_FREE, rfpulse) == FAILURE) {
      epic_error(use_ermes,"peakB1 failed",EM_PSD_SUPPORT_FAILURE,1,STRING_ARG,"peakB1");
      return FAILURE;
    }
    if (maxB1[entry] > maxB1Seq)
      maxB1Seq = maxB1[entry];
  }
sjp */

if( findMaxB1Seq(&maxB1Seq, maxB1, MAX_ENTRY_POINTS, rfpulse, RF_FREE) == FAILURE )
{
epic_error(use_ermes,supfailfmt,EM_PSD_SUPPORT_FAILURE,EE_ARGS(1),STRING_ARG,
"findMaxB1Seq");
return FAILURE;
}

@inline Prescan.e PScveval

    return SUCCESS;
}

/*DV26*/
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



int cvcheck()
{
  return SUCCESS;
}

int predownload()
{
    int pdi, pdj;
    int i;
    float max_rbw;
    FILE *fpin;

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
    gamp = loggrd.xfs;
    gslew = MIN(cfsrmode,150.0);   /* can't use it all  */

    if(fpin=fopen("daqdeloff.sprl", "r")) {     /* look for ext. file */
      fscanf(fpin, "%f", &daqdeloff);
      fscanf(fpin, "%f", &daqdelrev);
      fclose(fpin);
    }  

/*  try to make tr check */

    tmin = RUP_GRD(tlead +pw_rf0 + pw_gz0 + 2*pw_gz0a + pw_gzrf1a + 
      pw_rf1/2 + opte + pw_gx + daqdel + mapdel + pw_gzspoil + 
      2*pw_gzspoila) + timessi;
    if(gtype==1)  tmin -= pw_gx;
    if(gtype==2)  tmin += espace;
    if(nl>1) tmin += pw_gxspoil + 2*pw_gxspoila;
    seqtr = tmin*opslquant;
    psdseqtime = (scluster==0)? RUP_GRD(optr/opslquant) : tmin + 460us;	/* add some time */
    psdtottime = psdseqtime*opslquant;
    trerror = psdtottime - optr;
    nerror = fabs((double)trerror)/GRAD_UPDATE_TIME;
    printf("seqtr, tmin, psdseqtime, psdtottime, trerror=  %d  %d  %d  %d  %d\n", seqtr,tmin,psdseqtime,psdtottime,trerror);
    if(seqtr > optr)  {
       epic_error(use_ermes,"Oops! optr must be > %.1f ms.\n", EM_PSD_SUPPORT_FAILURE,1,FLOAT_ARG,seqtr/1000.0);
       return FAILURE;
    }

/* adjust grads, tsp, to reflect bandwidth  */

    gfov = opfov*.1;
    calcvalidrbw((double)oprbw,&bandwidth,&max_rbw,&decimation,OVERWRITE_OPRBW,0);
    gmax = 2e3*bandwidth/(GAM*gfov);    /* max grad allowed for BW */
    gamp = MIN(cfxfs, gmax);
    tsp = TSP*decimation;

/* readout gradients - calculate 'em here  */

    tadmax = tsp*GRESMAX;		/* max readout */
    if(vdflag==0) {
     if(!(genspiral(gfov, opxres, tadmax*1.e-6, 4.e-6))) {
       epic_error(use_ermes,"Oops! genspiral failed\n",0,0);
       return FAILURE;
     }
    }
    else{
      if(!(genspiralcdvd(gfov, opxres, tadmax*1.e-6, 4.e-6, alpha, kmaxfrac))) {
        epic_error(use_ermes,"Oops! genspiral CDVD failed\n",0,0);
        return FAILURE;
      }
    }
    if(gram_duty() == FAILURE) return FAILURE;

#include "predownload.in"	

/* set up RF pulse  */
    a_rf1 = cyc_rf1*(6400us/pw_rf1)*opflip/360;
    ia_rf1 = a_rf1 * max_pg_iamp;

/* set up sat pulse */
    satBW = (cffield==15000)? 220 : 440; 
    satoff = (cffield==15000)? -260 : -520;  /* offset  down a little */
    arf0 = 0.5*satBW/1250.0;	
    pwrf0 = RUP_GRD((int)(4s*cyc_rf0/satBW));
    printf("satBW, satoff, arf0, pwrf0 = %f  %f  %f  %d\n", satBW, satoff, 
	arf0, pwrf0);


/*  spoilers to return the readout grads to a constant state  */

    if(nl>1)  {		/* only if interleaving */
      pw_gxspoila = 2*cfrmp2xfs;
      pw_gxspoild = 2*cfrmp2xfs;
      pw_gxspoil = 500us;
      a_gxspoil = 0.5*loggrd.yfs;
      pw_gyspoila = 2*cfrmp2yfs;
      pw_gyspoild = 2*cfrmp2yfs;
      pw_gyspoil = 500us;
      a_gyspoil = 0.5*loggrd.yfs;
    }

    nbang = (nextra+nl*nframes)*opslquant;
    ndisdaq = MIN(nextra, 6e6/optr);	/* for prescan only  */

    /* set up clock */
    if ((exist(opcgate) == PSD_ON) && existcv(opcgate))
    {
	pidmode = PSD_CLOCK_CARDIAC; 
	piviews = nextra+nl*nframes;
	piclckcnt = ophrep;
	pitscan = (float)(optr)*nbang/opslquant;
	pitslice = psdseqtime;
    }
    else
    {
	pidmode = PSD_CLOCK_NORM;
	pitslice = psdseqtime;
	pitscan = (float)(optr)*nbang/opslquant;
    }

    /* initialize slice sel spoiler gradient. */

    pw_gzspoil = 800us;
    a_gzspoil = .5*loggrd.zfs;
    pw_gzspoila = cfrmp2zfs;
    pw_gzspoild = cfrmp2zfs;

    minte = pw_rf1/2+pw_gzrf1d + pw_gz2+2*pw_gz2a;
    if(gtype>0) minte += pw_gx + pwgpre;
    cvmin(opte, minte);
    cvdef(opte, minte);
    if ((exist(opautote) == PSD_MINTE)||(exist(opautote) == PSD_MINTEFULL))
	opte = minte;
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
    rhuser16 = nextra;  /* number of disdaqs */
    rhuser19 = opuser5 - nextra; /* =1 if map acq is part of disdaq */
    rhuser20 = alpha;	/* for vd trajectory  */
    rhuser21 = gtype; /* for compatability */
    rhuser22 = kmaxfrac;
    rhuser23 = vdflag;
   
    rhuser30=opslthick;
    rhuser31=opslspace;

    rhuser32=daqdeloff;
    rhuser33=daqdelrev; 
    
    rhbline = 0;  
    rhnecho = (gtype==2)? 2:1;
    rhnslices = opslquant;
    rhrcctrl = 1;    		/* lx wants to create images.  */
    rhexecctrl = 2;  		/* just save the raw data */
    rhrecon = opuser3;		/* invoke son of recon */

    if(opuser11==1.0)           /* turn on/off RDS for realtime */
      rhtype1 |= (0x00080000 | 0x00100000);
    else
      rhtype1 &=  0x0007FFFF;

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
    rhfrsize = (res_gx-RES_GRAMP)*4us/tsp;      /* num points sampled */
    rhfrsize = 4*(rhfrsize/4);          /* wants to be divisible by 4 */
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

    daqdel = psd_grd_wait + daqdelrev + 0.5;
    daqdel2 = psd_grd_wait + daqdeloff + 0.5;
    if (gtype == 0) daqdel = psd_grd_wait + daqdeloff + 0.5;

    strcpy(entry_point_table[L_SCAN].epname, "scan");
    entry_point_table[L_SCAN].epfastrec = 0;
    entry_point_table[L_SCAN].epstartrec = rhdab0s;
    entry_point_table[L_SCAN].ependrec = rhdab0e;
    entry_point_table[L_SCAN].epfilter = (unsigned char)echo1_filt.fslot;
    entry_point_table[L_SCAN].epprexres = rhfrsize;
    entry_point_table[L_SCAN].epxmtadd = txCoilInfo[getTxIndex(coilInfo[0])].coilAtten;
    entry_point_table[L_APS2] =
    entry_point_table[L_MPS2] =
    entry_point_table[L_SCAN];      /* copy scan into APS2 & MPS2 */
    strcpy(entry_point_table[L_APS2].epname,"aps2");
    strcpy(entry_point_table[L_MPS2].epname,"mps2");
    entry_point_table[L_APS2].epfilter = (unsigned char)aps2_filt.fslot;
    entry_point_table[L_MPS2].epfilter = (unsigned char)aps2_filt.fslot;
    entry_point_table[L_APS2].epprexres = psfrsize;
    entry_point_table[L_MPS2].epprexres = psfrsize;

    trigfreq = opslquant; /* default for TTL trig is every TR */

/*  Some prescan stuff  */

    pislquant = opslquant;

@inline Prescan.e PSfilter
@inline Prescan.e PSpredownload

    phys_record_flag = opuser10;        /* put here so it isn't overwritten in predownload */
    phys_record_channelsel = 15;        /* PG wave,trig & RESP */

    return SUCCESS;
} /* End-Of-Predownload */

@inline Prescan.e PShost
#include "genspiral5.e"
#include "genspiralcdvd.e"
#include "gram_duty.e" 

@rsp

int pre = 0; /* prescan flag */
short thamp;

CHAR *entry_name_list[ENTRY_POINT_MAX] = { "scan", "mps2", "aps2",
@inline Prescan.e PSeplist
};

WF_PULSE thetrec = INITPULSE;   /* fov offset */
WF_PULSE *thetrecintl;
WF_HW_WAVEFORM_PTR *thetrecintlp;
WF_PULSE thetrec2 = INITPULSE;   /* fov offset */
WF_PULSE *thetrecintl2;
WF_HW_WAVEFORM_PTR *thetrecintlp2;
int *fxmit, *frec;
int *rfphastab;
int *slcphastab;
int *slordtab;
short ibuf[GRESMAX]; 	/*  for intwave.h  */

@rspvar
int iv, ifr, isl;
int tmp;
int i, k;
int bangn;
int trig, dtype;

short trigonpkt[3] = {0, SSPOC+DREG, SSPD+DSSPD4};
short trigoffpkt[3] = {0, SSPOC+DREG, SSPD};
short trigonwd, trigoffwd;

/* variables needed for prescan */
short chopamp;	
int view, slice, dabop, excitation, seqCount, ec, rf1Phase, seqCount;
int rspent, rspdda, rspbas, rspvus, rspgy1, rspasl;
int rspesl, rspchp, rspnex, rspslq, rspsct;  
int dabmask;
@inline Prescan.e PSrspvar	/* For Prescan */
extern PSD_EXIT_ARG psdexitarg;

@pg

#include <epic_loadcvs.h>
long deadtime_core;

STATUS pulsegen(void)
{
    int waitloc, waitloc2;
    char tstr[40];
    short *ts;
    int j, jj;
    float rdx, rdy;
    float cphi, sphi, x;

    sspinit(psd_board_type);

/*
 * regular interleaved sequence (core). 
 */
    SINC2(RHO, rf0, tlead, pwrf0, arf0,,0.5,,,loggrd);
    TRAPEZOID(ZGRAD, gz0, pend(&rf0, "rf0", 0)+ pw_gz0a, 4*1ms, 1, loggrd);

    SLICESELZ(rf1, pend(&gz0d,"gz0d",0)+pw_gzrf1a, (opslthick>=1.0)? pwrf1:9000, opslthick, opflip,cycrf1,, loggrd);
    TRAPEZOID(ZGRAD, gz2, RUP_GRD(pend(&gzrf1d, "gzrf1d", 0)+ pw_gz2a), -.5*zref*a_gzrf1*(pw_rf1+pw_gzrf1d),1, loggrd);
    waitloc = pend(&gz2d,"gz2d",0);
    readpos = RUP_GRD(pmid(&rf1,"rf1",0) + opte);

    daqpos = readpos;
    if(gtype>0)  {
      readpos -= gres*4us;
      daqpos -= (gres - nramp)*4us;
      SINUSOID(XGRAD, gxpre, readpos-pwgpre, pwgpre, prefudge*agxpre, 0, 0., 0.5, 0., loggrd);
      SINUSOID(YGRAD, gypre, readpos-pwgpre, pwgpre, prefudge*agypre, 0, 0., 0.5, 0., loggrd);
    }

    WAIT(XGRAD, mapx, waitloc, 4us);
    WAIT(YGRAD, mapy, waitloc, 4us);
    WAIT(ZGRAD, mapz, waitloc, 4us);
    WAIT(THETA, mapt, waitloc, 4us);
    WAIT(SSP, maps1, waitloc, 4us);
    INTWAVE(XGRAD, gx, readpos, gamp, gres, Gx, 1, loggrd);
    INTWAVE(YGRAD, gy, readpos, gamp, gres, Gy, 1, loggrd);
    ACQUIREDATA(echo1, daqpos+daqdel,,, );

    pulsename(&thetrec, "thetrec");
    createreserve(&thetrec, THETA, gres);
    createinstr(&thetrec, RUP_RF(readpos+daqdel+thetdeloff), pw_gx, max_pg_iamp);

    waitloc2 = pend(&gx,"gx",0);

/* spiral out as echo 2 */

    if(gtype==2)  {
      readpos = RUP_GRD(pend(&gx,"gx",0) + espace);
      INTWAVE(XGRAD, gx2, readpos, gamp, gres, Gx, -1, loggrd);
      INTWAVE(YGRAD, gy2, readpos, gamp, gres, Gy, -1, loggrd);
      ACQUIREDATA(echo2, readpos+daqdel2,,, );

      pulsename(&thetrec2, "thetrec2");
      createreserve(&thetrec2, THETA, gres);
      createinstr(&thetrec2, RUP_RF(readpos+daqdel2+thetdeloff), pw_gx, max_pg_iamp);

      waitloc2 = pend(&gx2,"gx2",0);
    }
 
    WAIT(SSP, maps3, waitloc2+daqdel+20us, mapdel+4us);

/* Fov offset  */
    ts = AllocNode(gres*sizeof(short));
    thetrecintl = (WF_PULSE *) AllocNode(nl*sizeof(WF_PULSE));
    thetrecintlp = (WF_HW_WAVEFORM_PTR *) AllocNode(nl*sizeof(WF_HW_WAVEFORM_PTR));
    if(gtype==2)  {
      thetrecintl2 = (WF_PULSE *) AllocNode(nl*sizeof(WF_PULSE));
      thetrecintlp2 = (WF_HW_WAVEFORM_PTR *) AllocNode(nl*sizeof(WF_HW_WAVEFORM_PTR));        
    }
    rdx = rsp_info[0].rsprloc;
    rdy = rsp_info[0].rspphasoff;
    for (i = 0; i < nl; i++) {
      cphi = cos(2.0*3.14159265*i / (double) nl);
      sphi = sin(2.0*3.14159265*i / (double) nl);
      x = off_fov*2.*FS_PI*gamp*GAM*GRAD_UPDATE_TIME*1e-6/(10.0*max_pg_wamp);
      sprintf(tstr, "thetrecint_%d", i);
      pulsename(&thetrecintl[i], tstr);
      createreserve(&thetrecintl[i], THETA, gres);
      /* The demodulation waveform necessary for this interleaf */
      if(gtype==0)  {
        ts[0] = 0;
        for (j = 1; j < gres; j++)  {
          ts[j] = (short) (ts[j-1] + x*((cphi*Gx[j] - sphi*Gy[j])*rdx +
                          (cphi*Gy[j] + sphi*Gx[j])*rdy)) & ~WEOS_BIT;
        }
      }  else  {
        ts[gres-1] = 0;
        for (j = gres-2; j >=0; j-=1)  {
          ts[j] = (short) (ts[j+1] - x*((cphi*Gx[j] - sphi*Gy[j])*rdx +
                          (cphi*Gy[j] + sphi*Gx[j])*rdy)) & ~WEOS_BIT;
        }
      }
      ts[gres - 1] |= WEOS_BIT;
      movewaveimm(ts, &thetrecintl[i], (int) 0, gres, TOHARDWARE);
      thetrecintlp[i] = thetrecintl[i].wave_addr;
      if(gtype==2)  {
        sprintf(tstr, "thetrecint2_%d", i);
        pulsename(&thetrecintl2[i], tstr);
        createreserve(&thetrecintl2[i], THETA, gres);
        ts[0] = 0;
        for (j = 1; j < gres; j++)  {
          jj = gres -j - 1;
          ts[j] = (short) (ts[j-1] - x*((cphi*Gx[jj] - sphi*Gy[jj])*rdx +
                          (cphi*Gy[jj] + sphi*Gx[jj])*rdy)) & ~WEOS_BIT;
        }
        ts[gres - 1] |= WEOS_BIT;
        movewaveimm(ts, &thetrecintl2[i], (int) 0, gres, TOHARDWARE);
        thetrecintlp2[i] = thetrecintl2[i].wave_addr;
      }
    }   
    FreeNode(ts);
    setwave(thetrecintlp[0], &thetrec, 0);      /* initial load */
    if(gtype==2)  setwave(thetrecintlp2[0], &thetrec2, 0);

    TRAPEZOID(ZGRAD, gzspoil, RUP_GRD(waitloc2+pw_gzspoila),0,TYPNDEF, loggrd); 
    if(nl>1)  {
      TRAPEZOID(XGRAD, gxspoil, RUP_GRD(pend(&gzspoild,"gzspoild",0)+pw_gxspoila),0,TYPNDEF, loggrd); 
      TRAPEZOID(YGRAD, gyspoil, RUP_GRD(pend(&gzspoild,"gzspoild",0)+pw_gxspoila),0,TYPNDEF, loggrd); 
    }

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

    SEQLENGTH(seqcore,psdseqtime-timessi,seqcore); 
    getperiod(&deadtime_core, &seqcore, 0);

/*  pass packet sequence (pass).  */
    PASSPACK(endpass, 49ms);
    SEQLENGTH(pass, 50ms, pass);

/*  wait_for_scan_to_start sequence */
    WAIT(SSP, waitStart, 24us, 1ms);
    SEQLENGTH(waitpass, 10ms, waitpass);

/*  wait for scanend for real time */
    WAIT(SSP, waitEnd, 24us, 2us);
    SEQLENGTH(waitend, endtime, waitend);

@inline Prescan.e PSpulsegen	/*  prescan sequences  */

    buildinstr();              	/* load the sequencer memory */
    return SUCCESS;

} /* end of pulsegen */

@inline Prescan.e PSipg
/* end of @pg */

@rsp

STATUS scancore(void);
int doleaf(int leafn, int framen, int slicen, int* trig, int* bangn, int dabop, int dtype);

@inline Prescan.e PScore

int mps2() {
    pre = 2;
    scancore();
    rspexit();
    return SUCCESS;
} 
 
int aps2() {
    pre = 1;
    scancore();
    rspexit();
    return SUCCESS;
}

int scan() 
{ 
    pre = 0; 
    scancore(); 
    rspexit();
    return SUCCESS;
}

void get_spgr_phase(int ntab, int *rfphase);

STATUS scancore()
{
    int counter;
#define RESERVED_IPG_MEMORY (0xbfff00)
    int *comm_buffer;		/* to talk to real time recon */
    float phi;
    int i, j;

    printf("entering scancore   pre = %d\n", pre);

/* set the pointer comm_buffer to the 64 ints at the top of ipg memory */
    comm_buffer = (int *) RESERVED_IPG_MEMORY;
/* set the first entry to the address, as a handshake to recon client */
    comm_buffer[0] = (int) (&(comm_buffer[0]));

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
       if(rhnecho==2) setrfltrs(filter_aps2, &echo2);
     }
     else  {
       setrfltrs(filter_echo1, &echo1);
       if(rhnecho==2) setrfltrs(filter_echo1, &echo2);
    }

    /* fix the clock for aux trig */
    
    if (!pre && gating==TRIG_AUX)  {
      setscantimemanual(); 
      setscantimestop(); 
      setscantimeimm(pidmode, pitscan, piviews, 
			pitslice, opslicecnt);
    }

    rfphastab = (int *) AllocNode(nbang*sizeof(int));
    get_spgr_phase(nbang, rfphastab);
    fxmit = (int *) AllocNode(opslquant*sizeof(int));
    frec  = (int *) AllocNode(opslquant*sizeof(int));
    slcphastab  = (int *) AllocNode(opslquant*sizeof(int));
    slordtab  = (int *) AllocNode((opslquant+1)*sizeof(int));

    setupslices(fxmit, rsp_info, opslquant, a_gzrf1, 1.0, opfov, TYPTRANSMIT);
    setiamp(ia_rf1, &rf1, 0);
  
    setfrequency(satoff/TARDIS_FREQ_RES, &rf0, 0);

    for (isl = 0; isl < opslquant; isl++)
	rsp_info[isl].rsprloc = 0;
    setupslices(frec, rsp_info, opslquant, 0.0, 1.0, 2.0, TYPREC);

/* make table for loaddab slice num */

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
  
/* phase shift due to sliceselect freq shift  */

    for (isl = 0; isl < opslquant; isl++)  {
      phi = -4.0*cyc_rf1*rsp_info[isl].rsptloc*(1.0 + psd_rf_wait/(float)pw_rf1)/opslthick;
      slcphastab[isl] = FS_PI*phi;
      /*printf("isl slcloc phase = %d %f %f\n", isl, rsp_info[isl].rsptloc, phi);*/
    }

    if(rhuser14>0 && !pre)  {	/* first shot is delayed for map */
        setperiod(mapdel+4us, &mapx, 0);
        setperiod(mapdel+4us, &mapy, 0);
        setperiod(mapdel+4us, &mapz, 0);
        setperiod(mapdel+4us, &mapt, 0);
        setperiod(mapdel+4us, &maps1, 0);
        setperiod(4us, &maps3, 0);
      }

    bangn = 0;		/* init spoiler counter */
    dabop = DABSTORE;

    /* prescan loop. */
    if(pre)  {		
      /* I think these lines shift the a/d window so that TG is set correctly */
      /* as written, this lengthens the TR slightly during presacn -DCN */
      if(gtype==0 || gtype==2) 
	setperiod(4us, &maps1, 0);
      else
	setperiod(pw_gx-psfrsize*tsp, &maps1, 0); /* offset window to k=0 */
      for (iv = 0; iv < ndisdaq; iv++) {	/*  disdaqs  */
        trig = (gating==TRIG_AUX)? TRIG_INTERN : gating;
        for (isl = 0; isl < opslquant; isl++) {
          doleaf(0, 0, isl, &trig, &bangn, dabop, DABOFF);
	}
        getiamp(&chopamp, &rf1, 0);
        setiamp(-chopamp, &rf1, 0);
      }
      for (iv = 0; iv < 10000; iv++) {	/* get data  */
        trig = (gating==TRIG_AUX)? TRIG_INTERN : gating;
        for (isl = 0; isl < opslquant; isl++) {
	  dtype = (pre==1 || isl==opslquant/2)? DABON:DABOFF; 
          doleaf(0, 0, isl, &trig, &bangn, dabop, dtype);
	}
        getiamp(&chopamp, &rf1, 0);
        setiamp(-chopamp, &rf1, 0);
      }
      rspexit();
    }

    /* disdaq loop. */ 

    trig = gating;
    for (iv = 0; iv < nextra; iv++)  {

 if (iv==0)
            setwamp(trigonwd, &trigon, 2); /* initial trigger SJP */

      for (isl = 0; isl < opslquant; isl++) 
        { doleaf(0, 0, isl, &trig, &bangn, dabop, DABOFF);
          
          if (isl==0)			   /*  turn off trigger SJP */
       		setwamp(trigoffwd, &trigon, 2);
        }



      if(opuser2 == 2) trig = TRIG_AUX;  	/* wait for trig */
    }

    /* scan loop */
    counter = 0;
    for (ifr = 0; ifr < nframes; ifr++)  {
      if(rhuser14>0 && ifr == 1)  {	/*  reset  */
          setperiod(4us, &mapx, 0);
          setperiod(4us, &mapy, 0);
          setperiod(4us, &mapz, 0);
          setperiod(4us, &mapt, 0);
          setperiod(4us, &maps1, 0);
          setperiod(mapdel+4us, &maps3, 0);
      }
      for (iv = 0; iv < nl; iv++)  {
        for (isl = 0; isl < opslquant; isl++)   {
 /*         if(maketrig==1 && (counter++)%trigfreq==0)
	    setwamp(trigonwd, &trigon, 2);
          else if(maketrig==1)
	    setwamp(trigoffwd, &trigon, 2);   don't need   SJP */

	  doleaf(iv, ifr, isl, &trig, &bangn, dabop, DABON);
	}
	if(opuser2 == 2) trig = TRIG_AUX;  	/* wait for trig */
      }
      comm_buffer[1] = ifr;           /* talk to RT grecons */
    }      /* end frames */ 

    if(opuser11 == 1.0)  {      /* wait around for grecon to finish */
      boffset(off_waitend);
      settrigger(TRIG_INTERN, 0);
      startseq(0, MAY_PAUSE);   /* fat lady sings */
    }

    /* tell 'em it's over */
    boffset(off_pass);
    setwamp(SSPD+DABPASS+DABSCAN, &endpass, 2);
    settrigger(TRIG_INTERN, 0);
    startseq(0, MAY_PAUSE);	/* fat lady sings */

    return SUCCESS;
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
 *     bangn  -- rf bang number.         0 <= bangn  < nbang.
 *     dabop  -- dabop for loaddab.       
 *     dtype  -- type of data acquisition (DABON or DABOFF).
 *
 */

int doleaf(int leafn, int framen, int slicen, int* trig, int* bangn, int dabop, int dtype)
{
    int k, viewn;
    int echon;
    long rotmatx[1][9];
    float phi, cphi, sphi;
    int phase;

    /* select slice and spgr phase */

    setfrequency(fxmit[slicen], &rf1, 0);

    phase = rfphastab[*bangn] + slcphastab[slicen];
    phase = phase % FS_2PI;
    if(phase>FS_PI) phase -= FS_2PI;
    if(phase<-FS_PI) phase += FS_2PI;   /*  +/- pi  */
    setiphase(phase, &rf1, 0);

    setfrequency(frec[slicen], &echo1, 0); 
    setiphase(rfphastab[*bangn], &echo1, 0); 
    if(rhnecho==2)   {
      setfrequency(frec[slicen], &echo2, 0); 
      setiphase(rfphastab[*bangn], &echo2, 0); 
    }
    (*bangn)++;
    *bangn = *bangn%nbang;      /*  for mps2  */

    /*  printf("rfphs, bangn= %d  %d\n", rfphastab[*bangn], *bangn); */

    /* set up timing. */

    tmp = deadtime_core;
    if (scluster==1)  {
      if (slicen == opslquant-1)
        tmp = optr - opslquant*psdseqtime; 
    }
    else
      if(slicen < nerror)		/* spread the error ... */
        tmp = deadtime_core - trerror/nerror;	/* ... while keeping the sign */
    setperiod(RUP_GRD(tmp), &seqcore, 0);

    settrigger(*trig, slicen);

    /* set up dab */
    viewn = framen*nl + leafn + 1;
    echon = 0;
    if(gtype==2 && pre)  {	/* no first echo acq */
      loaddab(&echo1, slordtab[slicen], echon, dabop, viewn, DABOFF, dabmask);
    }
    else  {
      loaddab(&echo1, slordtab[slicen], echon, dabop, viewn, dtype, dabmask);
    }
    if(rhnecho==2)  {
      loaddab(&echo2, slordtab[slicen], echon+1, dabop, viewn, dtype, dabmask);
    }
    /* printf("slicen, dabslc = %d %d\n", slicen, slordtab[slicen]); */

    /* select interleaf */
    phi = 2.0*3.14159265*(leafn)/(float)nl; 
    cphi = cos(phi); sphi = sin(phi);
    for (k = 0; k < 9; k += 3)
    {
	rotmatx[0][k] = IRINT(cphi*savrot[slicen][k]+sphi*savrot[slicen][k+1]);
	rotmatx[0][k+1] = IRINT(-sphi*savrot[slicen][k]+cphi*savrot[slicen][k+1]);
	rotmatx[0][k+2] = savrot[slicen][k+2];
    }
    scalerotmats(rotmatx, &loggrd, &phygrd, 1, 0);
    setrotate(rotmatx[0],slicen);
 
    setwave(thetrecintlp[leafn], &thetrec, 0);  /* fov offset for receiver */
    if(gtype==2) setwave(thetrecintlp2[leafn], &thetrec2, 0);

/*  spoiler gradients on readout axis don't rotate; they are here to
	fix an evil hysteresis problem in the grads  */

    if(nl>1)  {
      ia_gxspoil = (cphi + sphi)*(a_gxspoil/loggrd.xfs)*max_pg_iamp;
      ia_gyspoil = (cphi - sphi)*(a_gyspoil/loggrd.yfs)*max_pg_iamp;
      setiampt(ia_gxspoil, &gxspoil, 0);
      setiampt(ia_gyspoil, &gyspoil, 0);
    }

    /* reset offset and go for it */
    boffset(off_seqcore);
    startseq(slicen, MAY_PAUSE);
    if(*trig == TRIG_AUX && opuser2 >= 1)  {	/*  make clock start  */
      setscantimestart();
    }
    *trig = TRIG_INTERN;
    return SUCCESS;

}   /* end of function doleaf() */

void get_spgr_phase(ntab, rfphase)
  int ntab;
  int rfphase[];
{
 
  int IA = 141;         /*  24 bit overflow  */
  int IC = 28411;
  int IM = 134456;
  int i, jran;
  float x;
 
  if(spgr_flag<=2)  {
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
      default:
        break;
    }  /* switch  */
  }
  else          /*  make quadratic phase schedule  */
  {
    for (i=0;i<ntab;i++)  {
      x = spgr_flag*(i - ntab/2);
      rfphase[i] = (int)(x*x) % FS_2PI - FS_PI;
    }
  }  
  return; 

}	/*  end get_spgr_phase  */

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


