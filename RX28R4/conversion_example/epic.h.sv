/*
 * Copyright 2017 General Electric Company.  All rights reserved.
 */
 
/*
 *****************************************************************************
   Source: epic.h
   
   @Synopsis

   This is the master interface file for Signa Software.

   @Description

   This file includes the definitions of the required CVs,
   required host export and target export variables that are
   shared across Signa System Software modules as well as the types,
   sizes, and value definitions required by or used with the variables.

   epic.h also contains 

   a. Common EPIC Macros to be used by PSDs. 
   b. Control Variables commonly used across PSDs.
   c. Data Structures and Constants common to the host and runtime (tgt)
      PSD modules.

   These sections are provided in self contained EPIC header modules:
   @global (epic_global.eh) for type and macro definitions to be shared
   among PSDs and/or with external Host or Target (runtime) processes
   via derived headers
   @revision (epic_cvconst.eh) to identify unique sets of content (name,
   type, order) in the @reqcv and @reqexport sections
   @reqcv (epic_cvconst.eh) for CVs (structure wrappers for controlling
   primitive types) required for communication with Host processes via
   generated CV IDs (cv_const.h)
   @reqexport (epic_cvconst.eh) for complex types and other primitives
   not allowed by CV structures directly (unsigned, long long, etc.)
   that are required for communication with Host processes.
   @cv (epic_commoncv.eh) for CVs used across sets of PSDs but not
   required for communication with non-PSD processes
   @ipgexport (epic_ipgexport.eh) for complex variables that need to
   be conveyed from the host PSD to the target (runtime) PSD via
   serialization/deserialization
   @rspvar (epic_rspvar.eh) for runtime variable used across sets of PSDs
   @pulsedef (epic_pulsedef.eh) for definitions of pulse definition
   macros (EPIC)

   Guidelines: 
   -----------

   One MUST NOT add new EPIC sections (@reqcv, @reqexport, @ipgexport,
   @global, @cv, @pulsedef, @rsp, @rspvar).

   Information should be added via inlined EPIC header files and not
   added directly to epic.h. New inlines are allowed as long as the
   inline file contains the correct EPIC directive as given above.
   Adding new files or new sections of existing files containing the
   directives @reqcv or @reqexport is prohibited since ordering and
   order of processing is critical to correct communication.
   Modification of the existing inlined files is the preferred mechanism.

   Addition of new reqcvs, reqexports and ipgexports MUST be done in the
   already existing section appropriately. See the comments in
   epic_cvconst.eh for guidance on updating the revision number.

   Note: 
   ----

   This file is intended to be modified only by GE.
   Modification of this file may result in inoperabale PSDs.
 
   @Comments

*/

#if !defined(IPG_TGT) && !defined(MGD_TGT) && !defined(HOST_TGT)
#error Missing Target Specification.  Expecting IPG_TGT, MGD_TGT, or HOST_TGT.
#endif

@inline epic_global.eh

@inline epic_cvconst.eh

@inline epic_commoncv.eh

@inline epic_ipgexport.eh

@inline epic_rspvar.eh

@inline epic_pulsedefs.eh

/* Keep the below one as the last line of epic.h for syntax check in EPIC IDE */
@global
