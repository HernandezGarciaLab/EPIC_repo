/*
 *  umsp2a.global.h
 *
 *  Do not edit this file. It is automatically generated by EPIC.
 *
 *  Date : Mar 18 2021
 *  Time : 22:18:04
 */

#ifndef h_umsp2a_global_h
#define h_umsp2a_global_h

/*
 * global
 * Globally used definitions
 * These are shared between host and target compilation
 * Items used in this section are candidates for serialization
 * and as such will introduce endian conversion code
 */

#include "acquisition_control.h"
#include "ca_filt.h"
#include "CoilParameters.h"
#include "coilsupportDefs.h"
#include "config_platform_hw.h"
#include "dabrecord_common.h"
#include "entrypttab.h"
#include "epic_advisory_panel.h"
#include "epic_algorithm_control.h"
#include "epic_application_ranges.h"
#include "epic_anatomy.h"
#include "epic_entry_points.h"
#include "epic_geometry_types.h"
#include "epic_hw_defs.h"
#include "epic_ifcc_sizes.h"
#include "epic_pulse_structs.h"
#include "epic_recon_control.h"
#include "epic_regulatory.h"
#include "epic_rsp_sizes.h"
#include "epic_sar_communication.h"
#include "epic_slice_order_types.h"
#include "epic_ssp_defs.h"
#include "epic_system_defs.h"
#include "epic_ui_control.h"
#include "epic_usercv.h"
#include "epic_waveform_types.h"
#include "filter_defs.h"
#include "GElimits.h"
#include "GEtypes.h"             /* type definitions from GEtypes project*/
#include "gradient_pulse_types.h"
#include "gradSpec.h"
#include "hoec_defines.h"  /* HOEC */
#include "IfccPSDShared.h"
#include "log_grad_struct.h"
#include "op_recn.h"
#include "pgen_epic.h"
#include "physics_constants.h"
#include "physioHwDefs.h"
#include "prescan_defs.h"
#include "psdexitarg.h"
#include "recon_filter_defs.h"
#include "ReconHostPSDShared.h"
#include "round_int_macros.h"
#include "seqCfg.h"
#include "slice_factor.h"  
#include "supp_macros.h"
#include "transmit_chain.h"
#include "usage_tag.h"

/*
 * Miscellaneous entries. Candidates for relocation to other, more
 * specific headers.
 */
#include "psd_common_global_includes.h"

/*
 * Copyright 2019 General Electric Company.  All rights reserved.
 */

/*
 * epic_cvconst.eh
 *
 * This EPIC source file declares the variables used to communicate
 * between host applications (scn, ifcc, psc, etc) and PSDs.  This file
 * is used to generate "cv_const.h" which assigns an integer for use
 * in referencing each CV fromi many psdIF APIs.  Therefore, it is 
 * critical that the variable names and order match between the PSD and
 * host applications.  The @revision must be changed accordingly as
 * indicated below.
 *
 * This file is included in epic.h
 *
 */

/*
 * A revision number change is mandatory when variables are added to or
 * removed from @reqcv.  A revision number change is also mandatory when
 * variables ared added to or removed from @reqexport unless a variable
 * is added at to end, in which case a revision number change is
 * not necessary for testing purposes.  
 */

/*
 * Do not insert new @ EPIC directives in this file!
 */

/* Macro to make a nice gradient pulse
 *	waveform is passed to macro
 *
 * rev 0	1/23/99	
 * rev 1	10/22/00	allows reverse load (negate wave)
 */

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

#define GRESMAX       21000     /* number of points grad max */
#define RES_GRAMP       100     /* number of points grad rampdown  */
#define TSP             2.0     /* slow rcvr sampling 500kHz */
#define MAX_BW		250
#define IRINT(f) ((((f)-(int)(f)) < 0.5) ? ((int) (f)) : (1+(int)(f)))

/*********************************************************************
 *                    PRESCAN.E GLOBAL SECTION                       *
 *                            PSglobal                               *
 *                                                                   *
 * Common code shared between the Host and Tgt PSD processes.  This  *
 * section contains all the #define's, global variables and function *
 * declarations (prototypes).                                        *
 *********************************************************************/
#include "Prescan.h"

#include <stdio.h>
#include <sysDep.h>
#include <sysDepSupport.h>

#include "dynTG_sliceloc.h"

#define amp_killer 0.4
#define pw_killer 3600 
#define FA_FERMI_BLS 630

/* defines for pimrsaps CVs from op_prescan.h */
#define MRSAPS_OFF 0
#define MRSAPS_CFL 1
#define MRSAPS_TG 2
#define MRSAPS_VTG 2
#define MRSAPS_CFH 3
#define MRSAPS_TR 4
#define MRSAPS_FSEPS 9
#define MRSAPS_RCVN 12
#define MRSAPS_RFSHIM 13 
#define MRSAPS_DYNTG 14
#define MRSAPS_CAL 15 
#define MRSAPS_AUTOCOIL 16
#define MRSAPS_AWS 101
#define MRSAPS_AVS 102
#define MRSAPS_AS  103
#define MRSAPS_FTG 104
#define MRSAPS_XTG 116
#define MRSAPS_XTG_SPINE 117

/* defines for cfh_ti */
#define CFHTI_1HT 120000
#define CFHTI_3T  190000
#define CFHTI_7T  270000
#define CFHTE_1HT 50000
#define CFHTE_3T  30000
#define CFHTE_7T  25000
#define PSD_ISI_CFH (PSD_ISI0_BIT | PSD_ISI1_BIT)
#define PSCFH_SHIMVOL_DEBUG_X 1
#define PSCFH_SHIMVOL_DEBUG_Y 2
#define PSCFH_SHIMVOL_DEBUG_Z 4
#define PSCFH_SHIMVOL_DEBUG_NONE 0

#define PH_SEQUENTIAL   0 
#define PH_CENTRIC_LOW  1 
#define PH_CENTRIC_HIGH 2 
#define RFSHIM_SLQ 1 
#define DYNTG_SLQ  5
#define MAPTG_SLQ 1

#define B1RF1_SINC 0
#define B1RF1_TBW  1

#define MINFOV_TG 60.0 

/* defines for rcvn_filter */
#define RCVN_MIN_BW  4.0
#define RCVN_MAX_BW  62.5
#define RCVN_MIN_TR  250000

/* defines for Cal */
#define CAL_NONE_INTERLEAVED 0 
#define CAL_TR_INTERLEAVED 1 
#define CAL_NEX_INTERLEAVED 2 

/** Convert from microTesla to Gauss */
#define UTESLA2GAUSS 0.01

#define TR_PSCPASS  100000

int debugstate = 1;


#endif /* h_umsp2a_global_h */

