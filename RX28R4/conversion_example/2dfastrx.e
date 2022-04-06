/*
 * GE Medical Systems
 * Copyright 2017 General Electric Company. All rights reserved.
 *
 * 2dfast.e
 *
 * 2d Gradient Recalled PSD with CINE.
 *
 * Language : ANSI C/EPIC
 * Author   : Matt Suminski, C. Yuan, L.Ploetz
 * Date     : 8-Nov-1993
 */
/* do not edit anything above this line */

/* *********************************************************************
   Internal
   Release # 	Date	Person		Comments

   5.5.1	11/8/93	J. Mitchell  	Modified for 5.5
   5.5.2         2/1/94 JM              More 5.5 modifications
   5.5.3         2/7/94 JM              The finishing touches for 5.5...
   5.5.4         3/1/94 JM              Fixed up PosPhaseEncode1 in pulsegen
sccs 1.171     940308 MGH        Put in fixes accrued since 1.167 in 5.4
sccs 1.172     940319 MGH        Acquiredata macro changes.
sccs 1.173     940321 JM         Changed loaddab() and obloptimize()
                                 call lines
                                 Moved SpSatInit, ChemSatInit, and
                                 PScvinit above cvinit.in (MRIge19321)
                                 Modified optramp calls (MRIge19329)
sccs 1.1.74    940416 SS         Following chages for MRIge19847:
				   Call line change to createcine.
				   Call ssivector in psdinit.  Need to do this
				     because IPG clears out vector at the beginning
				     of each entry point.
				   Removed attenflagon & setrfltrs for cine packet
				     since cine packet is now all dab, not dab
				     and xtr.
				   Removed CreateCine subroutine (not used).
				 Moved setting of physa_rf1 to cveval.
				 Moved PSpredownload() call to the end of section
				   MRIge19415
				 Removed code contained in PSD_2DVBTOF - MRIge19961
   5.5.8       940509 JM         Added max_fcx_ramp for flow comp pulse ramp time
                                   (needed until amppwgxfc2 is fixed)
				   FIXED 7-25-94 LP
				 Changed some occurences of pw_gzrf1/2 to iso_delay
                                   to clean up the minTEs.
				 (addresses MRIge<20041,20061,20062,19821,20063>)
   5.5.9       940511 JM         Added yfov_aspect definition and to minfov
                                 Lock out cardiac gating with interleaved slices
                                 (via opileave)
				 Changed remaining occurences of pw_rf1/2 to iso_delay
                                   to clean up the minTEs.
                                 Added definition of pos_moment_start
   5.5.10      940725 LP         Added new parameters to amppwgxfc2 call
                                 amppwgxfc2 now supports 5.5 gradient configurations
				 (MRIge19335)
				 Added resp comp min seq reference to prevent eos errors
				 (MRIge20592)
   5.5.11      940725 LP         Moved matrix check ahead of asymmetric fov init
                                 (MRIge19802)
   5.5.12      940729 LP         gy1dummy changed to trapezoid for resp comp processing
                                 (MRIge20771)
   5.5.13      940806 LP         Killer's scaled down in target amp for sr17 to match
                                 min seq time due to gradient heating.
                                 (MRIge20772)
				 recalc BW code trashed since it's commented out
				 reposition inittargets and obloptimize
   5.5.14	940809 AK	 Moved inits of x,zkillscales to after
				 obloptimize in cveval.  Call SpSat,
				 ChemSat after obloptimize in cveval.
				 psd_grad_acq_delay to psd_grd_wait.
   5.5.15	940822 LP	 MRIge20882 - min fov range improved 
				 as well as advisory panel hysteresis
				 especially for obliques - optramp call
				 affected
				 MRIge19338 - DAB packet positioned prior
                                 to alpha pulse
				 code review changes - spsatiamp correction
				 pi button settings moved to proper section
				 rtf_flag removed
				 1.5nex w/o nop check added
				 post_echo_time correction
				 sp_satstart & cs_satstart correction
   5.5.16	940908 AK        MRIge20963 - avminfov for a 2 echo flow
				 comp scan does not use minfov routine which
				 rounds up to integer.  Must place roundup
				 in the code after avminfov determined.
   5.5.17       940913 BES	 Change _killscale to _killtarget and pass
				 0.7 if sr17 or loggrd.t__xyz otherwise. 
   5.5.18       940923 LP        MRIge21274 - cine packet repositioned to
                                 end of excitation
   5.5.19	941012 BES	 Remove off90 from iso_delay calc.  5.4
				 did not include off90 in the calc so
				 to keep 5.4 parity for sr17, remove.
   5.5.20       941018 bes       Add off90 back in.  Got the okay from
				 core team.  Added changes for Qing that
				 fix the phase2view table for cine pc
				(table is too small).
   5.5.29       950629 lp        MRIge21873 - ctlend_last protection
   7.0.0      10/24/94 YH        Added CERD and Solar2 changes.
   7.0.1      10/26/94 YH        deleted psdtap and psdtaps.
   7.0.2      12/09/94 YI        Changed for Vectra hardware. Support 30mm
                                 min fov.
   7.0.3      12/15/94 YI        Changed receiver frequency.
   5.5.21       941130 bes       MRIge21489 - scale ramp times for killers
				 for sr17.
				 MRIge21750 - conditional to add sattimes
				to pos_start and pos_dab if cardiac was
				wrong.
				 MRIge21751 - non_tetime missing sattimes.
   5.5.22       950118 aek       MRIge22006 - If sattimes are added to
			         pos_start (MRIge21750), non_tetime should
				 not have sattimes as well (MRIge21751).
   7.0.5      03/15/95 YI        Changed for new system safety.
   7.0.6      03/31/95 YI        Fixed cine problem.
   7.0.7      04/17/95 YI        Fixed min fov problem in min/min full te modes.
   7.0.8      04/21/95 YI        Fixed mav fov problem for advisory.
				 Change data type of rsprot_orig to int.
   7.0.9      05/03/95 YI        55 merged(to 5.26 950420 lp,2dfast:55 95fw16.4)
   7.0.10     05/11/95 YI	 Turns opirmode on if SPGR.
   7.0.11     05/22/95 NM        Added cffield support for 0.2T(profile)
   7.0.12     05/25/95 YI	 Support B4 pause in mpgr mode.
   7.0.13     05/31/95 YI	 Calculate sar in cveval also for scan panel.
				 Fixed the problem of B4 pause with gating.
   7.0.14     06/30/95 KS        55 merged (5.5.27, 28).
   7.0.15     07/13/95 YI	 Changed minfov in min/min full te modes.
   7.0.16     07/17/95 YI	 Changed calculation for min rbw and minte
				 slightly,but there is still inaccuracy in 
				 calculation for min te and min read BW with
				 multiple echos.
   7.0.17     07/24/95 YI	 Fixed memory check problem in scan in the case
				 of opslquant=4 and opclocs=3.
				 slquant1 does not necessarily equal opclocs
				 at this point, so in this case,
				 psd changes opclocs to slquant1 in it.

  8.0.1   13-Sept-95   JDM       Removed vmx code forcing spgr mode to
                                 be sequential. Don't know why they changed
				 this, but this is not how it was in ufi so 
				 we removed this restriction.

  8.0.2   14-Sept-95   JDM       spgr mode should be seq always; it is in ufi and
                                 vmx; the distinction is that you won't get
				 the warning from cvcheck if in spgr and user
				 did not select seq, the psd will set it for you;
				 thus the change of 8.0.1 has been removed.
  
  8.0.3   08-Nov-95    JDM       Using pendallssp(&e1distns,0) in ATTENUATOR call
				 to correctly accommodate TNS at all field strengths.

  8.0.4   09-Nov-95    JDM       psdname changed to "2DFAST" to be consistent with
				 all other psds; needed by scan in the future potentially

  8.0.5   17-Nov-95    DM        SPR MRIge27048: error message text change for 
                                 EM_PSD_PHASE_OUT_OF_RANGE and EM_PSD_YRES_OUT_OF_RANGE

  8.0.6   19-Dec-95    RJL       Lockout MT for this PSD - MRIge28286

  8.0.7   05-Mar-96    JDM       MRIge30677
				 Changed ampfov() calls to use 15.625 and
				 31.25 for bw's instead of 16 and 32.

  8.0.8   19-Mar-96    VB        MRIge30724
                                 pw_gzrf1d uses loggrd.tz_xyz both when flow comp
                                 is on or off. Same fix as in MRT.
  8.0.9   04/21/96    RJL   Numerous modifications for Advisory Panel Popup support.
                            1. Added event handlers and return status of ADVISORY_FAILURE to
			       several cvcheck checks. Added initialization of new epic.h
			       advisory panel values at beginning of cvcheck():
				    av<min,max>etl,av<min,max>phasefov,av<min,max>nex,
                                    avminyres,av<min,max>rtarr,av<min,max>rtpoint,
                                    av<min,max>slthick, refer to epic.h for more
				    details on these new values.
				  
                                Refer to 8.0 EPIC Advisory Panel SDD for technical description 
                                of the changes.
			    2. Remove if (set_exist) from adjust_avminte which caused 
                               hysteresis effect in avminte calculation and hosed popup.

                            3. Add InitAdvisories.e inline and Add InitAdvPnlCvs() call 
                               to initialize new advisory panel cvs in cvcheck as first line.
	                    4. Add advisory panel check for opphasefov to keep users from entering invalid values into text widget
			    5. Add ADVISORY_FAILURE returns where appropriate in cveval1(). Please
                               see code for description. Modify cveval1 calls to return status
                               of ADVISORY_FAILURE or FAILURE if routine fails for either
                               reason.

  8.0.10   04/25/96    TKF/JDM
				MRIge31900
				MRIge31555
				Ghosting in multicoil images fixed, and loss of a slice when vbw on.
				Major rewrite by TKF to use fgre vbw/fract echo logic for 2dfast.
				
  8.0.11   04/26/96    TKF/JDM  PET testing fixes.
				1. opte set to min_tenfe for minfullte,
				   instead of always avminte.
				2. maxyres ues nop*opfov and not nop*fov*phfov

  8.0.12   05/03/96    RJL      MRIge32215 - Modify avminte calculation to account for
	                        Fractional echo with Fractional NEX scans. This
	                        was placed into cveval as final bump up of
	                        avminte since fractional echo is not allowed
	 			with fractional NEX. By catching and changing
				the opte value and avminte values to min_tenfe
	                        the user will see the avminte value change on the
				display and no error message need be reported. If
				user selects a Te manually then error message is still
				displayed as it should.
 8.0.13    05/03/96    RJL      Fix logic for minte calcs. Made a boo-boo in 8.0.12 which
                                a hysteresis was found. Fixed now....

 8.0.14    05/03/96    RJL      MRIge32218 - Removed ophasefov advisory panel error check from cvcheck which
                                was inadvertently placed into PSD during popup merge.
				When TF made changes for minte calculations inadvertatly messed
				up flow comp pulse gxfc. After all computations are performed
				we need to set the pulse width and amplitudes based on the 
				fractional and full_echo pulse widths. Please see code below
				for details.
 8.0.15    05/06/96    J.Meng   MRIge32263 & MRIge32217 - fixed the error in 8.0.14. The 
				opphasefov advisory panel error check code was not removed
				yet in 8.0.14. It is deleted now.

 8.0.16    05/06/96    JDM/TKF  MRIge32218
				Logic errors regarding full/fract echo; psd was only using
				opautote as the indicator; it should have been using fullte_flag
				for all compares and decisions, as the psd automatically
				switches between full/fract w/o reference to opautote.

 8.0.17  07-May-96     JDM/VB   MRIge32287 (similar to MRIge31655)
				 psd calculates act_tr using the line gating
 				 logic, because lcycles ends up <= optr in
				 some cases. When this occurs, the act_tr must
				 get checked against tmin, and the max used;
				 this spr was caused by act_tr coming up less
				 tmin and not being checked.

 8.0.18  14-May-96     RJL      MRIge32481 - Set avmaxte2 equal to avminte2 when 
                                avmaxte2 < avminte2. Just like av<max,min>te changes to stop
				misleading UIF updates.

 8.0.19  23-May-96     RJL      MRIge32611  - 1. Moved all matrix checks to top of cveval1(). When
                                opyres is set greater than opxres, the values of tmin_total
				increases unneccessarily. The matrixcheck() call is supposed to
				set opyres back to opxres. But, if this happens after opyres is
				used in the system safety checks it chokes the PSD. 
				2. Moved all advisory panel defaults to cveval just after InitAdvPnlCVs()
				call so that we can overwrite the values with the ones we really want.

 8.0.20  25-Jun-96    VB       MRIge32968:
                               execute the changes made for VMX (07/24/95 - YI) only
			       when opslquant exists. This way the user can enter the
			       maximum number of clocs even before entering the number
			       of slices.

8.0.21  01-July-96     TKF/JDM MRIge32416
			       Started enabling 2nd echo 2dfast. Restrict acquisition
                       	       to only  2 echoes at present. If first echo is a partial echo,
                               then the second echo must be time-reversed.

8.0.22  17-July-96   TKF/VB    MRIge32416:
                               Added the following recon variable - rhmethod.
			       eepf was instead of eeff and the logic around it was wrong.
			       Made corrections to this.
			       fixed typo in the last turbofilter call section.
 
8.0.23 25-July-96     VB      Due to recon failures had to revert back to the version of
                              2dfast.e to pre 2nd echo changes. That is basically to 8.0.20
			      (delta 1.213 - 25-Jun-96)

8.0.24 30-July-96    VB       Reverting back to the version (17th july '96) which has the
                              ability to handle two echoes.

			      MRIge34004:
			      The problem was due to the fact that when Resp Comp was turned
			      ON, opnopwrap was not getting set to 1 and rhrcyres was not
			      accounting for the doubling of the Phase matrix. Now
			      opnopwrap will be turned on if Resp Comp is selected.

			      MRIge34113:
			      Corrected the logic used to set the minimum and minimum full
			      te values.

8.0.25 7-Aug-96     VB        MRIge34241 and MRIge34242
                              Corrected avminte2 calculation to retain some of the VMX
			      changes which were discarded during the remake of 2dfast.
			      The avminte2 values are increased by a couple of ms.

			      MRIge34209.
			      This spr is not actually a problem. By default the PSD
			      sets the avminte in the advisory area to the minte value
			      when the value typed in is greater than mintenfe. I have now
			      set the defauly avminte value to minfullte value.

8.0.26 3-Sept-96    VB        MRIge34743. 
                              The fix is from vmx 08/18/96 YI  YMSmr00395.
			      pitslice exceeds its own integer range and this results in a 
			      download failure. The fix is to make sure that max TR is less 
			      than the MAXINT. The code below is rounding calculation for 
			      line gating(worst case) only. - Vinod    

8.0.27 4-Sept-96    VB        MRIge34746.
                              dda was hardcoded to be 4 in the previous fix. This was
			      corrected.

8.0.28 4-Sept-96   VB         Fix an error in the previous fix.

8.0.29 11-Sept-96  VB         MRIge35061.
                              The problem in this spr was because No Phase Wrap was being
			      turned on when Respiratory Compensation was selected. This is
			      correct to a certain extent but it should have had the additional
			      clause that the NEX should be greater than 1.4. No Phase Wrap
			      is ON only for High Sort Resp Compensation.

			      MRIge35026.
			      Added new logic so that when an invalid TE is entered, and if it 
			      is less that the min te the popup will appear with the min_te
			      value instead of the min_fullte value as it currently does.

8.0.30 27-Sept-96  VB         MRI35599:
                              When fixing MRIge35061 we were setting opnopwrap to 0 when
			      the condition for MRIge35061 is not met. Thanks to this even if
			      NPW is selected it was being turned off within the psd. 
			      This logic was removed to fix this spr.

8.0.31 02-Oct-96  VB/TKF      MRIge34569, MRIge35542.
                              Redid avminte2 calculation by adding prefill time and made
                              sure that time between filter select and start of prefill
			      is 300us.

8.0.32 21-Oct-96  YP Du	      Changed avmaxrbw and avmaxrbw2 from 32 to 31.25 (MRIge35966).

8.0.33 03-Jun-97  VB          MRIge39634: Fixed gating bug when optdel1 != min or
                              recommended value.

sccs1.228 24-Jun-97   VB      added changes for cmon but removed it as it is a better
                              idea to branch 2dfast. No new changes have been included
			      since 3-june-97

sccs1.229 24-Jun-97  RJF      CMON Implementation. First LX2 version.

sccs1.230 08/21/97   LR       MRIge41267 - changes for i18n. 

sccs1.231 08/21/97   LR       MRIge41267 - changes for i18n. 

sccs1.232 08/27/97   LR       MRIge41267 - changes for i18n. 

sccs1.233 09/06/97   RJF      Including Lx2NewIoptCheck.e inline file for 
			      Locking out all the New Lx2 Imaging Options which 
			      are incompatible with 2dfast.

sccs1.234 09/07/97   RJF      Correcting error checks for cmon, nex>1 and var fov case.
			      MRIge41599.

sccs1.235 09/08/97   LR       Corrected logic for returning FAILURE
			      - MRIge41673.

sccs1.236 09/10/97   RJF      MRIge41476 : cmon, for a nex greater than
			      1.5 must be treated in the same way as a 
			      no phase wrap case.  This is done by tur
			      ning opnopwrap to 1 inside the PSD - same
			      way as it is done for exor.
sccs1.237 09/16/97  RJF	      MRIge41778 : Refer to the SPR enclosures for details 
			      of all the changes done.  cvmax for opcmon is redefined to 
			      1, as this PSD supports Card. Comp.

sccs1.238 09/22/97 RJF	     MRIge41902 : cmon was locked out for 
			     SPGR selection, by a wrong check in 
			     Lx2NewIoptCheck.e.  Now that the min/max
			     range check in psdIF is fixed, this file
			     is no longer need to be inlined.

sccs1.239 09/23/97 RJF	    MRIge41712 : cmon phase ordering was no
			    t enabled at download, because SPU was 
			    never communicated that we're doing 
			    a cmon scan.  This is done by the 
			    exorcist_set_gate call.

sccs1.240 10/02/97 RJF	    MRIge42068 : opvbw was not getting turned 
			    on for 1.5T systems.  For 2dfast, Variable 
			    Bandwidth should be the default option. 
			    Refer SPR enclosures for more details.

sccs1.241 10/16/97  VB      MRIge42338: In the compatibility checks for
                            for cmon the checks were made if cmon_flag
                            is ON. Somehow with this code the error message
                            was being displayed but the offending option
                            was not being cleared. I just changed the
                            cmon_flag to exist(opcmon). 

sccs1.244 11/12/97 VB       MRIge42909: added a check to check if pietr
                            is greater than 1 RR. If it is then we need to
                            tell the user to reduce TR or the # slices.

sccs1.245 08-Jan-98 CMC     Added a check for opcphases in cvcheck() and
			    corrected errors in Internationalisation

sccs1.246 02/19/98  LR      MRIge43862 - added GRAD_UPDATE_TIME to
			    include the time to play out seqcore 
			    at the end of waveform. 

sscs1.247 26-Mar-98 JAP    MRIge44953 - Add an error check to make
                           sure that the effective TR fits in the R-R
                           interval. The fix for MRIge42909 used
                           ophrate which was not actually set for
                           CINE. Need to use opchrate instead.

sccs1.248 26-Mar-98 JAP    Changed serror for above message to
                           error. Actually report the minimum sequence TR.
sccs1.249 02-Apr-98 JAP    Use Advisory Panel error for maximum TR.

sccs1.250 06-July-98 VB    First ANSI version.

sccs1.251 06-Jul-98  VB    changed 2dfast.h to fast2d.h

sccs1.252 18-Aug-98  VB    Added the individual include files.

MERGED WITH CARDIAC34.01 - 9/13/98 - VB

sccs1.250 08/03/1998 VB    MRIge46787: Added code for SNR Monitor. 
                           Search for pifractecho.

          08/31/1998 JAP   MRIge47211: Add check for opfast with
                           CINE. These are incompatible.
---------------------------------------------------------------
          10/12/1998 RJF   Adding include pgen_tmpl.h to @rsp section 
                           to add RSP function prototypes.

          12/10/1998 CMC   Bolus Chasing changes were added. 

          01/19/1999 GFN   MRIge50275: Moved the update to autoadvtoscn
                           together with the update for auto prescan.
                           MRIge49784: Removed duplicate definitions for
                           dum[1-6] and unused variable fdum1.

          03/29/1999 PRA   MRIge51417. For calculating SAR values 
                           powermon_b1scale considers both body and surface
                           coils as the same. So we need to use the body coil
                           values in the entryPoint table.

          04/16/1999 FEC   Moved opuser0 range check to cveval, was core
                           dumping in cvcheck. (MRIge52288)

          06/16/1999 GFN   MRIge53899 - Locking out Multistation for ME2 
                           software.

          06/16/1999 JFS   MRIge53949 - Use rotation matrix of imaging sequence
                           rather than that of the explicit SAT during playout
                           of SAT relaxers to avoid GRAM overload.

          06/17/1999 JFS   MRIge53949 - Added the above change to cinescan as
                           well.

          06/23/1999 GFN   MRIge54141 - Reactivating Multistation for M3
                           software.

          07/20/1999 JFS   MRIge54446 - Add psd_grd_wait to non_tetime to
                           prevent gradient over-ranges.

          07/21/1999 GFN   MRIge54076 - Changing pisioverlap from 10mm to 10%
                           of the FOV.  The 10% value is provided by a new CV
                           pifovpctovl.

          07/21/1999 GFN   MRIge54212 - Changed setup of the User CV page
                           for the Number of Stations CV used in Bolus
                           Chasing scans.

          08/09/1999 BJM   MRIge54963 - Add check for SmartPrep99 and SmartPrep.

          09/13/1999 GFN   MRIge55689 - Removed support to MultiStation.

          09/14/1999 RAK   MRIge55728:  Adding support for the nMR swing
                           table.  With the nMR swing table the patient
                           coordinate system and gradient coordinate
                           system no longer coincide. Therefore, the CV
                           opplane can no longer be used indiscriminately.
                           When a portion of code refers to the gradient
                           coordinate system the CV opphysplane will be
                           used instead of opplane. 

          11/11/1999 TAA   MRIge56926 - Added calculation for avminslthick even 
                           if error conditions do not occur, to make the value 
                           available in all the cases.

          12/08/1999 AMJ   MRIge57299: Implementing optimized obliques for
                           nMR Swing table support. 
                           Changes made: obl_method = 1,
                              added initnewgeo to call in cvinit, 
                              corrected error handling in cvinit, cveval

          03/15/2000 AF    MRIge57455 - Deleted avmintr TR minimum check of 18ms
                           which was previously placed for compatibility with 4x.

          04/21/2000 AKV   MRIge59519: Removed the deadtime of psd_seqtime
                           inorder to avoid the extra deadtime.

          05/26/2000 AMJ   MRIge60182: Corrected timing calculation for
                           DFM Sequence and its positioning. Details updated
                           in SDD. Wrapped all DFM calculations and functions
                           with epic precompiler flag DFMONITOR
 
          06/26/2000 RDP   MRIge60135: Included cvmin(rhte2,0) to avoid
                           download failures.

          07/21/2000 AMJ   MRIge61082: Added DFMonitor_CVeval1() to force update
                           of avmintscan in cveval when DFMfeature is enabled. 
          07/31/2000 AKV   MRIge61176: Limiting  the maximum FOV value to 40 in the
                           pulldown menu.

          08/08/2000 RAK   MRIge61365: Added DFM support to CINE mode.              

          09/27/2000 AKV   MRIge61907: Modification for Resp Comp when DFM is present

          12/07/2000 BSA   MRIge62650/62655: Optimized dda's for RC and CCOMP  sequences
			   using optdda support routine within Exorcist_cveval.

          02/29/2001 GFN   Merged external triggering for FUS from Haifa code under
                           .../fus/LATEST branch.
          02/29/2001 GFN   Merged code from .../FUS_ortho/LATEST which includes
                           support for Binomial Pulse and the following:
                     DRT   MRIge65249: Made revisions to incorporate Jason's new
                           filter generation routines and methods.
                           - Changed turbofilter to calcfilter

                     RJF   LxMGD features and fixes for ISMRM.
                            1) Enable Sequential Multiphase. Can be turned on 
                               using a User CV, or by the internal CV lxmgd_multiphase 
                            2) Provided a "Turbo Mode" to allow better temporal resol 
                               for the sequential multiphase. The following are the improvements.
                               - Artificial limitation on TR is removed
                               - Bandwidth opened up to 62.5  in this mode. 
                               - BW pulldowns, default selection and CV defaults set differently.
                               - automatically do Sequential, because 
                                 this mode sets DDAs, multi-echoes and other settings 
                                 automatically gets checked for correctly. 
                               - Switched to Internal Triggering from Line, which 
                                 was defaulted in certain cases of TR for sequential
                            3) Fix RBW which was getting fixed to 15KHz due to calcfilter coding error. 
                            4) Enable SAT with the new multi-phase implementation. 
                            5) Replaced old gradient heating computation with minseq.
                            6) Gave user CV control for Multi-Phase as the multi-phase IOpt was under
                               scan control. This couldn't be an internal CV, because we'd want the
                               Locs before pause to be available for multi-phase. 
                            7) General code clean up - removed left over code from multi-station support
                            8) Added support for repetitions before pause with multiphase.
                            9) Added support for Phase Time Stamping via annotation (ihtdeltab).
                           10) Added support for Additional Delay between Phases ! 
                           11) Added support for standard multiphase user interface.

       	  04/27/2001 AMR   Incorporating Spine IQ Enhancements for LEO1 program.
			   This involves adding Magnetization Transfer Contrast (MT),
			   Flexible XRES and ZIP512 functionality to this PSD.
                           
			   The changes with regard to MT,Flexible XRES and
			   ZIP512 are referred to in the code as "FOR MT", 
    		           "FOR FLEX XRES"and "FOR ZIP512" respectively.

          06/02/2001 AMR   MRIge66553 - Changed the calculation of rhfermr to opxres/2
                           for those cases when ZIP512 is not enabled.Please refer SPR
                           enclosure for more details.Consulted Ben Luh regarding this 
                           change.

          07/26/2001 DG    MRIge67827 - zoom_limit checking only if relevant CVs "exist"

          08/15/2001 DG    MRIge68820 - zoom_limit checking using inlines

          06/06/2002 AMR   MRIge74590 - Changes made to get rid of Zipper
                           Artifacts with MT option.
                           The fix for this involved increasing the area of the
                           MT crushers / killers by increasing the pulse width
                           of the MT killer from 3500 to 5000 and increasing the
                           amplitude from 0.95 to 2. A third crusher was also
                           incorporated along the X direction apart from those
                           along Y and Z. All references to this set of changes
                           can be found by searching for "MRIge74590". Further
                           details related to this SPR can be found in the
                           DDTS enclosures. The rest of the changes for the 
                           above fix can be found in the file MagTransfer.e.

          12/04/2002 SVR   MRIge79334
                           Round-off the calculation of rhnframes to the
                           nearest integer.

          10/15/2003 RKS   MRIge78873 -- Limit NEX <4 when CCOMP = 1.

          01/25/2004 GFN   MRIge90911 - Updated LxMGD features and fixes
                           for ISMRM, and the FUS thermal map code.  This
                           includes the following:
                           0. Added check for PSD name (tx_therm) to activate
                              the FUS options.
                           1. Changed the lxmgd_turbo_mode CV to
                              turbo_mode_flag.
                           2. Changed the lxmgd_multiphase CV to
                              multiphase_flag.
                           3. Changed the ismrm_phases CV to multi_phases.
                           4. Fixed error checks when multi-phase mode
                              is ON to use prodcut messages and CVs.
                           5. Changed ThermalMap to thermal_map.
                           6. Changed BinomialPulse to binomial_pulse.
                           7. Created fus_chemsat CV to use instead of opuser2
                              for ChemSat with the FUS application.

	  04/23/2004 HAD  MRIge92784 - The rounding off for rhnframes was
			  somehow removed in 12.0. It exists in 11.0 base line. Brought
			  back the changes.

          06/24/2004 HK   MRIhc00582 - Removed explicit setting of rhdacqctrl
                          value.  Changed it to be done the same way as in
                          loadrheader.e after eeff is set.
                          2nd promote to fix the problem of 2nd echo image flip
                          (MRIhc01390).
	
           01/27/2004 RKS  MRIge90956 -- MRIhc01169 Gradient over voltage fault (Luxembourg CSO)
                           Observed with oblique scan plane, overlapping gy1 with gz1
                           PSD work around --- Move gy1 after slice rewinder
                          
          06/24/2004 HK   MRIge90164 - 1. check opnex for "0" entry; 2. added opnex and ccmon
                          check in _iopt.e file. 

         09/10/2004 RKS  MRIge89906 --  Gradient rollover with MT and explicit SAT pulse with axial
                         presciption. Gradient error since the MT crusher exceed the limit since the
                         rotation matrix was non-axial (SAT matrix) instead of being axial (SCAN).
                         Corrected by updating sp_satcard_loc

          09/10/2004 RDP  MRIge90568  Turning off phase encoding with CV "nope".
	  03/16/2005 HK   2048 slices support for Value 1.5T.

14.0   03/24/2005 ARI  Implementing pulsegen-on-host feature. Created a new function 
                       calcPulseParams() to set parameters for pulse generation 
                       (e.g., pulse widths, instruction, amplitudes). This allows 
                       pulsegen-on-host feature call this function instead of predownload().

14.0   06/21/2005 ARI  MRIhc06762 - CINE fails with MT, fix in MTPG() call

       05/19/2005 KK   YMSmr06744  Rect FOV & NPW support (rectfov_npw_support)


14.0   06/27/2005 MSK  MRIhc08159 - Initialized RF_PULSE_INFO

14.0   08/02/2005 AMR  MRIhc08845 - Lockout Dynaplan (Multi-phase with
                       Variable delays) with this PSD. It should be enabled
                       only with the Value 1.5T system.
                         
14.0   08/08/2005 LS   MRIhc08734 - decrease TR msg came up before TR is entered
                       and it sometimes cause image option compatibility errors.

14.0   08/20/2005 ARI  MRIhc09238 - moved mt_flip_calc() function call from 
                       predownload to cveval to prevent SAR error message.

14.0   08/31/2005 ARI  MRIhc09511 - replaced hardcoded SAR limits from 
                       mt_flip_calc() function with config CV values.		   

14.0   11/09/2005 RKS  MRIhc11027 - An error message was introduced 
                       during 8.0 days (MRIge32968). This was done to inform 
                       the user than they need to complete the CINE prescription 
                       before entering TR. Subsequent improvements to the code results 
                       in an annoying and sometimes repetitive error message. Removed 
                       the error message to eliminate the pop-up.

14.2   04/12/2006 ARI  MRIhc14923 - Remove GRAM model.

14.2   04/13/2006 ARI  MRIhc14933 - Remove OLD_MINSEQ compiler flag.

14.2   05/25/2006 VSN  MRIhc15554 - Setting obl_method = 0 and setting
                       oblmethod_dbdt_flag = 1. This are used to scale the axes in
                       obloptimize.c.

14.2   06/16/2006 VSN  MRIhc15606 - Underestimation of power for phase encoding grad.

14.2   07/10/2006 ARI  MRIhc16496 - Change minseq() function interface.

14.2   08/07/2006 SHM  MRIhc16615 - Moved max_seqsar calc. prior to tmin_total calc.
                       and added max_seqsar to list of tmin_total parameters.

14.2   09/08/2006 ARI  MRIhc18055 - Remove pgen_debug flag.


14.5   10/05/2006 TS    MRIhc15304 - Coil info related changes

20.0   01/25/2007 VAK  MRIhc16225 -  Removing a check from endview fucntion call and making the 
                                     change in 2dfast.e  	

20.0   03/22/2007 SWL MRIhc21901,MRIhc23348, MRIhc23349 - new BAM model supports multi phase, 
                      dynaplan phase, and requires additional input argument in maxslquanttps(). 

20.0   03/30/2008 ALI MRIhc35476, MRIhc35494 - added fixes for pFOV different from UI prescribed value 
                      and multi-echo with gating incorrect scantime.

15.0   01/04/2008 AKR  MRIhc35549      Missing SPR merge  YMSmr06678                     

15.0   11/04/2008 AKR  MRIhc35762 and MRIhc35763 : Missing SPR merge YMSmr08289 and YMSmr09218.

20.0   08/09/2008 JAH MRIhc38656
                   Removed physa_ variables and reordered amplitude scaling
                   code to finalize amplitudes prior to calcPulseParams
                   so predownload.in can correctly set the instruction
                   amplitudes. ( This is a 20.0 spr. The 15.0 sync up spr is MRIhc39234 )

15.0   09/12/2008 MCN  MRIhc39773   rhnslices is defined again after loadrheader.e inline to avoid DLF
                                    for multiphases with cardiac gating

20.0   09 Jun 2008 JAH MRIhc38656
                   Removed physa_ variables and reordered amplitude scaling
                   code to finalize amplitudes prior to calcPulseParams
                   so predownload.in can correctly set the instruction
                   amplitudes.

20.1   10 Mar 2009 Lai GEHmr01484: support "In-range" auto TR

22.0   31 Dec 2009 VSN/VAK MRIhc46886 : SV to DV Apps Sync Up
                                      : Enabled SPSATXKILLER after evaluating it on DV and HDxt 

22.0   18 Jan 2010 VSN     MRIhc44866 - Removed local declaration of fnecho_lim. This is now moved to epic.h

23.0      03/03/2011 YS       MRIhc54090 : oblmethod_dbdt_flag is used only for SR200 system.

23.0   14 May 2012 MK      HCSDM00079165 : Removed Value Flag to support In-range autoTR
                                           and legacy Auto TR values.

24.0   11 Oct 2012 MK      HCSDM00157147 : Set the default value of min/maxTR for In-Range TR

PX25   22 Apr 2014 YT      HCSDM00282488 : Added support for KIZUNA gradient thermal models

PX25   25/Jul/2014 YT      HCSDM00289004 : add APx functions
                                           change xres step to 4 and yres step to 2

PX25   01/Dec/2014 YI      HCSDM00322607 : Fixed amplitude violation of MT killer pulses
                                           in oblique cases about phase axis.

PX25   26/Aug/2015 YT      HCSDM00341147 : Support image cut reduction

26.0    02/Nov/2015 SL     HCSDM00379663 : # of phase encodings for endview() calculation was scaled incorrectly
                                        for fn = 0.75 cases, caused phase direction size error.

26.0   16/Mar/2016 RV      HCSDM00396846: Enable Pixel size, RBW/pixel informational display fields

27.0   20/Feb/2017 SK      HCSDM00446486: fixed divide by zero and rounding errors involving act_tr

PX26.1 30/Mar/2017 YI      HCSDM00453302: Added Flexible NPW support changes.

PX26.1 26/Jul/2017 MO      HCSDM00470514: Added return FAILURE for avepepowscale().

**********************************************************************/

@inline epic.h


@global 
/*********************************************************************
 *                     2DFAST.E GLOBAL SECTION                       *
 *                                                                   *
 * Common code shared between the Host and Tgt PSD processes.  This  *
 * section contains all the #define's, global variables and function *
 * declarations (prototypes).                                        *
 *********************************************************************/

#include "fast2d.h"

#include <string.h>

#include "ChemSat.h"
#include "em_psd_ermes.in"
#include "epic_error.h"
#include "epicconf.h"
#include "Exorcist.h"
#include "filter.h"
#include "grad_rf_2dfast.globals.h"
#include "InitAdvisories.h"
#include "Minte_fgre_calcs.h"
#include "Prescan.h"
#include "psd_proto.h"
#include "pulsegen.h"
#include "SpSat.h"
#include "stddef_ep.h"

/* FUS - This arbitrary number is set by Scan when ortho slice is selected */
#define ORTHO_SLICE 553681

#define RESP_TABLE_SIZE 0x20000

/* ChemSat supported in CFH */
#define PSD_CFH_CHEMSAT

/* AMR - FOR MT */
%define PSD_CFH_MT

/* AMR - FOR MT */
#define NINE_BITS_RESOL 0.015594
#define PSD_DDS_COS_RES 4096   /* number of points in exciter 
				  lookup table */
#define PSD_DDS_CLOCK_RATE 10  /* exciter clock rate in MHz */

#define min_filt_time 300    /* MRIge34569: Time required by CERD between filter 
                             select and start of prefills of next
                             echo SOA.- TKF/VB*/
#define DFM_TR_THRESHOLD 30000
#define IMG_TO_DFM_DELAY 0

#define TR_SLOP_GR 1ms
#define EXOROVER

#define SPSATXKILLER  /* YMSmr09409 HK */

/* AMR - FOR MT */
@inline MagTransfer.e MTGlobal

@inline ChemSat.e ChemSatGlobal
@inline SpSat.e SpSatGlobal
@inline Exorcist.e ExorcistGlobal
@inline Prescan.e PSglobal
@inline loadrheader.e rheaderglobal

/* 2009-Mar-10, Lai, GEHmr01484: In-range autoTR support */
@inline AutoAdjustTR.e AutoAdjustTRGlobal

@ipgexport
/*********************************************************************
 *                   2DFAST.E IPGEXPORT SECTION                      *
 *                                                                   *
 * Standard C variables of _any_ type common for both the Host and   *
 * Tgt PSD processes. Declare here all the complex type, e.g.,       *
 * structures, arrays, files, etc.                                   *
 *                                                                   *
 * NOTE FOR Lx:                                                      *
 * Since the architectures between the Host and the Tgt sides are    *
 * different, the memory alignment for certain types varies. Hence,  *
 * the following types are "forbidden": short, char, and double.     *
 *********************************************************************/

@inline Prescan.e PSipgexport
int off_rfcsz[DATA_ACQ_MAX];
/* MRIhc08159 */
RF_PULSE_INFO rfpulseInfo[RF_FREE] = { {0,0} };


@cv
/*********************************************************************
 *                       2DFAST.E CV SECTION                         *
 *                                                                   *
 * Standard C variables of _limited_ types common for both the Host  *
 * and Tgt PSD processes. Declare here all the simple types, e.g,    *
 * int, float, and C structures containing the min and max values,   *
 * and ID description, etc.                                          *
 *                                                                   *
 * NOTE FOR Lx:                                                      *
 * Since the architectures between the Host and the Tgt sides are    *
 * different, the memory alignment for certain types varies. Hence,  *
 * the following types are "forbidden": short, char, and double.     *
 *********************************************************************/

/* AMR - FOR MT */
@inline MagTransfer.e MTCV

@inline ChemSat.e ChemSatCV
@inline SpSat.e SpSatCV
@inline loadrheader.e rheadercv
@inline Exorcist.e ExorcistCV

/* 2009-Mar-10, Lai, GEHmr01484: In-range autoTR support */
@inline AutoAdjustTR.e AutoAdjustTRCVs

@inline Minte_fgre_calcs.e MinteCV

float maxpeak = 8.0;

float xkilltarget;
float zkilltarget;
int zrtime;
int xrtime;

int rfconf=137;
float a_scale = 2 with {.001,,.001, INVIS," rf scaling factor",};
float area_rf1 = 0 with {0,,0,INVIS, "area of rf1 pulse",};

int ctlend = 0 with {0,,0,INVIS,
		       "card deadtime when next slice in intern gated",};
int ctlend_last = 0 with {0,,0,INVIS,
			    "deadtime for last slice in a cardiac scan",};
int ctlend_fill = 0 with {0,,0,INVIS, 
			    "deadtime for last slice in a filled R-R",};
int ctlend_unfill = 0 with {0,,0,INVIS, 
			      "deadtime for last slice in a unfilled R-R",};
int dda = 4 with {0,,4,INVIS," number of disdaqs in scan",};
int debug = 0 with {0,1,0,INVIS,"1 if debug is on ",};
int debug_MT = 0 with {0,1,0,INVIS,"1 if debug for the Magnetization Transfer option is on ",};

int dex = 0 with {,,0,INVIS, "num of discarded excitations",};
int gating = 0 with {0,,0,INVIS, "gating - TRIG_INTERN, TRIG_LINE, etc.",};

/* FUS */
int ext_trig = 0 with {0,1,0,INVIS,"Externally Triggered Scan (1=ON, 0=OFF)",};

int temp_trig = 0 with {0,,0,INVIS, "TRIG_INTERN or gating, etc.",};
int ipg_trigtest = 1 with {0,1,0,INVIS, "if 0 use internal trig always",};
float echo1bw = 16 with {,,,INVIS, "Echo1 filter bw. in KHz",};
float echo2bw = 16 with {,,,INVIS, "Echo2 filter bw. in KHz",};
float fnecho_lim_temp = 1 with {,,,VIS, "min percentage of read window for minfov.",};
int min_tenfe = 0 with {,,0,INVIS," minimum echo time w/ full echo",};
int min_tefe = 0 with {,,0,INVIS," minimum echo time w/ frac. echo",};
int num_scanlocs = 1 with {1,,1,INVIS,
			     "opphases for multi-phase, opslquant otherwise",};
int pre_pass = 0 with {0,,0,INVIS, "prescan slice pass number",};
int nreps = 0 with {0,,0,INVIS, " number of sequences played out",};
int gxktime = 0 with {0,,,INVIS, "X Killer Time.",};
int gzktime = 0 with {0,,,INVIS, "Z Killer Time.",};
int pos_killer = 0 with {0,,,INVIS, "Time location for killer.",};
int pos_start = 0 with {0,,,INVIS, "Start time for sequence. ",};
int pos_DAB = 0 with {0,,,INVIS, "Start time for 1st DAB SSP. ",};
int pos_DAB2 = 0 with {0,,,INVIS, "Start time for 2nd DAB SSP. ",};
int prerf_ssptime;
int post_echo_time = 0 with {0,,,INVIS, "time from te to end of seq",};
int psd_tseq = 0 with {0,,,INVIS, " intersequence delay time for cardiac",};
int ps2_dda = 0 with {0,,,INVIS," Number of disdaq in 2nd pass prescan.",};
int pw_gxwl = 0 with {0,,,INVIS, " left wing of readout",};
int pw_gxwr = 0 with {0,,,INVIS, " right wing of readout",};
int pw_gxwr_delta = 0 with {0,,,INVIS, " right wing delta of readout",};
int pw_gxwl2 = 0 with {0,,,INVIS, " left wing of readout for 2nd echo",};
int pw_gxwr2 = 0 with {0,,,INVIS, " right wing of readout for 2nd echo",};
int max_read_ramp = 0 with {0,,,INVIS, "maximum ramp width of readout attack/decay",};
int eppkpower,epseqtime;
int slquant_per_trig = 0 with {0,,0,INVIS, 
				 "slices in first pass or slices in first R-R for XRR scans",};

int td0  = 4 with {0,,1,INVIS, "Init deadtime",};
int t_exa = 0 with {0,,0,INVIS,"time from start of 90 to mid 90"};
int t_exb = 0 with {0,,0,INVIS,"time from mid of 90 to end 90"}; 
int iso_delay = 0 with {0,,0,INVIS,"time from point of zero phase precession to end of 90"}; 
int te_time = 0 with {0,,0,INVIS," te * opnecho ",};
int tfe_extra = 0 with {0,,0,INVIS, "savings for fract echo ",};
int time_ssi = 400us with {0,,400us,INVIS, "time from eos to ssi in intern trig",};
int tlead = 25us with {0,,25us,INVIS, "Init deadtime",};

/* These CVs are used to override the triggering scheme in testing. */
int psd_mantrig = 0 with {0,1,0, INVIS, "manual trigger override",};
int trig_mps2 = TRIG_LINE with {0,,TRIG_LINE, INVIS, " mps2 trigger",};
int trig_aps2 = TRIG_LINE with {0,,TRIG_LINE, INVIS, " aps2 trigger",};
int trig_scan = TRIG_LINE with {0,,TRIG_LINE, INVIS, " scan trigger",};
int trig_prescan = TRIG_LINE with {0,,TRIG_LINE, INVIS, "prescan trigger",};
int read_truncate = 1 with {0,,1,INVIS, "Truncate extra readout on fract echo",};

int trigger_time = 0 with {0,,0,INVIS, "Time for cardiac trigger window",};
int use_myscan = 0 with {0,,0,INVIS,"On(=1) to use my scan setup",};
int vemp_flag = 0 with {0,,0,INVIS,"on if vemp",};
int vemp_maybe_flag = 0 with {0,,0,INVIS,"on if we're not sure whether vemp",};
int mpgr_flag = 0 with {0,,0,INVIS,"on(=1) if no phase rewinder - old MPGR",};
int cine_flag = 0 with {0,,0,INVIS,"on(=1) if cine mode",};
int spgr_flag = 0 with {0,,0,INVIS,"on(=1) if spoiled grass",};
int cs_flag = 0 with {0,,0,INVIS,"on(=1) if fat or water sat is on.",};
int rewinder_flag = 0 with {0,1,0,INVIS,"on when PSD_CINE, opexor or !mpgr_flag",};
int vemp_temp = 0 with {0,,0,INVIS,"on if vemp",};
int vrg = 0 with {0,1,0,INVIS, "VRG flag",};

int fs_pi  = 32752 with {0,,32752,INVIS,"Phase board value for pi radians",};
int fs_2pi = 65504 with {0,,65504,INVIS,"Phase board value for 2pi radians",};
int seed   = 16807 with {0,,16807,INVIS,"Spoiled Grass seed value",};

float myrloc = 0 with {,,,INVIS, "Value for scan_info[0].oprloc",};

float area_gz1;
float area_gzr;			/* area of binomial rewinder - FUS */
float area_gxk;			/* area of gxk killer pulse */
float area_gzk;			/* area of gzk killer pulse */
int avail_pwgx1;		/* avail time for gx1 pulse */
int avail_pwgx1b;		/* same, but may be bumped for flow comp */
int avail_pwgxfc2;
int avail_pwgy1;		/* avail time for gy1 pulse */
int avail_pwgy1b;		/* same, but may be bumped for flow comp */
int avail_pwgz1;		/* avail time for gz1 pulse */
int pwgz1_slack;		/* spare time in gz1 and gzfc pulses */
int avail_image_time;		/* act_tr for norm scans, */
				/* R_R avail time for cardiac */ 
int avail_temp;
int bw_rf1;			/* bandwidth of rf pulse */
int bw_rf2;			/* bandwidth of rf2 pulse - FUS */
int time_binom;			/* extra time for binomial excitation - FUS */

float fecho_factor;		/* percentage of the echo acquired */

int flow_comp_type;		/* on if flow comp */
int lgate;                       /* for calculation of gating status */
float lgatef;                    /* more gating calculation */
int max_bamslice;		/* max slices that can fit into bam */

/* min sequence times based on coil heating */
int max_seqtime;                 /* max time per slice for max av 
				    panel routines */
int max_seqsar;                 /* max time for sar for max av 
				    panel routines */
int max_slicesar;                /* min slices based on sar */
int min_seq2, min_seq1, min_seq3; /* advisory panel */
int min_seqx, min_seqxz;           /* used for min full echo calculation */
int min_seq2_echo2, min_seq2_echo3, min_seq2_echo4;
int other_slice_limit;		/* temp av panel value */
int non_tetime;			/* time outside te time */
int slice_size;			/* bytes per slice */
float temp_float;		/* temp float value */
int tread_vbw;                   /* avail time for readout */
int tread_vbwl;                   /* avail time for 1st echo left readout */
int tread_vbwr;                   /* avail time for 1st echo right readout */

float vbw_mult;                 /* stretch factor for vbw */
	

/* since cfgradamp could not be seen in pulsegen (declared in epic.h), added
this dummy variable to test for ACGD gradient driver (8915)*/
int gradamp; 

int slicecnt;			/* slices B4 pause */
int pause_mpgr = 1 with {0,1,1,VIS,"B4 pause in mpgr 0:no pause 1:available",}; /* vmx 5/25/95 YI */
int dobaselines = 1;          /* switch for baselines */
int dither_on = 0;		 /* 1 means turn dither on  */
int dither_value = 6 with {0,15,6,VIS, "Value for dither",};

/* Intermediate timing CVs */
float a_gxw_nom, a_gxw2_nom, targ_slthick;

/* Number of cine locations */
int clocs;

int transformsize;
float phasefov;

/* int use_myscan = 0 with {0,,0,INVIS,"On(=1) to use my scan setup",}; */

/* cine CVs */
int choplet = 0 with {0,1,0,INVIS,"On chopper, scan lets pcm do chopping",};
int cine_nframes = 0 with {,,,INVIS,
			    "Number of frames in an acq for cine",};

int lcycles;
int fullcyc;
int test_cpmg = 1;             /* if 1, use new cpmg tech.,
				    otherwise use pi/2 */
int test_getecg = 1; 
int premid_rf90 = 0 with {0,,0, INVIS,"Time from beg. of seq. to mid 90", };

int loc_tdel;  /* Local trigger delay for cine */

int eflush = 1016us; /* time to post flush 127 samples */
int v6at15 = 0; /* power monitor adjustment for testing */

float save_opnex; /* save opnex value */
int save_nex_fixed, save_nex_exist;

float xmtaddScan;

/* AMR - FOR MT */
/* Test CV used to indicate the ratio of the the computed b'1s of the
   excitation pulse and the MT pulse */
float b1_ratio;

/* obloptimize */
int obl_debug = 0 with {0,1,0,INVIS,
                        "On(=1) to print messages for obloptimize",};
/* MRIhc15554*/
int obl_method = 0 with {0,1,1,INVIS,
                        "On(=1) to optimize the targets based on actual rotation matrices",};
int initnewgeo;

int maxx, maxy; /* maximum legal xres and yres for psd used
					by matrixcheck */
float target_area;      /* temp area */

int pw_gy1_tot;       /* temp time accumulation */
int pw_gy1r_tot;       /* temp time accumulation */
float yfov_aspect = 1.0 with {0,,,INVIS, "acquired Y FOV aspect ratio to X",};
int phaseres = 128 with {1, 2048, 128, INVIS, "Number of Points in the view table",};

@inline FlexibleNPW.e fNPWcvs

int vwchp = PSD_OFF with {,,PSD_OFF, INVIS, "Do view rf choping(=1)",};

/* begin TKF */
/* x axis variables */
int pw_gx1_frac = 0 with {0,,,INVIS, " Width of gx1 pulse for frac. echo.",};
int pw_gx1a_frac = 0 with {0,,,INVIS, " Attact width of gx1 pulse for frac. echo.",};
int pw_gx1d_frac = 0 with {0,,,INVIS, " Decay width of gx1 pulse for frac. echo.",};
int pw_gx1_full = 0 with {0,,,INVIS, " Width of gx1 pulse for full echo.",};
int pw_gx1a_full = 0 with {0,,,INVIS, " Attack width of gx1 pulse for full echo.",};
int pw_gx1d_full = 0 with {0,,,INVIS, " Decay width of gx1 pulse for full echo.",};

int pw_gxw_frac = 0 with {0,,,INVIS, " Width of gxw pulse for frac. echo.",};
int pw_gxwa_frac = 0 with {0,,,INVIS, " Width of gxw attact pulse for frac. echo.",};
int pw_gxwd_frac = 0 with {0,,,INVIS, " Width of gxw decay pulse for frac. echo.",};
int pw_gxw_full = 0 with {0,,,INVIS, " Width of 1st full echo if not truncated.",};
int pw_gxwa_full = 0 with {0,,,INVIS, " Width of gxw attact pulse for full echo.",};
int pw_gxwd_full = 0 with {0,,,INVIS, " Width of gxw decay pulse for full echo.",};

float a_gx1_frac = 0 with {,,,INVIS, " amplitude of gx1 pulse for frac. echo.",};
float a_gx1_full = 0 with {,,,INVIS, " amplitude of gx1 pulse for full echo.",};
int t_rd1a = 0 with {0,,0,INVIS,"time from start of readout to echo peak"};

int t_rd1a_frac = 0 with {0,,0,INVIS,"time from start of readout to echo peak for frac. echo"};
int t_rd1a_full = 0 with {0,,0,INVIS,"time from start of readout to echo peak for full echo"};
int t_rdb = 0 with {0,,0,INVIS,"time from echo peak to end of readout"};
int t_rdb_frac = 0 with {0,,0,INVIS,"time from echo peak to end of readout for frac. echo"};
int t_rdb_full = 0 with {0,,0,INVIS,"time from echo peak to end of readout for full echo"};
int tdaq = 0 with {0,,0,VIS,"time interval of data acquisition"}; 

int t_rd1a2 = 0 with {0,,0,INVIS,"time from start of readout to echo peak for second echo"};
int t_rdb2 = 0 with {0,,0,INVIS,"time from echo peak to end of readout for second echo"};
int pw_gxw2_full;

int dum1,dum2,dum3,dum4,dum5,dum6,dum7,dum8,dum9,dum10,dum11,dum12,dum13,dum14;
float a_dum1,a_dum2,a_dum3;

/* temporary variables for flow comp (if enabled) */
float a_gxfc_frac = 0 with {,,,INVIS, " amplitude of gxfc pulse for frac. echo.",};
float a_gxfc_full = 0 with {,,,INVIS, " amplitude of gxfc pulse for full echo.",};
int pw_gxfc_frac = 0 with {0,,,INVIS, " Width of gxfc pulse for frac. echo.",};
int pw_gxfca_frac = 0 with {0,,,INVIS, " Attact width of gxfc pulse for frac. echo.",};
int pw_gxfcd_frac = 0 with {0,,,INVIS, " Decay width of gxfc pulse for frac. echo.",};	
int pw_gxfc_full = 0 with {0,,,INVIS, " Width of gxfc pulse for full echo.",};
int pw_gxfca_full = 0 with {0,,,INVIS, " Attact width of gxfc pulse for full echo.",};
int pw_gxfcd_full = 0 with {0,,,INVIS, " Decay width of gxfc pulse for full echo.",};

int fullte_flag=PSD_OFF;
float fnecho_lim_frac;
int xres,xres_frac;

/*MRIge34569 - VB/TKF*/
int psdtap = 255;     
int prefilltime;
int min_echo_space;

float act_echofrac = 1 with {,,,VIS, "Actual echo fraction acquired",};

float rhfreqscale2;
float avminfov2;
/* end TKF */

/*  MRIge42775 For manufacturing requirements - CMC */
int do_noise = 0 with {0,1,0,INVIS,"1 to acquire no-RF data",};


/* MRIge90956 -- MRIhc01169 --- Luxexembourg gradient overrange  issue --- Move gy1 after slice rewinder --- RKS & RP */
int move_gy1 = 1 with {0,1,1,VIS,"set to 1 to move gy1 after gz1",};

/* begin LxMGD */
int multiphase_flag = 0 with {
    0, 1, 0, VIS, "0=OFF, 1=Support for sequential single slice multiphase",
};
int turbo_mode_flag = 0 with {
    0, 1, 0, VIS, "0=OFF, 1=Allow shorter TRs and TEs",
};
int multi_phases = 1 with {
    1, 256, 1, VIS, "Number of phases when multiphase is ON",
};
int tdel_bet_phases = 0 with {
    0, 5s, 0, VIS, "Internal CV for Delay Time Between Slices",
}; 
/* end LxMGD */
/* begin FUS */
int thermal_map = 0 with {
    0, 1, 0, VIS, "Thermal Mapping Flag (2 echoes) (0=OFF, 1=ON)",
};
int fus_chemsat = 0 with {
    0, 1, 0, VIS, "ChemSat Fat Suppression Flag (0=OFF, 1=ON)",
};
int binomial_pulse = 0 with {
    0, 1, 0, VIS, "Binomial Fat Suppression Flag (0=OFF, 1=ON)",
};
float fw_echo_delay = 6820.0 with {
    0.0, 10000.0, 6820.0, VIS, "Fat-Water out-of-phase delay (us)",
};
/* end FUS */

@inline vmx.e SysCVs /* vmx 12/09/94 YI */
 
@inline Prescan.e PScvs

int endview_iamp; /* last instruction phase amp */
float endview_scale; /* ratio of last instruction amp to maximum value */

float ave_grady_gy1_scale = 1.0 with {-1.0,1.0,1.0,VIS,"average gradient scale for gradient thermal calc",};

@host
/*********************************************************************
 *                       2DFAST.E HOST SECTION                       *
 *                                                                   *
 * Write here the code unique to the Host PSD process. The following *
 * functions must be declared here: cvinit(), cveval(), cvcheck(),   *
 * and predownload().                                                *
 *********************************************************************/

#include <float.h>
#include <math.h>
#include <stdlib.h>

#include "epic_iopt_util.h"
#include "epicfuns.h"   /* needed for pulsegen on the host */
#include "grad_rf_2dfast.h"
#include "psd.h"
#include "psdIF.h"
#include "psdopt.h"
#include "receiverunblankpulse.h"
#include "sar_burst_api.h"
#include "sar_display_api.h"
#include "sar_limit_api.h"
#include "sar_pm.h"
#include "sokPortable.h"
#include "support_func.host.h"
#include "sysDep.h"
#include "sysDepSupport.h"      /* FEC : fieldStrength dependency libraries */

/* VAL15  04/04/2005 YI */
@inline vmx.e HostDef
@inline loadrheader.e rheaderhost


#define GXKAREA_2DFAST 980.0
#define GZKAREA_2DFAST 980.0

FILTER_INFO *echo1_filt, *echo2_filt, *echo2e_filt; 
/* These will point to 
   a structure defining
   parameters of the filter
   used for the 1st echo
   and 2nd through N echos */


FILTER_INFO echo1_rtfilt, echo1_rtfilt_frac, echo2_rtfilt, echo2e_rtfilt;
/* for V6 use real time  filters,
   so allocate space for them 
   instead of trying to point to
   an infinite number of structures
   in filter.h. */

int av_temp_int;                 /* temp placement for advisory 
                                    panel return values */
int loop_delta;
int te2;

static char supfailfmt[] = "Support routine %s failed.";

/* peak B1 amplitudes */
float maxB1[MAX_ENTRY_POINTS], maxB1Seq;

/* Loop counters */
int entry, pulse;

static STATUS status;

@inline Prescan.e PShostVars            /* added with new filter calcs */

@inline 2dfast_iopts.e AllSupportedIopts
@inline 2dfast_iopts.e ImagingOptionFunctions

/* **********************
   Load up PSD header 
   ******************* */
psdname("2DFAST");
abstract("Regular 2D Gradient Echo PSD with CINE.");

/* ****************************************
   MYSCAN
   myscan sets up the scan_info table for a hypothetical scan.
   It is controlled by the cv opslquant, and opslthick, and opfov. 
   ************************************** */
STATUS
myscan(void)
{
    int i,j;

    int num_slice;
    float z_delta;		/* change in z_loc between slices */
    float r_delta;		/* change in r_loc between slices */

    num_slice = exist(opslquant);

    r_delta = exist(opfov)/num_slice;
    z_delta = exist(opslthick)+exist(opslspace);

    scan_info[0].optloc = 0.5*z_delta*(num_slice-1);
    scan_info[0].oprloc = myrloc;

    for(i=1;i<num_slice;i++) 
    {
        scan_info[i].optloc = scan_info[i-1].optloc - z_delta;
        scan_info[i].oprloc = i*r_delta;
        for(j=0;j<9;j++)
            scan_info[i].oprot[j] = scan_info[0].oprot[j];
    }
    return SUCCESS;
}


@inline Exorcist.e ExorcistHost

/* ****************************************
   CVINIT
   cvinit is invoked once and only once when
   the psd host process is started up.  Place
   code here that is independent of any OPIO
   button operation.
   ************************************** */
STATUS
cvinit(void)
{
#ifdef ERMES_DEBUG
    use_ermes = 0;
#else
    use_ermes = 1;
#endif

    /*
     * MRIge90911 - Activate the thermal mapping options only if the
     * right type-in name is provided
     */
    if( !strncasecmp( "tx_therm", get_psd_name(), 8 ) ) {
        /* LxMGD - Allow sequential multiphase */
        multiphase_flag = PSD_ON;
        /* LxMGD - Make sure that Multi-Phase selection defaults Turbo Mode to ON -- FUS */
        if( PSD_ON == multiphase_flag ) { 
            turbo_mode_flag = PSD_ON;
        }

        /* FUS - Show User CVS for FUS application */
        cvmod(opuser1, 0.0, 1.0, 1.0, "Thermal Mapping (2 echoes) (0=OFF, 1=ON)", 0, " ");
        opuser1 = _opuser1.defval;
        thermal_map = (int)exist(opuser1);

        cvmod(opuser2, 0.0, 1.0, 0.0, "ChemSat Fat Suppression (0=OFF, 1=ON)", 0, " ");
        opuser2 = _opuser2.defval;
        fus_chemsat = (int)exist(opuser2);

        cvmod(opuser3, 0.0, 1.0, 0.0, "Binomial Fat Suppression (0=OFF, 1=ON)", 0, " ");
        opuser3 = _opuser3.defval;
        binomial_pulse = (int)exist(opuser3);

        cvmod(opuser4, 0.0, 10000.0, 6820.0, "Fat-Water out-of-phase delay (us)", 0, " ");
        opuser4 = _opuser4.defval;   /* this is 3x the minimum, required for 3.2ms sincs */
        fw_echo_delay = exist(opuser4);

#ifdef ORTHOGONAL_SLICE
        cvmod(opuser5, 0.0, 1.0, 0.0, "Orthogonal Slice Mode", 0, " ");
        opuser5 = _opuser5.defval;

        /* opuser10 is used by SCAN to activate the FUS Ortho application */
        if( PSD_ON == thermal_map ) {
            opuser10 = ORTHO_SLICE;
        } else {
            opuser10 = PSD_OFF;
        }
#endif /* ORTHOGONAL_SLICE */
    }

    td0 = GRAD_UPDATE_TIME;

    cvmax(opcmon, 1);
    /* AMR - FOR MT */
    cvmax(opmt,1);

    /* begin LxMGD -- FUS */
    if( PSD_ON == multiphase_flag ) { 
        cvmax(opmph, 1);
        cvdef(opmph, 1);
        cvdef(opfphases, 1);
        opfphases = 1;
        TR_PASS = 20ms;
        cvmin(opsldelay, TR_PASS);
        cvdef(opsldelay, 1s);
        opsldelay = 1s;
        pimphscrn = 1;

        pifphasenub = 6;
        pifphaseval2 = 1;
        pifphaseval3 = 2;
        pifphaseval4 = 5;
        pifphaseval5 = 10;
        pifphaseval6 = 15;

        pisldelnub = 6;
        pisldelval3 = 500ms;
        pisldelval4 = 1000ms;
        pisldelval5 = 2000ms;
        pisldelval6 = 5000ms;

        piacqnub = 0;
    } else {
        cvmax(opmph, 0);
        cvdef(opmph, 0);
        cvdef(opfphases, PHASES_MIN);
        opfphases = PHASES_MIN;
        TR_PASS = 50ms;
        cvmin(opsldelay, TR_PASS);
        cvdef(opsldelay, TR_PASS);
        opsldelay = 50ms;
        pimphscrn = 0;
        pifphasenub = 0;    /* buttons for number of phases per location */
        pifphaseval2 = 1;
        pifphaseval3 = 2; 
        pifphaseval4 = 4;
        pifphaseval5 = 8;
        pifphaseval6 = 16;
        pisldelnub = 0;     /* buttons for delay after acquisition, value 0-6 */
        pisldelval3 = 500ms;
        pisldelval4 = 1s;
        pisldelval5 = 2s;
        pisldelval6 = 5s;
        piacqnub = 0;       /* buttons for phase acquisition order, value 0-2 */
    }
    /* end LxMGD -- FUS */

    if(exist(oppseq) == PSD_SPGR)
    {
        cvoverride(opirmode, PSD_SEQMODE_ON, PSD_FIX_ON, PSD_EXIST_ON);
    }

@inline vmx.e SysParmInit  /* vmx 12/09/94 YI */
@inline vmx.e AcrxScanVolumeInit

    /* initialize configurable variables */
    /* MRIhc18005 psd_board_type intialized in epic.h*/

    /* 2009-Mar-10, Lai, GEHmr01484: In-range autoTR support */
@inline AutoAdjustTR.e PulsegenonhostSwitch

    EpicConf();
    gradHeatMethod = TRUE;	/* Added for pulsegen-on-host feature */

    /* MRIhc54090 */
    if(cfsrmode == PSD_SR200)
    {
        obl_method = PSD_OFF;
        oblmethod_dbdt_flag = PSD_ON;
    }
    else
    {
        obl_method = PSD_ON;
        oblmethod_dbdt_flag = PSD_OFF;
    }

    inittargets(&loggrd, &phygrd);

    /* Save configurable variables after conversion by setupConfig() *//* VAL15  04/04/2005 YI */
    if(set_grad_spec(CONFIG_SAVE,glimit,srate,PSD_ON,debug_grad_spec) == FAILURE)
    {
        epic_error(use_ermes,"Support routine set_grad_spec failed",
                   EM_PSD_SUPPORT_FAILURE,1, STRING_ARG,"set_grad_spec");
        return FAILURE;
    }

@inline MK_GradSpec.e GspecInit
@inline MK_GradSpec.e GspecInit2

    /* For testing multi-slice in evaltool */
    if (exist(use_myscan)==1) myscan();
    initnewgeo = 1;
    if (obloptimize(&loggrd, &phygrd, scan_info, exist(opslquant), 
                    opphysplane, exist(opcoax), obl_method, 
                    obl_debug, &initnewgeo, cfsrmode)==FAILURE)
    {
        epic_error( use_ermes, "%s failed in %s.", EM_PSD_FUNCTION_FAILURE, EE_ARGS(2), STRING_ARG, "obloptimize", STRING_ARG, "cvinit()" );
        return FAILURE;
    } 

    if (value_system_flag) {
       vrgsat = SINC_SAT; /* YMSmr07571 */
    }

    if (SpSatInit(vrgsat) == FAILURE) 
        return FAILURE;

    /* MRIge65081 */
    if(opcgate==PSD_ON)
        setexist(opcgate,PSD_ON);
    else
        setexist(opcgate,PSD_OFF);

    /* AMR - FOR MT */
@inline MagTransfer.e MTInit
@inline ChemSat.e ChemSatInit
@inline Prescan.e PScvinit  

    /* First run the code generated by macros in  
       the preprocessor */
#include "cvinit.in"
    /* initialize configurable variables */
    /* init for oddnex flags. MHN */
    isNonIntNexGreaterThanOne  = 0;
    isOddNexGreaterThanOne      = 0;
    truenex     = 0;

    cvmin(opte2,0);
    cvmin(rhte2,0);      /* MRIge60135 */

    /************** CMON initialization ************/
    if(existcv(opcmon) && exist(opcmon)== PSD_ON)
    {
        cmon_flag = PSD_ON;
    }
    else
    {
        cmon_flag = PSD_OFF;
    }

    acq_type = TYPGRAD;
    flow_comp_type = TYPNFC;

    /* AMR - FOR ZIP512 */
    opzip512 = 0;
    cvmod(opzip512,0,1,0,"512 ZIP (0=off  1=on)",0,"512 ZIP must be 0 or 1.");

    /* ******************************
       Screen Control 
       ****************************** */

    /* bandwidth is field strength dependent - handle in cveval */
    pirbwpage = 1;        /* always place rbw parameters on scan timing screen */
    pircbnub = 4;         /* three bandwidth buttons dep on field strength */
    /* bandwidth - dependent on field strength */
    if( (cffield == B0_15000) || (cffield == B0_10000) || 
        (cffield == B0_30000) || (cffield == B0_40000) || (cffield == B0_70000) ||
        (cffield == B0_7000) ) {
        pircbval2 = 15.63;
        pircbval3 = 31.25;
        pircbval4 = 62.5;
        /* Change default selection in LxMGD turbo mode
           where 62KHz is allowed for both echoes */
        if( PSD_ON == turbo_mode_flag ) { 
            pidefrbw = 62.5;            /* default to 62.5kHz */
            cvdef(oprbw, 62.5);
            pircbnub = 4;               /* three bandwidth buttons selectable */
        } else { 
            pidefrbw = 15.63;           /* default to 16kHz */
            cvdef(oprbw,15.83);
            pircbnub = 3;               /* hide 62.5kHz when turbo_mode_flag is OFF */
        }
    } else {
        pircbval2 = 7.81;
        pircbval3 = 12.5;
        pircbval4 = 15.63;
        pidefrbw = 7.81;           /* default to 8kHz */
        cvdef(oprbw,7.81);
    }

    /* Second RBW is OFF by default */
    pircb2nub = 0;

    /* bandwidth - dependent on field strength */
    if( (cffield == B0_15000) || (cffield == B0_10000) || 
        (cffield == B0_30000) || (cffield == B0_40000) || (cffield == B0_70000) ) {
        /* Change RBW2 pulldown LxMGD turbo mode where 62KHz is allowed
           for second echo */
        if ( PSD_ON == turbo_mode_flag ) { 
            pircb2val2 = 12.5;
            pircb2val3 = 15.63;
            pircb2val4 = 31.25; 
            pircb2val5 = 62.5; 
            cvdef(oprbw2, 62.5);        /* default to 62.5kHz */
        } else { 
            pircb2val2 = 7.81;
            pircb2val3 = 12.5;
            pircb2val4 = 15.63;
            pircb2val5 = 31.25;
            cvdef(oprbw2, 15.63);       /* default to 16kHz */
        }
    } else if( (cffield == B0_5000) || (cffield == B0_7000) ) {
        pircb2val2 = 7.81;
        pircb2val3 = 12.5;
        pircb2val4 = 15.63;
        pircb2val5 = 23.44; 
        cvdef(oprbw2, 7.81);            /* default to 8kHz */
    }

    cvdef(opslthick,10); /* for shortest minte */
    cvdef(opte,40000);
    if(system_type == 1)
    {
        cvmin(opfov, 30.0);
    }

    /* **************************************************************
       RF1 CVs
       ************************************************************* */

    gscale_rf1 = 1.0;          /* Chun says it should be 1.0 */
    cyc_rf1 = 1;
    a_rf1 = 1.0;

    /* begin FUS - binomial Fat SAT */
    gscale_rf2 = gscale_rf1;
    cyc_rf2 = cyc_rf1;
    if( PSD_ON == binomial_pulse ) {
        rfpulse[RF2_SLOT].num = 1;  /* 2nd excitation identical to 1st */
        gradz[GZRF2_SLOT].num = 1;  /* 2nd slice select */
        gradz[GZR_SLOT].num = 1;    /* rewind between 2 slice selects */
        rfpulse[RF2_SLOT].activity = rfpulse[RF1_SLOT].activity;
    } else {
        rfpulse[RF2_SLOT].num = 0;
        gradz[GZRF2_SLOT].num = 0;
        gradz[GZR_SLOT].num = 0;
        rfpulse[RF2_SLOT].activity = PSD_PULSE_OFF;
    }
    /* end FUS */

    gradz[GZRF1_SLOT].num = 1;
    gradz[GZ1_SLOT].num = 1;
    gradz[GZK_SLOT].num = 1;

    gradx[GX1_SLOT].num = 1;
    gradx[GXW_SLOT].num = 1;

    /* *******************************************
       Scan Screen Control Initialization
       Standard initializations are listed in epic.h
       Screen values which don't match with epic.h 
       should be listed here.  Screen values that 
       are dependent on a operator input cv value
       should be listed in cveval. 
       pi<param>val1 is always reserved for the "other"
       button.
       ****************************************** */

    /* flip angle buttons */
    pifanub = 6;
    pifaval2 = 10;
    pifaval3 = 20;
    pifaval4 = 30;
    pifaval5 = 60;
    pifaval6 = 90;


    /* TE1 Buttons */
    pite1nub = 63;
    if( PSD_ON == thermal_map ) {
        /* Don't allow fractional echo with Thermal Mapping */
        pite1nub -= 2;
    }
    pite1val2 = PSD_MINIMUMTE;
    pite1val3 = PSD_MINFULLTE;
    pite1val4 = 10ms;
    pite1val5 = 15ms;
    pite1val6 = 20ms;

    /* TE2 Buttons */
    pite2nub = 6; /* Scan will not display if other than 2 echo button chosen */
    pite2val2 = 20ms;
    pite2val3 = 30ms;
    pite2val4 = 40ms;
    pite2val5 = 50ms;
    pite2val6 = 60ms;

    /* AMR - FOR MT */
    if( existcv(opmt) && (PSD_ON == exist(opmt)) )
    {
        pisupnub = 0;      /* ChemSAT not allowed with MT */
    }
    else
    {
        pisupnub = 1;
    }

    /* TI - defaulted to 0 in epic.h */

    /* FOV is coil dependent - Handle values in cveval */
    /* karun - MRIge 61176 */
    pifovnub = ((cffield   == B0_7000) &&
                (RX_COIL_BODY == getRxCoilType()) ? 5 : 6 );


    /* Slice Thickness - Use defaults in epic.h */

    /* Slice Skips - Use defaults in epic.h 
       Interleaving is available */

    /* begin FUS */
    if( PSD_ON == thermal_map ) {
        /* When ortho slice is used set slice spacing to 0 */
        if(floatsAlmostEqualEpsilons(exist(opuser10),ORTHO_SLICE,2)) 
        {
            piisnub = 0;
        } 
        else 
        {
            /* Reset to default from epic.h */
            piisnub = 5;
        }

        pislqnub = 0;

#ifdef UNDEF
        /* Overlap slices */
        pipctovl = 25;  /* Percentage of overlapping region thickness over whole slab thickness. */
        pidefovl = 0;   /* Indicate default button for overlap slices; 0: "Other" button, 1: "Recommended" button. */
        piovlnub = 1;   /* overlap locations on 3D MS scanning range (bitmap) */
#endif /* UNDEF */
    } else {
        /* Reset to defaults from epic.h */
        pislqnub = 15;
#ifdef UNDEF
        pipctovl = 25;
        pidefovl = 1;
#endif /* UNDEF */
        piovlnub = 0;
    }
    /* end FUS */

    /* Slice Locations - Defaulted to 0 in epic.h */

    /* Acquistion Timing  - Use defaults in epic.h */

    /* Nex button - Handle values in cveral */
    pinexnub = 61;

    /* Locs before pause - defaulted to 0 in epic.h */

    /* ****************************************************
       Advisory Panel 

       If piadvise is 1, the advisory panel is supported.
       pimax and pimin are bitmaps that describe which
       advisory panel routines are supported by the psd.
       Scan Rx will activate cardiac gating advisory panel
       values if gating is chosen from the gating screen onward.
       Scan Rx will display the minte2 and maxte2 values 
       if 2 echos are chosen.

       Constants for the bitmaps are defined in epic.h
       *********************************************** */
    piadvise = 1; /* Advisory Panel Supported */

    /* bit mask for minimum adv. panel values.
     * Scan Rx will remove TE2 entry automatically if 
     * 1 or 4 echos selected. */
    piadvmin = (1<<PSD_ADVECHO) +
        (1<<PSD_ADVTE) + (1<<PSD_ADVTE2)  + (1<<PSD_ADVTR) +
        (1<<PSD_ADVFOV) ;
    piadvmax = (1<<PSD_ADVECHO) +
        (1<<PSD_ADVTE) + (1<<PSD_ADVTE2)  + (1<<PSD_ADVTR) +
        (1<<PSD_ADVFOV) ;

    /* bit mask for cardiac adv. panel values */
    piadvcard = (1<<PSD_ADVISEQDELAY)
        + (1<<PSD_ADVMAXPHASES) + (1<<PSD_ADVEFFTR) + (1<<PSD_ADVMAXSCANLOCS)
        + (1<<PSD_ADVAVAILIMGTIME);

    /* bit mask for scan time adv. panel values */
    piadvtime = (1<<PSD_ADVMINTSCAN) + (1<<PSD_ADVMAXLOCSPERACQ) +
        (1<<PSD_ADVMINACQS) + (1<<PSD_ADVMAXYRES);

    if (SDL_CheckValidFieldStrength(SD_PSD_2DFAST,cffield,use_ermes)==FAILURE) {
        return FAILURE;
    }               

    /* Set psd_rf_wait and psd_grd_wait for this system. */
    if (setsysparms() == FAILURE) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "setsysparms" );
        return FAILURE;
    }

    /* There is no MSMA limitation anymore.  Radial prescriptions are
       always on for all 2D GRE prescriptions */
    pizmult = PSD_ON;

    /* initialize the gradient amplifier type to cfgradamp */
    gradamp = cfgradamp;

    /* Set flags for scan volume scale */
    set_vol_scale_cvs(cfgcoiltype,
                      VOL_SCALE_FREQ_DIR_ALLOWED | VOL_SCALE_PHASE_DIR_ALLOWED,
                      VOL_SCALE_CONSTRAINT_NONE,
                      &vol_scale_type,
                      &vol_scale_constraint_type);

    return SUCCESS;
}   /* end cvinit() */

@inline SpSat.e SpSatInit
@inline SpSat.e SpSatCheck

/* 4/21/96 RJL: Init all new Advisory Cvs */
@inline InitAdvisories.e InitAdvPnlCVs

/* *********************************************
   CVEVAL
   cveval is called upon every OPIO button push
   which has a corresponding CV (95% of the buttons).
   Place only that code that has an effect on 
   advisory panel results to save on button to
   button time.  Other code can be placed in cvinit
   or predownload.

   V6 0.5T support:
   VBW is always on for Version 6.  First echo
   is allowed to have bandwidths other than 16 kHz
   along with fractional echo.  Real time filter
   generation is also used for Version 6.
   To support V6 1st echo vbw, all cveval code
   has been moved to cveval1 function, which
   is called upon entry into cveval.  In V6 mode
   additional modifications are made to bw, % frac.
   echo, etc.
   ****************************************** */
STATUS
cveval( void )
{     
    double ave_sar_eval;
    double peak_sar_eval;
    double cave_sar_eval; /* Coil SAR for MRIge75651 */
    double b1rms_eval;

    /* 4/21/96 RJL: Init all new Advisory Cvs from InitAdvisories.e */
    InitAdvPnlCVs();

    if( PSD_CINE == exist(opimode) )
    {
        cvmax(opnex, MAX_CINE_NEX);
    }
    else
    {
        cvmax(opnex, MAX_NEX);
    }

    if ((exist(opexor) == PSD_ON) || (exist(opcmon) == PSD_ON) || (cine_flag == PSD_ON))
    {
        npw_flag = NPW_LIMITED_FACTOR;
    }
    else
    {
        npw_flag = NPW_FLEXIBLE_FACTOR;
    }

@inline FlexibleNPW.e fNPWeval

     /* Get gradient spec for silent mode *//* VAL15  04/04/2005 YI */
    if(!strncmp("2dfast_silent",get_psd_name(),13))
    {
        getSilentSpec(PSD_ON, &grad_spec_ctrl, &glimit, &srate);    
        /* ensure that only slew rate is changed for silent mode */
        grad_spec_ctrl = grad_spec_ctrl & ~GMAX_CHANGE; 
    }
    else
    {
        getSilentSpec(exist(opsilent), &grad_spec_ctrl, &glimit, &srate); 
    } 

@inline MK_GradSpec.e GspecEval

    /* Update configurable variables */
    if(set_grad_spec(grad_spec_ctrl,glimit,srate,PSD_ON,debug_grad_spec) == FAILURE)
    {
        epic_error(use_ermes,"Support routine set_grad_spec failed",
                   EM_PSD_SUPPORT_FAILURE,1, STRING_ARG,"set_grad_spec");
        return FAILURE;
    }
    /* Skip setupConfig() if grad_spec_ctrl is turned on */
    if(grad_spec_change_flag) { /* YMSmr06931  07/10/2005 YI */
        if(grad_spec_ctrl)
        {
            config_update_mode = CONFIG_UPDATE_TYPE_SKIP;
        }
        else
        {
            config_update_mode = CONFIG_UPDATE_TYPE_ACGD_PLUS;
        }
        inittargets(&loggrd, &phygrd);
    }

    /* PURE Mix */
    model_parameters.gre2d.minph_pulse_index = 0;
    model_parameters.gre2d.spgr_flag = spgr_flag;

@inline vmx.e SysParmEval  /* vmx 12/09/94 YI */
@inline vmx.e AcrxScanVolumeEval

@inline FlexibleNPW.e fNPWcheck1

    /* 2009-Mar-10, Lai, GEHmr01484: In-range autoTR support */
@inline AutoAdjustTR.e AutoAdjustTREval
    TR_SLOP = TR_SLOP_GR;

    /* MRIge90548 - RDP - turning off phase encoding */
    if (nope == 2) {
       autolock = 1;
       rawmode = 1;
    }

    /* *************************************
       CV Min, CV Max, and CV Error Modification
       ************************************ */
    avminflip = 1.0;
    avmaxflip = 180.0;
    /* AMR - FOR FLEX XRES */
    cvmin(opxres,128);
    avminxres = 128;
    cvdef(opxres,256);
    cvmin(opyres,128);
    avminyres = 128;
    cvdef(opyres,128);

    if (cffield == B0_70000)
    {
        cvmin(opxres, 64);
        avminxres = 64;
        cvmin(opyres, 64);
        avminyres = 64;

        cvmax(opxres, 1024);
        avmaxxres = 1024;
        cvmax(opyres, 1024);
        avmaxyres = 1024;
    }

    /* Initializations for advisory panel */
    avminslquant = 1;
    avminti = 0;
    avmaxti = 0;
    avmaxte = 1000ms;
    avminnecho = 1; 
    if (maxfov(&avmaxfov) == FAILURE)
    {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "maxfov" );
        return FAILURE;
    }
    if (maxtr(&avmaxtr) == FAILURE)
    {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "maxtr" );
        return FAILURE;
    }

    /* YMSmr09515 HK*/
    if( exist(opcgate) == PSD_ON ){
        piisil = 0;
    } else {
        piisil = 1;
    }

    cvmin(opslthick, 3); /* set min thickness to 3mm */      
    SDL_SetSLTHICK(SD_PSD_2DFAST,cffield);
    cvmin(opte, TE_MIN);   

    /* AMR - FOR ZIP512 */
    cvmax(opzip512, 1);                 /* Allow 512 ZIP */

    cvdef(opautote, PSD_MINTEFULL);	/* default to minimum te selection */
    cvdef(opnecho,1);
    opnecho = 1;
    cvdef(opfcomp,TYPNFC);
    opfcomp = TYPNFC;
    cvdef(opte2,60000);
    avminrbw = 2.0;
    avminrbw2 = 2.0;
    /* Set RBW/RBW2 defaults */
    if( (cffield == B0_15000) || (cffield == B0_10000) ||
        (cffield == B0_30000) || (cffield == B0_40000) || (cffield == B0_70000) ||
        (cffield == B0_7000) ) {
        /* Change default selection in LxMGD turbo mode where 62KHz is allowed for both echoes */
        if( PSD_ON == turbo_mode_flag ) { 
            pidefrbw = 62.5;            /* default to 62.5kHz */
            cvdef(oprbw, 62.5);
        } else { 
            pidefrbw = 15.63;           /* default to 16kHz */
            cvdef(oprbw,15.83);
        }
    } else {
        pidefrbw = 7.81;                /* default to 8kHz */
        cvdef(oprbw,7.81);
    }
    if( (cffield == B0_15000) || (cffield == B0_10000) ||
        (cffield == B0_30000) || (cffield == B0_40000) || (cffield == B0_70000) ) {
        /* Change RBW2 pulldown LxMGD turbo mode where 62KHz is allowed for second echo */
        if ( PSD_ON == turbo_mode_flag ) {
            cvdef(oprbw2, 62.5);        /* default to 62.5kHz */
        } else {                                              
            cvdef(oprbw2, 15.63);       /* default to 16kHz */
        }                                                     
    } else if( (cffield == B0_5000) || (cffield == B0_7000) ) {
        cvdef(oprbw2, 7.81);            /* default to 8kHz */ 
    }                                                         

    /* *************************************
       Set User CV page
       ************************************ */
    pititle = 0;
    piuset = 0; 
    cvdesc(pititle, "2DFAST User CV Page");

    /* begin FUS */
    /* Update internal flags */
    thermal_map = (int)exist(opuser1);
    fus_chemsat = (int)exist(opuser2);
    binomial_pulse = (int)exist(opuser3);
    fw_echo_delay = exist(opuser4);

    if( PSD_ON == thermal_map ) {
        /* Add user CVs for FUS */
        piuset |= use1 | use2 | use3 | use4;
#ifdef ORTHOGONAL_SLICE
        piuset |= use5;
#endif /* ORTHOGONAL_SLICE */

        /* Activate 2nd echo */
        cvdef(opnecho,2);
        cvoverride(opnecho, 2, PSD_FIX_OFF, PSD_EXIST_ON);
        avminnecho = 2; 

        /* Update default RBWs*/
        pidefrbw = 31.25;            /* default to 31.25kHz */
        cvdef(oprbw, 31.25);
        cvdef(oprbw2, 31.25);

        /* Set default X/Y res */
        avminyres = 64;
        cvmin(opyres,64);
        avminxres = 64;
        cvmin(opxres,64);

        /* Use flow comp grad slot for rewinder */
        cvdef(opfcomp,TYPNFC);
        cvoverride(opfcomp, TYPNFC, PSD_FIX_OFF, PSD_EXIST_ON);
    }
    /* end FUS */

    /* LxMGD - Set internal CVs using prescribed values from MPH page */
    if( PSD_ON == multiphase_flag ) { 
        multi_phases = exist(opfphases);
        tdel_bet_phases = exist(opsldelay);
    } else { 
        /* Set default values */
        multi_phases = 1; 
        tdel_bet_phases = TR_PASS;
    }

    /* Turn ON User CV page */
    pititle = (piuset != 0);

    /**************************************
     * Check out some flags governing
     * what type of scan we are doing
     *************************************/
    acq_type = TYPGRAD;
    flow_comp_type = ((existcv(opfcomp) && (exist(opfcomp) == TYPFC)) ? TYPFC : TYPNFC);
    vemp_flag = ((existcv(opnecho) && (exist(opnecho) == 2)) ? TYPVEMP : TYPNVEMP);
    cine_flag = (exist(opimode) == PSD_CINE ? PSD_ON : PSD_OFF);
    cmon_flag = ((existcv(opcmon) && exist(opcmon) == PSD_ON) ? PSD_ON : PSD_OFF);
    mpgr_flag = ((exist(opirmode) == PSD_SEQMODE_OFF) ? PSD_ON : PSD_OFF);
    cs_flag = (((exist(opfat) == PSD_ON) || (exist(opwater) == PSD_ON)) ? PSD_ON : PSD_OFF);
    rewinder_flag = PSD_ON;
    spgr_flag = (exist(oppseq) == PSD_SPGR);

    /*************************************************************************************
     **Initialize RF System Safety Information. This must be re-initialized in eval section
     ** since CV changes may lead to scaling of rfpulse
     **************************************************************************************/
    for (pulse=0; pulse<RF_FREE; pulse++) 
    {
        rfpulseInfo[pulse].change=PSD_OFF;
        rfpulseInfo[pulse].newres=0;
    }
    flip_rf1 = exist(opflip);
    off90 = 80;
    res_rf1 = 0;
    pw_rf1 = 3.2ms;

    /* begin FUS - binomial 1-1 pulses */
    res_rf2 = res_rf1;
    pw_rf2 = pw_rf1;
    rfpulse[RF2_SLOT].nom_pw = rfpulse[RF1_SLOT].nom_pw;

    /*
     * Repeat num and activity assignments to avoid cvinit omission
     * issues for certain changes on the fly
     */

    if( PSD_ON == binomial_pulse ) {
        flip_rf1 /= 2;
        flip_rf2 = flip_rf1;
        rfpulse[RF2_SLOT].num = 1;  /* 2nd excitation identical to 1st */
        gradz[GZRF2_SLOT].num = 1;  /* 2nd slice select */
        gradz[GZR_SLOT].num = 1;    /* rewind between 2 slice selects */
        rfpulse[RF2_SLOT].activity = rfpulse[RF1_SLOT].activity;
    } else {
        rfpulse[RF2_SLOT].num = 0;
        gradz[GZRF2_SLOT].num = 0;
        gradz[GZR_SLOT].num = 0;
        rfpulse[RF2_SLOT].activity = PSD_PULSE_OFF;
    }
    /* end FUS */

    if (SpSatInit(vrgsat) == FAILURE) 
        return FAILURE;

@inline ChemSat.e ChemSatInit
@inline Prescan.e PScvinit

    /* Check to see if rf pw's need scaling for large patients */
    for (entry=0; entry<MAX_ENTRY_POINTS; entry ++)
        scalerfpulses(opweight,cfgcoiltype,RF_FREE,rfpulse,entry,rfpulseInfo);

    pw_gzrf1 = pw_rf1;
    bw_rf1 = (int)(4*cyc_rf1/((float)pw_rf1/(float)1.0s));
    bw_rf2 = bw_rf1;   /* binomial pulse - FUS */

    /* If pulse width of 90 scaled, then scale off90 accordingly */
    if (rfpulseInfo[RF1_SLOT].change==PSD_ON) 
        off90 = (int)((float)off90*(float)pw_rf1/(float)rfpulse[RF1_SLOT].nom_pw);

    iso_delay = RUP_GRD(pw_rf1/2 + off90);

    if (!existcv(opautote)) setexist(opte, PSD_OFF);

    if (obloptimize(&loggrd, &phygrd, scan_info, exist(opslquant), 
                    opphysplane, exist(opcoax), obl_method, 
                    obl_debug, &opnewgeo, cfsrmode)==FAILURE)
    {
        epic_error( use_ermes, "%s failed in %s.", EM_PSD_FUNCTION_FAILURE, EE_ARGS(2), STRING_ARG, "obloptimize", STRING_ARG, "cveval()" );
        return FAILURE;
    }

    /* AMR - FOR MT *//* HCSDM00322607  Call MTEval() after obloptimize(). */
    if (MTEval(&mt_time) == FAILURE) {
        epic_error( use_ermes, "%s failed.", EM_PSD_ROUTINE_FAILURE, EE_ARGS(1), STRING_ARG, "MTEval" );
        return FAILURE;
    }

    /* MRIge20772 scale xkiller amp to reduce min seqcoilx time & get more slices 
       if sr17 mode.  This is not really correct - could cause problems with
       oblique, but for sr17 we need 5.4 parity. 5.5 will be okay with obliques */
    if (cfsrmode == PSD_SR17)
    { /* sr17 mode */
        xkilltarget=.7;
        zkilltarget=.7;
        xrtime = (70*loggrd.xrt)/100;
        zrtime = (70*loggrd.zrt)/100;
    }
    else
    {
        xkilltarget=loggrd.tx_xyz;
        zkilltarget=loggrd.tz_xyz;
        xrtime = loggrd.xrt;
        zrtime = loggrd.zrt;
    }

    max_read_ramp = loggrd.xrt;

    /* FUS - Disallow fractional echo for phase recon */
    if( PSD_ON == thermal_map && (PSD_MINTE == exist(opautote)) )
    {
        cvoverride(opautote, PSD_MINTEFULL, PSD_FIX_ON, PSD_EXIST_ON);
    }
    if( (exist(opautote) == PSD_MINTE) ||
        (exist(opautote) == PSD_MINTEFULL) )
    {
        setexist(opte,PSD_OFF);
    }

    /* ****************************
       Killer CVs  
       ************************** */

    /* if even number of echos flip killer */
    /* FUS - Don't flip if Thermal Map is ON */
    if( (( (exist(opnecho)) & 0x01 ) == 0) && (PSD_OFF == thermal_map) ) {
        area_gxk = -GXKAREA_2DFAST;
    } else {
        area_gxk = GXKAREA_2DFAST;
    }

    if ((amppwgradmethod(&gradx[GXK_SLOT], area_gxk, xkilltarget,
                         0.0 /* start amp */, 0.0 /* end amp */,
                         xrtime, MIN_PLATEAU_TIME))==FAILURE) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "amppwgradmethod:gxk" ); 
        return FAILURE;
    }
    gxktime = pw_gxka + pw_gxk + pw_gxkd;

    area_gzk = GZKAREA_2DFAST;

    if ((amppwgradmethod(&gradz[GZK_SLOT], area_gzk, zkilltarget,
                         0.0 /* start amp */, 0.0 /* end amp */,
                         zrtime, MIN_PLATEAU_TIME))==FAILURE) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "amppwgrad:gzk" );
        return FAILURE;
    }
    gzktime = pw_gzk + pw_gzka +pw_gzkd; 

    if( (status = cveval1()) != SUCCESS )
    {
        return status;
    }

    /* AMR - FOR MT */
    /* Calculate MT pulse flip angle and also average and peak sar */
    if( (exist(opmt) == PSD_ON) && (existcv(opmt)) )
    {
        if( SUCCESS != mt_flip_calc( &flip_rfmt, cffield,
                                     exist(opweight),
                                     txCoilInfo[getTxIndex(coilInfo[0])],
                                     (GRADIENT_COIL_E)cfgcoiltype,
                                     &rfpulse[RFMT_SLOT], RFMT_SLOT ) )
        {
            epic_error( use_ermes, supfailfmt,
                        EM_PSD_SUPPORT_FAILURE, EE_ARGS(1),
                        STRING_ARG, "mt_flip_calc" );
            return FAILURE;
        }
%ifdef PSD_CFH_MT
        flip_rfmtcfh = flip_rfmt;
%endif /* PSD_CFH_MT */
    } 

    if(debug_MT) {
        printf(" AFTER THE mt_flip_calc ROUTINE ......\n ");
        printf(" The Average SAR :mt_flip_calc: ave_sar is %f\n",ave_sar_eval);
        printf(" The Peak SAR :mt_flip_calc: peak_sar is %f\n",peak_sar_eval);
        printf(" The Coil SAR :mt_flip_calc: cave_sar is %f\n",cave_sar_eval);
        printf( " ************************************ \n");
        fflush(stdout);
    }

    /* First, find the peak B1 for the whole sequence. */
    if (findMaxB1Seq(&maxB1Seq, maxB1, MAX_ENTRY_POINTS, rfpulse, RF_FREE) == FAILURE)
    {
        epic_error(use_ermes,supfailfmt,EM_PSD_SUPPORT_FAILURE,EE_ARGS(1),STRING_ARG,"findMaxB1Seq");
        return FAILURE;
    }

    /* Set xmtadd according to maximum B1 and rescale for powermon,
       adding additional (audio) scaling if xmtadd is too big.
       Add in coilatten, too. */
    xmtaddScan = -200*log10(maxB1[L_SCAN]/maxB1Seq) + getCoilAtten(); 

    if (xmtaddScan > cfdbmax) {
        extraScale = (float) pow(10.0, (cfdbmax - xmtaddScan)/200.0);
        xmtaddScan = cfdbmax;
    } else {
        extraScale = 1.0;
    }

    if (setScale(L_SCAN, RF_FREE, rfpulse, maxB1[L_SCAN], 
                 extraScale) == FAILURE) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "setScale" );
        return FAILURE;
    }

    if( peakAveSars( &ave_sar_eval, &cave_sar_eval, &peak_sar_eval, &b1rms_eval,
                     (int)RF_FREE, rfpulse, L_SCAN, (int)(act_tr/slquant1)) == FAILURE )
    {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "peakAveSars" );
        return FAILURE;
    }
    piasar = (float)ave_sar_eval; /* Report to plasma */
    picasar = (float)cave_sar_eval; /* Coil SAR report to Plasma */
    pipsar = (float)peak_sar_eval; /* Report to plasma */
    pib1rms = (float)b1rms_eval; /* Report predicted b1rms value on the UI */
    
    /* SNR monitor */
    _pifractecho.fixedflag = 0;
    pifractecho = fecho_factor;
    setexist(pifractecho,_opte.existflag);
    _pifractecho.fixedflag = _opte.fixedflag;

    /* MRIge56926 - To make the value of avminslthick available even if 
       error conditions do not occur - TAA */

    minslicethick(&targ_slthick, bw_rf1, loggrd.tz, gscale_rf1,TYPDEF);
    targ_slthick = ceil(targ_slthick*10.0)/10.0;
    avminslthick = targ_slthick;

    if( PSD_ON == exist(opexor) )
    {
        piautovoice = 0;
    }
    else
    {
        piautovoice = 1;
    }

    info_fields_display(&piinplaneres,&pirbwperpix,&piesp,&ihinplanexres,
                        &ihinplaneyres,&ihrbwperpix,&ihesp,
                        DISP_INPLANERES|DISP_RBWPERPIX,
                        NO_ESP_DEFAULT_VALUE,
                        NOSCALE_INPLANEYRES_SQP);

    return SUCCESS;
}   /* end cveval() */


STATUS
cveval1( void )     
{
    float use_tr;		/* Use the proper tr value for pisctimx.  Value is 
                         *  determine if psd is 2dfast, cardiac gated,
                         *  or cine.
                         */
    int avmaxtr_tmp,fullcyc_tmp;
    float round_factor = 2.0; /* MRIhc16225 */

    /* 2009-Mar-10, Lai, GEHmr01484: In-range autoTR support */
@inline AutoAdjustTR.e AutoAdjustTRDebug

    /* ******************************
       Screen Control 
       ****************************** */
    /* Aquisition Matrix */
    maxx = 512; /* maximum xres for this psd */
    maxy = 512; /* maximum yres for this psd */

    if (B0_70000 == cffield)
    {
        maxx = 1024;
        maxy = 1024;
    }

    /* AMR - FLEX XRES */ 
    /* begin FUS */
    if( PSD_ON == thermal_map ) {
        /* For Thermal Map application */
        pixresnub = 14;
        pixresval2 = 128;
        pixresval3 = 256;
        pixresval4 = 512;
    } else {
        pixresnub = 1 + 2 + 4 + 8 + 16 + 32;      
        pixresval2 = 192;
        pixresval3 = 256;
        pixresval4 = 320;
        pixresval5 = 384;
        pixresval6 = 512;
    }
    if( PSD_ON == thermal_map ) {
        piyresval2 = 128;
    } else {
        piyresnub = 63; /* show 128 through 512 */
    }
    /* end FUS */

    /* Varibale FOV button on or off depending on square pixels */
    if (exist(opsquare) == PSD_ON)
    {
        piphasfovnub = 0;
        piphasfovnub2 = 0;
    }
    else if ( (exist(opexor) == PSD_ON) && (exist(opnpwfactor) > 1.0) )
    {
        piphasfovnub = 0;
        piphasfovnub2 = 3;
        piphasfovval2 = 1.0;
    }
    else
    {
        piphasfovnub = 0;
        piphasfovnub2 = 63;
        piphasfovval2 = 1.0;
        piphasfovval3 = 0.9;
        piphasfovval4 = 0.8;
        piphasfovval5 = 0.7;
        piphasfovval6 = 0.6;
    }

    /**** phase encodes in steps of 2 control ****/
    /* must be done before asymmetric fov */
    if (matrixcheck(maxx,maxy) == FAILURE)
    {
        return FAILURE;
    }

    if (existcv(opnecho) && (exist(opnecho) > 2)) {
        epic_error( use_ermes, "Only two echo multi-echo is currently supported.", EM_PSD_NECHO_OUT_OF_RANGE2, EE_ARGS(0) );
        return FAILURE;
    }                    /* restrict to only two echoes at the moment TKF */

    /* Activate second RBW only if num_echoes > 1 */
    if (exist(opnecho) > 1) {
        pircb2nub = 5;
    } else {
        pircb2nub = 0;
    }

    if (RX_COIL_BODY == getRxCoilType()) 
    {
        pifovval2 = 200;
        pifovval3 = 240;
        pifovval4 = 320;
        pifovval5 = 400;
        pifovval6 = cfsystemmaxfov;
        if((cfgradcoil == GCOIL_HGC)||(cfgradcoil == GCOIL_VECTRA))
            pifovval6 = 450;
    }
    else
    {
        /* Currently the same FOV buttons are used for 
           heads and surface coils */
        pifovval2 = 80;
        pifovval3 = 120;
        pifovval4 = 160;
        pifovval5 = 200;
        pifovval6 = 240;
    }

    if (exist(opirmode)==PSD_SEQMODE_OFF)
    {  /* MPGR mode*/
        /* TR Buttons */
        pitrval2 = 100ms;
        pitrval3 = 150ms;
        pitrval4 = 250ms;
        pitrval5 = 500ms;
        pitrval6 = 800ms;
    } 
    else
    {  /* GRASS mode*/
        /* TR Buttons */
        pitrval2 = 18ms;
        pitrval3 = 33ms;
        pitrval4 = 50ms;
        pitrval5 = 100ms;
        pitrval6 = 200ms;
    } 

    /* 2009-Mar-10, Lai, GEHmr01484: In-range autoTR support */
@inline AutoAdjustTR.e AutoAdjustTRInit

    /* Set min/maxTR for In-Range TR */ 
    piinrangetrmin = 200ms;
    piinrangetrmax = 11000ms;

    /* ****************
       Nex bookkeeping
       ************** */

    if( (status = nexcalc()) != SUCCESS )
    {
        return status;
    }

    /* begin FUS */
    {
        int savopsat = 0;
        int savopfat = 0;

        /* Save existing ChemSAT values and force Fat SAT ON */
        if( PSD_ON == fus_chemsat ) {
            savopfat = opfat;
            savopsat = opsat;
            cvoverride(opfat, PSD_ON, PSD_FIX_ON, PSD_EXIST_ON);
            cvoverride(opsat, PSD_ON, PSD_FIX_ON, PSD_EXIST_ON);
            cs_flag = PSD_OFF;
        }

        if( ChemSatEval( &cs_sattime ) == FAILURE ) {
            epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "ChemSatEval" );
            return FAILURE;
        }

        /* Restore previous ChemSAT values */
        if( PSD_ON == fus_chemsat ) {
            cvoverride(opfat, savopfat, PSD_FIX_ON, PSD_EXIST_ON);
            cvoverride(opsat, savopsat, PSD_FIX_ON, PSD_EXIST_ON);
        }
    }
    /* end FUS */

    if (SpSatEval(&sp_sattime) == FAILURE)
    {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "SpSatEval" );
        return FAILURE;
    }


    /* *************************************
       Check out some flags governing what type
       of scan we are doing
    *************************************/
    if (cine_flag == PSD_ON)
    {
        /* TE1 Buttons */
        /* button 2 and 3 are set for minimum and minimum full earlier */
        pite1val4 = 9ms;
        pite1val5 = 15ms;
        pite1val6 = 20ms;
        /* the following TR selections default to non sequential GRASS (MPGR) */
        /* TR Buttons */
        pitrnub = 6;
        pitrval2 = 18ms;
        pitrval3 = 33ms;
        pitrval4 = 50ms;
        pitrval5 = 100ms;
        pitrval6 = 200ms;

        blank = 0; /* Set to zero for cine */
        piadvcard = ((1<<PSD_ADVMAXPHASES) + 
                     (1<<PSD_ADVEFFTR) + 
                     (1<<PSD_ADVMAXSCANLOCS));
    }
    else
    {
        piadvcard = (1<<PSD_ADVISEQDELAY)
            + (1<<PSD_ADVMAXPHASES) + (1<<PSD_ADVEFFTR) + (1<<PSD_ADVMAXSCANLOCS)
            + (1<<PSD_ADVAVAILIMGTIME);
    }

    /* echo buttons */
    if((mpgr_flag == PSD_OFF) || (cine_flag == PSD_ON))
    {
        piechnub = 0;
    }
    else
    {
        piechnub = 2+4;  /* bit mask */
        piechval2 = 1;
        piechval3 = 2;
    }


    /* *********************
       Locations before pause
       ********************* */

    if( (exist(opcgate) == PSD_ON)||(cine_flag == PSD_ON) )
    {
        pause_mpgr = PSD_OFF;
        _opslicecnt.fixedflag = 0; opslicecnt = 0; _opslicecnt.existflag = 0;
    } 
    else
        pause_mpgr = _pause_mpgr.defval;  

    /* LxMGD : Change widget label to Repetitons before pause */
    if( PSD_ON == multiphase_flag ) { 
        pipautype = PSD_LABEL_PAU_REP;
    } else {
        /* Reset to default from epic.h */
        pipautype = PSD_LABEL_PAU_LOC;
    }

    if (exist(opslicecnt)==0 || cine_flag == PSD_ON) {
        pidmode = PSD_CLOCK_NORM;
        slicecnt = exist(opslquant);
        /* LxMGD : If pause between acquisitions is not desired, set slicecnt
           to (slices * phases) */
        if( PSD_ON == multiphase_flag ) { 
            slicecnt = exist(opslquant) * multi_phases;
        }
    } else {
        slicecnt = exist(opslicecnt);
        pidmode = PSD_CLOCK_PAUSE;
    }

    /* *********************
       Starting point logic
       ********************* */
    if (((exist(opexor) == PSD_ON) && existcv(opexor)) || cmon_flag == PSD_ON)
    {
        tlead = 1.8ms;
    }
    else
    {
        tlead = 24us;
    }

    tlead = RUP_GRD(tlead);

    /* ******************************************************************
       Z Board
       Slice Selection
    ******************************************************************/

    /* Slice Selection 
       First determine the bandwidth of each pulse */

    if (ampslice(&a_gzrf1, bw_rf1, exist(opslthick), gscale_rf1,TYPDEF)
        == FAILURE) 
    {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "ampslice for gzrf1" );
        return FAILURE;
    }

    /* Calculate attack ramp for alpha slice select */
    /* AMR _ FOR MT */
    if (optramp(&pw_gzrf1a, a_gzrf1, loggrd.tz, loggrd.zrt, TYPDEF)
        ==FAILURE)
        return FAILURE;

    /*** MROR fix - MRIge30724 - VB 3/19/96 ***/
    /* pw_gzrf1d = pw_gzrf1a; */
    /* If fcomp: gzrf1, phase encode, and gxfca overlap causing slew rate violations. */
    /* If not:   gzrf1, phase encode, and gx1a  overlap causing slew rate violations. */
    if (optramp(&pw_gzrf1d, a_gzrf1, loggrd.tz_xyz, loggrd.zrt, TYPDEF)
        ==FAILURE)
        return FAILURE;
    /*** End MROR ***/

    /* begin FUS - binomial pulse */
    bw_rf2 = bw_rf1;
    gscale_rf2 = gscale_rf1;
    if( PSD_ON == binomial_pulse ) {
        a_gzrf2 = a_gzrf1;
        pw_gzrf2 = pw_gzrf1;
        pw_gzrf2a = pw_gzrf1a;
        pw_gzrf2d = pw_gzrf1d;
    } else {
        a_gzrf2 = 0;
        pw_gzrf2 = 0;
        pw_gzrf2a = 0;
        pw_gzrf2d = 0;
    }
    /* end FUS */

    t_exb = iso_delay;
    t_exa = pw_gzrf1a + pw_rf1 - iso_delay;
    /* FUS - mid-binomial pulse */
    if( PSD_ON == binomial_pulse ) {
        t_exa += RUP_GRD((int)fw_echo_delay / 2);
    }

    psd_card_hdwr_delay = 10ms;
    if ((exist(opcgate) == PSD_ON) && existcv(opcgate))
    {
        avmintdel1 = psd_card_hdwr_delay + tlead + t_exa + GRAD_UPDATE_TIME;
        pitdel1 = avmintdel1 + sp_sattime + cs_sattime;
        advroundup(&avmintdel1); /* round up to ms */
        advroundup(&pitdel1); /* round up to ms */
        if (optdel1 < pitdel1)
        {
            td0 = RUP_GRD((int)(exist(optdel1) - (psd_card_hdwr_delay
                                                  + tlead + t_exa)));
        }
        else
        {
            td0 = RUP_GRD((int)(exist(optdel1) - (psd_card_hdwr_delay + tlead
                                                  + t_exa + sp_sattime
                                                  + cs_sattime)));
        }
        gating = TRIG_ECG;
        piadvmin = (piadvmin & ~(1<<PSD_ADVTR));
        piadvmax = (piadvmax & ~(1<<PSD_ADVTR));
        pitrnub = 0;
    }
    else
    {
        avmintdel1 = 0;
        td0 = GRAD_UPDATE_TIME;
        gating = TRIG_INTERN;
        piadvmin = (piadvmin | (1<<PSD_ADVTR));
        piadvmax = (piadvmax | (1<<PSD_ADVTR));
        pitrnub = 6;
    }

    /*************************************************************************
      pos_start marks the position of the start of the attack ramp of
      the gradient for the excitation pulse.  If Sat or other prep pulses
      are played before excitation, then the pos_start marker is incremented
      accordingly to account for the prep time.

      Because the rf unblank must be played at least -rfupa us prior to
      the excitation pulse, and the rf exciter frequency must also be
      set rffrequency_length prior to unblank, pos_start must allow enough
      space for these SSP packets if the attack of the ramp is not long
      enough.  Rather than arbitrarily making the attack pulse longer, the
      start position is adjusted and the attack ramp is optimized.

      Note also that rfupa is a negative number, so it is negated in
      the following calculation to make it a positive number.
    **************************************************************************/

    /* I think the GRAD_UPDATE_TIME should really be td0, but the following 
       comment that was in pulsegen before this makes me think that 
       GRAD_UPDATE_TIME may actually be correct. */

    /*  start time on boards
        Don't be concerned with creating a cardiac trigger delay time
        in pulsegen.  We will simply build a 4us wait at the beginning of the
        boards that can be expanded to length td0 on the first slice of an R-R.
        Start the first gradient in pulsegen at (tlead + the minimum length of 
        the td0 wait instruction (4us))  */

    prerf_ssptime = RUP_GRD((int)(DAB_length[bd_index]+minimumPreRfSspTime()));

    pos_start = RUP_GRD((int)(GRAD_UPDATE_TIME + tlead +
                              IMax(2,pw_gzrf1a,prerf_ssptime)
                              - pw_gzrf1a));

    pos_DAB = RUP_GRD((int)(GRAD_UPDATE_TIME + tlead +
                            IMax(2,pw_gzrf1a,prerf_ssptime)
                            - prerf_ssptime)); 


    /* MRIge21274 */
    /* There is a possibility that cine timing will fail with higher
       SR rated systems that result in shorter TE's. */
    if (cine_flag == PSD_ON)
    {
        pos_DAB = ( RUP_GRD((int)(GRAD_UPDATE_TIME + tlead +
                                  IMax(2, pw_gzrf1a, prerf_ssptime) )) + pw_gzrf1
                    + psd_rf_wait + minimumPostRfSspTime() );
    }

    if (((exist(opcgate) == PSD_ON) && (exist(optdel1) >= pitdel1)) ||
        (exist(opcgate) == PSD_OFF))
    {
        pos_start += sp_sattime + cs_sattime;
        pos_DAB += sp_sattime + cs_sattime;
        pos_DAB2 += sp_sattime + cs_sattime;
    }

    /* AMR - FOR MT */
    if ( existcv(opmt) && (PSD_ON == exist(opmt)) )
    {
        pos_start += mt_start + mt_time;
        pos_DAB += mt_start + mt_time;
        pos_DAB2 += mt_start + mt_time;
    }
    /* sunl -- MRIge73418 */
    pos_start = RUP_GRD(pos_start);
    pos_DAB = RUP_GRD(pos_DAB);
    if (pos_DAB2 > 0) pos_DAB2 = RUP_GRD(pos_DAB2);

    /****  Asymmetric Fov  ****/
    /* handling for phase (y) resolution and recon scale factor.*/
@inline FlexibleNPW.e fNPWeval1

    if( PSD_ON == turbo_mode_flag ) {  
        avmaxrbw = 62.5;
        avmaxrbw2 = 62.5;
    } else {
        avmaxrbw = 31.25;
        avmaxrbw2 = 31.25;
    }

    /* begin TKF */

    /* *****************************************
       Z rephaser and flow comp
       ************************************** */

    /* bypass this check */
    avail_pwgz1 = TR_MAX;

    if ((exist(opfcomp))==TYPFC)
    {
        if (amppwgzfcmin(a_gzrf1,pw_gzrf1a,pw_gzrf1,pw_gzrf1d,
                         avail_pwgz1,iso_delay - pw_gzrf1/2,
                         loggrd.tz_xyz, loggrd.zrt,loggrd.zbeta,
                         &a_gz1,&pw_gz1a,&pw_gz1,&pw_gz1d,
                         &a_gzfc,&pw_gzfca,&pw_gzfc,&pw_gzfcd) == FAILURE )
        {
            epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "amppwgzfcmin:gzrf1" );
            return FAILURE;
        }
        gradz[GZFC_SLOT].num = 1;
    } else {
        /* area needed for rephaser */
        area_gz1 = (iso_delay + pw_gzrf1d/2.0)*a_gzrf1; 

        if (amppwgz1(&a_gz1, &pw_gz1, &pw_gz1a, &pw_gz1d, area_gz1, avail_pwgz1,
                     MIN_PLATEAU_TIME, loggrd.zrt, loggrd.tz_xyz) == FAILURE)
        {
            epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "amppwgz1:gz1" );
            return FAILURE;
        }
        gradz[GZFC_SLOT].num = 0;

        /* FUS - Area for rewinder between binomial slice selects */
        if( PSD_ON == binomial_pulse ) {
            area_gzr = (pw_gzrf1 + (pw_gzrf1a + pw_gzrf1d)/2.0) * a_gzrf1;
            if( amppwgz1( &a_gzr, &pw_gzr, &pw_gzra, &pw_gzrd, area_gzr,
                          avail_pwgz1, MIN_PLATEAU_TIME, loggrd.zrt,
                          loggrd.tz_xyz ) == FAILURE ) {
                epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "amppwgz1:gzr" );
                return FAILURE;
            }
        }
    }


    /* *************************************************************
       Y Board - Dephaser and Rewinder

       Calculate Y Phase encode amp and pw.

    ************************************************************/
    yfov_aspect = nop*exist(opphasefov);

    /* MRIhc16225: Introducing round_factor for rounding rhnframes & and endview() call argument
                   to nearest even number */
    round_factor = (floatsAlmostEqualEpsilons(fn,0.75,2)) ? 6.0 : 2.0;
    rhnframes = (int)(ceil( eg_phaseres * fn * yfov_aspect/round_factor ) * round_factor);
    phaseres = (INT)(rhnframes/fn);

    /* Scale the waveform amps for the phase encodes 
     * so each phase instruction jump is an integer step */
    if (endview(phaseres, &endview_iamp) == FAILURE)
    {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "endview" );
        return FAILURE;
    } 

    endview_scale = (float)max_pg_iamp / (float)endview_iamp;

    if (amppwencode(&grady[GY1_SLOT], &pw_gy1_tot,
                    FMin(2,loggrd.ty_xyz,loggrd.ty/endview_scale),
                    loggrd.yrt,
                    nop*exist(opfov)*exist(opphasefov), phaseres,
                    0.0 /* offset area */) == FAILURE) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "amppwencode:gy1" );
        return FAILURE;
    }

    grady[GY1_SLOT].num = 1;

    /* phase rewinder */
    if (rewinder_flag == PSD_ON)
    {
        a_gy1ra = -a_gy1a;
        a_gy1rb = -a_gy1b;
        pw_gy1r = pw_gy1;
        pw_gy1ra = pw_gy1a;
        pw_gy1rd = pw_gy1d;
        grady[GY1R_SLOT].num = 1;
    }
    else
    {
        a_gy1ra = 0;
        a_gy1rb = 0;
        pw_gy1r = 0;
        pw_gy1ra = 0;
        pw_gy1rd = 0;
        grady[GY1R_SLOT].num = 0;
    }
    pw_gy1r_tot = pw_gy1ra + pw_gy1r + pw_gy1rd;

    /* ***************************************************************
       Mininum seq times for Z and Y axis 
    ***************************************************************/

    /* Calculate minimum time from mid 90 */
    /* to end of refocus based on slice */
    /* select axis */ 
    if (exist(opfcomp)==TYPFC)
        min_seq1 =			/* add in flow comp pulse */
            (iso_delay+pw_gzrf1d) + (pw_gzfca+pw_gzfc+pw_gzfcd) +
            (pw_gz1a+pw_gz1+pw_gz1d);
    else
        min_seq1 =			/* no flow comp pulse */
            (iso_delay+pw_gzrf1d) + (pw_gz1a+pw_gz1+pw_gz1d);

    /* Calculate minimum time from mid 90 to end of gy1 on phase encoding axis */ 
    /* iso_delay accounts for min phase rf */  
    min_seq3 = RUP_GRD(iso_delay + pw_gy1_tot + rfupd);


    /* FUS - Add binomial excitation */
    if( PSD_ON == binomial_pulse ) {
        time_binom = RUP_GRD((pw_gzra + pw_gzr + pw_gzrd) + 
                             (pw_gzrf2a + pw_gzrf2 + pw_gzrf2d));
        if( time_binom > fw_echo_delay ) {
            cvoverride(opuser4, time_binom + 20us, PSD_FIX_ON, PSD_EXIST_ON);
            fw_echo_delay = exist(opuser4);
        }
        min_seq1 += RUP_GRD((int)(fw_echo_delay / 2));  /* midpoint of binomial pulses */
        min_seq3 += RUP_GRD((int)(fw_echo_delay / 2));
    }

    /* ***************************************************************
       X Board - readout 
    ***************************************************************/

    /* *********************************************************
       Determine full or fractional echo
       also determine readout gradient amplitude and pulse width
       ********************************************************* */

    /* ***********************
       first calculate the timing for full echo case 
       ***********************                         */


    xres = exist(opxres);
    fnecho_lim = 1;
    fecho_factor = 1;

    if ( calcfilter( &echo1_rtfilt,       /* I:   all the filter parameters */
                     exist(oprbw),       /* I/O: desired and final allowable bw */
                     exist(opxres),      /* I:   output pts generated by filter */
                     OVERWRITE_NONE )    /* oprbw will be updated in the next calcfilter call */
         == FAILURE) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "calcfilter:echo1:full" );
        return FAILURE;
    }

    echo1_filt = &echo1_rtfilt;

    /* Divide by 0 protection */
    if ((echo1_filt->tdaq == 0) || floatsAlmostEqualEpsilons(echo1_filt->decimation, 0.0, 2)) 
    {
        epic_error( use_ermes, "echo1 tdaq or decimation = 0", EM_PSD_BAD_FILTER, EE_ARGS(0) );
        return FAILURE;
    }

    pw_gxw_full = pw_gxwl + RUP_GRD(echo1_filt->tdaq) + pw_gxwr;
    pw_gxw = pw_gxw_full;

    /* record the bandwidth in CV for RSP */
    echo1bw = echo1_filt->bw;

    if (ampfov(&a_gxw, echo1bw, rhfreqscale*exist(opfov)) == FAILURE) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "ampfov" );
        return FAILURE;
    }

    /* if 64Khz rbw, increase fov and chop off */
@inline loadrheader.e rheadereval

    /* rounded up to the nearest 10mm*/
    avminfov = (float)((int)( (20.0 * (exist(oprbw)) * 1000.0 / (GAM * loggrd.tx) + 9.0) / 10.0 ) * 10);
    avminfov = FMax( 2, (double)avminfov, (double)FOV_MIN );

    mintefgre(&min_tenfe, &t_rd1a_full, &t_rdb_full,
              &tfe_extra, &pw_gxwa_full, &pw_gxwd_full,
              &a_gx1_full,&pw_gx1a_full,&pw_gx1_full,&pw_gx1d_full,
              &a_gxfc_full,&pw_gxfca_full,&pw_gxfc_full,&pw_gxfcd_full,
              fecho_factor, pw_gxwl, pw_gxw_full, pw_gxwr,
              a_gxw, iso_delay, flow_comp_type,min_seq1, min_seq3,loggrd.tx_xyz,loggrd.xrt);

    /***********************************************
      now calculate the timing for fractional echo case 
    ***********************************************/

    calc_xresfn(&xres_frac, &fnecho_lim_frac, (int)(exist(opxres)),&act_echofrac);

    fecho_factor = fnecho_lim_frac;

    if ( calcfilter( &echo1_rtfilt_frac,  /* I:   all the filter parameters */
                     exist(oprbw),        /* I/O: desired and final allowable bw */
                     xres_frac,           /* I:   output pts generated by filter */
                     OVERWRITE_OPRBW )    /* I:   request oprbw be updated */
         == FAILURE ) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "calcfilter:echo1:frac" );
        return FAILURE; 
    }

    echo1_filt = &echo1_rtfilt_frac;
    pw_gxw_frac = pw_gxwl + RUP_GRD(echo1_filt->tdaq) + pw_gxwr;

    mintefgre(&min_tefe, &t_rd1a_frac, &t_rdb_frac,
              &tfe_extra, &pw_gxwa_frac, &pw_gxwd_frac,
              &a_gx1_frac,&pw_gx1a_frac,&pw_gx1_frac,&pw_gx1d_frac,
              &a_gxfc_frac,&pw_gxfca_frac,&pw_gxfc_frac,&pw_gxfcd_frac,
              fecho_factor, pw_gxwl, pw_gxw_frac, pw_gxwr,
              a_gxw, iso_delay,flow_comp_type, min_seq1, min_seq3,loggrd.tx_xyz,loggrd.xrt);

    /* Divide by 0 protection */
    if ((echo1_filt->tdaq == 0) || floatsAlmostEqualEpsilons(echo1_filt->decimation, 0.0, 2)) {
        epic_error( use_ermes, "The filter specified has a zero time of acquisition or decimation.", EM_PSD_BAD_FILTER, EE_ARGS(0) );
        return FAILURE;
    }

    /* fractional echo is not supported when
       doing partial nex or when the user selected TE is
       greater than min_tenfe -- TKF */

    if ( (fn < 1) && existcv(opnex))
        fullte_flag = PSD_ON; /* full echo */
    else if ((exist(opautote) == PSD_MINTEFULL) || ((exist(opte) >= min_tenfe) && existcv(opte))) 
        fullte_flag = PSD_ON; /* full echo */
    else
        fullte_flag = PSD_OFF;  /* frac. echo */


    /* ****************************************
       Determine xres and frac echo parameters
       *************************************** */
    if (fullte_flag == PSD_ON) {
        /* Full Echo */
        t_rdb = t_rdb_full;
        t_rd1a = t_rd1a_full;
        pw_gx1 = pw_gx1_full;
        pw_gx1a = pw_gx1a_full;
        pw_gx1d = pw_gx1d_full;
        a_gx1 = a_gx1_full;

        xres = exist(opxres);
        fnecho_lim = 1;
        fecho_factor = 1;
        tfe_extra = 0;
        pw_gxw = pw_gxw_full;
        pw_gxwa = pw_gxwa_full;
        pw_gxwd = pw_gxwd_full;
        echo1_filt = &echo1_rtfilt;

        /* LxMGD : move the gxfc pulse settings to here */
        /* MRIge32218 RJL - Set pulse amplitudes etc. now that we know the values
           for the flowcomp lobes */
        if (exist(opfcomp)==TYPFC) {
            a_gxfc = a_gxfc_full;
            pw_gxfc = pw_gxfc_full;
            pw_gxfca = pw_gxfca_full;
            pw_gxfcd = pw_gxfcd_full;
        } 
    } else {
        /* Fractional Echo */
        t_rdb = t_rdb_frac;
        t_rd1a = t_rd1a_frac;
        pw_gx1 = pw_gx1_frac;
        pw_gx1a = pw_gx1a_frac;
        pw_gx1d = pw_gx1d_frac;
        a_gx1 = a_gx1_frac;
        pw_gxw = pw_gxw_frac;
        pw_gxwa = pw_gxwa_frac;
        pw_gxwd = pw_gxwd_frac;

        xres = xres_frac;
        fnecho_lim = fnecho_lim_frac;
        fecho_factor = fnecho_lim;   

        echo1_filt = &echo1_rtfilt_frac;

        /* LxMGD : move the gxfc calcs up here */
        if (exist(opfcomp)==TYPFC) {
            a_gxfc = a_gxfc_frac;
            pw_gxfc = pw_gxfc_frac;
            pw_gxfca = pw_gxfca_frac;
            pw_gxfcd = pw_gxfcd_frac;
        }
    }
    /* FUS - Use flow comp gradient slot as rewinder */
    if( PSD_ON == thermal_map ) {
        a_gxfc   = a_gx1;
#ifdef UNDEF
        pw_gxfc  = 2 * pw_gx1 + pw_gx1a;   /* 2x area of gx1 */
#endif /* UNDEF */
        pw_gxfc  = -(int)( (a_gxw * (pw_gxw + pw_gxwa) + a_gx1 * pw_gx1a) / a_gx1 / 4 ) * 4;
        pw_gxfca = pw_gx1a;                               
        pw_gxfcd = pw_gx1d;                               
    }                                                     
    /* End FUS */

    pitfeextra = tfe_extra;  /* recon header looks at this!! */

    if (mpgr_flag == PSD_ON)
        gradx[GXK_SLOT].num = 1;

    /* set slot values */
    /* FUS - Rewinder for 2nd echo */
    if( (flow_comp_type == TYPFC) ||
        ((PSD_ON == thermal_map) && (2 == exist(opnecho))) ) {
        gradx[GXFC_SLOT].num = 1;
    } else {
        gradx[GXFC_SLOT].num = 0;
    }

    /* ok now that we can find the minimum TE, set opte
       to that value */

    /* MRIge32215 RJL - For fractional echo, fractional NEX scans modify avminte to MINTEFULL value.
       2dfast doesn't allow fractional echo/fractinal NEX scans */

    /*  In 2dfast, we force the second echo to have the same number of points as the first echo */
    /*  LxMGD : Note that for fractional NEX, the TE defaults to fullTE,
        no matter what's selected in the TE pulldown. Make sure that avminte
        shows the right TE value used in the sequence in minTE, minFullTE,
        and fractional NEX cases */ 

    /* FUS - Disallow fractional echo for phase recon */
    if( PSD_ON == thermal_map && (PSD_MINTE == exist(opautote)) )
    {
        cvoverride(opautote, PSD_MINTEFULL, PSD_FIX_ON, PSD_EXIST_ON);
    }
    if ( (exist(opautote) == PSD_MINTE) ||
         (exist(opautote) == PSD_MINTEFULL) ) {
        setexist(opte,PSD_ON);
        _opte.fixedflag = 0;

        if ( (exist(opautote) == PSD_MINTEFULL) ||
             ( ( fn < 1.0 ) && existcv(opnex) ) ) {
            avminte = min_tenfe * 10;
            advroundup(&avminte);
            avminte = avminte / 10;
            opte = avminte;
        } else {
            avminte = min_tefe * 10;
            advroundup(&avminte);
            avminte = avminte / 10;
            opte = avminte;
        }
        _opte.fixedflag = 1;
    } else {
        /* Now take care of the type in TE values */
        /* Note that the fullteflag was already set based on typed in values */

        if ( fullte_flag == PSD_OFF ) {
            avminte = min_tefe * 10;
            advroundup(&avminte);
            avminte = avminte / 10;
        } else {
            avminte = min_tenfe * 10;
            advroundup(&avminte);
            avminte = avminte / 10;
        }
    }
    /*MRIge35026 - 9/11/96 - VB*/

    /* *****************************
       now do the second echo
       ***************************** */

    gradx[GXFC2_SLOT].num = 0;
    gradx[GXFC3_SLOT].num = 0;


    /* There's no reason why the 2nd echo BW should exceed the 1st.  */
    if (avmaxrbw2 > exist(oprbw)) { 
        avmaxrbw2 = exist(oprbw);
    }

    /* Make sure we do the second echo with the xres for the first one. 
       If the first echo is partial, all subsequent echoes are partial too
       - RJF 
    */

    if ( calcfilter( &echo2_rtfilt,       /* I:   all the filter parameters */
                     exist(oprbw2),       /* I/O: desired and final allowable bw */
                     xres,                /* I:   output pts generated by filter */
                     OVERWRITE_OPRBW2 )   /* I:   request oprbw2 be updated */
         == FAILURE ) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "calcfilter:echo2" );
        return FAILURE;
    }

    echo2_filt = &echo2_rtfilt;

    /* Divide by zero protection */
    if (floatsAlmostEqualEpsilons(echo2_filt->decimation, 0.0, 2)) 
    {
        epic_error( use_ermes, "The filter specified has a zero time of acquisition or decimation.", EM_PSD_BAD_FILTER, EE_ARGS(0) );
        return FAILURE;
    }

    if (exist(opnecho) > 1) {
        /* No Readout wings */
        /* for higher bandwidths, decimation -> 1,
           hence if echo2 has a lower bandwidth, it has a higher decimation and
           vbw_mult > 1. But in cvcheck, we do not allow oprbw2 > oprbw, so
           let's optimize the gradient amplitudes based off oprbw2.

           Also, we cannot acquire 160 points on the first echo and 256 on the
           subsequent echoes, if partial echo is used, then partial echoes
           must be used for all subsequent echoes.  - TKF */

        vbw_mult = echo2_filt->decimation/(float)echo1_filt->decimation;

        pw_gxw2 = pw_gxwl2 + RUP_GRD(echo2_filt->tdaq) + pw_gxwr2;
        echo2bw = echo2_filt->bw;            /* use our calc filter bandwidth */

        if (exist(oprbw2) > 60.0)                             
            rhfreqscale2 = 1.1;                               
        else                                                  
            rhfreqscale2 = 1.0;                               

        if (ampfov(&a_gxw2, echo2bw, rhfreqscale2*exist(opfov)) == FAILURE)
        {                                                     
            epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "ampfov(2)" );
            return FAILURE;                                   
        }                                                     

        if (optramp(&pw_gxw2a,a_gxw2,loggrd.tx_xyz,loggrd.xrt,TYPDEF) == FAILURE)
        {                                                     
            epic_error( use_ermes, "%s for %s failed.", EM_PSD_ROUTINE_FAILURE3, EE_ARGS(2), STRING_ARG, "optramp", STRING_ARG, "gxw2" );
            return FAILURE;                                   
        }
        pw_gxw2d = pw_gxw2a;                                  

        /* rounded up to the nearest 10mm*/
        avminfov2 = (float)((int)( (20.0 * (exist(oprbw2)) * 1000.0 / (GAM * loggrd.tx) + 9.0) / 10.0 ) * 10);
        avminfov = FMax( 2, (double)avminfov, (double)avminfov2 );

        /* get full echo readout time */                      
        if (fullte_flag == PSD_OFF) {

            /* Even if we are doing fractional echo on the second echo, let's calculate the full echo
               pulsetiming so that we can callmintefgre with the full readout pulse width. - RJF */

            if ( calcfilter( &echo2e_rtfilt,
                             exist(oprbw2),
                             exist(opxres),
                             OVERWRITE_NONE )
                 == FAILURE ) {
                epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "calcfilter:echo2:frac" );
                return FAILURE;
            }

            echo2e_filt = &echo2e_rtfilt;
            pw_gxw2_full = pw_gxwl2 + RUP_GRD(echo2e_filt->tdaq) + pw_gxwr2;

            /* See how t_rd1 and t_rdb is swapped in the argument list
               for partial second echo ! - RJF/TKF  */

            mintefgre(&dum1, &t_rdb2, &t_rd1a2,   
                      &dum2, &dum3, &dum4,
                      &a_dum1,&dum5,&dum6,&dum7,
                      &a_dum2,&dum8,&dum9,&dum10,
                      fecho_factor, pw_gxwl, pw_gxw2_full, pw_gxwr,
                      a_gxw2, iso_delay, flow_comp_type,40ms, 40ms,loggrd.tx_xyz,loggrd.xrt);
        } else {

            pw_gxw2_full = pw_gxw2;
            mintefgre(&dum1, &t_rd1a2, &t_rdb2,
                      &dum2, &dum3, &dum4,
                      &a_dum1,&dum5,&dum6,&dum7,
                      &a_dum2,&dum8,&dum9,&dum10,
                      fecho_factor, pw_gxwl, pw_gxw2_full, pw_gxwr,
                      a_gxw2, iso_delay, flow_comp_type,40ms, 40ms,loggrd.tx_xyz,loggrd.xrt);
        }

        /* Optimized Echo spacing calculations for MGD - RJF */
        /* RJF - 4us below is the length of the TNS off packet. */
        /* psd_grd_wait below makes sure that the XTR packet for the second echo doesnot
           playout before the first echo acquisition finishes. */

        avminte2 = (opte + t_rdb + psd_grd_wait + t_rd1a2 +
                    IMax(2, (pw_gxwd + pw_gxw2a), (4us + ATTEN_unlock_length[ bd_index] 
                                                   + DAB_length[bd_index]
                                                   + XTR_length[bd_index])) );


        /* FUS - Use flow comp gradient slot as rewinder */
        if( PSD_ON == thermal_map ) {
            a_gxfc   = a_gx1;
#ifdef UNDEF
            pw_gxfc  = 2 * pw_gx1 + pw_gx1a;   /* 2x area of gx1 */
#endif /* UNDEF */
            pw_gxfc  = -(int)( (a_gxw * (pw_gxw + pw_gxwa) + a_gx1 * pw_gx1a) / a_gx1 / 4 ) * 4;
            pw_gxfca = pw_gx1a; 
            pw_gxfcd = pw_gx1d;

            avminte2 += (pw_gxfca + pw_gxfc + pw_gxfcd);
        }
        /* End FUS */

        if ((exist(opfcomp))==TYPFC) {
            /*the minte2 quick check will catch any failures so use 3s */
            amppwgxfc2(a_gxw, pw_gxw_full, pw_gxwd, pw_gxw2a, pw_gxw2_full, 
                       loggrd.xrt,3s,loggrd.tx_xyz,exist(opte2)-exist(opte),
                       &a_gxfc2,&pw_gxfc2a,&pw_gxfc2,&pw_gxfc2d,
                       &a_gxfc3,&pw_gxfc3a,&pw_gxfc3,&pw_gxfc3d);

            a_gxfc2 = -a_gxfc2;
            a_gxfc3 = -a_gxfc3;

            gradx[GXFC2_SLOT].num = opnecho-1;
            gradx[GXFC3_SLOT].num = opnecho-1;

            avminte2 = (opte + t_rdb + t_rd1a2 +
                        IMax(2, (pw_gxwd + pw_gxfc2a + pw_gxfc2 + pw_gxfc2d +
                                 pw_gxfc3a + pw_gxfc3 + pw_gxfc3d + pw_gxw2a),
                             (4us + ATTEN_unlock_length[ bd_index] 
                              + DAB_length[bd_index] + XTR_length[bd_index])) );
        }

        avminte2 *= 10;
        advroundup(&avminte2);
        avminte2 /= 10;
    }

    gradx[GXW2_SLOT].num = exist(opnecho) -1;



    /* **********************************************************
       Advisory Panel Calculations 

       All rfpulse and gradient bookkeeping structures should be
       uptodate by this point.  Advisory panel routines automatically
       set corresponding advisory panel export variables.

       * ********************************************************** */

    if (exist(opcgate) ==  PSD_OFF)
    {
        if (cine_flag == PSD_ON)
        {
            gating = TRIG_INTERN;
        }
        else if(mpgr_flag == PSD_ON)
        {
            /* FUS - Use internal triggering */
            gating = (PSD_ON == thermal_map) ? TRIG_INTERN : TRIG_LINE;
        }
        else
        {
            lcycles = (int)((exist(optr)+TR_SLOP_GR)/(1s/cflinfrq));
            lgate = ((float)lcycles*(1s/cflinfrq) >= exist(optr)) ? PSD_ON : PSD_OFF;
            gating = (lgate == PSD_ON) ? TRIG_LINE : TRIG_INTERN;
        }
    }


    /* Seqtype(e.g., MPMP, XRR, NCAT, CAT)  needed for several routines */
    /*
     * FUS - To use the standard Multi-Phase screen, the user must select
     * Gradient Echo, type in the PSD name (e.g., tx_thermal), and type in
     * [Fast, MPh] for Imaging options.  However, we do not want the
     * opfast CV set when deciding the type of sequence.  Otherwise, we
     * would be a TYPFASTMPH instead of TYPNCAT.
     */
    if( PSD_ON == thermal_map ) {
        cvoverride(opfast, PSD_OFF, PSD_FIX_ON, PSD_EXIST_ON);
    }
    if( seqtype( &seq_type ) == FAILURE ) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "seqtype" );
        return FAILURE;
    }

    /* Calculate some necessary intermediate times for advisory panel */
    if( TYPVEMP == vemp_flag ) {
        te_time = exist(opte2);
    } else {
        te_time = exist(opnecho) * exist(opte);
    }

    /* Fixes MRIge22006 - If pos_start has sattimes, don't add sattimes
       to non_tetime.  But if pos_start doesn't have sattimes, non_tetime
       must have them added here. */ 

    /* MRIge43862 - added GRAD_UPDATE_TIME to non_tetime calcualtion
       to include the time to play out seqcore at the end of waveform - latha@mr 
    */

    /* MRIge73486 - RJF/LS - Added gzk pulse timing to non-tetime. 
       gzk time could be longer than the other killer times in specific
       rotation angles due to different target amplitudes for the killers. 
    */

    if (((exist(opcgate) == PSD_ON) && (exist(optdel1) >= pitdel1)) ||
        (exist(opcgate) == PSD_OFF)) {
        /* case where pos_start has sattimes. */
        non_tetime = pos_start + t_exa +
            IMax(3, gzktime, pw_gy1r_tot,((exist(opnecho) == 1 ? pw_gxwd : pw_gxw2d) + gxktime)) + time_ssi + GRAD_UPDATE_TIME;
    } else {
        non_tetime = pos_start + t_exa + sp_sattime + cs_sattime +
            IMax(3, gzktime, pw_gy1r_tot,((exist(opnecho) == 1 ? pw_gxwd : pw_gxw2d) + gxktime)) + time_ssi + GRAD_UPDATE_TIME;
    }

    /* for a full echo t_rd1a = trd1a2 and t_rdb = t_rdb2.
       for a partial echo, the second echo is time reversed and
       t_rdb2 needs to be recalculated. */
    if (exist(opnecho) == 1)
    {
        non_tetime += t_rdb;
    }
    else
    {
        non_tetime += t_rdb2;  /* time reversed second echo TKF */
    }

    /* MRIge54446 - Added psd_grd_wait to prevent gradient over-ranges. */
    non_tetime += RUP_GRD(psd_grd_wait);

    tmin = te_time + non_tetime;

    /* MRIge61907 : changed the tmin value inorder to incorporate the time for
       Respiratory compensation */
%ifdef DFMONITOR
    if (exist(opexor)==PSD_ON || cmon_flag == PSD_ON) {
        exorcist_cveval();
        imgtodfm_tdelay = IMax(2,GRAD_UPDATE_TIME,exor_min_seq - tmin);
    }
    tmin += dfm_flag*(dfm_tseq + imgtodfm_tdelay);
%endif
  
    /* Imgtimutil calculates actual tr for 
       normal scans, available portion of R-R
       interval for imaging for cardiac scans.
       First parameter is only used if the scan
       is cardiac gated.  imgtimutil will only be
       used if not line gating.  */

    if(gating == TRIG_LINE)
    {
        fullcyc = (int)floor((double)(((exist(optr)+ TR_SLOP_GR)/ 1000000.0)
                                      / (1 / cflinfrq)));
        act_tr = RUP_GRD((int)ceilf(((fullcyc / cflinfrq) * 1000000 - TR_SLOP_GR)));

        /* MRIge32287 */
        act_tr = IMax(2,tmin,act_tr);
        advroundup(&act_tr);

        avail_image_time = RDN_GRD(act_tr);
        premid_rf90 = 0;
    }
    else
    {
        act_tr = exist(optr);
        /* FUS - To support Fat SAT in positive double echo */
        if( (PSD_ON == thermal_map) && (PSD_ON == fus_chemsat) ) {
            act_tr = IMax( 2, tmin, act_tr );
            advroundup( &act_tr );
        }
        avail_image_time = RDN_GRD(act_tr); 
        if (existcv(opcgate) && (opcgate == PSD_ON))
        {
            premid_rf90 = optdel1 - psd_card_hdwr_delay  - td0; 
            if (imgtimutil(premid_rf90, seq_type, gating, 
                           &avail_image_time)==FAILURE)
            {
                epic_error( use_ermes, "%s failed.", EM_PSD_ROUTINE_FAILURE, EE_ARGS(1), STRING_ARG, "imgtimutil" );
                return FAILURE;
            }
            else
            {
                act_tr = avail_image_time;
            }
        } /* cardiac gated */
        else
        {
            premid_rf90 = 0;  /* initial for non gating cases */
        }
    }

    if (existcv(opcgate) && (opcgate == PSD_ON))
    {
        /* act_tr is used in powermon routines */
        act_tr = RUP_GRD((int)((float)(exist(ophrep))
                               * (60.0/exist(ophrate))* 1e6));
    }

    if (((isOddNexGreaterThanOne == PSD_ON) || (isNonIntNexGreaterThanOne == PSD_ON)
         || (nex < 2)) && cine_flag)
        choplet = PSD_ON; 
    else 
        choplet = PSD_OFF;

    rhptsize = opptsize;
    rhfrsize = xres; /* MRIge32416 - VB */

    /*MRIge32968 - VB*/
    if ((cine_flag == PSD_ON)&&(existcv(opslquant)))
    {
        if (existcv(opslquant) && existcv(opclocs) && 
            exist(opslquant) < exist(opclocs))
        {
            epic_error( use_ermes, "The number of locations/acquisition cannot exceed the number of scan locations.", EM_PSD_LOC_PER_ACQS_EXCEEDED, EE_ARGS(0) );
            return FAILURE;
        }
        clocs = exist(opclocs);
        acqs =  exist(opslquant) / clocs + 
            ((exist(opslquant) % clocs > 0) ? 1 : 0);
        if (existcv(opileave) && (exist(opileave) == PSD_ON))
        {
            acqs = IMax(2, 2, acqs);
        }
        if( SUCCESS != slicein1(&slquant1, acqs, seq_type) )
        {
            epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "slicein1" );
            slquant_per_trig =1; /* just try to get out of eval to catch
                                    the problem in cvcheck */
            return FAILURE;
        }
        if( exist(opclocs) != slquant1 )
        {
            cvoverride( opclocs, slquant1, _opclocs.fixedflag, _opclocs.existflag );
        }
    }

    if (cine_flag == PSD_ON)
    {
        slice_size = exist(opclocs)*(1+(rhbline*rawdata)+rhnframes+rhhnover)*2*
            rhptsize*exist(opcphases)*
            ((1-rawdata)+((int) ((float)rawdata * truenex)))
            *exist(opnecho)*rhfrsize;

    }
    else
    {
        if (rawdata)
            slice_size = (1+baseline+rhnframes+rhhnover)*
                (int)((float)(2*rhptsize*rhfrsize*exist(opnecho))*truenex);
        else 
            slice_size = (1+rhnframes+rhhnover)*2*rhptsize*rhfrsize
                *exist(opnecho);
    }

%ifdef DFMONITOR  
    if(dfm_flag == PSD_ON) {
        slice_size *= opnex;
    }
%endif

    /* FOR ZIP512 - reuse existing code */
    rhdayres = rhnframes + rhhnover + 1;  

    setResRhCVs();

    if(cine_flag == PSD_ON)
    {
        rhcphases = opcphases;
        /*have to convert this from uSec to Sec */
        rhctr = (float)optr/1000000.0;
        rhcrrtime = 60.0/(float)opchrate;  /* also in Sec */
        /* convert from seconds to microseconds, but only be
           precise to tenths of a millisecond to avoid persistent
           advisory messages -- MRIhc01066 */
        avmaxtr = 100 * (int)((rhcrrtime / slquant1) * 10000);
    }
    else
    {
        rhcphases = 1;
        rhctr = 1;
        rhcrrtime = 1;
    }

    if (maxslquanttps(&max_bamslice, rhimsize, slice_size, 1, NULL) == FAILURE)
    {
        epic_error( use_ermes, "Not enough memory for a scan this size.  Reduce the scan size.", EM_PSD_SCAN_SIZE, EE_ARGS(0) );
        return FAILURE;
    }

    if (maxyres(&avmaxyres, loggrd.ty_xyz, loggrd.yrt, avail_pwgy1, 
                nop*exist(opfov),
                &grady[GY1_SLOT],PHASESTEP32) == FAILURE) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "maxyres" );
        return FAILURE;
    }

%ifdef DFMONITOR
    opdfm = (exist(optr) && (optr >= dfm_tr_threshold) ? PSD_ON : PSD_OFF);
%endif

@inline Prescan.e PScveval
   
    int num_overscans = 0;
    num_overscans = (int)(rhnframes - rhnframes / (2.0 * fn)) + rhhnover;
    if ((status = avepepowscale(&ave_grady_gy1_scale, phaseres, num_overscans)) != SUCCESS)
    {
        return status;
    }

    grady[GY1_SLOT].scale = ave_grady_gy1_scale;
    grady[GY1R_SLOT].scale = ave_grady_gy1_scale;

    /* set .powscale for each pulse. */
    if ( opphysplane != PSD_OBL)
    {
        gradx[GXFC_SLOT].powscale = 1.0;
        gradx[GX1_SLOT].powscale = 1.0;
        gradx[GXW_SLOT].powscale = 1.0;
        gradx[GXFC2_SLOT].powscale = 1.0;
        gradx[GXFC3_SLOT].powscale = 1.0;
        gradx[GXK_SLOT].powscale = 1.0;
        gradx[GXW2_SLOT].powscale = 1.0;
        /* MRIge74590 */
        gradx[GXKMT_SLOT].powscale = 1.0;

        grady[GY1_SLOT].powscale = 1.0;
        grady[GY1R_SLOT].powscale = 1.0;
        /* AMR - FOR MT */
        grady[GYKMT_SLOT].powscale = 1.0;
        grady[GYKMT_CFH_SLOT].powscale = 1.0;

        gradz[GZRF1_SLOT].powscale = 1.0;
        gradz[GZ1_SLOT].powscale = 1.0;
        gradz[GZR_SLOT].powscale = 1.0;     /* FUS - binomial pulse */
        gradz[GZRF2_SLOT].powscale = 1.0;   /* FUS - binomial pulse */      
        gradz[GZFC_SLOT].powscale = 1.0;
        gradz[GZK_SLOT].powscale = 1.0;
        /* AMR - FOR MT */
        gradz[GZKMT_SLOT].powscale = 1.0;
    } 
    else 
    {
        gradx[GXFC_SLOT].powscale = loggrd.xfs/loggrd.tx_xyz;
        gradx[GX1_SLOT].powscale = loggrd.xfs/loggrd.tx_xyz;
        gradx[GXW_SLOT].powscale = loggrd.xfs/loggrd.tx;
        gradx[GXFC2_SLOT].powscale = loggrd.xfs/loggrd.tx;
        gradx[GXFC3_SLOT].powscale = loggrd.xfs/loggrd.tx;
        gradx[GXK_SLOT].powscale = loggrd.xfs/xkilltarget;
        gradx[GXW2_SLOT].powscale = loggrd.xfs/loggrd.tx;
        /* MRIge74590 */
        gradx[GXKMT_SLOT].powscale = loggrd.xfs/loggrd.tx_xyz;

        grady[GY1_SLOT].powscale = loggrd.yfs/loggrd.ty_xyz;
        grady[GY1R_SLOT].powscale = loggrd.yfs/loggrd.ty_xyz;
        /* AMR - FOR MT */
        grady[GYKMT_SLOT].powscale = loggrd.yfs/loggrd.ty_xyz;
        grady[GYKMT_CFH_SLOT].powscale = loggrd.yfs/loggrd.ty_xyz;

        gradz[GZRF1_SLOT].powscale = loggrd.zfs/loggrd.tz;
        gradz[GZ1_SLOT].powscale = loggrd.zfs/loggrd.tz_xyz;
        gradz[GZR_SLOT].powscale = loggrd.zfs/loggrd.tz_xyz;     /* FUS - binomial pulse */
        gradz[GZRF2_SLOT].powscale = loggrd.zfs/loggrd.tz_xyz;   /* FUS - binomial pulse */
        gradz[GZFC_SLOT].powscale = loggrd.zfs/loggrd.tz_xyz;
        gradz[GZK_SLOT].powscale = loggrd.zfs/zkilltarget;
        /* AMR - FOR MT */
        gradz[GZKMT_SLOT].powscale = loggrd.zfs/zkilltarget;
    }

    /* 2009-Mar-10, Lai, GEHmr01484: In-range autoTR support */
@inline AutoAdjustTR.e PulsegenonhostSwitch

    /* Perform gradient safety checks for main sequence */

    INT seq_entry_index = 0;  /* core sequence = 0 */

    if ( FAILURE == minseq( &min_seqgrad,
                            gradx, GX_FREE,
                            grady, GY_FREE,
                            gradz, GZ_FREE,
                            &loggrd, seq_entry_index, tsamp,
                            avail_image_time,
                            use_ermes, seg_debug ) ) 
    {
        epic_error( use_ermes, "%s failed.",
                    EM_PSD_ROUTINE_FAILURE, EE_ARGS(1), STRING_ARG, "minseq" );
        return FAILURE;
    }

    /* Under voltage prediction for SSSD */
    if(5550 == cfgradamp && vol_ratio_est_req < 1.0)
    {
        epic_error(use_ermes,
                   "Too much Gradient Power is required.",
                   EM_PSD_GRADPOWER_FOV_BW_PHASE, EE_ARGS(0));
        return FAILURE;
    }

    /* AMR - FOR MT */
    if ((exist(opmt) == PSD_ON) && existcv(opmt)) {
        rfpulse[RFMT_SLOT].num = mt_index;
        rfpulse[RFMT_CFH_SLOT].num = mt_index;
        rfpulse[RFMT_CFH_SLOT].act_fa = &flip_rfmt; 
    } else {
        rfpulse[RFMT_SLOT].num = 0;
        rfpulse[RFMT_CFH_SLOT].num = 0;
    }


    /* ************************************************
       RF Scaling
       Scale SAT Pulses to the relative B1 amplitudes.
       ********************************************** */
    /* Make sure the pulse attributes agree for CFH and PS1. */

    /* RF amp, SAR, and system limitations on seq time */
    if (minseqrfamp( &min_seqrfamp, (int)RF_FREE, rfpulse, L_SCAN ) 
        == FAILURE) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE,
                    EE_ARGS(1), STRING_ARG, "minseqrfamp" );
        return FAILURE;
    }

    if (mt_maxslicesar( &max_slicesar, (int)RF_FREE, rfpulse, L_SCAN )
        == FAILURE) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE,
                    EE_ARGS(1), STRING_ARG, "maxslicesar" );
        return FAILURE;
    }

    if(mt_maxseqsar( &max_seqsar, (int)RF_FREE, rfpulse, L_SCAN )
       == FAILURE)
    {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE,
                    EE_ARGS(1), STRING_ARG, "maxseqsar" );
        return FAILURE;
    }

    tmin_total = IMax(4, min_seqgrad, min_seqrfamp, tmin, max_seqsar);

    /* MRIge20592 - need to call exorcist_cveval after rhnframes is set in
       order to get proper exor_min_seq value */
    if(exist(opexor)==PSD_ON || cmon_flag == PSD_ON)
    {
        exorcist_cveval();
        tmin_total = IMax(2,tmin_total,exor_min_seq);
    }

    /* Used for cardiac intersequence time.  Round up to integer number of ms
     * but report to scan in us. */
    avmintseq = tmin_total;
    advroundup(&avmintseq);

    if ((exist(opcgate) == PSD_ON) && existcv(opcgate))
    {
        advroundup(&tmin_total); /* this is the min seq time cardiac can run at.
                                    Needed for adv. panel validity until all 
                                    cardiac buttons exist. */
        if (existcv(opcardseq))
        {
            switch (exist(opcardseq)) {
            case PSD_CARD_INTER_MIN:
                psd_tseq = avmintseq;
                tmin_total = avmintseq;
                break;
            case PSD_CARD_INTER_OTHER:
                psd_tseq = optseq;
                if (optseq > tmin_total)
                {
                    tmin_total = optseq;
                }
                break;
            case PSD_CARD_INTER_EVEN:
                /* Roundup tmin_total for the routines ahead. */
                advroundup(&tmin_total);
                break;
            }
        }
        else
        {
            psd_tseq = avmintseq;
        }
    }
    other_slice_limit = IMin(2, max_slicesar, max_bamslice);

    /* YMSmr09515: moved the compatibility check here in order to avoid maxpass() fail */
    if ((exist(opileave) == PSD_ON) && (exist(opcgate) == PSD_ON))
    {
        epic_error( use_ermes, "The interleave option and cardiac gating cannot be selected at the same time.", EM_PSD_ILEAV_CGAT_INCOMPATIBLE, EE_ARGS(0) );
        return FAILURE;
    }

    if (maxphases(&avmaxphases, tmin_total, seq_type,
                  other_slice_limit) == FAILURE) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "maxphases" );
        return FAILURE;
    }
    
    /* MRIhc51934 Restrict avmaxphases to be consistant where opcphases max value defined in epic.h */
    avmaxphases =  IMin( 2, avmaxphases, MAX_CINE_PHASES ) ;
 
    if (maxslquant(&avmaxslquant, avail_image_time, other_slice_limit,
                   seq_type, tmin_total) == FAILURE) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "maxslquant" );
        return FAILURE;
    }

    if (cine_flag == PSD_ON) {
        avmaxslquant = avmaxslquant > 4 ? 4 : avmaxslquant;
        if (existcv(opclocs)) {
            clocs = exist(opclocs);
        } else {
            clocs = avmaxslquant;
        }
    } else if (mpgr_flag == PSD_OFF) {
        avmaxslquant = 1; /* need to show a 1 on the adv panel
                             for grass */
    }

    /* Set maximum number of acquisitions.  Note that avmaxacqs is already
       set in the maxpass() function. */
    if( cine_flag == PSD_ON ) {
        acqs =  exist(opslquant) / clocs + ((exist(opslquant) % clocs > 0) ? 1 : 0);
        /*  Even though ileave is not supported in 4.0, leave in this hook. */
        if( existcv(opileave) && (exist(opileave) == PSD_ON) ) {
            acqs = IMax(2, 2, acqs);
        }
        avmaxacqs = acqs;
    } else if( PSD_ON == multiphase_flag ) {
        acqs = multi_phases * exist(opslquant);   /* LxMGD MPH */
        avmaxacqs = acqs;
    } else if( maxpass( &acqs, seq_type, (INT)exist(opslquant),
                        avmaxslquant ) == FAILURE ) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "maxpass" );
        return FAILURE;
    }

    if ((acqs > MAX_PASSES) && existcv(opslquant))
    {
        epic_error(use_ermes, "Maximum of %d acqs exceeded. Decrease number of slices.",
                   EM_PSD_MAX_ACQS, 1, INT_ARG, MAX_PASSES);
        return FAILURE;
    }

    if (slicein1(&slquant_per_trig, acqs, seq_type) == FAILURE)
    {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "slicein1" );
        slquant_per_trig =1; /* just try to get out of eval to catch
                                the problem in cvcheck */
        return FAILURE;
    }
    if (slquant_per_trig == 0)
    {
        epic_error( use_ermes, "slquant per trigger can not equal zero(0).", EM_PSD_SLQUANT_ZERO, EE_ARGS(0) );
        return FAILURE;
    }

    /* let's calculate slquant1 before we use it */

    if (seq_type == TYPXRR)
    {
        slquant1 = opslquant;
    }
    else
    {
        slquant1 = slquant_per_trig;
    }

    if ((slquant1 > MAX_SLICES_PER_PASS) && existcv(opslquant))
    {
        epic_error(use_ermes,
                   "The no. of locations/acquisitions cannot exceed the max no. of per acq = %d.",
                   EM_PSD_LOC_PER_ACQS_EXCEEDED_MAX_SL_PER_ACQ, 1, INT_ARG, MAX_SLICES_PER_PASS);
        return FAILURE;
    }

    /* 2009-Mar-10, Lai, GEHmr01484: In-range autoTR support */
    automintr_compatibility_checks();

    if(PSD_ON == cine_flag)
    {
        piautotrmode = PSD_AUTO_TR_MODE_MANUAL_TR;
    }

    if(automintr_set_display_acqs() == FAILURE)
    {
        return FAILURE;
    }

    /* Calculate inter-sequence delay time for 
       even spacing. */
    if ((exist(opcardseq) == PSD_CARD_INTER_EVEN) && existcv(opcardseq))
    {
        psd_tseq = piait/slquant_per_trig;
        advrounddown(&psd_tseq);
    }
    pitseq = avmintseq; /* Value scan displays in min inter-sequence display button */
    /* Set optseq to inter-seq delay value for adv. panel routines. */
    _optseq.fixedflag = 0;
    optseq = psd_tseq;
    /* Have existence of optseq follow opcardseq. */
    _optseq.existflag = _opcardseq.existflag;

    if (seqtime(&max_seqtime, avail_image_time, 
                cine_flag == PSD_ON ? 1 : slquant_per_trig, seq_type)
        == FAILURE)
    {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "seqtime" );
        return FAILURE;
    }

    if((exist(opnecho)>1) && existcv(opnecho))
    {
        min_seq2_echo2 = RUP_GRD(echo1_filt->tdaq)/2 + pw_gxwd + pw_gxw2/2 + pw_gxw2a +
            ((exist(opfcomp)== TYPFC) ? (pw_gxfc2a+pw_gxfc2+pw_gxfc2d+
                                         pw_gxfc3a+pw_gxfc3+pw_gxfc3d):0);
    }
    else
    {
        min_seq2_echo2 = 0;
    }

    if( (TYPVEMP == vemp_flag) && (existcv(opte2)) )
    {
        vemp_temp = TYPVEMP;
    }
    else
    {
        vemp_temp = TYPNVEMP;
    }


    maxte1(&avmaxte, max_seqtime, vemp_temp, non_tetime, min_seq2_echo2);

    if (avmaxte < avminte)
        avmaxte = avminte;

    if (maxte2(&avmaxte2, max_seqtime, non_tetime)
        == FAILURE)
    {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "maxte2" );
        return FAILURE;
    }

    /* MRIge32481 RJL - If max less than min then set max equal to min to stop misleading
       updates to interface. Just like for avmaxte above */
    if (avmaxte2 < avminte2)
        avmaxte2 = avminte2;

    if(mpgr_flag == PSD_ON)
    {
        temp_trig = gating;
    }
    else
    {
        temp_trig = TRIG_INTERN;
    }

    {
        LONG minimum_seq_time = tmin_total;

        if(temp_trig == TRIG_LINE)
        {
            /* mintr uses TR_SLOP which is 1 ms > TR_SLOP_GR, so.... */
            minimum_seq_time -=  1ms / slquant_per_trig;
        }
        if(PSD_ON == cine_flag)
        {
            int maxclocs = 1;
            maxclocs = IMin( 2, (avmaxtr / minimum_seq_time), 4 );
            cvmax(opclocs, maxclocs);
            minimum_seq_time *= exist(opclocs);

            if( existcv(opslquant) && existcv(opclocs)
                && (exist(opclocs) > _opclocs.maxval) )
            {
                epic_error( use_ermes, "The number of views per segment does not fit within the RR period. Reduce the views per segment parameter or reduce TR via other parameter modifications.", EM_PSD_NO_PHASES, EE_ARGS(0) );
                return FAILURE;
            }
        }

        if (mintr(&av_temp_int, seq_type,  minimum_seq_time,
                  0, temp_trig) == FAILURE)
        {
            epic_error(use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE,
                       EE_ARGS(1), STRING_ARG, "mintr");
            return FAILURE;
        }
    }

    /* You can't lower TR if SAR is limiting Factor */
    if (max_slicesar == slquant_per_trig && TRIG_LINE == gating)
    {
        avmintr = IMax(2, avmintr,(int)((int)((av_temp_int * cflinfrq)/1e6)*1e6/cflinfrq)); /* MRIhc21782 */
        advroundup(&avmintr); /* round up to ms */
    }

    if ((exist(opte2) != 2*exist(opte)) && (existcv(opnecho)) && 
        (exist(opnecho) == 2))
    {
        vemp_temp = TYPVEMP;
    }
    else
    {
        vemp_temp = TYPNVEMP;
    }


    if (maxnecho(&avmaxnecho, non_tetime, max_seqtime, vemp_temp)
        == FAILURE)
    {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "maxnecho" );
        return FAILURE;
    }

    if (exist(opirmode) == PSD_SEQMODE_ON)
        avmaxnecho = 1;
    else
        avmaxnecho = 2; /* maximum allowed is 2 */


    /* ****************************
       cine CVs
       ************************** */
    if (cine_flag == PSD_ON)
        cine_nframes = (int)(truenex*(rhnframes+rhhnover));


    /* keep the number of disdaqs even */
    /* MRIge62655/62650 dda must be set prior to exorcist_cveval() */
    dda = 4;
    if (cine_flag == PSD_ON || mpgr_flag == PSD_ON)
    {
        dda = IMax(2, 4, (( ((int) (3s/ IMax(2, act_tr, GRAD_UPDATE_TIME))) + 2)/2) * 2);
    }

    /* ****************************
       Exorcist CVs  
       ************************** */
    if (exorcist_cveval() == FAILURE) 
        return FAILURE;
    if (opexor == PSD_ON || cmon_flag == PSD_ON) 
        TR_PASS = 50ms + (exor_ngroups*10ms);

    /* ************************
       Scan Clock
       ********************** */
    SatCatRelaxtime(acqs,(act_tr/((cine_flag == PSD_ON) ? 1 : slquant1)),
                    seq_type);
    passtime = TR_PASS*acqs + (acqs-1)*TR_PASS*( ((opexor==PSD_ON) || (cmon_flag == PSD_ON))?1:0 );

    /*
     * LxMGD : Note that passtime is used in total scan time computation,
     * but not in pitslice. pitslice + tdel_bet_phases will be used in
     * annotation calculations
     */  
    if( PSD_ON == multiphase_flag ) {
        passtime += ((acqs - 1) * tdel_bet_phases); 
    } 

    /* FUS - Thermal fast sequence */
    if( PSD_ON == thermal_map ) {
        dda = 4;
    }

    if (cine_flag == PSD_ON) {
        use_tr = (float)((60.0/exist(opchrate))* 1e6);
        act_tr = exist(optr);

        nreps = acqs*(int) ((truenex + (float)dex)* ( (float)(rhnframes)));
        avmintscan = use_tr * (float)nreps 
            + (float)(((float)baseline + 
                       (float)acqs * (float)(dda + ccs_relaxers)) * (float)act_tr)
            + (float)(2 * passtime);
        /* Fix for SPR #13132. Used to be * acqs. */
        pietr = (act_tr) * slquant1;
    }
    else
    {
        if( (status = nexcalc()) != SUCCESS )
        {
            return status;
        }
        exorcist_cveval();

        if (exist(opcgate))
            use_tr = (float)act_tr;
        else
        {
            if (gating == TRIG_INTERN)
                use_tr = (float)act_tr;
            else
                use_tr = (float)act_tr + TR_SLOP_GR;
        }

        nreps = acqs*((dda + baseline) + exor_osdd_vus + rhoscans +
                      (int)((truenex + dex)*(rhnframes+rhhnover)));
        avmintscan = (float)((exist(opcgate) == PSD_ON) ?
                             act_tr:((gating == TRIG_INTERN) ? act_tr:
                                     (act_tr + TR_SLOP_GR))) * nreps + passtime 
            + ccs_relaxtime;

        pitslice = ((dda + baseline) + (nex + dex)*(rhnframes+rhhnover))
            *((gating == TRIG_INTERN)?act_tr:(act_tr+TR_SLOP_GR)) + TR_PASS;

        /* pitslice exceeds its own integer range and this results in a download failure.
           The fix is to make sure that max TR is less than the MAXINT. The code below
           is rounding calculation for line gating(worst case) only. - Vinod*/
        avmaxtr_tmp = (MAXINT-TR_PASS)/((dda + baseline) + (nex + dex)*(rhnframes+rhhnover));
        avmaxtr_tmp -= TR_SLOP_GR;
        fullcyc_tmp = (int)floor((double)((avmaxtr_tmp/ 1000000.0) / (1 / cflinfrq)));
        fullcyc_tmp = IMax(2, fullcyc_tmp,1); /* SK we do not allow 0 cycles */
        avmaxtr_tmp = (int)floorf((fullcyc_tmp / cflinfrq) * 1000000);

        avmaxtr_tmp = RDN_GRD(avmaxtr_tmp);
        avmaxtr = IMin(2,avmaxtr_tmp,TR_MAX);
    }

%ifdef DFMONITOR
    if (DFMonitor_CVeval1(slquant1, opnecho, 
                          rhnframes + rhhnover + exor_osdd_vus + rhoscans, 
                          nex, opnecho) == FAILURE){
        return FAILURE;
    }
    avmintscan += dfm_flag * (acqs * dfm_tseqwrite);
%endif

    pitscan = avmintscan; /* This value shown in clock */

    /* selection of nex buttons with oddnex */
    if( cine_flag == PSD_OFF )
    {
        if( (exist(opexor) == PSD_ON) || (cmon_flag == PSD_ON) ) /* no 3 nex button*/
        {
            pinexval2 = 0.75;
            pinexval3 = 1;
            pinexval4 = 2;
            if (exist(opnpwfactor) > 1.0)
            {
                pinexnub = 1 + 2 + 4 + 8;
            }
            else
            {
                pinexnub = 1 + 2 + 4;
            }
            if( (exist(opautote) == PSD_OFF) && (tfe_extra > 0) )
            {
                pinexnub = pinexnub - 2; /* Don't show fract nex button */
            }
        }
        else
        {
            pinexnub = 1 + 2 + 4 + 8 + 16 + 32;
            if( (exist(opte) < min_tenfe) && (exist(opautote) != PSD_MINTE) )
            {
                pinexnub = pinexnub - 2; /* Don't show fract nex button */
            }
            pinexval2 = 0.75;
            pinexval3 = 1;
            pinexval4 = 2;
            pinexval5 = 3;
            pinexval6 = 4;
            if( cmon_flag == PSD_ON )
            {
                pinexnub = 1 + 2 + 4 + 8 + 16; /* don't show NEX = 4 */
            }
        }
    } /* end not cine */
    else
    {
        pinexnub = 1 + 4 + 8 + 16 + 32;
        pinexval3 = 1;
        pinexval4 = 2;
        pinexval5 = 3;
        pinexval6 = 4;
        if( (exist(opexor) == PSD_ON) || (cmon_flag == PSD_ON) )
        {
            if (exist(opnpwfactor) > 1.0)
            {
                pinexnub = 1 + 4 + 8;
            }
            else
            {
                pinexnub = 1 + 4;
            }
        }
    }

    /* if not sequential don't display */

    if ((cine_flag == PSD_ON)||((mpgr_flag == PSD_ON)&&(pause_mpgr == PSD_OFF)))
        pipaunub = 0;
    else if (acqs > 5) 
        pipaunub = 6;
    else if (acqs > 3)
        pipaunub = 5;
    else if (acqs > 2)
        pipaunub = 4;
    else if (acqs > 1)
        pipaunub = 3;
    else
        pipaunub = 0;

    pipauval2 = 0;
    pipauval3 = 1;
    pipauval4 = 2;
    pipauval5 = 3;
    pipauval6 = 5;

    return SUCCESS;

}   /* end cveval1() */

/* 2009-Mar-10, Lai, GEHmr01484: In-range autoTR support */
@inline AutoAdjustTR.e AutoAdjustTREval1

/* 
 * CalcPulse Params() function is added for pulsegen-on-host feature
 */

STATUS calcPulseParams( int encode_mode ) 
{

    /* include insert code */
#include "predownload.in"

    if(MAXIMUM_POWER == encode_mode)
    {
        grady[GY1_SLOT].scale = 1.0;
        grady[GY1R_SLOT].scale = 1.0;
    }
    else
    {
        grady[GY1_SLOT].scale = ave_grady_gy1_scale;
        grady[GY1R_SLOT].scale = ave_grady_gy1_scale;
    }

    /**************************************
     *  Timing for SCAN entrypoint  (begin)
     */

    /* Calculate time from middle of last echo to when 
       spatial sat, chemsat or killer can begin */
    if( TYPVEMP == vemp_flag )
        post_echo_time = t_rdb2 + pw_gxw2d;
    else
        post_echo_time = t_rdb + pw_gxwd;

    /* Ordering of pulse is for non cardiac:
       spatial sat, chemsat, 90 180 readout, possible exorcist rewinder,
       and killer.
       For cardiac:
       90 180 readout, possible exorcist rewinder, spatial sat, chemsat, and 
       killer */

    sp_satcard_loc = 0;
    if (opcgate == PSD_ON) {
        /* Set some values for the scan clock */
        pidmode = PSD_CLOCK_CARDIAC; /* Display views  and clock */
        /* piclckcnt 
           piclckcnt is used is estimating the scan time remaining in
           a cardiac scan.  It is the number of cardiac triggers within
           an effective TR interval used by the PSD to initiate a 
           sequence after the initial  cardiac trigger 

           piviews
           piviews is used by the IPG in cardiac scans to display the
           number of heart beat triggers the PSD will use 
           to complete a scan 

           trigger_time
           Amount of time to leave for the cardiac trigger.
        */

        ctlend = IMax(2,(int)GRAD_UPDATE_TIME, RDN_GRD(psd_tseq - tmin - time_ssi));
        if (opphases  > 1) 
        {
            piviews = nreps; /* used by the IPG in cardiac scans to display the
                                number of heart beat triggers the PSD will use 
                                to complete a scan */
            piclckcnt = 0;
            trigger_time =  RDN_GRD((int)(.01 * oparr 
                                          * (60.0/ophrate)*1e6 * ophrep));
            ctlend_last = RDN_GRD(act_tr - trigger_time - td0 -
                                  (opphases -1)*psd_tseq - tmin - time_ssi);
            ctlend_fill = 0;
            ctlend_unfill = 0;
        } 
        else 
        {
            ctlend_fill = RDN_GRD(piait - (((int)(opslquant/ophrep) +
                                            (opslquant%ophrep ? 1:0) -1) * psd_tseq)
                                  - tmin - time_ssi);
            ctlend_unfill = RDN_GRD(ctlend_fill + (opslquant%ophrep ? psd_tseq:0));
            /* Cross R-R */
            if (opslquant >= ophrep) 
            {
                piclckcnt = ophrep - 1;
                piviews = nreps * ophrep;
                trigger_time = RDN_GRD((int)(.01 * oparr * (60.0/ophrate)*1e6));
                ctlend_last = ctlend_unfill;
            } 
            else 
            {
                piclckcnt = opslquant - 1;
                piviews = nreps * opslquant;
                trigger_time =  RDN_GRD((int)(.01 * oparr * (60.0/ophrate)*1e6 *
                    (ophrep + 1 - opslquant)));
                ctlend_last = RDN_GRD(ctlend_fill + (ophrep - opslquant)*
                                      ((1 -.01*oparr)* (60.0/ophrate)*1e6));
            }
        }

        if (ctlend_last<0) ctlend_last = 0; /* 21873 */

        ps2_dda = IMax(2,2,(int)(((int)(2.0s/IMax(2, act_tr, GRAD_UPDATE_TIME)) + 1)/2)*2);
        if (optdel1 < pitdel1) {
            sp_satstart = pos_start + t_exa + te_time + 
                post_echo_time + gzktime;
            cs_satstart = sp_satstart + sp_sattime - rfupa + CHEM_SSP_FREQ_TIME;
            pos_killer = RUP_GRD(pos_start + t_exa + te_time +
                                 post_echo_time);
            post_echo_time += sp_sattime + cs_sattime;
            sp_satcard_loc = 1;
        } else {
            sp_satstart = tlead + GRAD_UPDATE_TIME;
            cs_satstart = sp_satstart + sp_sattime - rfupa + CHEM_SSP_FREQ_TIME;
            sp_satcard_loc = 0;
            pos_killer = RUP_GRD(pos_start + t_exa + te_time +
                                 post_echo_time);
        }
    }
    else
    {
        /* Display scan clock in seconds unless pause*/
        if (exist(opslicecnt)==0 || cine_flag == PSD_ON)
            pidmode = PSD_CLOCK_NORM;
        else
            pidmode = PSD_CLOCK_PAUSE;
        ps2_dda = IMax(2,2,(int)(((int)(2.0s/IMax(2, act_tr, GRAD_UPDATE_TIME)) + 1)/2)*2);

        /* AMR - FOR MT */
        if ( existcv(opmt) && (exist(opmt) == PSD_ON) ) {
            mt_start = RUP_GRD(GRAD_UPDATE_TIME + tlead - rfupa + MT_SSP_FREQ_TIME);/*RDP 07-26-00*/
            sp_satstart = mt_start + mt_time + 4us;                                 /*RDP 07-26-00*/
        } else {
            ps2_dda = IMax(2,2,(int)(((int)(2.0s/IMax(2, exist(optr), GRAD_UPDATE_TIME)) + 1)/2)*2);
            sp_satstart = GRAD_UPDATE_TIME + tlead;
        }
        cs_satstart = sp_satstart + sp_sattime - rfupa + CHEM_SSP_FREQ_TIME;

        /* AMR - END OF MT SPECIFIC CHANGES */

        pos_killer = RUP_GRD(pos_start + t_exa + te_time + post_echo_time);

        ctlend_fill = 0;
        ctlend_unfill = 0;
        ctlend_last = 0;
    }

    /* MRIge89906 - Gradient rollover since the first MT pulse was played out with the matrix corresponding
       to the SAT pulse. See spr for details */
    
    sp_satcard_loc = exist(opmt) ? 1 : sp_satcard_loc;

    pos_moment_start = pos_start + t_exa;
    cs_satstart = RUP_GRD(cs_satstart);
    sp_satstart = RUP_GRD(sp_satstart);

    /*
     *  Timing for SCAN entrypoint  (end)
     ************************************/


    /*
     * Initialization of td0 for pulsegen-on-host 
     *
     * Initialize the waits for the cardiac instruction.
     * Pulse widths of wait will be set to td0 for first slice
     * of an R-R in RSP.  All other slices will be set to
     * the GRAD_UPDATE_TIME. 
     */
    pw_x_td0 = GRAD_UPDATE_TIME;
    pw_y_td0 = GRAD_UPDATE_TIME;
    pw_z_td0 = GRAD_UPDATE_TIME;
    pw_rho_td0 = GRAD_UPDATE_TIME;
    pw_ssp_td0 = GRAD_UPDATE_TIME;
    pw_theta_td0 = GRAD_UPDATE_TIME;

    SpSatIAmp();

    if (opmt == PSD_ON)
    {
        ia_rfmt = (int)(max_pg_iamp*(*rfpulse[RFMT_SLOT].amp));
    }

    if (cs_sat == PSD_ON)
    {
        ia_rfcssat = (int)(max_pg_iamp*(*rfpulse[RFCSSAT_SLOT].amp));
    }

    /* 
     * Added for pulsegen-on-host feature 
     * Scale the phase encode according to the average power over time
      -- use scaled endview instruction amplitude for gradient heating
       (scale set by avepepowscale). copysign is math.h function for
       preserving the sign bit. */
/* MRIhc15606 */
    ia_gy1  = (int)(sqrt(grady[GY1_SLOT].scale) * endview_iamp);
    ia_gy1r = (int)(sqrt(grady[GY1R_SLOT].scale) * endview_iamp);

    return SUCCESS;

}    /* end calcPulseParams() */


STATUS
nexcalc( void )
{
    setResRhCVs();
    rhhnover = 0; /* init */

    if ( (status = setnexctrl(&nex, &fn, &truenex, &isOddNexGreaterThanOne, &isNonIntNexGreaterThanOne)) != SUCCESS )
    {
        return status;
    }

    if( ((exist(opnex) < 1.0) && (existcv(opnex))) && !floatsAlmostEqualEpsilons(exist(opnex), 0.75, 2) )
    {
        epic_error(use_ermes," Improper NEX selected ",EM_PSD_NEX_OUT_OF_RANGE,0);
        return FAILURE;
    }

    if ( floatsAlmostEqualEpsilons(fn, 0.5, 2) )
    {
        rhhnover = (int)(PSD_HNOVER * nop);
        rhhnover = rhhnover + rhhnover % 2;
    }

    baseline = 0;  /* No baselines for CINE or 2dfast */

    return  SUCCESS;
}   /* end nexcalc() */

void
getAPxParam(optval   *min,
            optval   *max,
            optdelta *delta,
            optfix   *fix,
            float    coverage,
            int      algorithm)
{
    /* Need to be filled when APx is supported in this PSD */
}

int getAPxAlgorithm(optparam *optflag, int *algorithm)
{
    return APX_CORE_NONE;
}

@inline loadrheader.e setResRhCVs

/* *************************************************************
 * CVCHECK *
 * This section will be executed every time a 'next page' is 
 * chosen.  This is to assure that the current prescribed 
 * protocol is legal.  If it is not, an error message will be  
 * returned to the psd manager.  For now, these messages
 * will be strings.  But later the messages will be given
 * by an ermes number.
 * ********************************************************* */
STATUS
cvcheck( void )
{
    int cardcv;                   /* on if cardiac selected */
    int temp_int;
    float phasesPerLoc;

@inline ZoomGradLimit.e ZoomGradParam
@inline MK_GradSpec.e GspecCheck

    if (existcv(opnecho) && (exist(opnecho) > 2)) {
        epic_error( use_ermes, "Only two echo multi-echo is currently supported.", EM_PSD_NECHO_OUT_OF_RANGE2, EE_ARGS(0) );
        return FAILURE;
    }                    /* restrict to only two echoes at the moment TKF */

    /* 4/21/96 RJL - Error checks split to support Advisory Panel Popup */

    if (floatsAlmostEqualEpsilons(exist(opnex), 0.0, 2) && existcv(opnex)) 
    {   /* guard against zero nex */
        epic_error( use_ermes, "Improper NEX selected",
                    EM_PSD_NEX_OUT_OF_RANGE, 0 );
        return FAILURE;
    }

    if (exist(opyres) > avmaxyres) 
    {
        epic_error( use_ermes, "The phase encoding steps must be decreased to %d for the current prescription.", EM_PSD_YRES_OUT_OF_RANGE, EE_ARGS(1), INT_ARG, avmaxyres );
        return ADVISORY_FAILURE;
    }

    if (existcv(opyres) && existcv(opxres) &&
        (exist(opyres) > exist(opxres)) )
    {
        epic_error( use_ermes, "The phase encoding steps must be decreased to %d for the current prescription.", EM_PSD_YRES_OUT_OF_RANGE, EE_ARGS(1), INT_ARG, opxres );
        /* 4/21/96 RJL - Event handler for this error to get choice into popup */
        avmaxyres = exist(opxres);
        return ADVISORY_FAILURE;
    }

    /* AMR - FOR FLEX XRES */
    if (exist(opxres)%4 != 0) {
        epic_error( use_ermes, "The nearest valid frequency encoding value is %d.", EM_PSD_XRES_ROUNDING, EE_ARGS(1), INT_ARG, 4*(int)((float)opxres/4.0 + 0.50) );
        return ADVISORY_FAILURE;
    }

    /* AMR - FOR FLEX XRES -  valid XRES range check */
    if (((exist(opxres) > 512) || (exist(opxres) < 128)) && (cffield != B0_70000)){
        epic_error( use_ermes, "The frequency encodings must be between 128 and 512.", EM_PSD_XRES_INVALID_RANGE, EE_ARGS(0) );
        return ADVISORY_FAILURE;
    }

    /* valid XRES range check for 7T */
    if ( ((exist(opxres) > 1024) || (exist(opxres) < 64)) && (cffield == B0_70000) )
    {
        epic_error( use_ermes, "The frequency encodings must be between %d and %d.", EM_PSD_XRES_INVALID_RANGE1, EE_ARGS(2),
                    INT_ARG, 64, INT_ARG, 1024);
        return ADVISORY_FAILURE;
    }

    if ((exist(opzip512) == PSD_ON) && ((existcv(opxres) && exist(opxres) > 512) || (existcv(opyres) && exist(opyres) > 512)))
    {
        epic_error(use_ermes,"%s is incompatible with %s",EM_PSD_INCOMPATIBLE,
                EE_ARGS(2),STRING_ARG,"512 ZIP",STRING_ARG,"larger than 512 Resolution");
        return FAILURE;
    }

    /* MRIge56926 - Removed calculation for avminslthick from within error condition - TAA */
    if (a_gzrf1 > loggrd.tz)
    {
        epic_error( use_ermes, "The Slice thickness must be increased to %.2f mm for the current prescription.", EM_PSD_SLTHICK_OUT_OF_RANGE, EE_ARGS(1), FLOAT_ARG, avminslthick );
        return ADVISORY_FAILURE;
    }


    if ((exist(opslquant) < avminslquant) && existcv(opslquant)) 
    {
        epic_error( use_ermes, "The number of scan locations selected must be increased to %d for the current prescription.", EM_PSD_SLQUANT_OUT_OF_RANGE2, EE_ARGS(1), INT_ARG, avminslquant );
        return ADVISORY_FAILURE;
    }

    if ((exist(opflip) < 1.0) || (exist(opflip)>180.0)) 
    {
        epic_error( use_ermes, "The flip angle is out of range.", EM_PSD_OPFLIP_OUT_OF_RANGE, EE_ARGS(0) );
        return ADVISORY_FAILURE;
    }

    if((mpgr_flag == PSD_ON)&&(pause_mpgr == PSD_ON))
    {
        if ((exist(opslicecnt) > (acqs-1)) && existcv(opslicecnt))
        {
            epic_error( use_ermes, "The number of locations Before Pause cannot exceed %d for the current prescription.", EM_PSD_LOC_B4_EXCEEDED, EE_ARGS(1), INT_ARG, acqs-1 );
            /* 4/21/96 RJL - Set values to be placed into Popup List as event handler */
            avminslicecnt = acqs - 1;
            avmaxslicecnt = acqs - 1;
            return ADVISORY_FAILURE;
        }
    }
    else
    {
        /*
         * LxMGD : Multi-Phase is available if multiphase_flag is ON.
         * Locs before reps is compatible in this case.
         */
        if( PSD_OFF == multiphase_flag ) {
            if ((exist(opslicecnt) > (exist(opslquant)-1)) && existcv(opslicecnt)) {
                epic_error( use_ermes, "The number of locations Before Pause cannot exceed %d for the current prescription.", EM_PSD_LOC_B4_EXCEEDED, EE_ARGS(1), INT_ARG, exist(opslquant)-1 );
                /* 4/21/96 RJL - Set values to be placed into Popup List as event handler */
                avminslicecnt = exist(opslquant) - 1;
                avmaxslicecnt = exist(opslquant) - 1;
                return ADVISORY_FAILURE;
            }
        }
    }

    cardcv = exist(opcgate) && existcv(ophrate) && existcv(ophrep) 
        && existcv(opphases) && existcv(optseq) && existcv(optdel1)
        && existcv(oparr);

    /* MRIge65081 */
    if (exist(opcgate))
        if ((exist(opslquant) > avmaxslquant) && existcv(opslquant)) 
        {
            epic_error( use_ermes, "The number of scan locations selected must be reduced to %d for the current prescription.", EM_PSD_SLQUANT_OUT_OF_RANGE, EE_ARGS(1), INT_ARG, avmaxslquant );
            return ADVISORY_FAILURE;
        }

    if ((exist(opfov) < avminfov) && existcv(opfov)) 
    {
        epic_error( use_ermes, "The FOV needs to be increased to %3.1f cm for the current prescription, or receive bandwidth can be decreased.", EM_PSD_FOV_OUT_OF_RANGE, EE_ARGS(1), FLOAT_ARG, avminfov/10.0 );
        return ADVISORY_FAILURE;
    }

    /* check only for WHOLE grad_mode in Gemini configuration */ 
    if ( (existcv(opgradmode) && (exist(opgradmode) == 1) && strcmp("2dfast_service",get_psd_name())) || existcv(opgradmode)==0 ) {
        if ((exist(opfov) > avmaxfov) && existcv(opfov)) 
        {
            epic_error( use_ermes, "The FOV needs to be decreased to %3.1f cm for the current prescription.", EM_PSD_FOV_OUT_OF_RANGE2, EE_ARGS(1), FLOAT_ARG, avmaxfov/10.0 );
            return ADVISORY_FAILURE;
        }
    }

    if ((spgr_flag == PSD_ON) && (exist(opirmode) == PSD_SEQMODE_OFF)) 
    {
        epic_error( use_ermes, "Sequential must be chosen with SPGR.", EM_PSD_SPGR_SEQ, EE_ARGS(0) );
        return FAILURE;
    }

    if (exist(opcgate)==PSD_OFF) 
    {
        if ((exist(optr) < avmintr) && existcv(optr)) 
        {
            epic_error( use_ermes, "The TR needs to be increased to %d ms for the current prescription.", EM_PSD_TR_OUT_OF_RANGE, EE_ARGS(1), INT_ARG, avmintr/1ms );
            return ADVISORY_FAILURE;
        }

        if ((exist(optr) > avmaxtr) && existcv(optr)) 
        {
            epic_error( use_ermes, "The TR needs to be decreased to %d for the current prescription.", EM_PSD_TR_OUT_OF_RANGE2, EE_ARGS(1), INT_ARG, avmaxtr/1ms );
            return ADVISORY_FAILURE;
        }
    } else {
        if (cine_flag == PSD_ON) 
        {
            epic_error( use_ermes, "Cine and Cardiac Gating are incompatible options.", EM_PSD_CINEGATE_INCOMPATIBLE, EE_ARGS(0) );
            return FAILURE;
        }

        if (mpgr_flag == PSD_OFF)
        {
            epic_error( use_ermes, "Cardiac Gating is not supported by this pulse sequence.", EM_PSD_GATING_INCOMPATIBLE, EE_ARGS(0) );
            return FAILURE;
        }

        if ((piait < avmintseq) && (existcv(optdel1))) 
        {
            epic_error( use_ermes, "The available imaging time is insufficient. Decrease the trigger window or the trigger delay.", EM_PSD_AIT_OUT_OF_RANGE, EE_ARGS(0) );
            return FAILURE;
        }

        if ((existcv(optdel1))&& ((exist(optdel1) < avmintdel1)
                                  || (exist(optdel1) > 1.6s)))
        {
            epic_error( use_ermes, "The trigger delay must be between %d ms and 1600 ms for the current prescription.", EM_PSD_TD_OUT_OF_RANGE, EE_ARGS(1), INT_ARG, (avmintdel1/1ms) );
            return FAILURE;
        }
    }

    if (!floatsAlmostEqualEpsilons(fn,1,2) && cine_flag == PSD_ON && existcv(opnex))
    {
        epic_error( use_ermes, "%s is not provided with CINE.", EM_PSD_CINE_ERMES, EE_ARGS(1), STRING_ARG, "Fractional Nex" );
        /* 4/21/96 RJL - Set values to be placed into Popup List as event handler */
        avminnex = 1.0;
        avmaxnex = 1.0;
        return ADVISORY_FAILURE;
    }

    if (floatsAlmostEqualEpsilons(fn,0.5,2) && (exist(opte)< min_tenfe) && existcv(opnex))
    {
        temp_int = min_tenfe;
        advroundup(&temp_int);
        epic_error( use_ermes, "The selected TE must be increased to %d ms for .5 nex or 1 nex/NPW.", EM_PSD_TE_OUT_OF_RANGE1, EE_ARGS(1), INT_ARG, (avminte/1ms) );
        /* 4/21/96 RJL - Set values to be placed into Popup List as event handler */
        avminte = temp_int;
        return ADVISORY_FAILURE;
    }

    if (floatsAlmostEqualEpsilons(fn,0.75,2) && (exist(opte)< min_tenfe) && existcv(opnex))
    {
        temp_int = min_tenfe;
        advroundup(&temp_int);
        epic_error( use_ermes, "The selected TE must be increased to %d ms for .75 nex or 1.5 nex/NPW.", EM_PSD_TE_OUT_OF_RANGE2, EE_ARGS(1), INT_ARG, (avminte/1ms) );
        /* 4/21/96 RJL - Set values to be placed into Popup List as event handler */
        avminte = temp_int;
        return ADVISORY_FAILURE;
    }

    if ((exist(opte2) <  avminte2) && existcv(opte2) && (TYPVEMP == vemp_flag))
    {
        epic_error( use_ermes, "The selected TE2 must be increased to %d ms for the current prescription.", EM_PSD_TE2_OUT_OF_RANGE, EE_ARGS(1), INT_ARG, (avminte2/1ms) );
        avminte2 = avminte2;
        return ADVISORY_FAILURE;
    }

    if ((exist(opte2) > avmaxte2) && existcv(opte2) && (TYPVEMP == vemp_flag))
    {
        epic_error( use_ermes, "The selected TE2 must be decreased to %d ms for the current prescription.", EM_PSD_TE2_OUT_OF_RANGE1, EE_ARGS(1), INT_ARG, (avmaxte2/1ms) );
        avmaxte2 = avmaxte2;
        return ADVISORY_FAILURE;
    }

    if ((exist(opte) < avminte) && existcv(opte))
    {
        epic_error( use_ermes, "The selected TE must be increased to %3.1f ms for the current prescription.", EM_PSD_FLOAT_MINTE_OUT_OF_RANGE, EE_ARGS(1), FLOAT_ARG, (avminte/1ms) );
        avminte = avminte;
        return ADVISORY_FAILURE;
    }

    if ((exist(opte) > avmaxte) && existcv(opte))
    {
        epic_error( use_ermes, "The selected TE must be decreased to %3.1f ms for the current prescription.", EM_PSD_FLOAT_MAXTE_OUT_OF_RANGE, EE_ARGS(1), FLOAT_ARG, (avmaxte/1ms) );
        avmaxte = avmaxte;
        return ADVISORY_FAILURE;
    }

    if (existcv(oprbw) && (exist(oprbw) < avminrbw))
    {
        epic_error( use_ermes, "With the current Scan Timimg prescription, the minimum first echo bandwidth is %4.2f KHz.", EM_PSD_MIN_RBW1, EE_ARGS(1), FLOAT_ARG, avminrbw );
        return ADVISORY_FAILURE;
    }

    if (existcv(oprbw) && (exist(oprbw) > avmaxrbw))
    {
        epic_error( use_ermes, "With the current Scan Timimg prescription, the maximum first echo bandwidth is %4.2f KHz.", EM_PSD_MAX_RBW1, EE_ARGS(1), FLOAT_ARG, avmaxrbw );
        return ADVISORY_FAILURE;
    }

    if ((exist(opnecho) > 1) && existcv(oprbw2) && (exist(oprbw2) < avminrbw2))
    {
        epic_error( use_ermes, "With the current Scan Timimg prescription, the minimum bandwidth for echoes 2-4 is %4.2f KHz.", EM_PSD_MIN_RBW2, EE_ARGS(1), FLOAT_ARG, avminrbw2 );
        return ADVISORY_FAILURE;
    }


    if ((exist(opnecho) > 1) && existcv(oprbw2) && (exist(oprbw2) > avmaxrbw2))
    {
        epic_error( use_ermes, "With the current Scan Timimg prescription, the maximum bandwidth for echoes 2-4 is %4.2f KHz.", EM_PSD_MAX_RBW2, EE_ARGS(1), FLOAT_ARG, avmaxrbw2 );
        return ADVISORY_FAILURE;
    }

    if ((exist(opnecho) > avmaxnecho) && existcv(opnecho))
    {
        epic_error( use_ermes, "The selected number of echoes must be decreased to %d for the current prescription.", EM_PSD_NECHO_OUT_OF_RANGE, EE_ARGS(1), INT_ARG, avmaxnecho );
        avmaxnecho = avmaxnecho;   /* latha@mr - set values to be placed in the popup list */
        return ADVISORY_FAILURE;
    }

    /* check for Exorcist and odd/even nex NPW. MHN */
    if ( (opexor == PSD_ON) && ( (isOddNexGreaterThanOne) || (isNonIntNexGreaterThanOne) ) )
    {
        epic_error( use_ermes, "Odd NEX is not supported with Respiratory Compensation.", EM_PSD_ODDNEX_WITH_RESPCOMP_INCOMPATIBLE, EE_ARGS(0) );
        return FAILURE;
    }

    if (cardcv)
    {
        if (exist(opphases) > avmaxphases)
        {
            epic_error( use_ermes, "The number of phase encoding steps must be decreased to %d.", EM_PSD_PHASE_OUT_OF_RANGE, EE_ARGS(1), INT_ARG, avmaxphases );
            return FAILURE;
        }
        if ((psd_tseq < avmintseq) && (existcv(opfov)) && (existcv(opcardseq)))
        {
            epic_error( use_ermes, "The inter-sequence delay must be increased to %d ms due to the FOV/ slice thickness selected.", EM_PSD_TSEQ_FOV_OUT_OF_RANGE, EE_ARGS(1), INT_ARG, (avmintseq/1ms) );
            return FAILURE;
        }

        if ((psd_tseq < avmintseq) && (existcv(opcardseq)))
        {
            epic_error( use_ermes, "The inter-sequence delay must be increased to %d ms due to the FOV/ slice thickness selected.", EM_PSD_TSEQ_FOV_OUT_OF_RANGE, EE_ARGS(1), INT_ARG, (avmintseq/1ms) );
            return FAILURE;
        }
        if (seq_type == TYPMPMP)
        {
            phasesPerLoc = (float)opphases/(float)opslquant;
            if(!floatsAlmostEqualEpsilons(phasesPerLoc,1.0,2) && !floatsAlmostEqualEpsilons(phasesPerLoc,2.0,2) &&
               !floatsAlmostEqualEpsilons(phasesPerLoc,3.0,2) && (exist(opslquant) > 1))
            {
                epic_error( use_ermes, "The number of phases divided by locations must equal 1, 2, or 3.", EM_PSD_SLCPHA_INCOMPATIBLE, EE_ARGS(0) );
                return FAILURE;
            }

            if (exist(opphases)*exist(opslquant) > DATA_ACQ_MAX) {
                epic_error( use_ermes, "The number of locations * phases has exceeded %d.", EM_PSD_SLCPHA_OUT_OF_RANGE, EE_ARGS(1), INT_ARG, DATA_ACQ_MAX );
                return FAILURE;
            }
        }
    }
    if (cs_sat)
    {
        if (ChemSatCheck()  == FAILURE)
            return FAILURE;
    }

    if ((exist(oppseq) == PSD_IR) && existcv(oppseq))
    {
        epic_error( use_ermes, "This database does not support Inversion Recovery imaging.", EM_PSD_IR_INCOMPATIBLE, EE_ARGS(0) );
        return FAILURE;
    }

    if ((exist(oppseq) == PSD_SE) && existcv(oppseq))
    {
        epic_error( use_ermes, "Fast Scan is the only pulse sequence supported by this psd.", EM_PSD_FAST_INCOMPATIBLE, EE_ARGS(0) );
        return FAILURE;
    }

    if (((exist(opimode) == PSD_3D)) && existcv(opimode))
    {
        epic_error( use_ermes, "2D is the only image mode supported by this psd.", EM_PSD_IM_INCOMPATIBLE, EE_ARGS(0) );
        return FAILURE;
    }

    /* AMR - FOR MT */
    if ((opcgate == PSD_ON) && (opmt == PSD_ON)) {
        epic_error( use_ermes, "Cardiac Gating is incompatible with MT option.", EM_PSD_GATE_MT_INCOMPATIBLE, EE_ARGS(0) );
        return FAILURE;
    }

@inline FlexibleNPW.e fNPWcheck2

    if ((fn<1)&& (nex > 1) && existcv(opnex))
    {
        epic_error( use_ermes, "Fast Scan does not support multi-nex fractional nex scans.", EM_PSD_FAST_MNFE_INCOMPATIBLE, EE_ARGS(0) );
        return FAILURE;
    }

    if((exist(opblim) == PSD_ON) && existcv(opblim))
    {
        epic_error( use_ermes, "The Classic option is not supported in this scan.", EM_PSD_CLASSIC_INCOMPATIBLE, EE_ARGS(0) );
        return FAILURE;
    }

    if((exist(oppomp) == PSD_ON) && existcv(oppomp))
    {
        epic_error( use_ermes, "The POMP option is not supported in this scan.", EM_PSD_POMP_INCOMPATIBLE, EE_ARGS(0) );
        return FAILURE;
    }

    if(cine_flag == PSD_ON)
    {

        if (exist(opfast) == PSD_ON ) {
            epic_error( use_ermes, "The Fast Option is not available with this pulse sequence.", EM_PSD_OPFAST_INCOMPATIBLE, EE_ARGS(0) );
            return FAILURE;
        }

        if (exist(opfat) == PSD_ON && existcv(opfat))
        {
            epic_error( use_ermes, "%s is not provided with CINE.", EM_PSD_CINE_ERMES, EE_ARGS(1), STRING_ARG, "Fat Suppression" );
            return FAILURE;
        }

        if (exist(opwater) == PSD_ON && existcv(opwater))
        {
            epic_error( use_ermes, "%s is not provided with CINE.", EM_PSD_CINE_ERMES, EE_ARGS(1), STRING_ARG, "Water Suppression" );
            return FAILURE;
        }

        if (exist(opileave) == PSD_ON && existcv(opileave))
        {
            epic_error( use_ermes, "%s is not provided with CINE.", EM_PSD_CINE_ERMES, EE_ARGS(1), STRING_ARG, "Interleaved key");
            return FAILURE;
        }

        if(((acqs > 4) && existcv(opslquant)) && existcv(opclocs))
        {
            epic_error( use_ermes, "Maximum of %d acqs exceeded.  Increase locations/acq or decrease number of slices.", EM_PSD_MAX_ACQS, EE_ARGS(1), INT_ARG, 4 );
            return FAILURE;
        }

        /* MRIge43749 - CMC */
        if ((exist(opcphases) > avmaxphases) && existcv(opcphases))
        {
            epic_error( use_ermes, "The number of phases must be decreased to %d.", EM_PSD_NUM_PASS_OUT_OF_RANGE, EE_ARGS(1), INT_ARG, avmaxphases );
            return FAILURE;
        }

        if((slquant1*exist(opnecho)*exist(opcphases) > 64) &&
           existcv(opcphases))
        {
            epic_error( use_ermes, "Cannot exceed 64 images/pass, reduce locations/pass or phases to recon.", EM_PSD_IMAGES_PER_PASS, EE_ARGS(0) );
            return FAILURE;
        }

        if(exist(opnecho) > 1)
        {
            epic_error( use_ermes, "Only 1 echo is allowed in cine imaging.", EM_PSD_NECHO_OUT_OF_RANGE_CINE, EE_ARGS(0) );
            /* 4/21/96 RJL - Set values to be placed into Popup List as event handler */
            avminnecho = 1;
            avmaxnecho = 1;
            return ADVISORY_FAILURE;
        }  

        if (existcv(opslquant) && existcv(opclocs) && 
            exist(opslquant) < exist(opclocs))
        {
            epic_error( use_ermes, "The number of locations/acquisition cannot exceed the number of scan locations.", EM_PSD_LOC_PER_ACQS_EXCEEDED, EE_ARGS(0) );
            return FAILURE;
        }

        /*MRIge42909 - check if pietr is greater than 1 RR */
        /*MRIge44953 - Use rhcrrtime which is based on opchrate */
        if((existcv(optr) == PSD_ON) && (rhctr * slquant1)  > rhcrrtime) {
            epic_error( use_ermes, "The TR needs to be decreased to %d for the current prescription.", EM_PSD_TR_OUT_OF_RANGE2, EE_ARGS(1), INT_ARG, avmaxtr/1ms );
            return ADVISORY_FAILURE;
        }

    } /* end cine checks */

    if (SpSatCheck() == FAILURE) return FAILURE;


    if ( exist(oprtcgate) && existcv(oprtcgate) )
    {
        epic_error( use_ermes, "Respiratory triggering is not supported by this pulse sequence", EM_PSD_RESPTRIG_INCOMPATIBLE, EE_ARGS(0) );
        return FAILURE;
    }

    /* Fixes MRIge20264 - Graphic ROI not locked out in imaging PSDs */
    if ((exist(opgrxroi) == PSD_ON) && existcv(opgrxroi))
    {
        epic_error( use_ermes, "The Graphic ROI Option is not available with this pulse sequence.", EM_PSD_OPGRXROI_INCOMPATIBLE, EE_ARGS(0) );
        return FAILURE;
    }

    /****************************************************
      Compatibility Checks for Cardiac Compensation -- RJF 
    ******************************************************/

    if(exist(opcmon) == PSD_ON)
    {
        if ( existcv(oppseq) && exist(oppseq) != PSD_SPGR && exist(oppseq)!= PSD_GE)
        {
            epic_error( use_ermes, "The Graphic ROI Option is not available with this pulse sequence.", EM_PSD_CMON_SELECTION, EE_ARGS(0) );
            return FAILURE ; 
        }

        if (existcv(opimode) && exist(opimode) == PSD_CINE )
        {
            epic_error( use_ermes, "Cine is not compatible with Cardiac Compensation.", EM_PSD_CMON_CINE_INCOMPATIBLE, EE_ARGS(0) );
            return FAILURE;
        }

        /* check for Exorcist and odd/even nex NPW. MHN */
        if ((isOddNexGreaterThanOne) || (isNonIntNexGreaterThanOne))
        {
            epic_error( use_ermes, "Odd NEX is not supported with Cardiac Compensation.", EM_PSD_CMON_ODDNEX_INCOMPATIBLE, EE_ARGS(0) );
            return FAILURE;
        }

        /*  MRIge78873 - NEX should be less than 4 when CCOMP = 1 */
        if( existcv(opnex) && exist(opnex) > 3.0 ) {
            epic_error( use_ermes, "The selected number of excitations is "
                        "not valid for the current prescription.",
                        EM_PSD_NEX_OUT_OF_RANGE, EE_ARGS(0) );
            avminnex = 3.0;
            avmaxnex = 3.0;
            return ADVISORY_FAILURE;
        }

        /* check for exorcist and cmon compatiblity */
        if ( existcv(opexor) && exist(opexor) == PSD_ON )
        {
            epic_error( use_ermes, "Cardiac Compensation is not allowed with Respiratory Compensation.", EM_PSD_CMON_RC_INCOMPATIBLE, EE_ARGS(0) );
            return FAILURE;
        }

        /* check for cardiac gating and cmon compatiblity */
        if ( existcv(opcgate) && exist(opcgate) == PSD_ON )
        {
            epic_error( use_ermes, "Cardiac Gating is not allowed with Cardiac Compensation.", EM_PSD_CMON_GATING_INCOMPATIBLE, EE_ARGS(0) );
            return FAILURE;
        }
    }

    if( PSD_ON == multiphase_flag ) {
        if( existcv(opphases) && (exist(opphases) > 1) )  {
            epic_error( use_ermes, "%s is incompatible with %",
                        EM_PSD_INCOMPATIBLE, EE_ARGS(2),
                        STRING_ARG, "Sequential Multi-phase",
                        STRING_ARG, "Cardiac Multi-phase" );
            return FAILURE;
        }

        if( (multi_phases * exist(opslquant)) > DATA_ACQ_MAX ) {
            epic_error( use_ermes, "The number of locations * phases has exceeded %d.",
                        EM_PSD_SLCPHA_OUT_OF_RANGE, EE_ARGS(1),
                        INT_ARG, DATA_ACQ_MAX );
            return FAILURE;
        }

        /* Incompatibility with exor/cmon due to image delay annotation etc. */
        if( (PSD_ON == cine_flag) || (PSD_ON == cmon_flag) ||
            (existcv(opexor) && (PSD_ON == exist(opexor))) ) {
            epic_error( use_ermes, "%s is incompatible with %",
                        EM_PSD_INCOMPATIBLE, EE_ARGS(2),
                        STRING_ARG, "Sequential Multi-phase",
                        STRING_ARG, "CINE or Cardiac/resp Compensation" );
            return FAILURE;
        }

        if( existcv(opsldelay) && existcv(opslicecnt) &&
            (exist(opsldelay) != avminsldelay) && (exist(opslicecnt) != 0) )
        {
            epic_error( use_ermes, "Pause is not available with non-minimum delay between acqs.",
                        EM_PSD_PAUSE_DELAY_INCOMPATIBLE, EE_ARGS(0) );
            return FAILURE;
        }
    }


    /* AMR - FOR MT */
    if (MTCheck() == FAILURE) {
        return FAILURE;
    }


    /* AMR - FOR MT */
    if( existcv(opmt) && (PSD_ON == exist(opmt)) ) {
        /* FEC : Removed check for 1.5T and 1.0T systems. */
        if ((opweight < NEO_WEIGHTLINE) &&
            ((opsatx != PSD_OFF) || (opsaty != PSD_OFF) || (opsatz != PSD_OFF)
             || (opexsatmask != PSD_OFF))) {
            epic_error( use_ermes, "Spatial SAT is not allowed for weights less than %d kg.", EM_PSD_SAT_NOT_ALLOWED, EE_ARGS(1), INT_ARG, NEO_WEIGHTLINE );
            return FAILURE;
        }

        /* Make sure MT flip angle is not less than minimum allowed value */
        if (flip_rfmt < minFlipMT)  /*new limits for fermi pulse*/ {
            epic_error( use_ermes, "Please increase TR, the MT flip angle is too small.", EM_PSD_MTFLIP_TOO_SMALL, EE_ARGS(0) );
            return FAILURE;
        }

        /* Make sure MT flip angle does not exceed max allowed value */
        if ( flip_rfmt > maxFlipMT) {
            epic_error( use_ermes, "The MT flip angle is too large.", EM_PSD_MTFLIP_TOO_LARGE, EE_ARGS(0) );
            return FAILURE;
        }
    } /* END OF MT CASE */

    /* AMR - FOR MT */
    /* vmx 08/16/95 YI   There is a risk of burn in the scan
       with MT pulse and with surface coils on VMX system */
    if(system_type == 1) {
        if( (TX_COIL_BODY == getTxCoilType()) &&
            (RX_COIL_LOCAL == getRxCoilType()) &&
            (exist(opmt) == PSD_ON) &&
            existcv(opmt) ) {
            epic_error( use_ermes, "The MT option is not available with surface coils.", 
                        EM_PSD_MT_COIL_INCOMPATIBLE, EE_ARGS(0) );
            return FAILURE;
        }
    } 
    /* end vmx */

    /* MRIhc08845 */
    if(!value_system_flag){
        if( PSD_ON == exist(opdynaplan) && (existcv(opdynaplan)) ) {
            epic_error( use_ermes,
                        "%s is incompatible with %s.",
                        EM_PSD_INCOMPATIBLE, EE_ARGS(2),
                        STRING_ARG, "Multi-phase (Variable delays)",
                        STRING_ARG, "this pulse sequence" );
            return FAILURE;
        }
    }

@inline ZoomGradLimit.e ZoomGradPrep

    /* to fix SPR MRIge66282 - running SPT with zoom gradient 
       (Ken Wu, Feb. 11, 2002) */


    if (do_noise == 1) 
        index_limit = -1;

@inline ZoomGradLimit.e ZoomGradCheck


    return SUCCESS;
}   /* end cvcheck() */


/* *********************************************************************
   PREDOWNLOAD
   
   This section will be executed before a download.  Its purpose is to 
   execute all operations that are not needed for the advisory panel
   results.  All code created by the pulsegen macro exspansions for 
   the predownload section will be executed here.  All internal
   amplitudes, slice ordering, prescan slice calculation, sat placement
   calculation are done here.
   
   Setting up the time anchors also for pulsegen will be done here.
   ******************************************************************* */
STATUS
predownload( void )
{
    /* AMR - FOR MT */
    float b1_90, b1_mt;
    int i,j;          /* counters */

@inline vmx.e PreDownLoad  /* vmx 12/09/94 YI */


    /* **************************************
       Image Header CVs
       ************************************** */

    initfilter();                         /* init filter slots */

    if (seq_type == TYPXRR)
    {
        slquant1 = opslquant;
    }
    else
    {
        slquant1 = slquant_per_trig;
    }

    num_scanlocs = opphases * opslquant;

    ihte1 = opte;
    if (opnecho == 2)
    {
        ihte2 = opte2;
    }

    if (fn < 1)
    {
        ihnex = fn;
    }
    else
    {
        ihnex = truenex;
    }

    ihflip = opflip;

    if( existcv(opmt) && (PSD_ON == exist(opmt)) )
    {
        /* AMR - To display the MT offset frequency on the annotation */
        ihoffsetfreq = MT_freq;
    }

    ihvbw1 = (float)((int)((echo1_filt->bw + 0.005)*100.0))/100.0;
    ihvbw2 = (float)((int)((echo2_filt->bw + 0.005)*100.0))/100.0;

    if (gating == TRIG_INTERN)
        dither_on = PSD_ON;            /* turn on dither for intern gating  */
    else
        dither_on = PSD_OFF;


    /* for exor 2 echo scan */
    a_gy1dummy = 0;
    pw_gy1dummy = GRAD_UPDATE_TIME;
    pw_gy1dummya = GRAD_UPDATE_TIME;
    pw_gy1dummyd = GRAD_UPDATE_TIME;
     
    /* added for pulsegen-on-host feature */
    if ( calcPulseParams(AVERAGE_POWER) == FAILURE ) { 
        return FAILURE;
    }


    /* *************************
       Recon variables
       *********************** */

    /* AMR -  FOR ZIP512 */
    /* Need to compute rhfermr and rhfermw */

    /* MRIge66553 - Changed the calculation of rhfermr for cases
       when ZIP512 is not selected to opxres/2. Please refer SPR 
       enclosure for more details  -AMR */

    fermi_rc = (float)(1.0 / 2.0);

    if( (exist(opzip512) == PSD_ON) && existcv(opzip512) ) {
        fermi_rc = (float)(9.0 / 16.0);
    }

    /* PURE Mix */
    model_parameters.gre2d.minph_pulse_index = 0;
    model_parameters.gre2d.spgr_flag = spgr_flag;

@inline loadrheader.e rheaderinit
@inline Genx.e GenxPredownload

    /* begin LxMGD */
    /* Communicate total number of slices to recon correctly */
    /* Recon believes that this is a regular multi slice multi pass acquisition */

    /* 09/12/2008 MCN MRIhc39773*/
    if( opcgate == PSD_OFF )
        rhnslices = exist(opslquant) * multi_phases;
    else
        rhnslices = exist(opslquant) * opphases;
    /* end LxMGD */

    /* make sure the following recon cvs are set for homodyne recon */
    rhmethod = ( (xres != opxres ) ? 1: 0 );
    /*  FOR ZIP512  - reuse as it was before */
    rhdaxres = xres;    /* data acquisition size */
    rhdayres = rhnframes + rhhnover + 1;
    rhfrsize = rhdaxres;

    /* AMR -  FOR ZIP512 - loadrheader sets the recon header cvs in rheaderinit.
       So there is a need to set them back once again */

    setResRhCVs();

    /* Y transform size of reconstructed image */

    rhhniter = 1;  /* enable iterative homodyne recon */

    /* account for time reversal if necho > 1 TKF */

    if( fullte_flag == PSD_ON || cine_flag == PSD_ON )
    {
        eeff = 0;
    }
    else
    {
        eeff = 1;
    }

    /* FUS - 2nd echo is NOT reversed */
    if( PSD_ON == thermal_map )
    {
        eeff = 0;
        rhhniter = 0;     /* like fgre */
    }    
    else if( exist(opnecho) == 2 )  
    {
        eeff = 1;  /* flip even echo */
    }

    /* Reset rhdacqctrl because eeff is changed after inlining loadrheader.e */
    set_echo_flip(&rhdacqctrl, &chksum_rhdacqctrl, eepf, oepf, eeff, oeff);

    if( (cine_flag == PSD_ON) && ((isOddNexGreaterThanOne == 1) || (isNonIntNexGreaterThanOne ==1)) )
    {
        rhtype1 |= RHTYP1CINEODDNEX; 
    }
    else
    {
        rhtype1 &= ~RHTYP1CINEODDNEX;
    }

    /* *************************
       Make sure exorcist variables are set up for recon
       ************************* */
    if( exorcist_predownload() == FAILURE ) 
    {
        return FAILURE;
    }

    /* Set rhyoff for cine */
    if (cine_flag == PSD_ON)
    {
        /* 5.3 calculation for rhyoff with asym fov,  this is */
        /* similar to how recon calculates its transform size. */
        phasefov = exist(opphasefov)*rhrcxres;
        transformsize = 1;

        /* increment through the powers of 2  */
        while( (transformsize - phasefov) < -0.001 )
        {
            transformsize <<= 1;
        }
        /* compare the power of 2 transform size to the phase fov size */
        /* if it is a power of 2 use that for transform size, otherwise */
        /* use the full resolution for transformsize */
        if( (transformsize - phasefov) > 0.001 )
        {
            transformsize = rhrcxres;
        }
        if( (nex == 1) || (isOddNexGreaterThanOne == 1) || (isNonIntNexGreaterThanOne == 1) )
        {
            /* YMSmr06635 */
            if((exist(opasset) > PSD_OFF) || (exist(opfatwater) > PSD_OFF) ||
               floatsAlmostEqualEpsilons(exist(opphasefov),1,2) || (nop > 1) ){

                rhrcyres = (int)(rhimsize * noptmp);
                rhrcyres = rhrcyres + rhrcyres % 2;

            } else {

                rhrcyres = transformsize;

            }

            rhyoff = rhrcyres/2;
        }
        else
        {
            rhyoff = 0;
        }
    } 

    /* *****************************
       Slice Ordering
       *************************** */

    if( orderslice(seq_type, opslquant * multi_phases, slquant1, gating) == FAILURE ) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "orderslice" );
        return FAILURE;
    }

#ifdef UNDEF
    printf("\nslloc\tslpass\tsltime\t\n++++++++++++++++++++\n");
    for (i = 0; i < opslquant*temp*opphases; i++) {
        printf("%d\t%d\t%d\n",data_acq_order[i].slloc,data_acq_order[i].slpass,
               data_acq_order[i].sltime);
    }
#endif /* UNDEF */

    if (scalerotmats(rsprot, &loggrd, &phygrd, (int)(opslquant*opphases), obl_debug) == FAILURE)
    {
        epic_error(use_ermes,"System configuration data integrity violation detected in PSD. \nPlease try again or restart the system.",
                   EM_PSD_PSDCRUCIAL_CONFIG_FAILURE,EE_ARGS(0));
        return FAILURE;
    }

    trig_scan = gating;

    psd_dump_rsp_info();

    if (cine_flag == PSD_ON) {

        free(ihtdeltab);
        ihtdeltab = (int *)malloc(opcphases*sizeof(INT));
        exportaddr(ihtdeltab, (int)(opcphases*sizeof(int)));
        loc_tdel = 60000000 / (opchrate * opcphases);
        for (i = 0; i < opcphases; i++)
            ihtdeltab[i] = psd_tseq + (i * loc_tdel) + 1ms;

        ihtr = act_tr * slquant1;
    } else if (opcgate == PSD_OFF) {
        ihtr = act_tr + ((gating==TRIG_LINE) ? TR_SLOP_GR : 0);
        if(cmon_flag == PSD_ON) {
            free(ihtdeltab);
            ihtdeltab = (int *)malloc(opslquant * sizeof(int));
            exportaddr(ihtdeltab, (int)(opslquant*sizeof(int)));
            for(i = 0 ; i < opslquant ; i++)
                ihtdeltab[i] = (int)(60.0s/motionrate*(float)cmon_phase/100.0 + 60.0s/motionrate * data_acq_order[i].sltime);
        } else if( PSD_ON == multiphase_flag ) { 
            /* LxMGD : for sequential multi-phase, annotate the tdel correctly. */ 
            free(ihtdeltab);
            if( (ihtdeltab = (int *)malloc(opslquant * multi_phases * sizeof(int))) == NULL ) { 
                epic_error( use_ermes, "malloc failed for %s.", EM_MALLOC_ERMES, EE_ARGS(1), STRING_ARG, "ihtdeltab" );
                return FAILURE;
            }
            exportaddr(ihtdeltab, (int) (opslquant * multi_phases * sizeof(int)) );

            /*
             * For the simple Sequential multiphase which is supported for
             * LxMGD, the delay between slices is the scan time per slice
             * plus any prescribed additional delay time.
             * Note that TR_PASS is included in pitlsice.
             */
            ihtdeltab[0] = 0;
            for ( i = 1; i < opslquant * multi_phases; i ++ ) { 
                ihtdeltab[i] = (int)(ihtdeltab[i-1] + pitslice + tdel_bet_phases);
            }
        } else {
            ihtdel1 = MIN_TDEL1;
        }
    } else {
        free(ihtdeltab);
        free(ihtrtab);
        ihtdeltab = (int *)malloc(opphases*opslquant*sizeof(int));
        exportaddr(ihtdeltab, (int)(opphases*opslquant*sizeof(int)));
        ihtrtab = (int *)malloc(opphases*opslquant*sizeof(int));
        exportaddr(ihtrtab, (int)(opphases*opslquant*sizeof(int)));
        if (opphases > 1) {
            for (i = 0; i < opphases*opslquant; i++) {
                if (data_acq_order[i].sltime < opslquant)
                    ihtrtab[i] = act_tr - ((opphases/opslquant) - 1)
                        *opslquant*psd_tseq;
                else
                    ihtrtab[i] = opslquant*psd_tseq;
                ihtdeltab[i] = optdel1 + psd_tseq*data_acq_order[i].sltime;
            }
        } else {
            /* Cross R-R */
            j= 0;
            for (i = 0; i < opslquant; i++) {
                j = i/ophrep;
                ihtdeltab[i] = optdel1 + psd_tseq*j;
                ihtrtab[i] = act_tr;
            }
        }
    }

    /* ***************************
       Prescan slice calculation
       ************************* */
    if (prescanslice(&pre_pass, &pre_slice, opslquant) == FAILURE) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "prescanslice" );
        return FAILURE;
    }

    piviews = nreps; /* used by the Tgt in cardiac scans to display the
                        number of heart beat triggers the PSD will use
                        to complete a scan */
    if(opcgate == PSD_ON) { /* YMSmr09218 */
        if(opphases > 1) {
            piviews = nreps;
        } else {
            if(opslquant >= ophrep) {
                piviews = nreps * ophrep;
            } else {
                piviews = nreps * opslquant;
            }
        }
    }
    /* Initialize the waits for the cardiac instruction.
     * Pulse widths of wait will be set to td0 for first slice
     * of an R-R in RSP.  All other slices will be set to
     * the GRAD_UPDATE_TIME. */
    pw_x_td0 = GRAD_UPDATE_TIME;
    pw_y_td0 = GRAD_UPDATE_TIME;
    pw_z_td0 = GRAD_UPDATE_TIME;
    pw_rho_td0 = GRAD_UPDATE_TIME;
    pw_ssp_td0 = GRAD_UPDATE_TIME;
    pw_theta_td0 = GRAD_UPDATE_TIME;

    /* Fix amplitude of instruction again here. We only really want the
       waveform value to be negative 
       a_gy1 = -a_gy1;
       ia_gy1 = -ia_gy1;
       a_gy1r = -a_gy1r;
       ia_gy1r = -ia_gy1r; 
    */


    /* *********************
       SAT Positioning
    *********************/
    if(SatPlacement(acqs) == FAILURE)
    {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE,
                    EE_ARGS(1), STRING_ARG, "SatPlacement" );
        return FAILURE;
    } 

    /* *****************************
       Auto Prescan Init

       Inform Auto Prescan about
       prescan parameters.
       *************************** */

    picalmode = 0;
    pislquant = slquant1; /* Number of slices in 2nd pass prescan */

    /* *******************************
       Entry Point Table Evaluation
       ******************************* */

    /* Initialize the entry point table */
    if (entrytabinit(entry_point_table, (INT)ENTRY_POINT_MAX) == FAILURE)
        return FAILURE;

    /* Scan entry point */
    strcpy(entry_point_table[L_SCAN].epname, "scan");

    entry_point_table[L_SCAN].epxmtadd = (short) rint((double)xmtaddScan);

    if (powermon(&entry_point_table[L_SCAN],
                 L_SCAN,
                 (int)RF_FREE,
                 rfpulse,
                 (int)(act_tr/slquant1) ) == FAILURE)
    {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE,
                    EE_ARGS(1), STRING_ARG, "powermon" );
        return FAILURE;
    }

    eppkpower = entry_point_table[L_SCAN].eppkpower;
    epseqtime = entry_point_table[L_SCAN].epseqtime;

    entry_point_table[L_SCAN].epfilter = (unsigned char)echo1_filt->fslot;
    entry_point_table[L_SCAN].epprexres = (s16)xres;

    /* Now copy into APS2 and MPS2 */
    entry_point_table[L_APS2] = entry_point_table[L_MPS2] =
        entry_point_table[L_SCAN];
    strcpy(entry_point_table[L_MPS2].epname, "mps2");
    strcpy(entry_point_table[L_APS2].epname, "aps2");

    /* LxMGD : Set up the filter structures to be downloaded for realtime
       filter generation. Get the slot number of the filter in the filter
       rack and assign to the appropriate acquisition pulse for the right
       filter selection */

    setfilter( echo1_filt, SCAN );
    filter_echo1 = echo1_filt->fslot;

    if (exist(opnecho) > 1) {
        setfilter( echo2_filt, SCAN ); 
        filter_echo2 = echo2_filt->fslot;
    }     

@inline Prescan.e PSfilter

    /* AMR - FOR MT */
    if ( existcv(opmt) && (exist(opmt) == PSD_ON) ) {
        /* Calculate b1_ratio for testing purposes */
        b1_90 = rfpulse[RF1_SLOT].max_b1 * ((float)(rfpulse[RF1_SLOT].nom_pw)/
                                            (float)(*rfpulse[RF1_SLOT].pw))
            * ((*rfpulse[RF1_SLOT].act_fa)/rfpulse[RF1_SLOT].nom_fa);
        b1_mt = rfpulse[RFMT_SLOT].max_b1 * ((float)(rfpulse[RFMT_SLOT].nom_pw)/
                                             (float)(*rfpulse[RFMT_SLOT].pw))
            * ((*rfpulse[RFMT_SLOT].act_fa)/rfpulse[RFMT_SLOT].nom_fa);
        b1_ratio = b1_90/b1_mt;
    }


    /* Set psd_rf_wait and psd_grad_acq_delay for this system. */
    if (setsysparms() == FAILURE) {
        epic_error( use_ermes, supfailfmt, EM_PSD_SUPPORT_FAILURE, EE_ARGS(1), STRING_ARG, "setsysparms" );
        return FAILURE;
    }
    /* end of CERD change. */

@inline Prescan.e PSpredownload

    if(debug_MT) {
        printf( " PREDOWNLOAD SUCCESSFUL \n");
        fflush(stdout);
    }

@inline loadrheader.e rheaderpredownload

    return SUCCESS;
}   /* end predownload() */

/* AMR - FOR MT */
@inline MagTransfer.e MTEval
@inline MagTransfer.e MTCheck
@inline MagTransfer.e MTpredownload
@inline ChemSat.e ChemSatEval
@inline ChemSat.e ChemSatCheck
@inline SpSat.e SpSatEval
@inline SpSat.e SatPlacement
@inline Prescan.e PShost


@inline Minte_fgre_calcs.e MinteCalcs


@rspvar
/*********************************************************************
 *                    2DFAST.E RSPVAR SECTION                        *
 *                                                                   *
 * Declare here the real time variables that can be viewed and modi- *
 * fied while the Tgt PSD process is running. Only limited standard  *
 * C types are provided: short, int, long, float, double, and 1D     *
 * arrays of those types.                                            *
 *                                                                   *
 * NOTE: Do not declare all real-time variables here because of the  *
 *       overhead required for viewing and modifying them.           *
 *********************************************************************/
int psd_seqtime;      /* sequence time */

int echo1cine;          /* Waveform index for the echo1 cine pulse */
int echo1dab;           /* Waveform index for the echo1 dab pulse */
int acq_echo1, acq_echo2; /* flags for data acquisiton */
short amp_gy1, amp_gy1e; /* amp of phase encodes */
short amp_gx1, amp_gxw, amp_gxw2, amp_gxfc; /* X grad variables */
int dabecho, dabecho_multi, dabop, dabview; /*  vars for loaddab */
short blimfactor; /* 1 if new memp, -1 if classic */
short debugstate; /* if trace is on */
int psd_index, pass, view, excitation, slice, baseviews, disdaqs, acq_sl,
    use_sl;
int sl_rcvcf; /*  center freq receive offset */
int rsp_card_intern; /* deadtime when next slice is internally gated in a
			cardiac scan */
int rsp_card_last; /* dead time for last temporal slice of a cardiac scan */
int rsp_card_fill; /* dead time for last slice in a filled R-R interval */
int rsp_card_unfill; /* dead time for last slice in a unfilled R-R interval */
short rsp_hrate;    /* cardiac heart rate */
int seq_count;
int exphase;
int exphasechop;
int org_rcv_phase;  /* used for cine only */
int temp_phase;
int rcphase; /* sum of receiver phase */

/* AMR - FOR MT */
int mtphase, mt_count;

/* AMR - FOR MT */
@inline MagTransfer.e MTRspVar

@inline SpSat.e SpSatRspVar
@inline ChemSat.e ChemSatRspVar 
@inline Prescan.e PSrspvar

int rspent;
short rspdda, rspbas, rspvus, rspnex, rspchp, rspgy1,
    rspesl, rspasl, rspech, rspsct, rspdex, rspslq, rsprlx,
    rmode, resdda, resbas, resvus, resnex, reschp, resdex, 
    resesl, resasl, resech, ressct, resslq;

int rspnex_int;
int rsp_ph_encode;

/* RSP Control Variable Definitions. Listed above  are
   several variables all with the prefix "rsp".  These variables
   are set in the initial part of each entry point,
   before CORE is called. They are used in CORE to
   control the excitation and acquisition of data.
   Descriptions of the use of each of these variables is given
   below.  Each of the variables also has a reseach rsp variable
   counterpart.  When rsp variable rmode is set to 1,
   all "res" variables with the prefix "res" are used for CORE
   control instead of variables with the "rsp" prefix.

   
   dda = total number of disdaq acquisitions ( NOT in pairs )
   bas = total number of baseline acquisitions ( NOT in pairs )
   vus = total number of views to collect
   gy1 = index of initial amplitude of y dephaser
   -1 = calculate initial amplitude
   nex = total number of excitations
   chp = chopper states:
   0 = chop baselines only
   1 = chop everything
   2 = no chopping
   esl = index number of excited slice
   -1 = excite all slices
   asl = index number of acquired slice
   -1 = acquire all non-disdaq slices
   sct = slice number to turn on scope trigger
   -1 = scope trigger on all slices
   dex = total number of views to discard per
   excitation. This allow a disdaq to be done
   on each view.  Normally = 0
   slq = total number of slices to acquire
   cfm = not used
   ent = entry point

*/


short rsp_preview = 0; /* amplitude of phase encode for prescan entrypoints */
short tempamp; /* temporary amplitude storage */
short temp_short;
short cine_check;    /* end of pass check */
short cine_phase; /* cine phase number */
int cine_nview; /* cine next view number */
int cine_pview; /* cine prior view number */
int cine_respview; /* local view count */
int cine_nindex;    /* cine index into phase2view for next view   QT */
int cine_pindex;    /* cine prior inext into phase2view           QT */
short cine_respgroup; /* next resp group */
short cine_prespgroup; /* Previous Resp group */
short cine_iamp;  /* rewinder and phase encoder amplitude */
short cine_collect; /* data collection flag */
short cineprep_mode;  /* Collectng cine data */
short cine_chop;  /* RF Chop flag */
int phaseoff_slice_index;


@pg
/*********************************************************************
 *                     2DFAST.E PULSEGEN SECTION                     *
 *                                                                   *
 * Write here the functional code that loads hardware sequencer      *
 * memory with data that will allow it to play out the sequence.     *
 * These functions call pulse generation macros previously defined   *
 * with @pulsedef, and must return SUCCESS or FAILURE.               *
 *********************************************************************/

#include <stdio.h>

#include "rfsspsummary.h"
#include "support_func.h"

long ssp_ctrl;
short *acq_ptr;               /* first slice in a pass */
int *ctlend_tab;              /* table of cardiac deadtimes */
long deadtime;                 /* amount of deadtime */
long scan_deadtime;            /* deadtime in scan entry point */
short prescan_trigger;        /* save the prescan slice's trigger */
short *slc_in_acq;            /* number of slices in each pass */
short viewtable[2049];        /* view table */
long rsptrigger_temp[1];       /*  temp trigger array for pass packets 
                                   sequences and other misc */
int sp_satindex, cs_satindex; /* index for multiple calls to spsat
                                 and chemsat routines */
int xrr_trig_time;            /* trigger time for a filled or unfilled
 				 R-R interval which is not the last
 				 R-R interval */
int slnum;                    /* slice index */
int pre_slnum;                    /* slice index */
TYPDAB_PACKETS dabpkt;        /* for switching between dab and cine pkts */
WF_PULSE echo1cpulse;   /* The cine pulse that is substitued with the DAB for */

/* cine structures */
CINE_SEQ cineseqinfo;
CINE_PASS cinepassinfo;

int cine_index;
int temp_cine;
int oddnex_cineview;
int phaseoff_cineview; /* view used in cine for phase offset calculations */


/* Frequency offsets */
int *rf1_freq;
int *receive_freq1;
int *receive_freq2;
short maxviews;
int c_seqtime;
int e_seqtime;			/* Exorcist sequenece update time */
int psdpause;
 
/* Move this array to ipg export when exports get shipped in the save */
const CHAR *entry_name_list[ENTRY_POINT_MAX] = { "scan",
                                                 "mps2",
                                                 "aps2",
@inline Prescan.e PSeplist
};

/* AMR - FOR MT */
/* Pulse declaration for external MT pulse stuff */
WF_PULSE rfmt = INITPULSE; 

extern PSD_EXIT_ARG psdexitarg;

/* some variables for exorcist simulation */
extern long ex_sim_spu;		/* on (=1) for simulating spu */
extern long ex_phase_algr;	/* on (=1) for random phase value */
				/* off(=0) for linear increment phase */

long rsprot_orig[DATA_ACQ_MAX][9];

@inline Exorcist.e ExorcistRspDecl
@inline Exorcist.e ExorcistPGDecl



void 
ssisat( void )
{

/* 
 * Added ifdef to bypass for avoid error in pulsegen-on-host
 */

#ifdef IPG

    int next_slice;

    next_slice = sp_sat_index;
    sp_update_rot_matrix(&rsprot_orig[next_slice][0], sat_rot_matrices,
                         sat_rot_ex_num, sat_rot_df_num);   

#endif   /* IPG */

    return;
}   /* end ssisat() */

void
ssiupdates(void)
{

/* 
 * Added ifdef to bypass for avoid error in pulsegen-on-host
 */

#ifdef IPG

    WF_PULSE *rbapulse;
    SHORT rbabits;
    int tmpcine_frame1, tmpcine_frame2, tmpcine_frame3, tmpcine_frame4;

    ssisat();

    if( (cineprep_mode == PSD_ON) && (rspent == L_SCAN)) {

%ifdef DFMONITOR
        if(dfmsequence_flag == PSD_OFF) {
%endif
            /* What this ssi routine should do: 
               - do the PSD stuff 
               - call Tgt routine (getcineinfo) 
               - lots of conditionals: 
               - if c_send == 1, update and send the cine packet; 
               - if c_collect == 0:disdaqs, 1:collect; 
               - do updates to RF and gradients (phase enc, chop, etc.)  
               last: 
               - call Tgt routine (getssitime), ensure that updates are complete 
               before continuing.  If not, flag an error.  */

            /* Updating the CINE_SEQ structure is done by a function call,
               getcineinfo(), which copies the Tgt's structure's contents.
               The PSD then copies pertinent information into the CINE packet. */

            getcineinfo(&cineseqinfo);

            if (opexor == PSD_ON || cmon_flag == PSD_ON) {
                /* Exorcist is called from getcineinfo but the phase has to
                 *  be translated to an exorcist view number. 
                 */
                cine_respgroup = cineseqinfo.c_group;

                /*  changed for cine hi-sort  QT */
                cine_nindex = cineseqinfo.c_nview*2 + (cine_respgroup -1);
                cine_pindex = cineseqinfo.c_pview*2 + (cine_prespgroup -1);
                cine_nview = (INT)phase2view[cine_nindex];
                cine_pview = (INT)phase2view[cine_pindex];

                cine_phase = cineseqinfo.c_nview;
                cine_chop = (((cine_respgroup % 2)==1) ? PSD_ON : PSD_OFF);
            }  
            else
            {   
                cine_pview = (INT)cineseqinfo.c_pview;
                cine_nview = (INT)cineseqinfo.c_nview;
                cine_chop = (((cineseqinfo.c_nview % 2)==1) ? PSD_ON : PSD_OFF);
            }

            /* Cases:
               1. exorcist
               It requires it's own formula for the view table lookup.

               2. oddnex NPW
               In NPW oddnex, the last excitation covers only the 1/2
               of K space. Since Tgt has no understanding of this,
               the Tgt view numbers must be mapped so as to cover
               K space opnex/2 times completely and then the middle half of
               K space for the last time. For instance a three nex 
               128 NPW scan, means 256 views for the first excitation and
               128 middle views for the second excitation. Tgt provides
               numbers from 1 to 394. They must be appropriately mapped.

               Cine_nview which represents the next view to be played
               out needs to be converted so that the view table
               lookup can be done. Using the example above, the values
               from 1 to 256 are okay, but the values greater than
               256 must be mapped to 64 to 192.

               Next, the real view number is passed to recon. This means
               that cine_pview must contain the correct view number.
               Previously in loadrheader, the rhtype1 is set to 4 to
               indicate to recon that the real view number is coming--
               use it as is. Again the same algorithm as cine_nview is
               applied to cine_pview to convert the Tgt numbers to the
               correct mapping.

               Recall cine_nview is not cine_pview. Cine_nview is the
               next view being played out. Cine_pview is the previous
               view. Cine_pview goes to recon!! Cine_nview does not.

               The operation in the cine dab packet is also filled out
               correctly to indicate add. Recon will use the operation
               supplied by the psd whenever rhtype1 is set to 4.

               3. Odd nex without NPW and even nex NPW
               Again the correct view number is given to recon in
               these cases. The formula is easier now. It just
               requires a division by nex. The last excitation completely
               covers K space so there is no need for the remapping to
               the middle.

               Likewise, the view table lookup formula just needs to
               consider nex.

               4. None of the above 
               Use the original formula. The true view is not passed
               to recon. Recon will determine the view based on the
               info the in the cine dab packet plus scan parameters.
            */
            /*
              The phase offset will be calculated with each view calculation.
              We are assumming that the org_rcv_phase and rcphase is global, that the cine
              RX allows only one group - such that the phase offset for slice
              zero (0) is the same for all slices, and
              that phase offset handling for the exorcist case is is Exorcist.e.  
              Once the offset is known, it will be used to update the receiver 
              phase and the org_rcv_phase value due to spoiling.
              ****The assumption that only one group is allowed for Cine is very
              important - we do not know what slice is being played out, so we
              cannot access different slice locations in the phase_off structure.

              The rcphase equation results in -pi if values feeding into it are
              zero, and we know this and it works!  Larry P said the images 
              would probably be split if it was 3pi%2pi-pi instead.

            */

            if (opexor == PSD_ON || cmon_flag == PSD_ON)
            {
                /* if there was a phase offset written in Exorcist.e,
                   we are just writing over it here because this is the last 
                   to be done*/
                cine_iamp = (SHORT)viewtable[ (cine_nview == 0 ? 1 :
                                               ( (rspnex_int == 2)?(cine_nview+1)/2:cine_nview )) ];
                phaseoff_cineview = (cine_nview == 0 ? 1 :
                                     ( (rspnex_int == 2)?(cine_nview+1)/2:cine_nview ));
                yres_phase = phase_off[phaseoff_slice_index].ysign*
                    (((phaseoff_cineview-1)* 
                      phase_off[phaseoff_slice_index].yoffs 
                      + 3L*FS_PI)%FS_2PI-FS_PI);
                if (nope >= 1)
                    yres_phase = 0;

                rcphase = (org_rcv_phase + yres_phase + 4L*FS_PI)%FS_2PI - FS_PI;
                setiphase(rcphase, &echo1, 0); /* yres phase and org_rcv_phase */
            }
            else
                if (isNonIntNexGreaterThanOne == 1)
                {
                    if (cine_pview <= rsp_ph_encode * (nex-1))
                    {

                        oddnex_cineview =  (cine_pview == 0 ? 1 : 
                                            (((cine_pview - 1) / (INT)(nex-1)) + 1));
                    }
                    else
                    {
                        oddnex_cineview = cine_pview - rsp_ph_encode * (nex-1) + rsp_ph_encode/4;
                    }

                    if (cine_nview <= rsp_ph_encode * (nex-1))
                    {
                        cine_iamp = (SHORT)viewtable[ (cine_nview == 0 ? 1 : 
                                                       (((cine_nview - 1) / (INT)(nex-1)) + 1))];
                        temp_cine =  (cine_nview == 0 ? 1 : 
                                      (((cine_nview - 1) / (INT)(nex-1)) + 1));
                        phaseoff_cineview = (cine_nview == 0 ? 
                                             1 : (((cine_nview - 1) / (INT)(nex-1)) + 1));
                        yres_phase = 
                            phase_off[phaseoff_slice_index].ysign*
                            (((phaseoff_cineview-1)* 
                              phase_off[phaseoff_slice_index].yoffs 
                              + 3L*FS_PI)%FS_2PI-FS_PI);

                        if (nope >= 1)
                           yres_phase = 0;
                        
                        rcphase = (org_rcv_phase + yres_phase + 
                                   4L*FS_PI)%FS_2PI - FS_PI;
                        setiphase(rcphase, &echo1, 0);  /* yres phase and org_rcv_phase */
                    }
                    else
                    {
                        cine_nview = cine_nview - rsp_ph_encode * (nex-1) + rsp_ph_encode/4;
                        temp_cine = cine_nview;
                        cine_iamp = (SHORT)viewtable[cine_nview]; 
                        phaseoff_cineview = cine_nview;
                        yres_phase = 
                            phase_off[phaseoff_slice_index].ysign*
                            (((phaseoff_cineview-1)* 
                              phase_off[phaseoff_slice_index].yoffs 
                              + 3L*FS_PI)%FS_2PI-FS_PI);

                        if (nope >= 1)
                           yres_phase = 0;
                        
                        rcphase = (org_rcv_phase + yres_phase + 
                                   4L*FS_PI)%FS_2PI - FS_PI;
                        setiphase(rcphase, &echo1, 0);  /* yres phase and 
                                                           org_rcv_phase */
                    }
                }
                else if (isOddNexGreaterThanOne == 1)
                {
                    oddnex_cineview =  (cine_pview == 0 ? 1 : 
                                        ((cine_pview - 1) / (INT)(nex) + 1));
                    cine_iamp = (SHORT)viewtable[ (cine_nview == 0 ? 1 : 
                                                   (((cine_nview - 1) / (INT)nex) + 1))];
                    phaseoff_cineview = (cine_nview == 0 ? 1 :
                                         (((cine_nview - 1) / (INT)nex) + 1));
                    yres_phase = phase_off[phaseoff_slice_index].ysign*
                        (((phaseoff_cineview-1)* 
                          phase_off[phaseoff_slice_index].yoffs 
                          + 3L*FS_PI)%FS_2PI-FS_PI);

                    if (nope >= 1)
                       yres_phase = 0;
                    
                    rcphase = (org_rcv_phase + yres_phase + 
                               4L*FS_PI)%FS_2PI - FS_PI;
                    setiphase(rcphase, &echo1, 0);  /* yres phase and 
                                                       org_rcv_phase */
                }
                else
                {
                    cine_iamp = (SHORT)viewtable[ (cine_nview == 0 ? 1 : 
                                                   (((cine_nview - 1) / (INT)nex) + 1))];
                    temp_cine =  (cine_nview == 0 ? 1 : 
                                  (((cine_nview - 1) / (INT)nex) + 1));
                    phaseoff_cineview = (cine_nview == 0 ? 1 :
                                         (((cine_nview - 1) / (INT)nex) + 1));
                    yres_phase = phase_off[phaseoff_slice_index].ysign*
                        (((phaseoff_cineview-1)* 
                          phase_off[phaseoff_slice_index].yoffs + 
                          3L*FS_PI)%FS_2PI-FS_PI);

                    if (nope >= 1)
                       yres_phase = 0;
                    
                    rcphase = (org_rcv_phase + yres_phase + 
                               4L*FS_PI)%FS_2PI - FS_PI;
                    setiphase(rcphase, &echo1, 0);  /* yres phase and 
                                                       org_rcv_phase */
                }


            tmpcine_frame1 = cineseqinfo.c_frame1;
            tmpcine_frame2 = cineseqinfo.c_frame2;
            tmpcine_frame3 = cineseqinfo.c_frame3;
            tmpcine_frame4 = cineseqinfo.c_frame4;

%ifdef DFMONITOR
            if(dfm_flag == PSD_ON) {   /* If CINE is being acquired with DFM then for every  */
                tmpcine_frame1 *= 2;   /* imaging acquisition there is a DFM acquisition.    */
                tmpcine_frame2 *= 2;   /* For this reason, double the number of frames       */
                tmpcine_frame3 *= 2;   /* acquired in CINE mode. If this is not done then    */
                tmpcine_frame4 *= 2;   /* the CERD will throw an error stating that the      */
            }                          /* number of frames in the CINE packet does not match */
            /* the number of acquisitions acquired                */
%endif
            if(cineseqinfo.c_send == 1 ) {

                /*  The regular DAB packet is already replaced with the CINE DAB packet
                    in cinecore() before we entered the cinescanprep() function. 
                    Now, update this CINE DAB packet to communicate the CINE related information
                    (arrhythmia, frame<x>, delay and slice info) to recon. - RJF */ 

                if (opexor)
                {

                    /* the groups are only different for the first send of
                     *  every group change.
                     */
                    if (cine_respgroup != cine_prespgroup)
                        cine_prespgroup = cine_respgroup;


                }

                if (((isNonIntNexGreaterThanOne == 1) || (isOddNexGreaterThanOne ==1))
                    && (opexor == 0) )
                {
                    loadcine(&echo1,cineseqinfo.c_arr,1,
                             oddnex_cineview,
                             tmpcine_frame1,
                             tmpcine_frame2,
                             tmpcine_frame3,
                             tmpcine_frame4,
                             cineseqinfo.c_delay,
                             cineseqinfo.c_f1slice,DABON);
                }
                else
                {
                    loadcine(&echo1,cineseqinfo.c_arr,cineseqinfo.c_op,
                             cine_pview,
                             tmpcine_frame1,
                             tmpcine_frame2,
                             tmpcine_frame3,
                             tmpcine_frame4,
                             cineseqinfo.c_delay,
                             cineseqinfo.c_f1slice,DABON);
                }
                ++cine_index;
            }
            else
            {
                loadcine(&echo1,cineseqinfo.c_arr,cineseqinfo.c_op,
                         cine_pview,
                         tmpcine_frame1,
                         tmpcine_frame2,
                         tmpcine_frame3,
                         tmpcine_frame4,
                         cineseqinfo.c_delay,
                         cineseqinfo.c_f1slice,DABOFF);

            }

            getssppulse(&rbapulse, &echo1, "rba", 0);

            if((cineseqinfo.c_collect == 1))
            {
                rbabits = RDC;
            }
            else
            {
                rbabits = 0;
            }
            sspload((SHORT *)&rbabits,
                    (WF_PULSE_ADDR)rbapulse,
                    (LONG)0, /* cerd */
                    (SHORT)1,
                    (HW_DIRECTION)TOHARDWARE,
                    (SSP_S_ATTRIB)SSPS1);


            cine_check = cineseqinfo.c_check;
            cine_collect = cineseqinfo.c_collect;

            /* set up phase encode and rewind amplitude */
            setiampt((SHORT)-cine_iamp,&gy1,0);
            if (rewinder_flag == PSD_ON)
                setiampt((SHORT)-cine_iamp,&gy1r,0);

            /* set up sign of RF amplitude */
            if (choplet == PSD_OFF)  /* Only chop when nex >= 2) */
            {
                /* Add pi to receiver phase to reverse the affects of
                   chopping. Pi is only added when cine_chop is off (i.e
                   even cine view and nex >=2 ) */

                if(cine_chop != PSD_ON)
                {
                    /* PI = 32768
                       Acceptable values are 32768 (PI) to -32767 (< -PI).
                       The last four binary places must be zeroed by definition.
                    */
                    temp_phase = rcphase + 32768;
                }
                else
                {   
                    temp_phase = rcphase;
                }

                if (temp_phase > 32768)
                {
                    temp_phase = temp_phase - 2*32768;
                }

                if (temp_phase == 32768)
                    temp_phase = -32768;

                setiphase(temp_phase,&echo1, 0);
            }

            forceupdate();

            if ((opexor == PSD_ON || cmon_flag == PSD_ON) && cineseqinfo.c_op == 1)
            {
                cine_respview += 1;
                if (cine_check == PSD_OFF)
                    updaterespindex(&cine_phase,cine_respgroup);
            }


#ifdef CHECK_TIME  
            if(getseqtime(c_seqtime) == FAILURE)
                return FAILURE;

            if(c_seqtime > pos_start) 
                /*Error:  Cine updates not done in time...

                This has to be checked before returning. it's
                to make sure the updates were done before 
                the next sequence started.  This MUST be the
                last thing done in this routine. */
                return FAILURE;
#endif

%ifdef DFMONITOR                 
        } else {

            getssppulse(&rbapulse, &echodfm, "rba", 0);

            if((cine_collect == 1)) {
                rbabits = RDC;
            } else {
                rbabits = 0;
            }

            sspload((SHORT *)&rbabits,
                    (WF_PULSE_ADDR)rbapulse,
                    (LONG)0,
                    (SHORT)1,
                    (HW_DIRECTION)TOHARDWARE,
                    (SSP_S_ATTRIB)SSPS1);

            forceupdate();
        }  /* endif(dfmsequence_flag == PSD_OFF) */
%endif

    } else if (cine_flag == PSD_OFF) {
        if(opexor == PSD_ON || cmon_flag == PSD_ON) 
        {
            /* MRIge61907: No need to do the Resp Comp for the 
               DFM sequence */ 
%ifdef DFMONITOR
            if(dfmsequence_flag == PSD_OFF) 
%endif
            {   exorcist_ssi(); }
        }
    }

#endif   /* IPG */

    return;

}   /* end ssupdates() */


STATUS
pulsegen(void) 
{
    int i;                /* counters */
    int PosPhaseEncode1, PosPhaseRew1; /* echo1 y pulse locs    */
    int PosReadoutWindow; /* Readout window location            */
    int PosGx1;           /* Readout dephaser location          */
    int PosGxfc;          /* Readout flow_comp                  */
    int PosGxfc2;         /* Readout flow_comp                  */
    int PosGxfc3;         /* Readout flow_comp                  */
    int PosGz1;           /* Slice dephaser location            */
    int PosGzr;           /* Binomial rewinder location - FUS   */
    int Posrf2;           /* 2nd binomial pulse location - FUS  */
    int Posrf1;           /* Excitation pulse location - FUS    */
    int PosZKiller;       /* Z Killer location                  */
    int PosXKiller;       /* X Killer location                  */
    short slmod_acqs;       /* slices%acqs */
    short temp_amp;         /* temporary amp */

    int resp_comp_type = TYPNORM;   /* low sort, high sort                */


    /* ********************************************************************
       Pulsegen
       In research and prototype PSDs, a majority of the work can be done 
       in the pulsegen section and taken out of the CvEval section.  The user
       can allow the pulsegen section to define many pulsewidths and 
       amplitudes for behind his back.  For product PSDs however, optimization
       and absolute knowledge of pulse widths and amplitudes are needed for
       the advisory panel.  Thus CV_Eval will define most pulse widths
       and amplitudes for pulsegen in product PSDs.
    ******************************************************************/


    debugstate = debug;
    /*MRIhc18005 psd_board_type initialization moves to epic.h*/

    sspinit(psd_board_type);

    /* Initialize TGlimit system limit: 200 */
    TGlimit = MAX_SYS_TG;

    /* Initialize psdexitarg */
    psdexitarg.abcode = 0;
    strcpy(psdexitarg.text_arg, "pulsegen");
    view = slice = excitation = 0;
    psdexitarg.longarg[0] = (long *)&rspent;
    psdexitarg.longarg[1] = (long *)&view;
    psdexitarg.longarg[2] = (long *)&slice;
    psdexitarg.longarg[3] = (long *)&excitation;


/* 
 * Added ifdef for pulsegen-on-host implementation
 */

#ifdef IPG

    if(cmon_flag == PSD_ON) 
    {
        exorcist_set_gate(); /** Inform SPU that we're doing cmon scan
                                 for MRIge41712, RJF **/
    }
#endif   /* IPG */


@inline vmx.e VMXpg  /* vmx 12/09/94 YI */

    /* **************************************
       Cardiac Waits
       Place at beginning to time trigger delays.  
       All slices after first in the R-R will have the
       period changed to 4us to essentially nullify
       this wait.
       ************************************ */
    WAIT(XGRAD, x_td0, tlead, pw_x_td0);
    WAIT(YGRAD, y_td0, tlead, pw_y_td0);
    WAIT(ZGRAD, z_td0, tlead, pw_z_td0);
    WAIT(RHO, rho_td0, tlead, pw_rho_td0);
    WAIT(OMEGA, theta_td0, tlead, pw_theta_td0);
    WAIT(SSP, ssp_td0, tlead, pw_ssp_td0);


    /* AMR - FOR MT */
    /*********************************************************
      MT Pulse
    *********************************************************/
    mt_index = 0;/*11/30/95 VB*/
    if (opmt == PSD_ON) {
        MTPG(mt_start, &mt_index);/* 11/30/95 VB */
    }


    /**********************
      Spatial Sat
    ********************/

    sp_satindex = 0;
    printdbg("Entering SpSatPG routine", debugstate);
    SpSatPG(vrgsat,sp_satstart, &sp_satindex, sp_satcard_loc);
    printdbg("Left SpSatPG routine", debugstate);

    /* *******************
       Chem Sat   
       **************** */
    cs_satindex = 0;
    if (cs_sat)
    {
        ChemSatPG(cs_satstart, &cs_satindex);
    }


    /* AMR - Invalid Wait period error fix  */
    if( PSD_ON == rfpulseInfo[RF1_SLOT].change ) {
        res_rf1 = rfpulseInfo[RF1_SLOT].newres;   /* Set to new resolution */
    }

    /* begin FUS */
    /*
     * MRIge73418 - removed RUP_GRD from Posrf1 calculation - sunl
     */
    setWaveformPurpose(rf1, EXCITATION_RF);
    Posrf1 = pos_start + pw_gzrf1a;     /* AMR - FOR MT */
    SLICESELZ(rf1, Posrf1 , pw_rf1, opslthick, flip_rf1, cyc_rf1, TYPNDEF, loggrd);
    /* end FUS */

    /* Assert the ESSP flag on the rf1 pulse */
#ifdef NOTYET
    attenflagon(&rf1, 0);
#endif

    /* ******************************
       Binomial Fat Saturation -FUS 
    *****************************/
    if( PSD_ON == binomial_pulse )
    {
        rfpulseInfo[RF2_SLOT].change = rfpulseInfo[RF1_SLOT].change;
        if (rfpulseInfo[RF2_SLOT].change==PSD_ON)
        {
            res_rf2 = rfpulseInfo[RF2_SLOT].newres;       /* Set to new resolution */
        }

        setWaveformPurpose(gzr, WINDER_GRAD);
        PosGzr = pendall(&gzrf1, 0) + pw_gzra;
        TRAPEZOID (ZGRAD, gzr, PosGzr, 0, TYPNDEF, loggrd);

        setWaveformPurpose(rf2, EXCITATION_RF);
        Posrf2 = Posrf1 + RUP_GRD((int)fw_echo_delay);
        SLICESELZ(rf2, Posrf2, pw_rf2, opslthick, flip_rf2, cyc_rf2, TYPNDEF, loggrd);

        /* Assert the ESSP flag on the rf2 pulse */                 
#ifdef NOTYET
        attenflagon(&rf2, 0);
#endif
    }

    /* ******************************
       Z Dephaser and flow comp
    *****************************/

    PosGz1 = pendall(&gzrf1, 0)+pw_gz1a;
    /* FUS - binomial pulse */
    if( PSD_ON == binomial_pulse ) {
        PosGz1 = pendall(&gzrf2, 0) + pw_gz1a;
    }


    setWaveformPurpose(gz1, WINDER_GRAD);
    TRAPEZOID( ZGRAD, gz1, PosGz1, 0, TYPNDEF, loggrd); 

    if (opfcomp==TYPFC)
    {
        /* don't have to round because pendall */
        /* and pw_gzfca are already rounded */ 
        setWaveformPurpose(gzfc, COMPENSATION_GRAD);
        TRAPEZOID( ZGRAD, gzfc, pendall(&gz1, 0)+pw_gzfca, 0, TYPNDEF, loggrd); 
    }



    /* ****************************************
       X Readout, Dephaser and Data Acquisition
       ************************************** */
    PosReadoutWindow =  RUP_GRD((int)(pend(&gzrf1,"gzrf1",0) - iso_delay + opte - t_rd1a));
    /* FUS - binomial pulse */
    if( PSD_ON == binomial_pulse ) {
        PosReadoutWindow =  RUP_GRD((int)(pend(&gzrf2,"gzrf2",0) - iso_delay - (int)(fw_echo_delay/2) + opte - t_rd1a));
    }

    setWaveformPurpose(gxw, READOUT_GRAD);
    TRAPEZOID( XGRAD, gxw, PosReadoutWindow, 0, TYPNDEF, loggrd) ;
    ACQUIREDATA( echo1, PosReadoutWindow+pw_gxwl+psd_grd_wait,
                 pos_DAB, DEFAULTPOS, DABNORM ); 

    TNSON(e1entns,PosReadoutWindow+pw_gxwl+psd_grd_wait);
    TNSOFF(e1distns,PosReadoutWindow+pw_gxwl+psd_grd_wait+pw_gxw);

    attenflagon(&echo1,0);
    getwave(&echo1dab, &echo1);

    /* Create cine packet */
    createcine(&echo1cpulse, "echo1cdab");
    getwave(&echo1cine, &echo1cpulse);

    if( TYPVEMP == vemp_flag )
    {
        pos_DAB2 = pendall(&e1distns,0);
        PosReadoutWindow = RUP_GRD((int)(pos_start + t_exa + opte2 - t_rd1a2));

        setWaveformPurpose(gxw2, READOUT_GRAD);
        TRAPEZOID( XGRAD, gxw2, PosReadoutWindow, 0, TYPNDEF, loggrd) ;
        /* FUS - If ON, same polarity as 1st echo */
        if( PSD_OFF == thermal_map ) {
            getiamp(&temp_amp, &gxw2, 0);
            setiampt(-temp_amp, &gxw2, 0);
        }

        /* position the second echo DAB at the end of the first echo */
        ACQUIREDATA( echo2, PosReadoutWindow+pw_gxwl2+psd_grd_wait,
                     pos_DAB2, DEFAULTPOS, DABNORM );

        TNSON(e2entns,PosReadoutWindow+pw_gxwl2+psd_grd_wait);
        TNSOFF(e2distns,PosReadoutWindow+pw_gxwl2+psd_grd_wait+pw_gxw2);

        attenflagon(&echo2,0);

        setrfltrs((int)filter_echo2, &echo2);
    }

    /* mark end of first aquisition window */
    ATTENUATOR(attenuator_key, pendallssp(&e1distns,0));

    /* frequency dephaser */
    setWaveformPurpose(gx1, WINDER_GRAD);
    PosGx1 = pbegall(&gxw,0)-(pw_gx1+pw_gx1d);
    TRAPEZOID( XGRAD, gx1, PosGx1, 0, TYPNDEF, loggrd);

    /* Insert flow comp pulses */
    if( (opfcomp == TYPFC) || ((PSD_ON == thermal_map) && (2 == opnecho))  ) {
        /* 1st echo flow comp pulse */
        setWaveformPurpose(gxfc, COMPENSATION_GRAD);
        PosGxfc = pbegall(&gx1,0)-(pw_gxfc+pw_gxfcd);
        /* FUS - Rewinder for 2nd echo with same polarity as 1st echo */
        if( (PSD_ON == thermal_map) && (2 == opnecho) ) {
            PosGxfc = pbegall(&gxw2,0)-(pw_gxfc+pw_gxfcd);        
        }
        TRAPEZOID( XGRAD, gxfc, PosGxfc, 0, TYPNDEF, loggrd);

        /* echo 2 flow comp pulses */
        if( (TYPVEMP == vemp_flag) && (PSD_OFF == thermal_map) ) {   /* FUS */
            setWaveformPurpose(gxfc2, COMPENSATION_GRAD);
            PosGxfc2 = pendall(&gxw,0)+pw_gxfc2a;
            TRAPEZOID( XGRAD, gxfc2, PosGxfc2, 0, TYPNDEF, loggrd);
            setWaveformPurpose(gxfc3, COMPENSATION_GRAD);
            PosGxfc3 = pbegall(&gxw2,0)-(pw_gxfc3+pw_gxfc3d);
            TRAPEZOID( XGRAD, gxfc3, PosGxfc3, 0, TYPNDEF, loggrd);
        }
    }

    /* *****************************************
       Y phase encoding and possible rewinder
    *****************************************/

    if (rewinder_flag == PSD_ON) {
        if(opnecho==1)
            PosPhaseRew1 = pend(&gxw,"gxw", 0);
        else
            PosPhaseRew1 = pend(&gxw2,"gxw2", (opnecho-2));
        setWaveformPurpose(gy1r, STEP_ENCODER_GRAD);
        TRAPEZOID2(YGRAD, gy1r, PosPhaseRew1, TRAP_ALL_SLOPED,,,endview_scale, loggrd);
    }



/* MRIge90956 -- MRIhc01169 --- Luxembourg gradient over range fix for ACGD  -- RKS * RP */
/* Move gy1 after slice rewinder for oblique and non minimum TE scans */
   if ((gradamp == 8915) && (move_gy1 == PSD_ON) &&
        (opte != TE_MIN) &&
        (opplane == PSD_OBL) &&
         (opte >= (pw_rf1/2 + pw_gz1a+ pw_gz1 +pw_gz1d + pw_gy1a + pw_gy1 +pw_gy1d + pw_gxwa + pw_gxw/2 + 100)))
   {
        PosPhaseEncode1 = RUP_GRD(pend(&gz1,"gz1",0) + pw_gz1d);
   }
   else  /* default location */
   {
         PosPhaseEncode1 = RUP_GRD(pend(&gzrf1,"gzrf1",0) + rfupd);
   }


    /* FUS - binomial pulse */
    if( PSD_ON == binomial_pulse ) {
        PosPhaseEncode1 = RUP_GRD(pend(&gzrf2,"gzrf2",0) + rfupd);
    }
    setWaveformPurpose(gy1, STEP_ENCODER_GRAD);
    TRAPEZOID2(YGRAD, gy1, PosPhaseEncode1, TRAP_ALL_SLOPED,,,endview_scale, loggrd);

    if (opexor == PSD_ON || cmon_flag == PSD_ON) {
        exorcist_pulse.rf1_time = pbeg(&rf1,"rf1",0);
        exorcist_pulse.echo[0].phase_encode_time = pbeg(&gy1,"gy1a",0);
        exorcist_pulse.echo[0].dab_time = pbeg(&gy1,"gy1a",0);
        exorcist_pulse.echo[0].phase_encode_rewinder_time = pbeg(&gy1r,"gy1ra",0);
        if (mpgr_flag == PSD_ON)
            exorcist_pulse.rf1_phase = FSI/2;  /* corresponds to half pi */
        else
            exorcist_pulse.rf1_phase = 0;

        if (((opplane == PSD_AXIAL) || ((opplane == PSD_OBL) && 
                                        (opobplane == PSD_AXIAL)))
            && (opsatz > 0) && (exor_chop == 0) && (opsat > 0) ) /*YMSmr07011 HK*/
        {
            switch (opsatz)
            {
            case 1:
            case 2:
            case 3:
                exorcist_pulse.num_sats = 1;
                exorcist_pulse.sat[0].sat_time = pbeg(&rfsz1,"rfsz1",0);
                exorcist_pulse.sat[0].sat_amp = ia_rfsz1;
                exorcist_pulse.sat[0].sat_index = 0;
                exorcist_pulse.sat[0].sat = &rfsz1;
                break;

            case 4:
                exorcist_pulse.num_sats = 2;
                exorcist_pulse.sat[0].sat_time = pbeg(&rfsz1,"rfsz1",0);
                exorcist_pulse.sat[0].sat_amp = ia_rfsz1;
                exorcist_pulse.sat[0].sat_index = 0;
                exorcist_pulse.sat[0].sat = &rfsz1;
                exorcist_pulse.sat[1].sat_time = pbeg(&rfsz2,"rfsz2",0);
                exorcist_pulse.sat[1].sat_amp = ia_rfsz2;
                exorcist_pulse.sat[1].sat_index = 0;
                exorcist_pulse.sat[1].sat = &rfsz2;
                break;
            }
        } else
            exorcist_pulse.num_sats = 0;
    }

    /* ********************
       Z & X Killer 
    *******************/

    /*   PosZKiller = pos_killer + pw_gzka;  */
    if( TYPVEMP == vemp_flag )
        PosZKiller = pendall(&gxw2,(opnecho - 2)) + pw_gzka;
    else
        PosZKiller = pendall(&gxw,0) + pw_gzka;

    setWaveformPurpose(gzk, KILLER_GRAD);
    TRAPEZOID(ZGRAD, gzk, PosZKiller, 0, TYPNDEF, loggrd);

    /* There is no x gradient killer created for cine */

    /*  PosXKiller = pos_killer + pw_gxka;  */
    if( TYPVEMP == vemp_flag )
        PosXKiller = pendall(&gxw2,(opnecho - 2)) + pw_gxka;
    else
        PosXKiller = pendall(&gxw,0) + pw_gxka;
    setWaveformPurpose(gxk, KILLER_GRAD);

    TRAPEZOID(XGRAD, gxk, PosXKiller, 0, TYPNDEF, loggrd);

    /* Actual deadtimes for cardiac scans will be rewritten later */
    if(opcgate == PSD_ON)
        psd_seqtime = RUP_GRD(tmin);
    else
        if (cine_flag == PSD_ON)
            psd_seqtime = RUP_GRD(act_tr - time_ssi);
        else
            psd_seqtime = RUP_GRD(act_tr/slquant1 - time_ssi);

    /* act_tr/slquant1 */
    SEQLENGTH(seqcore, psd_seqtime, seqcore); 

    /* save the scan deadtime */
    getperiod(&scan_deadtime, &seqcore, 0);

    /* Assert the ESSP flag on the sync packet created by seq length */
    attenflagon(&seqcore, 0);

/* 
 * Added ifdef for pulsegen-on-host implementation
 */

#ifdef IPG  
@inline Prescan.e PSpulsegen
#endif   /* IPG */


    /************************************************************
     * Pass Packet sequence
     ***********************************************************/
    /* begin LxMGD */
    {
        /*
         * LxMGD : Allow for additional delay between phases if requested 
         * by user. Do this by increasing the pass packet sequence length. 
         * The host makes sure that this value is at least equal to TR_PASS.
         */
        int posPass;
        int pass_seqtime;

        pass_seqtime = TR_PASS;
        if( PSD_ON == multiphase_flag ) {
            pass_seqtime = tdel_bet_phases;
        }
        posPass = (pass_seqtime - 1ms);
        PASSPACK(pass_pulse, posPass);
        SEQLENGTH(seqpass, RUP_GRD(pass_seqtime), seqpass); 
    }
    /* end LxMGD */

    /************************************************************
     * Dummy sequence for 2 echo resp comp that is never played
     ***********************************************************/
    TRAPEZOID2(YGRAD,gy1dummy,RUP_GRD(TR_PASS-1ms),,,,, loggrd);
    SEQLENGTH(seqdummy, RUP_GRD(TR_PASS), seqdummy); 

    if (SatRelaxers) /* Create Null sequence for Relaxers */
        SpSatCatRelaxPG(time_ssi);


    if (buildinstr() == FAILURE) {

        return FAILURE;
    }

    if (SatRelaxers) /* Use X and Z Grad offsets from off seqcore */
    {
        SpSatCatRelaxOffsets(off_seqcore);
    }

    /*  ***********************************************************
        Initialization
        This section performs the equivalent of the IPI section
        DOWNLOAD in 4.0.
        ********************************************************** */


    /* Allocate memory for various arrays.
     * An extra 2 locations are saved in case the user wants to do
     * some tricks. */
    acq_ptr = (short *)AllocNode((num_scanlocs + 2)*sizeof(SHORT));
    ctlend_tab = (int *)AllocNode((num_scanlocs + 2)*sizeof(INT));
    slc_in_acq = (short *)AllocNode((acqs + 2)*sizeof(SHORT));
    rf1_freq = (int *)AllocNode((num_scanlocs + 2)*sizeof(INT));
    receive_freq1 = (int *)AllocNode((num_scanlocs + 2)*sizeof(INT));
    receive_freq2 = (int *)AllocNode((num_scanlocs + 2)*sizeof(INT));



    rspdex = dex;
    rspech = 0;
    rspchp = 1;

    /* research rsp initialization */
    rmode = 0;
    reschp = 1;
    resdda = dda;
    resbas = baseline;
    resvus = opyres;
    resnex = nex;
    reschp = 1;
    resesl = 0;
    resasl = 0;
    resslq = slquant1;
    ressct = 1;
    resech = 0;
    resdex = dex;

    debugstate = debug;
    if (opblim)
        blimfactor = 1;
    else
        blimfactor = -1;

/* 
 * Added ifdef for pulsegen-on-host implementation
 */

#ifdef IPG
    /*
     * Execute this only on the IPG side.
     */

    /* Find frequency offsets */

    setupslices(rf1_freq, rsp_info, opslquant, a_gzrf1,
                (float)1, opfov, TYPTRANSMIT);
    setupslices(receive_freq1, rsp_info, opslquant, (float)0,
                echo1bw, opfov, TYPREC);
    /* FUS - Set the 2nd echo frequency according to gradient polarity */
    setupslices(receive_freq2, rsp_info, opslquant, (float)0,
                echo2bw, opfov, (PSD_ON == thermal_map) ? TYPREC : TYPRECGRDEVEN);

    if (ipg_trigtest == 0) {
        /* Inform the Tgt of the trigger array to be used */
        /* Following code is just here to support Tgt oversize
           board which only supports internal gating */
        for (slice=0; slice < opslquant*opphases; slice++)
            rsptrigger[slice] = (short)TRIG_INTERN;
    }

    /* Inform the Tgt of the trigger array to be used */
    settriggerarray((SHORT)(opslquant*opphases),rsptrigger);

    /* Inform the Tgt of the rotation matrix array to be used */
    setrotatearray((SHORT)(opslquant*opphases),rsprot[0]);

    /* Setup exorcist tables */
    exorcist_pg(&resp_comp_type);

    /* update RSP maxTG with min TGlimit value */
    maxTGAtOffset = updateTGLimitAtOffset(TGlimit, sat_TGlimit);
#endif /* IPG */

    setupphasetable(viewtable, resp_comp_type, phaseres);

    sl_rcvcf = (int)((float)cfreceiveroffsetfreq / TARDIS_FREQ_RES);

    /* Set up SlcInAcq and AcqPtr tables for multipass scans.
       SlcInAcq array gives number of slices per array.
       AcqPtr array gives index to the first slice in the 
       multislice tables for each pass. */


    if (opcgate == PSD_ON) {
        rspcardiacinit((short)ophrep, (short)piclckcnt);
        psd_index = acqs - 1;
        for (pass = 0; pass < acqs; pass++) {
            slc_in_acq[pass] = slquant1;
            if (pass == 0) 
                acq_ptr[pass] = 0;
            else {
                acq_ptr[pass] = psd_index;
                psd_index = psd_index - 1;
            }
        }
    } else {
        slmod_acqs = opslquant%acqs;
        for (pass = 0; pass < acqs; pass++) {
            slc_in_acq[pass] = opslquant/acqs;
            /* LxMGD MPH */
            if( (slmod_acqs > pass) || (multi_phases > 1) ) {
                slc_in_acq[pass] = slc_in_acq[pass] + 1;
            }
            acq_ptr[pass] = (INT)(opslquant/acqs) *pass;
            /* LxMGD MPH */
            if( (slmod_acqs <= pass) && (1 == multi_phases) ) {
                acq_ptr[pass] = acq_ptr[pass] + slmod_acqs ;
            } else {
                acq_ptr[pass] = acq_ptr[pass] + pass;
            }
        }
    }

    /* Save the trigger for the prescan slice. */
    prescan_trigger = rsptrigger[acq_ptr[pre_pass] + pre_slice];

    rsptrigger_temp[0] = TRIG_INTERN;

    sp_sat_index = 0;
    if (cine_flag == PSD_ON || opexor == PSD_ON || cmon_flag == PSD_ON)
        ssivector(ssiupdates, (short) FALSE);
    else if (opsat == PSD_ON)
        ssivector(ssisat, (short) FALSE);

    exorcist_pulse.rf1 = &rf1;
    exorcist_pulse.rf1_amp = ia_rf1;
    exorcist_pulse.rf1_index = 0;
    exorcist_pulse.num_echos = opnecho;
    exorcist_pulse.echo[0].dab = &echo1;
    exorcist_pulse.echo[0].phase_encode = &gy1;
    exorcist_pulse.echo[0].phase_encode_index = 0;
    exorcist_pulse.echo[0].phase_encode_rewinder = &gy1r;
    exorcist_pulse.echo[0].phase_encode_rewinder_index = 0;

    for (i=1; i<opnecho; i++) {
        exorcist_pulse.echo[i].dab = &echo2;
        exorcist_pulse.echo[i].phase_encode = &gy1dummy;
        exorcist_pulse.echo[i].phase_encode_index = 0;
        exorcist_pulse.echo[i].phase_encode_rewinder = &gy1dummy;
        exorcist_pulse.echo[i].phase_encode_rewinder_index = 0;
    }


    org_rcv_phase = 0;
    rcphase = 0;

    return SUCCESS;
} /* end pg */

/* AMR - FOR MT */
@inline MagTransfer.e MTPG

@inline ChemSat.e ChemSatPG
@inline SpSat.e SpSatPG
@inline Prescan.e PSipg


@rsp
/*********************************************************************
 *                       2DFAST.E RSP SECTION                        *
 *                                                                   *
 * Write here the functional code for the real time processing (Tgt  *
 * side). You may declare standard C variables, but of limited types *
 * short, int, long, float, double, and 1D arrays of those types.    *
 *********************************************************************/
#include <math.h>
#include "pgen_tmpl.h"
#include "epic_loadcvs.h"

@inline Exorcist.e ExorcistRsp


STATUS
psdinit(void) 
{
    int i; /* counter */

    /*DCZ: (MRIge73697)Convert opnex and nop 
      to int to avoid AGP crash during SSI.*/
    rspnex_int = (INT)opnex;
    rsp_ph_encode = (INT)(nop * opyres * opphasefov);

    if ((cine_flag == PSD_ON) || (opexor == PSD_ON) || cmon_flag == PSD_ON)
        ssivector(ssiupdates, (short) FALSE);
    else if (opsat == PSD_ON)
        ssivector(ssisat, (short) FALSE);

    vwchp = PSD_OFF;
    /* chopping logic with oddnex. MHN */
    if ( (nex==1) || (isOddNexGreaterThanOne==1) || (isNonIntNexGreaterThanOne==1) )
        vwchp = PSD_ON;
    if ( ((isOddNexGreaterThanOne == 0) && (isNonIntNexGreaterThanOne == 0)) ||
         ((rspent==L_MPS2)|| (rspent==L_APS2)) )
        vwchp = PSD_OFF;

    /* set up phase offset arrays */
    for (i = 0; i <= opslquant*opphases - 1; i++)
    {
        if (rsp_info[i].rspphasoff >=0)
            phase_off[i].ysign = -1;
        else
            phase_off[i].ysign = 1;
        /* phase offset increment */
        if (FAILURE == calcrecphase(&yoffs1, rsp_info[i].rspphasoff, opfov, opphasefov, nop, 1.0))
        {
            return FAILURE;
        }

        /* offset in range */
        phase_off[i].yoffs = (yoffs1 + FS_2PI + FS_PI)%FS_2PI-FS_PI;
    }

    /* Reset global error handling variable */
    strcpy(psdexitarg.text_arg, "psdinit");
    view = slice = excitation = 0;

    /* set dither control */
    setditherrsp(dither_on,dither_value);
    cineprep_mode = PSD_OFF;

    /* reset all the attenuator locks */
    if (rspent == L_SCAN)
        attenlockon(&attenuator_key);
    else
        attenlockoff(&attenuator_key);

    /* Reset all the scope triggers */
    scopeon(&seqcore);

    /* Reset all the synchronizations  - no need to use one in pass */
    syncon(&seqcore);

    syncoff(&seqpass);

    /* In case cine aborts prematurely, assure that echo1 has the
     *  right packet.
     */
    if (cine_flag == PSD_ON)
        setwave(echo1dab, &echo1, 0);


    /* Allow for manual trigger override for testing. */
    if (((psd_mantrig == 1) || (opcgate == PSD_ON))
        && ((rspent == L_APS2) || (rspent == L_MPS2)
            || (rspent == L_SCAN))) {
        for (slice=0; slice < opslquant*opphases; slice++) {
            if (rsptrigger[slice] != TRIG_INTERN) {
                switch (rspent) {
                case L_MPS2:
                    rsptrigger[slice] = trig_mps2;
                    break;
                case L_APS2:
                    rsptrigger[slice] = trig_aps2;
                    break;
                case L_SCAN:
                    rsptrigger[slice] = trig_scan;
                    break;
                default:
                    break;
                } /* end switch */
            } /* not internal trigger */
        } /* slice loop */
    } /* trigger override */

    /* FUS */
    if( ext_trig && (rspent == L_SCAN) ) {
        /* Set trigger array - first slice to external trigger */
        rsptrigger[0] = TRIG_AUX;
    }

    /* Assure trigger arrays are reset to standard ones */
    settriggerarray((SHORT)(opslquant*opphases),rsptrigger);

    SpSat_set_sat1_matrix( rsprot_orig, rsprot, opslquant*opphases,
                           sat_rot_matrices, sat_rot_ex_num, sat_rot_df_num,
                           sp_satcard_loc, 0 );

    /* Inform the Tgt of the rotation matrix array to be used.
       For scan, mps2 and aps2, the sat pulses are played out
       so the sat rotation matrix needs to be used. Otherwise
       the original slice rotation matrix is used. */
    if ((rspent == L_SCAN) || (rspent == L_MPS2) || (rspent == L_APS2))
        setrotatearray((SHORT)(opslquant*opphases),rsprot[0]);
    else
        setrotatearray((SHORT)(opslquant*opphases),rsprot_orig[0]);



    pass = 0;

    if (rmode) {
        rspdda = resdda;
        rspbas = resbas;
        rspvus = resvus;
        rspnex = resnex;
        rspchp = reschp;
        rspesl = resesl;
        rspasl = resasl;
        rspech = resech;
        rspslq = resslq;
    }


    if ((rspent == L_SCAN) || (rspent == L_APS2) || (rspent == L_MPS2)) {
        setrfltrs((int)filter_echo1, &echo1);
    }    

    /* Enable readout, phase encoding, and rho */
    setieos((SHORT)EOS_PLAY, &x_td0,0);
    setieos((SHORT)EOS_PLAY, &y_td0,0);
    setieos((SHORT)EOS_PLAY, &rho_td0,0);

    /* For non center frequency entrypoints in cardiac gating,
       set cardiac delay to grad_update_time. */
    if (rspent == L_SCAN) {
        if (opcgate == PSD_ON) {
            /* return wait to td0*/
            setperiod((long)td0, &x_td0, 0);
            setperiod((long)td0, &y_td0, 0);
            setperiod((long)td0, &z_td0, 0);
            setperiod((long)td0, &rho_td0, 0);
            setperiod((long)td0, &theta_td0, 0);
            setperiod((long)td0, &ssp_td0, 0);
        } else {
            if (opcgate == PSD_ON) {
                /* Don't wait for trigger delay in prescan */
                setperiod((long)GRAD_UPDATE_TIME, &x_td0, 0);
                setperiod((long)GRAD_UPDATE_TIME, &y_td0, 0);
                setperiod((long)GRAD_UPDATE_TIME, &z_td0, 0);
                setperiod((long)GRAD_UPDATE_TIME, &rho_td0, 0);
                setperiod((long)GRAD_UPDATE_TIME, &theta_td0, 0);
                setperiod((long)GRAD_UPDATE_TIME, &ssp_td0, 0);
            }
        }
    }

    /* Initialize phase amplitudes */
    if (rspgy1 == 0)
        amp_gy1 = rsp_preview;  /* Normally rsp_preview = 0 */
    else
        amp_gy1 = -viewtable[rspgy1];

    if (nope >= 1)
    {
        amp_gy1 = 0;
    }

    setiampt(amp_gy1, &gy1, 0);
    if (rewinder_flag == PSD_ON)
        setiampt(amp_gy1, &gy1r, 0);

    exphase = 0;   /* clear SPGR exciter phase */


    /* Baseviews and disdaqs */
    baseviews = -rspbas + 1;
    disdaqs = -rspdda;

    /* *************************************
       Cross R-R Tables
       ************************************* */

    /* DAB initialization */
    dabop = 0;			/* Store data */
    dabview = 0; 
    dabecho = 0;			/* first dab packet is for echo 0 */
    dabecho_multi = -1;		/* use the autoincrement echo feature 
                                   for subsequent echos */ 
    /* AMR - FOR MT */
    if (MTMod(mt_max_index) == FAILURE)
        return FAILURE;

    CsSatMod(cs_satindex);
    SpSatInitRsp((INT)1,sp_satcard_loc, 0);

    /* Set ssi time.  This is time from eos to start of sequence interrupt
       in internal triggering.  The minimum time is 50us plus 2us*(number of
       waveform and instruction words modified in the update queue) */

    setssitime((LONG)time_ssi/HW_GRAD_UPDATE_TIME);

    if (opexor == PSD_ON || cmon_flag == PSD_ON)
        exorcist_pass_init();

%ifdef DFMONITOR
    if(dfm_flag) {
        DFMonitor_psdinit();
    }

    if(dfm_flag == PSD_ON && rspent == L_SCAN){
        DFMonitor_SetSequenceDelay(psd_seqtime, tmin, &seqcore);
    }
%endif

    return SUCCESS;
} /* End Init */

/* *******************************************************************
   CardInit
   RSP Subroutine

   Purpose:
   To create an array of deadtimes for each slice/phase of the first
   pass in a cardiac scan.  For multi-phase scans, this same array can be
   used as the slices are shuffled in each pass to obtain new phases.

   Description: The logic for creating the deadtime array for
   multiphase scans is rather simple.  All of the slices except the last
   slice have the same deadtime.  This deadtime will assure that the
   repetition time between slices equals the inter-sequence delay time.
   The last slice has a deadtime that will run the logic board until the
   beginning of the cardiac trigger window.

   The logic for creating the deadtime for single phase, or cross R-R
   scans, is much more complicated.  In these scans, the operator
   prescribes over how many R-R intervals (1-4) the slices should be
   interleaved over.  The deadtimes for the last slice in each R-R
   interval will be different depending on whether the R-R interval is
   filled, unfilled, or the last R-R interval. For example, lets say 14
   slices are to be interleaved among 4 R-R intervals.  4 slices will be
   placed in the first R-R, 4 in the second, 3 in the third, and 3 in the
   fourth.  This prescription has 2 filled R-R intervals, 1 unfilled R-R
   interval, and a final R-R interval.  The deadtimes for slices which
   are not the last slice in a R-R interval is the same deadtime that
   assures that the inter-sequence delay time is met.

   Parameters:
   (O) int ctlend_tab[]  table of deadtimes
   (I) int ctlend_intern deadtime needed to maintain intersequence delay time.
   Delay when next slice will be internally gated.
   (I) int ctlend_last   Delay time for last slice in ophrep beats.  Deadtime needed
   to get proper trigger delay for next heart beat. 
   (I) int ctlend_fill   Dead time for filled R-R interval.  Not used in multi-phase
   scans. 
   (I) int ctlend_unfill Deadtime of last slice in an unfilled R-R interval.  Not used in
   multi-phase scans.
   ******************************************************************************* */


STATUS 
CardInit(int ctlend_tab[], 
         int ctlend_intern, 
         int ctlend_last, 
         int ctlend_fill, 
         int ctlend_unfill)
{
    int rr = 0;  /* index for current R-R interval - 1 */
    int rr_end;  /* index for last slice in a R-R interval */
    int slice_cnt;       /* counter */
    int slice_quant; /* number of sequences within the pass */

    /* Check for negative deadtimes and deadtimes that don't fall
       on GRAD_UPDATE_TIME boundaries */
    if ((ctlend_intern < 0) || (ctlend_last < 0) || (ctlend_fill < 0) ||
        (ctlend_unfill < 0)) 
    {
        psdexit(EM_PSD_SUPPORT_FAILURE, 0, "","CardInit", PSD_ARG_STRING, "CardInit", 0);
    }

    ctlend_intern = RUP_GRD(ctlend_intern);
    ctlend_fill = RUP_GRD(ctlend_fill);
    ctlend_unfill = RUP_GRD(ctlend_unfill);
    ctlend_last = RUP_GRD(ctlend_last);

    /* rr_end is only used in cross R-R, single phase  scans.
       Initialize rr_end as the number of slices in the first R-R - 1 */
    rr_end = opslquant/ophrep + ((opslquant%ophrep) ? 1:0) - 1;

    if (opphases > 1)
    {
        slice_quant = opphases;
    }
    else
    {
        slice_quant = opslquant;
    }
    for (slice_cnt=0; slice_cnt < slice_quant; slice_cnt++)
    {
        if (opphases > 1)
            /* Multiphase */
        {
            if ( slice_cnt == (slice_quant - 1))
            {
                /* next slice will be cardiac gated */
                ctlend_tab[slice_cnt] = ctlend_last;
            }
            else
            {
                /* next slice will be internally gated */
                ctlend_tab[slice_cnt] = ctlend_intern;
            }
        }
        else
        {
            /* Single phase, cross R-R */
            /* Initialize as if slice is NOT the last in a R-R */
            ctlend_tab[slice_cnt] = ctlend_intern; 

            if ( slice_cnt == (opslquant - 1)) /* last slice */
            {
                ctlend_tab[slice_cnt] = ctlend_last;
            }
            else
            {
                if (opslquant <= ophrep)
                {
                    /* At most 1 slice in each R-R. Each
                       slice is the first and last in an R-R */
                    ctlend_tab[slice_cnt] = ctlend_fill;
                }
                else
                {
                    if (slice_cnt == rr_end)
                    {
                        /* This is the last slice in an R-R */
                        rr += 1; /* up the rr counter */
                        /* Decide whether to use filled deadtime or
                           unfilled deadtime. Also recalculate rr_end,
                           the index of last slice of the next R-R interval */
                        if ( rr < (opslquant%ophrep))
                        {
                            /* This is a filled R-R interval and the next
                               will be filled also. */
                            ctlend_tab[slice_cnt] = ctlend_fill;
                            rr_end += (int)(opslquant/ophrep) + 1;
                        }
                        if (rr == (opslquant%ophrep))
                        {
                            /* This R-R is filled but the next is not */
                            ctlend_tab[slice_cnt] = ctlend_fill;
                            rr_end += (int)(opslquant/ophrep);
                        }
                        if (rr > (opslquant%ophrep))
                        {
                            /* This is an unfilled R-R interval */
                            ctlend_tab[slice_cnt] = ctlend_unfill;
                            rr_end += (int)(opslquant/ophrep);
                        }
                    } /* end if slice_cnt != rr_end */
                } /* end if opslquant > ophrep */
            } /* end if slice isn`t the last slice */
        } /* end if single phase */
    } /* end for slice_cnt loop */
    return SUCCESS;
}

void 
get_spgr_phase(int *seq,int *phase)
{
    (*phase) = ((int)((float)*phase + (float)*seq*seed + 3L*fs_pi) % fs_2pi)-fs_pi;
    (*seq)++;
    return;
}


@inline Prescan.e PScore

STATUS
mps2(void) 
{
    printdbg("Greetings from MPS2", debugstate);
    boffset(off_seqcore);
    rspent = L_MPS2;
    rspdda = ps2_dda;
    rspbas = 0;
    rspvus = 30000;
    rspgy1 = 0;
    rspnex = 2;
    rspesl = -1;
    rspasl = pre_slice;
    rspslq = slquant1;
    rspsct = 0;
    if (cs_sat == 1)
        cstun = 1;
  
    psdinit();
    strcpy(psdexitarg.text_arg, "mps2");
    
    setiamp(ia_rf1, &rf1, 0);
    /* FUS - binomial pulse */
    if( PSD_ON == binomial_pulse ) {
        setiamp(ia_rf2, &rf2, 0);
    }

    /* AMR - FOR MT */
    if (opmt == 1)
        mttun = 1;
    else
        mttun = 0;

    /* change deadtime to SCAN  TR */
    setperiod(scan_deadtime, &seqcore, 0);
  
    pass = pre_pass;
    if (opcgate == PSD_ON) {
        rsp_card_intern = ctlend + scan_deadtime;
        rsp_card_last = ctlend_last + trigger_time + scan_deadtime;
        xrr_trig_time = (int)(.01 * oparr * (60.0/ophrate)* 1e6);
        rsp_card_fill   = ctlend_fill + xrr_trig_time + scan_deadtime;
        rsp_card_unfill = ctlend_unfill + xrr_trig_time + scan_deadtime;;
        CardInit(ctlend_tab, rsp_card_intern, rsp_card_last,
                 rsp_card_fill, rsp_card_unfill);

    } else
        /* change deadtime to SCAN  TR */
        setperiod(scan_deadtime, &seqcore, 0);

%ifdef DFMONITOR
    if(dfm_flag == PSD_ON && dfmprescan_flag == PSD_ON)
        DFMonitor_Core(rspnex);
    else
%endif
        core();

    printdbg("Normal End of MPS2", debugstate);
    rspexit();
    return SUCCESS;
  
} /* End MPS2 */


STATUS 
aps2(void) 
{
    printdbg("Greetings from APS2", debugstate);
    boffset(off_seqcore);
    rspent = L_APS2;
    rspdda = ps2_dda;
    rspbas = 0;
    rspvus = 1024;
    rspgy1 = 0;
    rspnex = 2;
    rspslq = slquant1;
    rspsct = -1;
    rspesl = -1;
    rspasl = -1;
    if (cs_sat == 1)
        cstun = 1;

    /* AMR - FOR MT */
    if (opmt == 1)
        mttun = 1;
    else
        mttun = 0;

    psdinit();
    strcpy(psdexitarg.text_arg, "aps2");

    setiamp(ia_rf1, &rf1, 0);
    /* FUS - binomial pulse */
    if( PSD_ON == binomial_pulse ) {
        setiamp(ia_rf2, &rf2, 0);
    }

    /* change deadtime to SCAN  TR */
    setperiod(scan_deadtime, &seqcore, 0);
  
    pass = pre_pass;

    if (opcgate == PSD_ON) {
        rsp_card_intern = ctlend + scan_deadtime;
        rsp_card_last = ctlend_last + trigger_time + scan_deadtime;
        xrr_trig_time = (int)(.01 * oparr * (60.0/ophrate)* 1e6);
        rsp_card_fill   = ctlend_fill + xrr_trig_time + scan_deadtime;
        rsp_card_unfill = ctlend_unfill + xrr_trig_time + scan_deadtime;
        CardInit(ctlend_tab, rsp_card_intern, rsp_card_last,
                 rsp_card_fill, rsp_card_unfill);
    } else
        /* change deadtime to SCAN  TR */
        setperiod(scan_deadtime, &seqcore, 0);

%ifdef DFMONITOR
    if(dfm_flag == PSD_ON && dfmprescan_flag == PSD_ON)
        DFMonitor_Core(rspnex);
    else
%endif
        core();

    printdbg("Normal End of APS2", debugstate);
    rspexit();
    return SUCCESS;
} /* End APS2 */

STATUS
cinescan(void) 
{
    maxviews = 32767;

    printdbg("Greetings from CINE scan", debugstate);
    rspent = L_SCAN;
    rspdda = dda;
    rspbas = rhbline;
    rspvus = maxviews;
    rspgy1 = 1;
    rspnex = nex;
    rspslq = slquant1;
    rspasl = -1;
    rspsct = 0;
    rspesl = -1;
    if (cs_sat == 1)
        cstun = 1;

    /* change deadtime to SCAN  TR */
    setperiod(scan_deadtime, &seqcore, 0);

    psdinit();
    strcpy(psdexitarg.text_arg, "cine");

    /* looping goes like this:
       reset cine_check bit

       for pass from 0 to # of passes-1
       for view(vu?) from 0 to # of views-1 (views is set to be large, 32767)
       clear c_check
       for excitation from 1 to nex
       for slice from 0 to # of slices-1
       check cine_collect, if 0 put in disdaq mode
       set up slice marker on first slice, otherwise clear it
       set CINE_BIT
       excite and collect
       get update of cineseqinfo
       fill and send cine DAB packet if no arrhythmia
       end
       end
       end
       send pass packet
       set up pause attribute
       end
    */

    for (pass = 0; pass < acqs; pass++) {
        if (cinecore() == FAILURE) 
            return FAILURE;

        boffset(off_seqpass);
        if (pass == (acqs -1)) { /* Last pass */
            /* Set DAB pass packet to end of scan */
            setwamp(SSPD + DABPASS + DABSCAN, &pass_pulse, 2);
            printdbg("End of Scan and Pass", debugstate);
        } else {
            /* Set DAB pass packet to end of pass */
            setwamp(SSPD + DABPASS, &pass_pulse, 2);
            printdbg("End of Pass", debugstate);
        }

        if (pass == (acqs -1))
            psdpause = MAY_PAUSE;
        else
            psdpause = AUTO_PAUSE;

        settriggerarray((SHORT)1, rsptrigger_temp);
        sp_sat_index = 0;
        startseq((SHORT)0,(SHORT)psdpause);

        if ((pass != (acqs - 1) ) && (opexor == PSD_ON || cmon_flag == PSD_ON))
        {
            exorcist_pass_init();
            setwamp(SSPD, &pass_pulse, 2);
            sp_sat_index = 0;
            startseq((SHORT)0,(SHORT)MAY_PAUSE);
        }

        /* Return to standard trigger array and core offset */
        settriggerarray((SHORT)(opslquant*opphases), rsptrigger);

        /* If this isn't the last pass and we are */
        /* doing relaxers  */
        if ((SatRelaxers)&&(pass!=(acqs-1)))
        {   /* MRIge53949 - use rotation matrix of imaging sequence during relaxer */
            setrotatearray((SHORT)(opslquant*opphases),rsprot_orig[0]);
            SpSatPlayRelaxers();
            setrotatearray((SHORT)(opslquant*opphases),rsprot[0]);
        }

        boffset(off_seqcore);
    }

    printdbg("Normal End of CINESCAN", debugstate);
    return SUCCESS;
} /* End Cine SCAN */


STATUS
cinecore(void) 
{
    seq_count = 0;		/* clear the SPGR sequence counter per 
                                   pass (actually per slice 1pass=1slice) */

    printdbg("Starting cinecore", debugstate);

    /* For Exorcist */
    cine_respview = 0;  /* Set the local view counter to zero for every acqs */

    boffset(off_seqcore);

    setwave(echo1dab, &echo1, 0);
    echo1.wave_addr = echo1dab;

    /* 
       Finish doing disaqs first before we switch to the CINE DAB packet.
       Note that turning DAB off will cause the filter select to be turned off. 
    */

    for (view=disdaqs; view<=-1; view++) { 

        loaddab(&echo1, 0, dabecho, dabop, dabview,
                (TYPDAB_PACKETS)DABOFF,PSD_LOAD_DAB_ALL);

        /* we do not know the yres_phase value yet for disdaqs, 
           so don't include here */
        /* set up spoiled gradient recalled stuff. */

        if (spgr_flag) {	
            /* get phase offset and increment seq_count */ 
            get_spgr_phase(&seq_count,&exphase);
            setiphase(exphase, &rf1, 0);
            /* FUS - binomial pulse */
            if( PSD_ON == binomial_pulse ) {
                setiphase(exphase, &rf2, 0);
            }
            setiphase(exphase, &echo1, 0);

            if (opsat == PSD_ON) {
                SpSatSPGR(exphase);
            }

            if (cs_flag == PSD_ON) {
                setiphase(exphase, &rfcssat, 0);
            }

            org_rcv_phase = exphase;
        }

        sp_sat_index = 0;

%ifdef DFMONITOR
        if ( dfm_flag == PSD_ON && rspent == L_SCAN){
            setperiod(GRAD_UPDATE_TIME+imgtodfm_tdelay,&seqcore,0);
        } 
%endif
        startseq((SHORT)psd_index, (SHORT)MAY_PAUSE);
        syncoff(&seqcore);

%ifdef DFMONITOR

        if ( dfm_flag == PSD_ON && rspent == L_SCAN){
            if(DFMonitor_Acquire(0, 0, 0, 0, 0, (TYPDAB_PACKETS) DABOFF ) == FAILURE){
                return FAILURE;
            }
            boffset(off_seqcore);
        }
%endif

        /* how are the exciter and receiver resets cleared? it should be 
           done here */
        /* Tell exorcist which slices to acquire */
        exorcist_pulse.echo[0].dab_onoff = acq_echo1;

        /* No choping during disdaqs */

    } /* End Disdaqs */

    /* Disdaqs are done - Let's switch to the CINE DAB packet for the CINE
       acquisition. Note that we have to enable the Filter Select when doing so.
       The following loaddab serves this purpose only.  */
    loaddab(&echo1, 0, 0, 0, 0, (TYPDAB_PACKETS)DABON,PSD_LOAD_DAB_ALL);

    cineupdatep();     /*   update cine pass info */

    /* Now replace regular DAB with CINE DAB */
    setwave(echo1cine, &echo1, 0); 
    echo1.wave_addr = echo1cine;

    /* Enable CINE SSI updates by setting this global flag. 
       This would have been turned off during disdaqs to prevent
       CINE SSI updates to be executed during disdaq playouts.
       - RJF */
    cineprep_mode = PSD_ON;

    /* do the scan */
    for (view=0; view<=rspvus && cine_check == PSD_OFF; view++) {

        if ((cs_sat == 1) && (rspent == L_MPS2)) {
            CsSatMod(cs_satindex);
        }

        for (excitation=1-rspdex; excitation<=rspnex && cine_check==PSD_OFF;
             excitation++) {
            rsprlx = 0;
            if(cinescanprep() == FAILURE)  {
                return FAILURE;
            }
        } /* excitation */
    } /* view */

    /* Turn Off Cine */
    loadcine(&echo1,(short)0,(short)0,
             (int)0,(short)0,
             (short)0,(short)0,
             (short)0,(int)0,
             (int)0,DABOFF);

    setwave(echo1dab, &echo1, 0);  /* Restore DAB packet */
    echo1.wave_addr = echo1dab;
    cineprep_mode = PSD_OFF;


    printdbg("returning from CINE core", debugstate);
    return SUCCESS;
}


STATUS
cinescanprep(void)
{
    printdbg("greetings.  You're now entering scanprep.",debugstate);

    /*set up triggers, scope, here */

    for (slice = 0; slice < rspslq && cine_check == PSD_OFF; slice++) {

        /* Recon is going to toss the dummy views, so they should be
           collected.  However, if in disdaq mode, turn off data 
           acquisition.  RF will be shut off later. */

        /* Determine which slice is to be excited ( find spot in
           rspinfo table). */
        if (rspesl == -1)
            psd_index = (acq_ptr[pass] + slice)%opslquant;
        else
            psd_index = acq_ptr[pass] + rspesl;

        /* if it's the first slice, hit the slice marker bit.
           otherwise, turn it off. */
        if (slice== 0) {
            getctrl(&ssp_ctrl,&ssp_td0,0);
            ssp_ctrl = ssp_ctrl | PSD_SLC_MARK;
            setctrl(ssp_ctrl,&ssp_td0,0);
        } else {
            getctrl(&ssp_ctrl,&ssp_td0,0);
            ssp_ctrl = ssp_ctrl & ~PSD_SLC_MARK;
            setctrl(ssp_ctrl,&ssp_td0,0);
        }

        /* normally this is where we'd do the phase offset stuff, 
           but we need to know the slice and view, which we don't here - 
           so phase offset is handled in the ssiupdates section for CINE */

        /* Scope Trigger */
        if ((rspsct == slice) || (rspsct == -1))
            scopeon(&seqcore);
        else
            scopeoff(&seqcore);

        /* Attenuator Locks */
        if ((view >= 1) && (rspent == L_MPS2)) {
            if ((excitation == rspnex) && (acq_sl == 1))
                attenlockoff(&attenuator_key); 
            else
                attenlockon(&attenuator_key); 
        }

        /* Load frequencies and dab information.  Recon is going to 
           discard the dummy slices, so they must be acquired.  Turn off
           RF for dummys and relaxers. */
        if ((slice >= slc_in_acq[pass]) || (rsprlx==1)) {
            /* Dummy slice */
            /* turn off RHO BOARD */
            setieos((SHORT)EOS_DEAD, &rho_td0,0);
            use_sl = 0;
            if (rspesl == -1)
                psd_index = (acq_ptr[0] + slice)%opslquant;
        } else {

            /* turn on RHO BOARD */
            setieos((SHORT)EOS_PLAY, &rho_td0, 0);

            /* Update Sat Move CATSAT Pulse */
            SpSatUpdateRsp(1, pass, opccsat);

            /* Load Transmit and Receive Frequencies */
            setfrequency(rf1_freq[psd_index], &rf1, 0);
            /* FUS - binomial pulse */
            if( PSD_ON == binomial_pulse ) {
                setfrequency(rf1_freq[psd_index], &rf2, 0);
            }
            setfrequency(receive_freq1[psd_index], &echo1, 0);
        }

        if (spgr_flag) {
            /* get phase offset and increment seq_count */ 
            /* for phase offsets, the yres_phase will be added to the 
               spoiling phase in the ssiupdates section */
            get_spgr_phase(&seq_count,&exphase);
            setiphase(exphase, &rf1, 0);
            /* FUS - binomial pulse */
            if( PSD_ON == binomial_pulse ) {
                setiphase(exphase, &rf2, 0);
            }
            setiphase(exphase, &echo1, 0);

            if (opsat == PSD_ON) {
                SpSatSPGR(exphase);
            }

            if (cs_flag == PSD_ON)
                setiphase(exphase, &rfcssat, 0);

            /* Store original receiver phase for only cine portion of scan.
               This value is not needed for disdacqs or baselines loops above.
               The receiver phase in ssi routine is changed to reverse the
               chopping in cine 2 and 4 Nex scans. */

            org_rcv_phase = exphase;
        }

        /* Do the sequence */
        printdbg("S", debugstate);
        if (cine_check == PSD_OFF) {
            sp_sat_index = psd_index;
            phaseoff_slice_index = psd_index;
%ifdef DFMONITOR
            if ( dfm_flag == PSD_ON && rspent == L_SCAN){
                setperiod(GRAD_UPDATE_TIME+imgtodfm_tdelay,&seqcore,0);
            } 
%endif

            startseq((SHORT)psd_index, (SHORT)MAY_PAUSE);
            syncoff(&seqcore);

%ifdef DFMONITOR
            if ( dfm_flag == PSD_ON && rspent == L_SCAN){
                if(DFMonitor_Acquire(0, 0, 0, 0, 0, (TYPDAB_PACKETS) DABOFF ) == FAILURE){
                    return FAILURE;
                }
                boffset(off_seqcore);
            }
%endif
        }
    }  /* slice */

    if (view == baseviews)
        dabop = 1; /* add baseviews */  

    printdbg("Returning from CINESCANPREP", debugstate);
    return SUCCESS;
} /* End cinescanprep */


STATUS
cineupdatep(void) 
{
    /* update the cine pass info */

    /* this loads up the structure 'cinepassinfo' and calls the rsp
       routine 'cineinit' which grabs the data */

    cine_check = PSD_OFF;   /* Reset the cine check for the views */
    cine_prespgroup = 1;    /* Reset the previous group */

    cinepassinfo.c_numviews = cine_nframes;
    cinepassinfo.c_curpass = pass+1;  /* Tgt needs passes to start at 1 */
    cinepassinfo.c_tr = optr;
    cinepassinfo.c_slq = rspslq;
    cinepassinfo.c_acq = acqs;

    cineinit(&cinepassinfo);
    cine_index = 0;

    return SUCCESS;
}


STATUS
scan(void) 
{
    /* all I do is switch between CINE and normal scan */
    if (cine_flag == PSD_ON)
        cinescan();
    else
        normscan();
    rspexit();

    return SUCCESS;
}


STATUS
normscan(void)
{
    int pause; /* pause attribute storage loc */

    printdbg("Greetings from SCAN", debugstate);
    boffset(off_seqcore);
    rspent = L_SCAN;
    rspdda = dda;
    rspbas = rhbline;
    rspvus = rhnframes + rhhnover + exor_osdd_vus + rhoscans;
    rspgy1 = 1;
    rspnex = nex;
    rspslq = slquant1;
    rspasl = -1;
    rspsct = 0;
    rspesl = -1;
    if (cs_sat == 1)
        cstun = 1;

    /* AMR - FOR MT */
    if (opmt == 1)
        mttun = 1;
    else
        mttun = 0;

    /* change deadtime to SCAN  TR */
    setperiod(scan_deadtime, &seqcore, 0);

    psdinit();
    strcpy(psdexitarg.text_arg, "scan");

    if (opcgate == PSD_ON) {
#ifdef ERMES_DEBUG
        /* Don't check ecg rate in simulator mode. */
#else
        if (test_getecg == 1) {
            getecgrate(&rsp_hrate);
            if (rsp_hrate == 0)
                psdexit(EM_PSD_NO_HRATE,0,"","psd scan entry point",0);
        }
#endif
        rsp_card_intern = ctlend + scan_deadtime;
        rsp_card_last   = ctlend_last + scan_deadtime;
        rsp_card_fill   = ctlend_fill + scan_deadtime;
        rsp_card_unfill = ctlend_unfill + scan_deadtime;
        CardInit(ctlend_tab, rsp_card_intern, rsp_card_last,
                 rsp_card_fill, rsp_card_unfill);
    } else
        setperiod(scan_deadtime, &seqcore, 0);

    if (opnecho>1)
        setrfltrs((int)filter_echo2, &echo2);

    if (opexor == PSD_ON || cmon_flag == PSD_ON) {
        /* set up the ssi vector */
        ssivector(ssiupdates, (short) FALSE);
#ifdef ERMES_DEBUG
        ex_sim_spu = 1;
        ex_phase_algr = 1;
#endif
    }

    for (pass = 0; pass < acqs; pass++) {

        /* AMR - FOR MT - Do disdaqs b4 new pass as in memp */
        if ( opmt == PSD_ON ) {
            rspdda = dda;
            resdda = dda;
            disdaqs = - rspdda;
        }
        core();

%ifdef DFMONITOR         
        if(dfm_flag == PSD_ON) { 
            DFMonitor_WriteLookUpTable(pass);
        }
%endif

        boffset(off_seqpass);
        if (pass == (acqs -1)) { 
            /* Last pass */
            /* Set DAB pass packet to end of scan */
            setwamp(SSPD + DABPASS + DABSCAN, &pass_pulse, 2);
            printdbg("End of Scan and Pass", debugstate);
        } else {
            /* Set DAB pass packet to end of pass */
            setwamp(SSPD + DABPASS, &pass_pulse, 2);
            printdbg("End of Pass", debugstate);
        }

        if (settriggerarray((SHORT)1, rsptrigger_temp) == FAILURE)
            return FAILURE;

        if (pass == (acqs-1))
            pause = MAY_PAUSE;
        else {
            /* if not last pass */
            if ( ( ((pass+1) % slicecnt)==0 ) &&
                 ( (mpgr_flag == PSD_OFF)||((mpgr_flag == PSD_ON)&&(pause_mpgr == PSD_ON)) ) 
                 )
                pause = MUST_PAUSE;	/* pause if desired */
            else
                pause = AUTO_PAUSE;	/* or if required */
        }

        sp_sat_index = 0;
        if (startseq((SHORT)0,(SHORT)pause) == FAILURE)
            return FAILURE;

        if ((pass != (acqs -1)) && (opexor==PSD_ON || cmon_flag == PSD_ON)) {
            exorcist_pass_init();
            setwamp(SSPD, &pass_pulse, 2);
            sp_sat_index = 0;
            startseq((short)0,(SHORT)MAY_PAUSE);
        }

        /* Return to standard trigger array and core offset */
        settriggerarray((SHORT)(opslquant*opphases), rsptrigger);

        /* If this isn't the last pass and we are */
        /* doing relaxers  */
        if ((SatRelaxers)&&(pass!=(acqs-1)))
        {   /* MRIge53949 - use rotation matrix of imaging sequence during relaxer */
            setrotatearray((SHORT)(opslquant*opphases),rsprot_orig[0]);
            SpSatPlayRelaxers();
            setrotatearray((SHORT)(opslquant*opphases),rsprot[0]);
        }

        
        boffset(off_seqcore);

        if (opmt == PSD_ON)
            setiamp(ia_rfmt, &rfmt, 0);

    } /* Pass loop */
    printdbg("Normal End of SCAN", debugstate);
    return SUCCESS;
} /* End normal SCAN */


/* AMR - FOR MT */
/* reset exciter phase for MT spoiling */
void spoil(void)
{
    if (opmt == PSD_ON) {
        mtphase = ((INT)((float)mtphase + (float)mt_count*seed + 3L*FS_PI) % FS_2PI)
            - FS_PI;
        mt_count++;
        setiphase(mtphase, &rfmt,0);
    } 
    return;
}


STATUS
core(void) 
{
    INT i;		      /* counter */
    char psddbgstr[256] = "";
    int cntvus;               /* Flag for collecting central views in oddnex */
    int temp_pass;            /* LxMGD */ 

    seq_count = 0;	      /* clear the SPGR sequence counter per
                                 pass (actually per slice 1pass=1slice) */

    printdbg("Starting Core", debugstate);

    /* begin LXMGD */
    /*
     * For LxMGD, each pass is a phase. We will have multi_phases number
     * of passes, but won't have passes * slquant1 number of slices/info
     * tables. Hacking this to make it believe that we're doing a single
     * pass scan in this core function so that all slice lookups will
     * still work.
     */
    if( PSD_ON == multiphase_flag ) {
        temp_pass = 0;
    } else {
        temp_pass = pass;
    }
    /* End ISMRM - LXMGD */

    exphasechop = 0;    /* copied from 4.x */

    for (view=disdaqs+baseviews; view<= rspvus; view++) {
        if ((cs_sat == 1) && (rspent == L_MPS2))
            CsSatMod(cs_satindex);

        /* AMR - FOR MT */
        if ((opmt == PSD_ON) && ((rspent == L_MPS2) || (rspent == L_APS2))) {
            MTMod(mt_max_index);
        }

        if ((opmt == PSD_ON) && (rspent == L_SCAN)) {
            if (view <= 0)
                MTMod(mt_max_index);
            else
                MTMod(mt_index);
        }

        if (opmt == PSD_ON) {
            spoil();
        }  
        /* AMR - END FOR MT */

        if ((view > 0) && (rspgy1 > 0)) {
            setiampt(-viewtable[view], &gy1, 0);
            if (rewinder_flag == PSD_ON)
                setiampt(-viewtable[view], &gy1r, 0);
        }

        if (nope >= 1) {
            setiampt(0, &gy1, 0);
            if (rewinder_flag == PSD_ON)
                setiampt(0, &gy1r, 0);
        }
        
        cntvus = 0; /* initialize flag for oddnex NPW */
        for (excitation=1-rspdex; excitation <= rspnex && (cntvus<1);
             excitation++) 
        {
            /* Condition to turn cntvus flag on/off. MHN */
            if ( (isNonIntNexGreaterThanOne == 1) && (rspent == L_SCAN) &&
                 (excitation == (rspnex -1)) &&
                 ((view <= (rspvus/4))|| (view > (3*rspvus/4)) ) ) 
                cntvus = 1;
            else 
                cntvus = 0;

            if (debugstate==1)
                sprintf(psddbgstr,"  Excitation=%6d",excitation);

            printdbg(psddbgstr,debugstate);


            for (slice = 0; slice < rspslq; slice++) {

                if (debugstate==1)
                    sprintf(psddbgstr,"    slice=%6d",slice);

                printdbg(psddbgstr,debugstate);

                /* Determine if this slice should be acquired */

                if ((slice == rspasl) || (rspasl == -1))
                    acq_sl = 1;
                else 
                    acq_sl = 0;

                /* Determine which slice is to be excited ( find spot in
                   rspinfo table). Remember slices and passes start at 0 */
                if (rspesl == -1)
                    psd_index = (acq_ptr[pass] + slice)%opslquant;
                else
                    psd_index = acq_ptr[pass] + rspesl;


                /* calculate the phase offset for the sliceindex and view,
                   then set exciter phase */
                yres_phase = phase_off[psd_index].ysign*(((view-1)*
                                                          phase_off[psd_index].yoffs + 3L*FS_PI)%FS_2PI-FS_PI);

                if (nope >= 1)
                    yres_phase = 0;
                
                if (opexor == PSD_OFF && cmon_flag == PSD_OFF)
                {
                    setiphase(yres_phase, &echo1, 0);  /* yres phase */
                    if (opnecho > 1) setiphase(yres_phase, &echo2, 0);
                }
                /* else we do phase offset in Exorcist.e*/

                /* Build the trigger for multi-phase, mulit-planar cardiac */
                if ((opcgate == PSD_ON) && (opphases > 1) &&
                    ((rspent == L_MPS2)||(rspent == L_APS2)||
                     (rspent == L_SCAN))) {
                    if (slice == 0) 
                        switch(rspent){
                        case L_MPS2:
                            settrigger((short)trig_mps2, (short)psd_index);
                            break;
                        case L_APS2:
                            settrigger((short)trig_aps2, (short)psd_index);
                            break;
                        case L_SCAN:
                            settrigger((short)trig_scan, (short)psd_index);
                            break;
                        default:
                            break;
                        }
                    else
                        settrigger((short)TRIG_INTERN, (short)psd_index);
                }

                /* Scope Trigger */
                if ((rspsct == slice) || (rspsct == -1))
                    scopeon(&seqcore);
                else
                    scopeoff(&seqcore);

                /* Attenuator Locks */
                if ((view>=1) && ((rspent==L_MPS2))) {
                    if ((excitation == rspnex) && (acq_sl == 1))
                        attenlockoff(&attenuator_key); 
                    else
                        attenlockon(&attenuator_key); 
                }

                /* Set cardiac delays and end times */
                if (opcgate== PSD_ON) {
                    if ((rspent == L_SCAN)||(rspent == L_MPS2) 
                        ||(rspent == L_APS2))
                        setperiod(ctlend_tab[slice],&seqcore ,0);

                    /*  Fixed XRR gating bug.                                 */
                    /*  In case of trigger_intern, x_td0 is GRAD_UPDATE_TIME. */
                    /*  Else, x_td0 = td0.                                    */
                    /*  first slice in RR */
                    if (rsptrigger[slice] != TRIG_INTERN)
                    {
                        if ((rspent == L_SCAN)||(rspent == L_MPS2) 
                            ||(rspent == L_APS2)) {
                            /* Use cardiac trigger delay */
                            setperiod((long)td0, &x_td0, 0);
                            setperiod((long)td0, &y_td0, 0);
                            setperiod((long)td0, &z_td0, 0);
                            setperiod((long)td0, &rho_td0, 0);
                            setperiod((long)td0, &theta_td0, 0);
                            setperiod((long)td0, &ssp_td0, 0);
                        }
                    }
                    else {
                        /* Bypass cardiac trigger delay */
                        setperiod((long)GRAD_UPDATE_TIME, &x_td0, 0);
                        setperiod((long)GRAD_UPDATE_TIME, &y_td0, 0);
                        setperiod((long)GRAD_UPDATE_TIME, &z_td0, 0);
                        setperiod((long)GRAD_UPDATE_TIME, &rho_td0, 0);
                        setperiod((long)GRAD_UPDATE_TIME, &theta_td0, 0);
                        setperiod((long)GRAD_UPDATE_TIME, &ssp_td0, 0);
                    }
                }

                /* MRIge42775 - CMC */
                /* turn on RHO BOARD unless this is a noise acquisition */
                if (do_noise) {
                    rfoff(&rf1,0);
                    /* FUS - binomial pulse */
                    if( PSD_ON == binomial_pulse ) {
                        rfoff(&rf2,0);
                    }
                } else {
                    /* To recover in case we did noise just before */
                    rfon(&rf1,0);
                    /* FUS - binomial pulse */
                    if( PSD_ON == binomial_pulse ) {
                        rfon(&rf2,0);
                    }
                }

                /* Load frequencies and dab information */
                if (slice >= slc_in_acq[temp_pass]) {
                    /* Dummy slice */
                    acq_echo1 = (INT)DABOFF;
                    acq_echo2 = (INT)DABOFF;
                    /* turn off RHO BOARD */
                    setieos((SHORT)EOS_DEAD, &rho_td0,0);
                    use_sl = 0;
                    if (rspesl == -1)
                        psd_index = (acq_ptr[0] + slice)%opslquant;
                } else {
                    if ((acq_sl == 1)&&(view >= baseviews)&&(excitation > 0)) {
                        acq_echo1 = (INT)DABON;
                        /* Acquire 2nd echo if in scan or rspech is active. */
                        if ((rspent == L_SCAN) || (rspech == 1))
                            acq_echo2 = (INT)DABON;
                        else
                            acq_echo2 = (INT)DABOFF;
                    } else {
                        acq_echo1 = (INT)DABOFF;
                        acq_echo2 = (INT)DABOFF;
                    }
                    /* turn on RHO BOARD */
                    setieos((SHORT)EOS_PLAY, &rho_td0, 0);
                    use_sl = 1;

                    /* Load Transmit and Receive Frequencies */

                    if (debugstate==1) {
                        /* For debugging OCFOV */
                        sprintf(psddbgstr,
                                "\tTf= %d, Rf= %d ->rsp_info[%d].rsploc= %f",
                                rf1_freq[psd_index],receive_freq1[psd_index],
                                psd_index,rsp_info[psd_index].rsprloc);
                        printdbg(psddbgstr,debugstate);
                    }


                    /* Update Sat Move CATSAT Pulse */
                    SpSatUpdateRsp(1, temp_pass, opccsat);

                    setfrequency(rf1_freq[psd_index], &rf1, 0);
                    /* FUS - binomial pulse */
                    if( PSD_ON == binomial_pulse ) {
                        setfrequency(rf1_freq[psd_index], &rf2, 0);
                    }
                    setfrequency(receive_freq1[psd_index], &echo1, 0);
                    if (opnecho > 1)
                        setfrequency(receive_freq2[psd_index],&echo2,0);
                }

                /* Tell exorcist which slices to acquire */
                exorcist_pulse.echo[0].dab_onoff = acq_echo1;
                for (i=1;i<opnecho;i++)
                    exorcist_pulse.echo[i].dab_onoff = acq_echo2;

                if (view > 0) {
                    dabview = view;
                    if (excitation == 1)
                        dabop = 0;
                    /* dabop control for oddnex. MHN */
                    else if ( (isOddNexGreaterThanOne==1) || (isNonIntNexGreaterThanOne==1) )
                        dabop = 1;
                    else
                        dabop = 3 - 2*(excitation % 2);
                } else 
                {
                    dabview = 0;
                    if (view == baseviews)
                        dabop = 0;
                    else if (view > baseviews)
                        dabop =   1;
                }

                /* All DAB Info is Set, Load it Up ! */
%ifdef DFMONITOR
                loaddabwithnex(&echo1, excitation, slice, dabecho, dabop, dabview,
                               (TYPDAB_PACKETS)acq_echo1,PSD_LOAD_DAB_ALL);
%else
                loaddab(&echo1, slice, dabecho, dabop, dabview,
                        (TYPDAB_PACKETS)acq_echo1,PSD_LOAD_DAB_ALL);
%endif

                if (opnecho > 1) 
%ifdef DFMONITOR
                    loaddabwithnex(&echo2, excitation, slice, dabecho_multi, dabop, dabview,
                                   (TYPDAB_PACKETS)acq_echo2,PSD_LOAD_DAB_ALL);
%else
                loaddab(&echo2, slice, dabecho_multi, dabop, dabview,
                        (TYPDAB_PACKETS)acq_echo2,PSD_LOAD_DAB_ALL);
%endif

                if (spgr_flag == PSD_ON) {
                    /* get phase offset and increment seq_count */ 
                    get_spgr_phase(&seq_count,&exphase);
                    setiphase(exphase, &rf1, 0);
                    /* FUS - binomial pulse */
                    if( PSD_ON == binomial_pulse ) {
                        setiphase(exphase, &rf2, 0);
                    }
                    /* When we aren't in cine we know the yres_phase and add
                       it to the receiver now. */
                    if (opexor == PSD_OFF && cmon_flag == PSD_OFF)
                        rcphase = (exphase + yres_phase + 4L*FS_PI)%FS_2PI - FS_PI;
                    else
                        rcphase = exphase;
                    setiphase(rcphase, &echo1, 0);

                    if (opsat == PSD_ON) {
                        SpSatSPGR(exphase);
                    }

                    if (cs_flag == PSD_ON)
                        setiphase(exphase, &rfcssat, 0);
                    if (opnecho > 1) 
                        setiphase(rcphase, &echo2, 0);

                    org_rcv_phase = rcphase;
                }

                sp_sat_index = psd_index;

%ifdef DFMONITOR
                if ( dfm_flag == PSD_ON && rspent == L_SCAN){
                    setperiod(GRAD_UPDATE_TIME+imgtodfm_tdelay,&seqcore,0);
                } 
%endif

                /* Do the sequence */
                printdbg("      Before startseq", debugstate);
                startseq((short)psd_index, (SHORT)MAY_PAUSE);
                printdbg("      After startseq", debugstate);
                syncoff(&seqcore);

                /* MRIge61907: call this function before the DFM sequence */
                if (opexor == PSD_ON || cmon_flag == PSD_ON)
                {
                    ExorUpdate();
                    exor_check_status();
                }

%ifdef DFMONITOR
                if ( dfm_flag == PSD_ON && rspent == L_SCAN) {
                    if(DFMonitor_RTPAcquire(slc_in_acq[pass], slice, dabecho, dabview, 
                                            excitation, (TYPDAB_PACKETS) acq_echo1 ) == FAILURE){
                        return FAILURE;
                    }
                    boffset(off_seqcore);
                }
%endif

                /* FUS */
                if( ext_trig && (rspent == L_SCAN) && (slice == 0) && (view == (disdaqs + baseviews)) ) {
                    rsptrigger[0] = trig_scan;
                    settriggerarray( (SHORT)(opslquant * opphases), rsptrigger );
                }
            }  /* slice */


            /* Chopper logic with no Odd Nex. MHN */
            /* rspchp selections
               CHOP_ALL, CHOP_NONE, CHOP_BL */
            if (vwchp == PSD_OFF)
            {
                if ((rspchp == CHOP_ALL) || (view < 1)) 
                {
                    if (rspchp !=CHOP_NONE) 
                    {
                        if (mpgr_flag == PSD_ON) 
                        {
                            exphasechop = (-1)*((INT)((float)exphasechop 
                                                      + 3*fs_pi)%(INT)fs_2pi);
                            setiphase(exphasechop, &rf1, 0);
                            /* FUS - binomial pulse */
                            if( PSD_ON == binomial_pulse ) {
                                setiphase(exphasechop, &rf2, 0);
                            }
                        } 
                        else 
                        {            
                            getiamp(&temp_short, &rf1, 0);
                            setiamp(-temp_short, &rf1, 0);
                            /* FUS - binomial pulse */
                            if( PSD_ON == binomial_pulse ) {
                                setiamp(-temp_short, &rf2, 0);
                            }
                        }   
                    }
                }
            }
            if (view < 1)		/* Skip excitation loop for disdaqs */
                break;		/* and baseviews */ 

            if (debugstate==1)
                sprintf(psddbgstr,"View=%6d",view);

            printdbg(psddbgstr,debugstate);

        } /* excitation */

        if (vwchp == PSD_ON) 
        {

            if ((rspchp == CHOP_ALL) || (view < 1)) 
            {
                if (rspchp != CHOP_NONE) 
                {
                    if (mpgr_flag == PSD_ON) 
                    {
                        exphasechop = (-1)*((INT)((float)exphasechop 
                                                  + 3*fs_pi)%(INT)fs_2pi);
                        setiphase(exphasechop, &rf1, 0);
                        /* FUS - binomial pulse */
                        if( PSD_ON == binomial_pulse ) {
                            setiphase(exphasechop, &rf2, 0);
                        }
                    } 
                    else 
                    {            
                        getiamp(&temp_short, &rf1, 0);
                        setiamp(-temp_short, &rf1, 0);
                        /* FUS - binomial pulse */
                        if( PSD_ON == binomial_pulse ) {
                            setiamp(-temp_short, &rf2, 0);
                        }
                    }   
                }
            }
        }
    } /* view */
    printdbg("Returning from CORE", debugstate);
    return SUCCESS;
} /* End Core */

/* AMR - FOR MT */
@inline MagTransfer.e MTMod

@inline ChemSat.e CsSatMod
@inline SpSat.e SpSatInitRsp 
@inline SpSat.e SpSatUpdateRsp
@inline SpSat.e SpSatSPGR


/********************************************
 * dummylinks
 *
 * This routine just pulls in routines from
 * the archive files by making a dummy call.
 ********************************************/
void dummylinks()
{
    epic_loadcvs( "thefile" );            /* for downloading CVs */
}

/************************** END OF 2DFAST.E ******************************/


