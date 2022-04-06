typedef int ptrdiff_t;
typedef unsigned int size_t;
typedef long int wchar_t;
typedef signed char int8_t;
typedef short int int16_t;
typedef int int32_t;
__extension__
typedef long long int int64_t;
typedef unsigned char uint8_t;
typedef unsigned short int uint16_t;
typedef unsigned int uint32_t;
__extension__
typedef unsigned long long int uint64_t;
typedef signed char int_least8_t;
typedef short int int_least16_t;
typedef int int_least32_t;
__extension__
typedef long long int int_least64_t;
typedef unsigned char uint_least8_t;
typedef unsigned short int uint_least16_t;
typedef unsigned int uint_least32_t;
__extension__
typedef unsigned long long int uint_least64_t;
typedef signed char int_fast8_t;
typedef int int_fast16_t;
typedef int int_fast32_t;
__extension__
typedef long long int int_fast64_t;
typedef unsigned char uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned int uint_fast32_t;
__extension__
typedef unsigned long long int uint_fast64_t;
typedef int intptr_t;
typedef unsigned int uintptr_t;
__extension__
typedef long long int intmax_t;
__extension__
typedef unsigned long long int uintmax_t;
typedef char s8;
typedef unsigned char n8;
typedef int16_t s16;
typedef uint16_t n16;
typedef long s32;
typedef unsigned long n32;
typedef int64_t s64;
typedef uint64_t n64;
typedef float f32;
typedef double f64;
struct EXT_CERD_PARAMS
{
  s32 alg;
  s32 demod;
} ;
typedef struct {
  f64 filfrq;
  struct EXT_CERD_PARAMS cerd;
  s32 taps;
  s32 outputs;
  s32 prefills;
  s32 filter_slot;
} PSD_FILTER_GEN;
typedef struct CTMEntry
{
   n8 receiverID;
   n8 receiverChannel;
   n16 entryMask;
} CTMEntryType;
typedef struct QuadVolWeight
{
    n8 receiverID;
    n8 receiverChannel;
    n8 pad[2];
    f32 recWeight;
    f32 recPhaseDeg;
} QuadVolWeightType;
typedef struct CTTEntry
{
    s8 logicalCoilName[128];
    s8 clinicalCoilName[32];
    n32 configUID;
    n32 coilTypeMask;
    n32 isActiveScanConfig;
    CTMEntryType channelTranslationMap[256];
    QuadVolWeightType quadVolReceiveWeights[16];
    n32 numChannels;
} ChannelTransTableEntryType;
enum
{
    COIL_CONNECTOR_A,
    COIL_CONNECTOR_P1,
    COIL_CONNECTOR_P2,
    COIL_CONNECTOR_P3,
    COIL_CONNECTOR_P4,
    COIL_CONNECTOR_P5,
    NUM_COIL_CONNECTORS,
    NUM_COIL_CONNECTORS_PADDED = 8,
    COIL_CONNECTOR_PORT0 = COIL_CONNECTOR_A,
    COIL_CONNECTOR_PORT1 = COIL_CONNECTOR_P1,
    COIL_CONNECTOR_PORT2 = COIL_CONNECTOR_P2,
    COIL_CONNECTOR_PORT3 = COIL_CONNECTOR_P3,
    COIL_CONNECTOR_PORT4 = COIL_CONNECTOR_P4,
    COIL_CONNECTOR_PORT5 = COIL_CONNECTOR_P5,
    COIL_CONNECTOR_MCRV = NUM_COIL_CONNECTORS,
    NUM_COIL_CONNECTORS_INC_MCRV = NUM_COIL_CONNECTORS + 1
};
enum
{
    COIL_CONNECTOR_MNS_LEGACY_TOP,
    COIL_CONNECTOR_C_LEGACY_BOTTOM,
    COIL_CONNECTOR_PORT_A,
    COIL_CONNECTOR_PORT_B,
    NUM_COIL_CONNECTORS_PRE_HDV
};
enum
{
    COIL_STATE_UNKNOWN,
    COIL_STATE_DISCONNECTED,
    COIL_STATE_CONNECTED,
    COIL_STATE_ID,
    COIL_STATE_COMPLETE,
    NUM_COIL_STATES
};
enum
{
    COIL_INVALID,
    COIL_VALID,
    NUM_COIL_VALID_VALUES
};
enum
{
    COIL_TYPE_TRANSMIT,
    COIL_TYPE_RECEIVE,
    NUM_COIL_TYPE_VALUES
};
enum
{
    BODY_TRANSMIT_DISABLE,
    BODY_TRANSMIT_ENABLE,
    NUM_BODY_TRANSMIT_ENABLE_VALUES
};
enum
{
    TRANSMIT_SELECT_NONE,
    TRANSMIT_SELECT_A,
    TRANSMIT_SELECT_P1,
    TRANSMIT_SELECT_LEGACY_HEAD,
    TRANSMIT_SELECT_LEGACY_MC,
    TRANSMIT_SELECT_1MNS,
    NUM_TRANSMIT_SELECTS
};
enum
{
    MNS_CONVERTER_SELECT_NONE = 0x00000000,
    MNS_CONVERTER_SELECT_A = 0x00000001,
    MNS_CONVERTER_SELECT_MASK = 0x00000001,
};
enum
{
    COIL_ID_TYPE_REQUIRED = 0,
    COIL_ID_TYPE_PRESENCE_ONLY = 1,
    COIL_ID_TYPE_NOT_REQUIRED = 2,
    NUM_COIL_ID_TYPES
};
enum
{
    COIL_INT_FAULT_CHECK_UNSUPPORTED,
    COIL_INT_FAULT_CHECK_SUPPORTED,
    NUM_COIL_INT_FAULT_CHECK_TYPES
};
typedef struct
{
    n32 receiverID;
    n32 connectorStartCh;
    n32 receiverStartCh;
    n32 numChannels;
} CPRM_ENTRY_TYPE;
typedef struct
{
    n32 numCprmEntries;
    n32 pad;
    CPRM_ENTRY_TYPE coilPortReceiverMap[2];
} CPRM_TYPE;
typedef struct
{
    CPRM_TYPE cprm[NUM_COIL_CONNECTORS];
} COIL_PORTS_RX_MAPS_TYPE;
enum {
    TX_POS_BODY,
    TX_POS_HEAD,
    TX_POS_EXTREMITY,
    TX_POS_XIPHOID,
    TX_POS_STERN,
    TX_POS_BREAST,
    TX_POS_HEAD_XIPHOID,
    TX_POS_HEAD_BODY,
    TX_POS_NECK,
    NUM_TX_POSITIONS
};
enum
{
    NORMAL_COIL,
    F000_COIL,
    FG00_COIL,
    P000_COIL,
    PG00_COIL,
    R000_COIL,
    SERV_COIL
};
typedef struct _INSTALL_COIL_INFO_
{
    char coilCode[(32 + 8)];
    int isInCoilDatabase;
}INSTALL_COIL_INFO;
typedef struct _INSTALL_COIL_CONNECTOR_INFO_
{
    int connector;
    int needsInstall;
    INSTALL_COIL_INFO installCoilInfo[4];
}INSTALL_COIL_CONNECTOR_INFO;
typedef struct coil_config_params
{
    char coilName[16];
    char GEcoilName[24];
    short pureCorrection;
    int maxNumOfReceivers;
    int coilType;
    int txCoilType;
    int fastTGmode;
    int fastTGstartTA;
    int fastTGstartRG;
    int nuclide;
    int tRPAvolumeRecEnable;
    int pureCompatible;
    int aps1StartTA;
    int cflStartTA;
    int cfhSensitiveAnatomy;
    float pureLambda;
    float pureTuningFactorSurface;
    float pureTuningFactorBody;
    float cableLoss;
    float coilLoss;
    float reconScale;
    float autoshimFOV;
    float coilWeights[4][256];
    ChannelTransTableEntryType cttEntry[4];
} COIL_CONFIG_PARAM_TYPE;
typedef struct application_config_param_type
{
    int aps1StartTA;
    int cflStartTA;
    int AScfPatLocChangeRL;
    int AScfPatLocChangeAP;
    int AScfPatLocChangeSI;
    int TGpatLocChangeRL;
    int TGpatLocChangeAP;
    int TGpatLocChangeSI;
    int autoshimFOV;
    int fastTGstartTA;
    int fastTGstartRG;
    int fastTGmode;
    int cfhSensitiveAnatomy;
    int aps1Mod;
    int aps1Plane;
    int pureCompatible;
    int maxFOV;
    int assetThresh;
    int scic_a_used;
    int scic_s_used;
    int scic_c_used;
    float aps1ModFOV;
    float aps1ModPStloc;
    float aps1ModPSrloc;
    float opthickPSMod;
    float pureScale;
    float pureCorrectionThreshold;
    float pureLambda;
    float pureTuningFactorSurface;
    float pureTuningFactorBody;
    float scic_a[7];
    float scic_s[7];
    float scic_c[7];
    int assetSupported;
    float assetValues[3];
    int arcSupported;
    float arcValues[3];
    int sagCalEnabled;
    int scenicEnabled;
    float slice_down_sample_rate;
    float inplane_down_sample_rate;
    int num_levels_max;
    int num_iterations_max;
    float convergence_threshold;
    int gain_clamp_mode;
    float gain_clamp_value;
} APPLICATION_CONFIG_PARAM_TYPE;
typedef struct application_config_hdr
{
    int error;
    char clinicalName[32];
    APPLICATION_CONFIG_PARAM_TYPE appConfig;
} APPLICATION_CONFIG_HDR;
typedef struct {
    s8 coilName[32];
    s32 txIndexPri;
    s32 txIndexSec;
    n32 rxCoilType;
    n32 hubIndex;
    n32 rxNucleus;
    n32 aps1Mod;
    n32 aps1ModPlane;
    n32 coilSepDir;
    s32 assetCalThreshold;
    f32 aps1ModFov;
    f32 aps1ModSlThick;
    f32 aps1ModPsTloc;
    f32 aps1ModPsRloc;
    f32 autoshimFov;
    f32 assetCalMaxFov;
    f32 maxB1Rms;
    n32 pureCompatible;
    f32 pureLambda;
    f32 pureTuningFactorSurface;
    f32 pureTuningFactorBody;
    n32 numChannels;
    f32 switchingSpeed;
} COIL_INFO;
typedef struct {
    s32 coilAtten;
    n32 txCoilType;
    n32 txPosition;
    n32 txNucleus;
    n32 txAmp;
    f32 maxB1Peak;
    f32 maxB1Squared;
    f32 cableLoss;
    f32 coilLoss;
    f32 reflCoeffSquared[10];
    f32 reflCoeffMassOffset;
    f32 reflCoeffCurveType;
    f32 exposedMass[8];
    f32 lowSarExposedMass[8];
    f32 jstd[12];
    f32 meanJstd[12];
    f32 separationStdev;
} TX_COIL_INFO;
typedef struct _psd_coil_info_
{
    COIL_INFO imgRcvCoilInfo[10];
    COIL_INFO volRcvCoilInfo[10];
    COIL_INFO fullRcvCoilInfo[10];
    TX_COIL_INFO txCoilInfo[5];
    int numCoils;
} PSD_COIL_INFO;
enum
{
    CFG_VAL_APS_NOT_PRESENT = 0,
    CFG_VAL_APS_PRESENT = 1
};
enum
{
    CFG_VAL_CFB_NOT_PRESENT = 0,
    CFG_VAL_CFB_PRESENT = 1
};
enum
{
    CFG_VAL_RCV_SWITCH_16_CH_SWITCH = 0,
    CFG_VAL_RCV_SWITCH_8_CH_SWITCH = 1,
    CFG_VAL_RCV_SWITCH_MEGASWITCH = 2,
    CFG_VAL_RCV_SWITCH_RF_HUB = 3,
    CFG_VAL_RCV_SWITCH_NONE = 4
};
enum
{
    CFG_VAL_RECEIVER_DCERD = 0,
    CFG_VAL_RECEIVER_RRF = 1,
    CFG_VAL_RECEIVER_RRX = 2,
    CFG_VAL_RECEIVER_DPP = 3
};
enum
{
    CFG_VAL_SRI_SERIAL = 0,
    CFG_VAL_SRI_CAN = 1
};
enum
{
    CFG_VAL_TNS_UTNS = 0,
    CFG_VAL_TNS_TDM = 1
};
enum
{
    CFG_VAL_DACQ_DRF = 0,
    CFG_VAL_DACQ_VRF = 1,
    CFG_VAL_DACQ_IVRF = 2
};
enum
{
    CFG_VAL_HEC_NOT_PRESENT = 0
};
enum
{
    CFG_VAL_DV_CABINET = 0,
    CFG_VAL_ISC_CABINET = 1,
    CFG_VAL_HD_CABINET = 2,
    CFG_VAL_CABINET_TYPE_MAX_NUM
};
enum
{
    CFG_VAL_ONEWIRE_NET_ENV_MON_ONLY = 0,
    CFG_VAL_ONEWIRE_NET_PHPS = 1
};
enum
{
    CFG_VAL_SSC_TYPE_MGD = 0,
    CFG_VAL_SSC_TYPE_ICE = 1,
    CFG_VAL_SSC_TYPE_MAX_NUM = 2
};
enum
{
    CFG_VAL_ICE_CAN_FIBER_DISABLED = 0,
    CFG_VAL_ICE_CAN_FIBER_ENABLED = 1
};
enum
{
    CFG_VAL_TERMSERVER_NOT_PRESENT = 0,
    CFG_VAL_TERMSERVER_PRESENT = 1
};
enum
{
    CFG_VAL_FIELDSTRENGTH_0_0T = 0,
    CFG_VAL_FIELDSTRENGTH_0_35T = 3500,
    CFG_VAL_FIELDSTRENGTH_0_70T = 7000,
    CFG_VAL_FIELDSTRENGTH_1_0T = 10000,
    CFG_VAL_FIELDSTRENGTH_1_5T = 15000,
    CFG_VAL_FIELDSTRENGTH_3_0T = 30000,
    CFG_VAL_FIELDSTRENGTH_7_0T = 70000
};
enum
{
    CFG_VAL_SRPS_NOT_PRESENT = 0,
    CFG_VAL_SRPS_OR_ESRPS = 1
};
enum
{
    CFG_ESTOP_TYPE_SMC = 0,
    CFG_ESTOP_TYPE_EXT = 1,
    CFG_ESTOP_TYPE_MAX_NUM = 2
};
enum
{
    CFG_VAL_PTX_NOT_CAPABLE = 0,
    CFG_VAL_PTX_CAPABLE = 1
};
enum
{
    CFG_VAL_DPP_TYPE_GEN1 = 0,
    CFG_VAL_DPP_TYPE_GEN2 = 1,
    CFG_VAL_DPP_TYPE_NUM_TYPES
};
enum
{
    CFG_VAL_BODYCOIL_TYPE_0 = 0,
    CFG_VAL_BODYCOIL_TYPE_1 = 1,
    CFG_VAL_BODYCOIL_TYPE_2 = 2,
    CFG_VAL_BODYCOIL_TYPE_3 = 3,
    CFG_VAL_BODYCOIL_TYPE_4 = 4,
    CFG_VAL_BODYCOIL_TYPE_5 = 5,
    CFG_VAL_BODYCOIL_TYPE_6 = 6,
    CFG_VAL_BODYCOIL_TYPE_7 = 7,
    CFG_VAL_BODYCOIL_TYPE_8 = 8,
    CFG_VAL_BODYCOIL_TYPE_9 = 9,
    CFG_VAL_BODYCOIL_TYPE_10 = 10,
    CFG_VAL_BODYCOIL_TYPE_11 = 11,
    CFG_VAL_BODYCOIL_TYPE_12 = 12,
    CFG_VAL_BODYCOIL_TYPE_13 = 13
};
enum
{
    CFG_VAL_BODYCOIL_POLARITY_UNFLIPPED = 0,
    CFG_VAL_BODYCOIL_POLARITY_FLIPPED = 1
};
enum
{
    CFG_VAL_MRU_TYPE_LEGACY = 0,
    CFG_VAL_MRU_TYPE_ETHERNET = 1,
    CFG_VAL_MRU_TYPE_NUM_TYPES
};
enum
{
    CFG_WIRED_PAC = 3,
    CFG_WIRELESS_PAC = 4,
    CFG_PAC_TYPE_UNKNOWN = 10
};
enum
{
    CFG_FIXED_PAC = 0,
    CFG_DOCKABLE_PAC = 1
};
enum
{
    CFG_VAL_MCBIAS_VOLTAGE = 0,
    CFG_VAL_MCBIAS_CURRENT = 1
};
enum
{
    CFG_VAL_CABMON1_TYPE = 1,
    CFG_VAL_CABMON2_TYPE = 2,
    CFG_VAL_CABMON3_TYPE = 3
};
enum
{
    CFG_VAL_RECEIVE_FREQ_BANDS_DISABLED = 0,
    CFG_VAL_RECEIVE_FREQ_BANDS_ENABLED = 1
};
enum
{
    CFG_VAL_DPP_ALLOWED_RX_TYPE_RRX = 0x00000001,
    CFG_VAL_DPP_ALLOWED_RX_TYPE_GEN1PPORT = 0x00000002,
    CFG_VAL_DPP_ALLOWED_RX_TYPE_APORT = 0x00000004,
    CFG_VAL_DPP_ALLOWED_RX_TYPE_MPORT = 0x00000008,
    CFG_VAL_DPP_ALLOWED_RX_TYPE_RXDIST = 0x00000010,
    CFG_VAL_DPP_ALLOWED_RX_TYPE_GEN2PPORT = 0x00000020,
    CFG_VAL_DPP_ALLOWED_RX_TYPE_LCRX = 0x00000040,
    CFG_VAL_DPP_ALLOWED_RX_TYPE_GEN3PPORT = 0x00000080,
    CFG_VAL_DPP_ALLOWED_RX_TYPE_DSRXDIST = 0x00000100,
    MAX_DPP_ALLOWED_RX_COMBOS = 16
};
enum
{
    CFG_VAL_COIL_EXT_DECOUPLING_MEMS_PS = 0x00000001,
};
enum CoolingCabinetTypeValue
{
    CFG_VAL_COOLING_CABINET_TYPE_NOT_APPLICABLE = 0,
    CFG_VAL_COOLING_CABINET_TYPE_RIO = 1,
    CFG_VAL_COOLING_CABINET_TYPE_PLATFORM_ICC_DIMPLEX = 2,
    CFG_VAL_COOLING_CABINET_TYPE_STARTER = 3,
    CFG_VAL_COOLING_CABINET_TYPE_KIZUNA = 4,
    CFG_VAL_COOLING_CABINET_TYPE_COUNT,
    CFG_VAL_COOLING_CABINET_TYPE_MAX_NUM = CFG_VAL_COOLING_CABINET_TYPE_COUNT - 1
};
enum CoolingFlowModeValue
{
    CFG_VAL_COOLING_FLOW_MODE_LOW = 0,
    CFG_VAL_COOLING_FLOW_MODE_HIGH = 1,
    CFG_VAL_COOLING_FLOW_MODE_COUNT,
    CFG_VAL_COOLING_FLOW_MODE_MAX_NUM = CFG_VAL_COOLING_FLOW_MODE_COUNT - 1
};
enum
{
    CFG_VAL_DRIVER_MODULE = 0,
    CFG_VAL_MTD = 1,
};
enum
{
    CFG_VAL_NB_EXCITER_DVMR = 0,
    CFG_VAL_NB_EXCITER_TCE = 1,
};
enum
{
    CFG_VAL_NB_RF_AIF_ASC = 0,
    CFG_VAL_NB_RF_AIF_TCE = 1,
};
enum
{
    CFG_VAL_POWERMON_UPM = 0,
    CFG_VAL_POWERMON_CSA = 1,
    CFG_VAL_POWERMON_TCE = 2,
};
enum
{
    OCP_TYPE_NORMAL = 0,
    OCP_TYPE_REVERSED = 1
};
enum
{
    FAN_LIGHT_UI_NONE = 0,
    FAN_LIGHT_UI_ONE_LEVEL = 1,
    FAN_LIGHT_UI_THREE_LEVEL = 2
};
enum
{
    CFG_VAL_IRD_COMM_TYPE_NONE = 0,
    CFG_VAL_IRD_COMM_TYPE_ONEWIRE = 1,
    CFG_VAL_IRD_COMM_TYPE_DDC = 2
};
enum
{
    CFG_VAL_DPP_RXDIST_TYPE_GEN1 = 0,
    CFG_VAL_DPP_RXDIST_TYPE_GEN2_DS = 1,
    CFG_VAL_DPP_RXDIST_TYPE_NUM_TYPES
};
enum
{
    CFG_VAL_TIF_CABLE_NOT_PRESENT = 0,
    CFG_VAL_TIF_CABLE_PRESENT = 1,
};
enum
{
    CFG_VAL_ALLOW_ANY_MCRV_NOT_ALLOWED = 0,
    CFG_VAL_ALLOW_ANY_MCRV_ALLOWED = 1,
    CFG_VAL_ALLOW_ANY_MCRV_MAX_VALUES
};
typedef struct {
    s16 pmPredictSAR;
    s16 pmContinuousUpdate;
} power_monitor_table_t;
typedef struct {
    char epname[16];
    n32 epamph;
    n32 epampb;
    n32 epamps;
    n32 epampc;
    n32 epwidthh;
    n32 epwidthb;
    n32 epwidths;
    n32 epwidthc;
    n32 epdcycleh;
    n32 epdcycleb;
    n32 epdcycles;
    n32 epdcyclec;
    n8 epsmode;
    n8 epfilter;
    n8 eprcvrband;
    n8 eprcvrinput;
    n8 eprcvrbias;
    n8 eptrdriver;
    n8 epfastrec;
    s16 epxmtadd;
    s16 epprexres;
    s16 epshldctrl;
    s16 epgradcoil;
    n32 eppkpower;
    n32 epseqtime;
    s16 epstartrec;
    s16 ependrec;
    power_monitor_table_t eppmtable;
    n8 epGeneralBankIndex;
    n8 epGeneralBankIndex2;
    n8 epR1BankIndex;
    n8 epNbTransmitSelect;
    n8 epBbTransmitSelect;
    n32 epMnsConverterSelect;
    n32 epRxCoilType;
    f32 epxgd_cableirmsmax;
    f32 epcoilAC_powersum;
    n8 enableReceiveFreqBands;
    s32 offsetReceiveFreqLower;
    s32 offsetReceiveFreqHigher;
    n32 ecgCableAllowed;
} entry_point_table_t;
typedef entry_point_table_t ENTRY_POINT_TABLE;
typedef entry_point_table_t ENTRY_PNT_TABLE;
typedef enum ANATOMY_ATTRIBUTE {
    ATTRIBUTE_CODE_MEANING,
    ATTRIBUTE_CATEGORY,
    ATTRIBUTE_APX_BH,
    ATTRIBUTE_MAGIC,
    ATTRIBUTE_SAG_CAL,
    ATTRIBUTE_3DGW_BSPLINE_INTERP,
    ATTRIBUTE_2DFSE_ANNEFACT_REDUCTION,
    ATTRIBUTE_ENABLE_PURE_BLUR,
    ATTRIBUTE_PURE_BLUR,
    ATTRIBUTE_NEAR_HEAD,
    ATTRIBUTE_CALIB_TABLE_MOVE_THRESH,
    ATTRIBUTE_VIRTUAL_CHANNEL_RECON,
    ATTRIBUTE_OPTIMAL_SNR_RECON,
    ATTRIBUTE_SELF_SENSITIVITY_UNIFORM_CORRECTION
} ANATOMY_ATTRIBUTE_E;
typedef enum ANATOMY_ATTRIBUTE_CATEGORY {
    ATTRIBUTE_CATEGORY_HEAD,
    ATTRIBUTE_CATEGORY_NECK,
    ATTRIBUTE_CATEGORY_UPPEREXTREMITIES,
    ATTRIBUTE_CATEGORY_CHEST,
    ATTRIBUTE_CATEGORY_ABDOMEN,
    ATTRIBUTE_CATEGORY_SPINE,
    ATTRIBUTE_CATEGORY_PELVIS,
    ATTRIBUTE_CATEGORY_LOWEREXTREMITIES
} ANATOMY_ATTRIBUTE_CATEGORY_E;
size_t getAnatomyAttribute(const int id, const char* attribute, char* result, size_t len);
int getAnatomyAttributeCached(const int key_id, const int attribute, char* attribute_result);
int isApplicationAllowedForAnatomy(int key_id, int application);
int isCategoryMatchForAnatomy(int key_id, int category);
int getIntAnatomyAttribute(const int key_id, const int attribute, int* attribute_result_int);
int getFloatAnatomyAttribute(const int key_id, const int attribute, float* attribute_result_float);
typedef struct
{
    float oprloc;
    float opphasoff;
    float optloc;
    float oprloc_shift;
    float opphasoff_shift;
    float optloc_shift;
    float opfov_freq_scale;
    float opfov_phase_scale;
    float opslthick_scale;
    float oprot[9];
    int opslplane;
} SCAN_INFO;
typedef struct
{
    float oppsctloc;
    float oppscrloc;
    float oppscphasoff;
    float oppscrot[9];
    int oppsclenx;
    int oppscleny;
    int oppsclenz;
} PSC_INFO;
typedef struct {
    float opgirthick;
    float opgirtloc;
    float opgirrot[9];
} GIR_INFO;
typedef struct
{
    short slloc;
    short slpass;
    short sltime;
} DATA_ACQ_ORDER;
typedef struct {
    float rsptloc;
    float rsprloc;
    float rspphasoff;
    int slloc;
 } RSP_INFO;
typedef struct {
    int ysign;
    int yoffs;
} PHASE_OFF;
typedef struct {
  float rsppsctloc;
  float rsppscrloc;
  float rsppscphasoff;
  long rsppscrot[10];
  int rsppsclenx;
  int rsppscleny;
  int rsppsclenz;
 } RSP_PSC_INFO;
typedef enum {
    TYPXGRAD = 0,
    TYPYGRAD = 1,
    TYPZGRAD = 2,
    TYPRHO1 = 3,
    TYPRHO2 = 4,
    TYPTHETA = 5,
    TYPOMEGA = 6,
    TYPSSP = 7,
    TYPAUX = 8,
    TYPBXGRAD,
    TYPBYGRAD,
    TYPBZGRAD,
    TYPBRHO1,
    TYPBRHO2,
    TYPBTHETA,
    TYPBOMEGA,
    TYPBSSP,
    TYPBAUX
} WF_PROCESSOR;
typedef enum {
    TYPINSTRMEM = 0,
    TYPWAVEMEM = 1
} WF_HARDWARE_TYPE;
typedef enum {
    TOHARDWARE = 0,
    FROMHARDWARE = 1
} HW_DIRECTION;
typedef enum {
    SSPS1 = 0,
    SSPS2 = 1,
    SSPS3 = 2,
    SSPS4 = 3
} SSP_S_ATTRIB;
typedef struct {
  s32 abcode;
  char text_string[256];
  char text_arg[16];
  s32 *longarg[4];
} PSD_EXIT_ARG;
typedef enum RECEIVER_SPEEDS
{
    STD_REC = 0,
    FAST_REC = 1
} RECEIVER_SPEED_E;
typedef enum GRADIENT_COILS
{
    PSD_55_CM_COIL = 1,
    PSD_60_CM_COIL = 2,
    PSD_TRM_COIL = 3,
    PSD_4_COIL = 4,
    PSD_5_COIL = 5,
    PSD_CRM_COIL = 6,
    PSD_HFO_COIL = 7,
    PSD_XRMB_COIL = 8,
    PSD_OVATION_COIL = 9,
    PSD_10_COIL = 10,
    PSD_XRMW_COIL = 11,
    PSD_VRMW_COIL = 12,
    PSD_HRMW_COIL = 13,
    PSD_HRMB_COIL = 16
} GRADIENT_COIL_E;
typedef enum BODY_COIL_TYPES
{
    PSD_15_BRM_BODY_COIL = 0,
    PSD_15_TRM_BODY_COIL = 0,
    PSD_15_HDE_BODY_COIL = 0,
    PSD_15_CRM_BODY_COIL = 1,
    PSD_30_CRM_BODY_COIL = 2,
    PSD_30_TRM_BODY_COIL = 3,
    PSD_30_XRM_BODY_COIL = 4,
    PSD_15_XRM_BODY_COIL = 5,
    PSD_15_XRMW_BODY_COIL = 6,
    PSD_30_XRMW_BODY_COIL = 7,
    PSD_30_NEONATAL_BODY_COIL = 8,
    PSD_30_XRMW_PET_BODY_COIL = 9,
    PSD_30_VRMW_BODY_COIL = 10,
    PSD_30_HRMW_BODY_COIL = 11,
    PSD_30_VRMW_VCP_BODY_COIL = 12,
    PSD_15_VRMW_BODY_COIL = 13
} BODY_COIL_TYPE_E;
typedef enum PSD_BOARD_TYPE
{
    PSDCERD = 0,
    PSDDVMR,
    NUM_PSD_BOARD_TYPES
} PSD_BOARD_TYPE_E;
typedef enum SSC_TYPE
{
    SSC_TYPE_MGD = 0,
    SSC_TYPE_ICE = 1
} SSC_TYPE_E;
typedef enum GRADIENT_COIL_METHOD
{
    GRADIENT_COIL_METHOD_AUTO = -1,
    GRADIENT_COIL_METHOD_DC = 0,
    GRADIENT_COIL_METHOD_AC = 1,
    GRADIENT_COIL_METHOD_QAC = 2
} GRADIENT_COIL_METHOD_E;
typedef enum POWER_IN_HEAT_CALC
{
    AVERAGE_POWER = 0,
    MAXIMUM_POWER = 1
} POWER_IN_HEAT_CALC_E;
typedef enum GRADIENT_PULSE_TYPE
{
    G_RAMP = 1,
    G_TRAP = 2,
    G_SIN = 3,
    G_CONSTANT = 4,
    G_ARBTRAP = 5,
    G_USER = 6,
    G_EMPTY = -1,
} GRADIENT_PULSE_TYPE_E;
typedef struct {
  int ptype;
  int *attack;
  int *decay;
  int *pw;
  float *amps;
  float *amp;
  float *ampd;
  float *ampe;
  char *gradfile;
  int num;
  float scale;
  int *time;
  int tdelta;
  float powscale;
  float power;
  float powpos;
  float powneg;
  float powabs;
  float amptran;
  int pwm;
  int bridge;
  float intabspwmcurr;
} GRAD_PULSE;
typedef struct {
  int *pw;
  float *amp;
  float abswidth;
  float effwidth;
  float area;
  float dtycyc;
  float maxpw;
  float num;
  float max_b1;
  float max_int_b1_sq;
  float max_rms_b1;
  float nom_fa;
  float *act_fa;
  float nom_pw;
  float nom_bw;
  unsigned int activity;
  unsigned char reference;
  int isodelay;
  float scale;
  int *res;
  int extgradfile;
  int *exciter;
  int apply_as_hadamard_factor;
} RF_PULSE;
typedef struct {
  int change;
  int newres;
} RF_PULSE_INFO;
typedef enum {
    NORMAL_CONTROL_MODE = 0,
    FIRST_CONTROL_MODE = 1,
    SECOND_CONTROL_MODE = 2,
    LOWSAR_CONTROL_MODE = 3
} regulatory_control_mode_e;
typedef enum epic_slice_order_type_e
{
    TYPNCAT =0,
    TYPCAT =1,
    TYPXRR =2,
    TYPMPMP =3,
    TYPSSMP =4,
    TYP3D =5,
    TYPNORMORDER =6,
    TYPFASTMPH =7,
    TYPF3D =8,
    TYP3DMSNCAT =9,
    TYP3DMSCAT =10,
    TYP3DFSENCAT =11,
    TYP3DFSECAT =12,
    TYPRTG =13,
    TYPF3DMPH =14,
    TYPSSFSEINT =15,
    TYPSSFSESEQ =16,
    TYPSSFSEXRR =17,
    TYPSSFSERTG =18,
    TYPSEQSLIC =19,
    TYPF3DMSMPH =20,
    TYPSSFSEFLAIR=21,
    TYPMAVRIC =22,
    TYPNCATFLAIR =23,
    TYPMDMENORM =24,
    TYPMULTIBAND =25,
    TYPSSFSEMPH =26,
    TYPF3DCINE =27,
    TYPF3DMSCINE =28,
    TYPNCATRTG =29,
    TYPCATRTG =30,
    TYPMULTIBAND2=31,
    TYPMULTIBANDNORMORDER =32,
    TYP3PLANEAIRX=33
} epic_slice_order_type;
typedef enum exciter_type {
    NO_EXCITER = 0,
    MASTER_EXCITER,
    SLAVE_EXCITER,
    ALL_EXCITERS
} exciterSelection;
typedef enum receiver_type {
    NO_RECEIVER = 0,
    MASTER_RECEIVER,
    SLAVE_RECEIVER,
    ALL_RECEIVERS
} receiverSelection;
typedef enum oscillator_source {
    LO_MASTER_RCVALL = 0,
    LO_SLAVE_RCVB1,
    LO_SLAVE_RCVB2,
    LO_SLAVE_RCVB3,
    LO_SLAVE_RCVB4,
    LO_SLAVE_RCVB1B2,
    LO_SLAVE_RCVB1B3,
    LO_SLAVE_RCVB1B4,
    LO_SLAVE_RCVB1B2B3,
    LO_SLAVE_RCVB1B2B4,
    LO_SLAVE_RCVB1B3B4,
    LO_SLAVE_RCVB2B3,
    LO_SLAVE_RCVB2B4,
    LO_SLAVE_RCVB2B3B4,
    LO_SLAVE_RCVB3B4,
    LO_SLAVE_RCVALL,
    NO_LO_CHANGE
} demodSelection;
typedef enum nav_type {
    NAV_OFF = 0,
    NAV_ON,
    NAV_MASTER,
    NAV_SLAVE,
    NO_NAV_CHANGE
} navSelection;
typedef enum VALUE_SYSTEM_TYPE
{
  NON_VALUE_SYSTEM = 0,
  VALUE_SYSTEM_HDE,
  VALUE_SYSTEM_SVEM,
  VALUE_SYSTEM_SVDM,
  VALUE_SYSTEM_SVDMP
} VALUE_SYSTEM_TYPE_E;
typedef enum PSD_PATIENT_ENTRY {
    PSD_PATIENT_ENTRY_HEAD_FIRST = 1,
    PSD_PATIENT_ENTRY_FEET_FIRST = 2,
    PSD_PATIENT_ENTRY_AXIAL = 3,
    PSD_PATIENT_ENTRY_SIDE = 4,
    PSD_PATIENT_ENTRY_VERTICAL = 5,
    PSD_PATIENT_ENTRY_RESERVED = 6,
    PSD_PATIENT_ENTRY_HEAD_FIRST_PLUS_25DEG = 7,
    PSD_PATIENT_ENTRY_HEAD_FIRST_MINUS_25DEG = 8,
    PSD_PATIENT_ENTRY_FEET_FIRST_PLUS_25DEG = 9,
    PSD_PATIENT_ENTRY_FEET_FIRST_MINUS_25DEG = 10
} PSD_PATIENT_ENTRY_E;
typedef enum CAL_MODE
{
    CAL_MODE_MIN = 0,
    CAL_MODE_STANDARD = 0,
    CAL_MODE_BREATHHOLD_FREEBREATHING = 1,
    CAL_MODE_FREEBREATHING = 2,
    CAL_MODE_MAX = 2
} CAL_MODE_E;
typedef enum RG_CAL_MODE {
    RG_CAL_MODE_MIN = 0,
    RG_CAL_MODE_MEASURED = 0,
    RG_CAL_MODE_HIGH_FIXED = 1,
    RG_CAL_MODE_LOW_FIXED = 2,
    RG_CAL_MODE_AUTO = 3,
    RG_CAL_MODE_MAX = 3
} RG_CAL_MODE_E;
typedef enum ADD_SCAN_TYPE {
    ADD_SCAN_TYPE_NONE = 0,
    ADD_SCAN_HEADLOC_SCOUT = 1
} ADD_SCAN_TYPE_E;
typedef enum PSD_SLTHICK_LABEL
{
    PSD_SLTHICK_LABEL_SLTHICK = 0,
    PSD_SLTHICK_LABEL_RESOLUTION = 1
} PSD_SLTHICK_LABEL_E;
typedef enum PSD_NAV_TYPE {
  PSD_NAV_TYPE_90_180 = 0,
  PSD_NAV_TYPE_CYL
} PSD_NAV_TYPE_E;
typedef enum PSD_FLIP_ANGLE_MODE_LABEL {
    PSD_FLIP_ANGLE_MODE_EXCITE = 0,
    PSD_FLIP_ANGLE_MODE_REFOCUS = 1
} PSD_FLIP_ANGLE_LABEL_E;
typedef enum PSD_AUTO_TR_MODE_LABEL {
    PSD_AUTO_TR_MODE_MANUAL_TR = 0,
    PSD_AUTO_TR_MODE_IN_RANGE_TR = 1,
    PSD_AUTO_TR_MODE_ADVANCED_IN_RANGE_TR = 2
} PSD_AUTO_TR_MODE_LABEL_E;
typedef enum CARDIAC_GATE_TYPE
{
    CARDIAC_GATE_TYPE_MIN = 0,
    CARDIAC_GATE_TYPE_NONE = 0,
    CARDIAC_GATE_TYPE_ECG = 1,
    CARDIAC_GATE_TYPE_PG = 2,
    CARDIAC_GATE_TYPE_MAX = 2
} CARDIAC_GATE_TYPE_E;
typedef enum DL_RECON_MODE {
    DL_RECON_MODE_OFF = 0,
    DL_RECON_MODE_LOW = 1,
    DL_RECON_MODE_MEDIUM = 2,
    DL_RECON_MODE_HIGH = 3
} DL_RECON_MODE_E;
typedef char CHAR;
typedef s16 SHORT;
typedef int INT;
typedef INT LONG;
typedef f32 FLOAT;
typedef f64 DOUBLE;
typedef n8 UCHAR;
typedef n16 USHORT;
typedef unsigned int UINT;
typedef UINT ULONG;
typedef int STATUS;
typedef void * ADDRESS;
typedef enum e_axis {
    X = 0,
    Y,
    Z
} t_axis;

typedef unsigned char __u_char;
typedef unsigned short int __u_short;
typedef unsigned int __u_int;
typedef unsigned long int __u_long;
typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef signed short int __int16_t;
typedef unsigned short int __uint16_t;
typedef signed int __int32_t;
typedef unsigned int __uint32_t;
__extension__ typedef signed long long int __int64_t;
__extension__ typedef unsigned long long int __uint64_t;
__extension__ typedef long long int __quad_t;
__extension__ typedef unsigned long long int __u_quad_t;
__extension__ typedef __u_quad_t __dev_t;
__extension__ typedef unsigned int __uid_t;
__extension__ typedef unsigned int __gid_t;
__extension__ typedef unsigned long int __ino_t;
__extension__ typedef __u_quad_t __ino64_t;
__extension__ typedef unsigned int __mode_t;
__extension__ typedef unsigned int __nlink_t;
__extension__ typedef long int __off_t;
__extension__ typedef __quad_t __off64_t;
__extension__ typedef int __pid_t;
__extension__ typedef struct { int __val[2]; } __fsid_t;
__extension__ typedef long int __clock_t;
__extension__ typedef unsigned long int __rlim_t;
__extension__ typedef __u_quad_t __rlim64_t;
__extension__ typedef unsigned int __id_t;
__extension__ typedef long int __time_t;
__extension__ typedef unsigned int __useconds_t;
__extension__ typedef long int __suseconds_t;
__extension__ typedef int __daddr_t;
__extension__ typedef int __key_t;
__extension__ typedef int __clockid_t;
__extension__ typedef void * __timer_t;
__extension__ typedef long int __blksize_t;
__extension__ typedef long int __blkcnt_t;
__extension__ typedef __quad_t __blkcnt64_t;
__extension__ typedef unsigned long int __fsblkcnt_t;
__extension__ typedef __u_quad_t __fsblkcnt64_t;
__extension__ typedef unsigned long int __fsfilcnt_t;
__extension__ typedef __u_quad_t __fsfilcnt64_t;
__extension__ typedef int __fsword_t;
__extension__ typedef int __ssize_t;
__extension__ typedef long int __syscall_slong_t;
__extension__ typedef unsigned long int __syscall_ulong_t;
typedef __off64_t __loff_t;
typedef __quad_t *__qaddr_t;
typedef char *__caddr_t;
__extension__ typedef int __intptr_t;
__extension__ typedef unsigned int __socklen_t;
struct _IO_FILE;

typedef struct _IO_FILE FILE;


typedef struct _IO_FILE __FILE;
typedef struct
{
  int __count;
  union
  {
    unsigned int __wch;
    char __wchb[4];
  } __value;
} __mbstate_t;
typedef struct
{
  __off_t __pos;
  __mbstate_t __state;
} _G_fpos_t;
typedef struct
{
  __off64_t __pos;
  __mbstate_t __state;
} _G_fpos64_t;
typedef __builtin_va_list __gnuc_va_list;
struct _IO_jump_t; struct _IO_FILE;
typedef void _IO_lock_t;
struct _IO_marker {
  struct _IO_marker *_next;
  struct _IO_FILE *_sbuf;
  int _pos;
};
enum __codecvt_result
{
  __codecvt_ok,
  __codecvt_partial,
  __codecvt_error,
  __codecvt_noconv
};
struct _IO_FILE {
  int _flags;
  char* _IO_read_ptr;
  char* _IO_read_end;
  char* _IO_read_base;
  char* _IO_write_base;
  char* _IO_write_ptr;
  char* _IO_write_end;
  char* _IO_buf_base;
  char* _IO_buf_end;
  char *_IO_save_base;
  char *_IO_backup_base;
  char *_IO_save_end;
  struct _IO_marker *_markers;
  struct _IO_FILE *_chain;
  int _fileno;
  int _flags2;
  __off_t _old_offset;
  unsigned short _cur_column;
  signed char _vtable_offset;
  char _shortbuf[1];
  _IO_lock_t *_lock;
  __off64_t _offset;
  void *__pad1;
  void *__pad2;
  void *__pad3;
  void *__pad4;
  size_t __pad5;
  int _mode;
  char _unused2[15 * sizeof (int) - 4 * sizeof (void *) - sizeof (size_t)];
};
typedef struct _IO_FILE _IO_FILE;
struct _IO_FILE_plus;
extern struct _IO_FILE_plus _IO_2_1_stdin_;
extern struct _IO_FILE_plus _IO_2_1_stdout_;
extern struct _IO_FILE_plus _IO_2_1_stderr_;
typedef __ssize_t __io_read_fn (void *__cookie, char *__buf, size_t __nbytes);
typedef __ssize_t __io_write_fn (void *__cookie, const char *__buf,
     size_t __n);
typedef int __io_seek_fn (void *__cookie, __off64_t *__pos, int __w);
typedef int __io_close_fn (void *__cookie);
extern int __underflow (_IO_FILE *);
extern int __uflow (_IO_FILE *);
extern int __overflow (_IO_FILE *, int);
extern int _IO_getc (_IO_FILE *__fp);
extern int _IO_putc (int __c, _IO_FILE *__fp);
extern int _IO_feof (_IO_FILE *__fp) __attribute__ ((__nothrow__ , __leaf__));
extern int _IO_ferror (_IO_FILE *__fp) __attribute__ ((__nothrow__ , __leaf__));
extern int _IO_peekc_locked (_IO_FILE *__fp);
extern void _IO_flockfile (_IO_FILE *) __attribute__ ((__nothrow__ , __leaf__));
extern void _IO_funlockfile (_IO_FILE *) __attribute__ ((__nothrow__ , __leaf__));
extern int _IO_ftrylockfile (_IO_FILE *) __attribute__ ((__nothrow__ , __leaf__));
extern int _IO_vfscanf (_IO_FILE * __restrict, const char * __restrict,
   __gnuc_va_list, int *__restrict);
extern int _IO_vfprintf (_IO_FILE *__restrict, const char *__restrict,
    __gnuc_va_list);
extern __ssize_t _IO_padn (_IO_FILE *, int, __ssize_t);
extern size_t _IO_sgetn (_IO_FILE *, void *, size_t);
extern __off64_t _IO_seekoff (_IO_FILE *, __off64_t, int, int);
extern __off64_t _IO_seekpos (_IO_FILE *, __off64_t, int);
extern void _IO_free_backup_area (_IO_FILE *) __attribute__ ((__nothrow__ , __leaf__));
typedef __gnuc_va_list va_list;
typedef __off_t off_t;
typedef __ssize_t ssize_t;

typedef _G_fpos_t fpos_t;

extern struct _IO_FILE *stdin;
extern struct _IO_FILE *stdout;
extern struct _IO_FILE *stderr;

extern int remove (const char *__filename) __attribute__ ((__nothrow__ , __leaf__));
extern int rename (const char *__old, const char *__new) __attribute__ ((__nothrow__ , __leaf__));

extern int renameat (int __oldfd, const char *__old, int __newfd,
       const char *__new) __attribute__ ((__nothrow__ , __leaf__));

extern FILE *tmpfile (void) ;
extern char *tmpnam (char *__s) __attribute__ ((__nothrow__ , __leaf__)) ;

extern char *tmpnam_r (char *__s) __attribute__ ((__nothrow__ , __leaf__)) ;
extern char *tempnam (const char *__dir, const char *__pfx)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) ;

extern int fclose (FILE *__stream);
extern int fflush (FILE *__stream);

extern int fflush_unlocked (FILE *__stream);

extern FILE *fopen (const char *__restrict __filename,
      const char *__restrict __modes) ;
extern FILE *freopen (const char *__restrict __filename,
        const char *__restrict __modes,
        FILE *__restrict __stream) ;

extern FILE *fdopen (int __fd, const char *__modes) __attribute__ ((__nothrow__ , __leaf__)) ;
extern FILE *fmemopen (void *__s, size_t __len, const char *__modes)
  __attribute__ ((__nothrow__ , __leaf__)) ;
extern FILE *open_memstream (char **__bufloc, size_t *__sizeloc) __attribute__ ((__nothrow__ , __leaf__)) ;

extern void setbuf (FILE *__restrict __stream, char *__restrict __buf) __attribute__ ((__nothrow__ , __leaf__));
extern int setvbuf (FILE *__restrict __stream, char *__restrict __buf,
      int __modes, size_t __n) __attribute__ ((__nothrow__ , __leaf__));

extern void setbuffer (FILE *__restrict __stream, char *__restrict __buf,
         size_t __size) __attribute__ ((__nothrow__ , __leaf__));
extern void setlinebuf (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));

extern int fprintf (FILE *__restrict __stream,
      const char *__restrict __format, ...);
extern int printf (const char *__restrict __format, ...);
extern int sprintf (char *__restrict __s,
      const char *__restrict __format, ...) __attribute__ ((__nothrow__));
extern int vfprintf (FILE *__restrict __s, const char *__restrict __format,
       __gnuc_va_list __arg);
extern int vprintf (const char *__restrict __format, __gnuc_va_list __arg);
extern int vsprintf (char *__restrict __s, const char *__restrict __format,
       __gnuc_va_list __arg) __attribute__ ((__nothrow__));


extern int snprintf (char *__restrict __s, size_t __maxlen,
       const char *__restrict __format, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 4)));
extern int vsnprintf (char *__restrict __s, size_t __maxlen,
        const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 0)));

extern int vdprintf (int __fd, const char *__restrict __fmt,
       __gnuc_va_list __arg)
     __attribute__ ((__format__ (__printf__, 2, 0)));
extern int dprintf (int __fd, const char *__restrict __fmt, ...)
     __attribute__ ((__format__ (__printf__, 2, 3)));

extern int fscanf (FILE *__restrict __stream,
     const char *__restrict __format, ...) ;
extern int scanf (const char *__restrict __format, ...) ;
extern int sscanf (const char *__restrict __s,
     const char *__restrict __format, ...) __attribute__ ((__nothrow__ , __leaf__));
extern int fscanf (FILE *__restrict __stream, const char *__restrict __format, ...) __asm__ ("" "__isoc99_fscanf") ;
extern int scanf (const char *__restrict __format, ...) __asm__ ("" "__isoc99_scanf") ;
extern int sscanf (const char *__restrict __s, const char *__restrict __format, ...) __asm__ ("" "__isoc99_sscanf") __attribute__ ((__nothrow__ , __leaf__));


extern int vfscanf (FILE *__restrict __s, const char *__restrict __format,
      __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 2, 0))) ;
extern int vscanf (const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 1, 0))) ;
extern int vsscanf (const char *__restrict __s,
      const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format__ (__scanf__, 2, 0)));
extern int vfscanf (FILE *__restrict __s, const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vfscanf")
     __attribute__ ((__format__ (__scanf__, 2, 0))) ;
extern int vscanf (const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vscanf")
     __attribute__ ((__format__ (__scanf__, 1, 0))) ;
extern int vsscanf (const char *__restrict __s, const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vsscanf") __attribute__ ((__nothrow__ , __leaf__))
     __attribute__ ((__format__ (__scanf__, 2, 0)));


extern int fgetc (FILE *__stream);
extern int getc (FILE *__stream);
extern int getchar (void);

extern int getc_unlocked (FILE *__stream);
extern int getchar_unlocked (void);
extern int fgetc_unlocked (FILE *__stream);

extern int fputc (int __c, FILE *__stream);
extern int putc (int __c, FILE *__stream);
extern int putchar (int __c);

extern int fputc_unlocked (int __c, FILE *__stream);
extern int putc_unlocked (int __c, FILE *__stream);
extern int putchar_unlocked (int __c);
extern int getw (FILE *__stream);
extern int putw (int __w, FILE *__stream);

extern char *fgets (char *__restrict __s, int __n, FILE *__restrict __stream)
     ;
extern char *gets (char *__s) __attribute__ ((__deprecated__));

extern __ssize_t __getdelim (char **__restrict __lineptr,
          size_t *__restrict __n, int __delimiter,
          FILE *__restrict __stream) ;
extern __ssize_t getdelim (char **__restrict __lineptr,
        size_t *__restrict __n, int __delimiter,
        FILE *__restrict __stream) ;
extern __ssize_t getline (char **__restrict __lineptr,
       size_t *__restrict __n,
       FILE *__restrict __stream) ;

extern int fputs (const char *__restrict __s, FILE *__restrict __stream);
extern int puts (const char *__s);
extern int ungetc (int __c, FILE *__stream);
extern size_t fread (void *__restrict __ptr, size_t __size,
       size_t __n, FILE *__restrict __stream) ;
extern size_t fwrite (const void *__restrict __ptr, size_t __size,
        size_t __n, FILE *__restrict __s);

extern size_t fread_unlocked (void *__restrict __ptr, size_t __size,
         size_t __n, FILE *__restrict __stream) ;
extern size_t fwrite_unlocked (const void *__restrict __ptr, size_t __size,
          size_t __n, FILE *__restrict __stream);

extern int fseek (FILE *__stream, long int __off, int __whence);
extern long int ftell (FILE *__stream) ;
extern void rewind (FILE *__stream);

extern int fseeko (FILE *__stream, __off_t __off, int __whence);
extern __off_t ftello (FILE *__stream) ;

extern int fgetpos (FILE *__restrict __stream, fpos_t *__restrict __pos);
extern int fsetpos (FILE *__stream, const fpos_t *__pos);


extern void clearerr (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));
extern int feof (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;
extern int ferror (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;

extern void clearerr_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));
extern int feof_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;
extern int ferror_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;

extern void perror (const char *__s);

extern int sys_nerr;
extern const char *const sys_errlist[];
extern int fileno (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;
extern int fileno_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;
extern FILE *popen (const char *__command, const char *__modes) ;
extern int pclose (FILE *__stream);
extern char *ctermid (char *__s) __attribute__ ((__nothrow__ , __leaf__));
extern void flockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));
extern int ftrylockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;
extern void funlockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));

typedef enum e_fopen_mode {
   READ_MODE = 0,
   WRITE_MODE
} t_fopen_mode;
STATUS DefOpenUsrFile( const CHAR *filename, const CHAR *marker );
STATUS DefOpenFile( const CHAR *markername );
STATUS DefFindKey( const CHAR *key, const INT mark );
STATUS DefReadData( const CHAR *format_str, ADDRESS data_addr );
STATUS DefCloseFile( void );
INT ExtractNameTo( CHAR *orig_name, CHAR *key, CHAR *new_name );
double FMax( int info, ... );
double FMin( int info, ... );
int IMax( int info, ... );
int IMin( int info, ... );
short floatsAlmostEqualAbsolute( const float a,
                                 const float b,
                                 const float tol );
short floatsAlmostEqualRelative( const float a,
                                 const float b,
                                 const float fract );
short floatsAlmostEqualEpsilons( const float a,
                                 const float b,
                                 const unsigned int neps );
short floatsAlmostEqualEpsilon( const float a,
                                const float b );
short floatAlmostZeroAbsolute( const float a,
                               const float tol );
short floatIdenticallyZero( const float a );
short floatsAlmostEqualNulps( const float a,
                              const float b,
                              const n32 nulps );
float floatUlp( const float a );
short floatIsInteger( const float a );
short floatIsNormal( const float a );
short floatIsInfinite( const float a );
short floatIsPositiveInfinity( const float a );
short floatIsNegativeInfinity( const float a );
short floatIsNan( const float a );
short doublesAlmostEqualAbsolute( const double a,
                                  const double b,
                                  const double tol );
short doublesAlmostEqualRelative( const double a,
                                  const double b,
                                  const double fract );
short doublesAlmostEqualEpsilons( const double a,
                                  const double b,
                                  const unsigned int neps );
short doublesAlmostEqualEpsilon( const double a,
                                 const double b );
short doubleAlmostZeroAbsolute( const double a,
                                const double tol );
short doubleIdenticallyZero( const double a );
short doublesAlmostEqualNulps( const double a,
                               const double b,
                               const n64 nulps );
double doubleUlp( const double a );
short doubleIsInteger( const double a );
short doubleIsNormal( const double a );
short doubleIsInfinite( const double a );
short doubleIsPositiveInfinity( const double a );
short doubleIsNegativeInfinity( const double a );
short doubleIsNan( const double a );
typedef float datavalue;
datavalue median(const datavalue * p, const int kernel_size);
void smooth(float *data, int numpts, int kernel_size, int skip);
void intarr2float(float * f_a, const int * a, const int numpt);
void generate_polycurve(float * result, const float * xdata, const float * coeff, const int order, const int numpt);
STATUS weighted_polyfit( float * fittedResult,
               float * coeff,
               const float * ydata ,
               const float * xdata,
               const float * weight,
               const int order,
               const int numpt );
FILE *OpenFile( const CHAR *filename, const t_fopen_mode mode );
STATUS CloseFile( FILE *plotdata_fptr );
STATUS RewindFile( FILE *plotdata_fptr );
STATUS RemoveFile( const CHAR *filename );
STATUS FileExists( const CHAR *filename );
LONG FileDate( CHAR *path );
void WriteError( const CHAR *string );
STATUS FileExecs( const CHAR *filename );
STATUS IsaWDir( const CHAR *filename );
STATUS IsSunview( void );
const char *Resides( const char *env_varname );
const char *SetBase( const char *filename );
const char *ExtractBase( const char *filename );
int RNEAREST_RF( int n, int fact );
ADDRESS WTAlloc( size_t size );
void WTFree( ADDRESS address );
STATUS
activate_usercv( const int usercv );
STATUS
deactivate_usercv( const int usercv );
STATUS
deactivate_all_usercvs( void );
STATUS
activate_reserved_usercv( const int usercv );
STATUS
deactivate_reserved_usercv( const int usercv );
STATUS
deactivate_all_reserved_usercvs( void );
enum
{
    SEQ_CFG_SEQ_ID_GRAD_X = 0,
    SEQ_CFG_SEQ_ID_GRAD_Y = 1,
    SEQ_CFG_SEQ_ID_GRAD_Z = 2,
};
enum
{
    SEQ_CFG_TYPE_NONE = 0x00000000,
    SEQ_CFG_TYPE_SSP = 0x00000001,
    SEQ_CFG_TYPE_GRAD_X = 0x00000002,
    SEQ_CFG_TYPE_GRAD_Y = 0x00000004,
    SEQ_CFG_TYPE_GRAD_Z = 0x00000008,
    SEQ_CFG_TYPE_RHO = 0x00000010,
    SEQ_CFG_TYPE_THETA = 0x00000020,
    SEQ_CFG_TYPE_OMEGA = 0x00000040,
    SEQ_CFG_TYPE_RF_TX = 0x00000080,
    SEQ_CFG_TYPE_RF_RX = 0x00000100,
};
enum
{
    SEQ_CFG_RF_GROUP_MODE_NONE = 0x00000000,
    SEQ_CFG_RF_GROUP_MODE_DUAL_SEQUENCE = 0x00000001,
};
enum
{
    SEQ_CFG_MAX_RF_GROUPS = 3,
    SEQ_CFG_CORE_RF_CHANNEL_1 = 0,
    SEQ_CFG_CORE_RF_CHANNEL_2 = 1,
    SEQ_CFG_NUM_CORE_RF_CHANNELS = 2,
    SEQ_CFG_CORE_TYPE_NONE = 0x0000,
    SEQ_CFG_CORE_TYPE_PRIMARY = 0x0001,
    SEQ_CFG_CORE_TYPE_SECONDARY = 0x0002,
    SEQ_CFG_CORE_TYPE_4RF_MODE = 0x0004,
    SEQ_CFG_CORE_TYPE_6RF_MODE = 0x0008,
    SEQ_CFG_MAX_CORES = 5,
    SEQ_CFG_MAX_CORE_SEQS = 8,
    SEQ_CFG_MAX_SECONDARY_CORE_SEQS = 7,
    SEQ_CFG_MAX_SEQ_IDS = (SEQ_CFG_MAX_CORE_SEQS +
                                       ((SEQ_CFG_MAX_CORES - 1) *
                                        SEQ_CFG_MAX_SECONDARY_CORE_SEQS)),
    SEQ_CFG_DEBUG_OPTION_DEFAULT = 0,
};
typedef struct
{
    n32 sscType;
    n32 ptxCapable;
    n32 fieldStrength;
    n32 rfAmpType;
    n32 receiverType;
} SeqCfgSysCfgInfo;
typedef struct
{
    s32 seqId;
    n32 seqType;
    s32 duplicateSeqId;
    s32 sspSeqId;
    s32 rfGroupId;
    s32 rfGroupTxChannel;
    n32 coreId;
    s32 coreRfChannel;
} SeqCfgSeqInfo;
typedef struct
{
    s32 coreId;
    n32 coreType;
    s32 requiredPhysicalTxId[SEQ_CFG_MAX_RF_GROUPS];
    n32 numSeqs;
    n32 seqs[SEQ_CFG_MAX_CORE_SEQS];
} SeqCfgCoreInfo;
typedef struct
{
    n32 txAmp;
    n32 txCoilType;
    n32 txNucleus;
    n32 txChannels;
} SeqCfgRfTxInfo;
typedef struct
{
    n32 rfGroupId;
    n32 numAppTxChannels;
    n32 txSeqTypes;
    n32 rxFlag;
    n32 rxSeqTypes;
    n32 mode;
    SeqCfgRfTxInfo txInfo;
} SeqCfgRfGroupInfo;
typedef struct
{
    s32 valid;
    n32 debugOptions;
    n32 numRfGroups;
    n32 numCores;
    n32 numAppSeqs;
    n32 numSeqs;
    SeqCfgSysCfgInfo sysCfg;
    SeqCfgRfGroupInfo rfGroups[SEQ_CFG_MAX_RF_GROUPS];
    SeqCfgCoreInfo cores[SEQ_CFG_MAX_CORES];
    SeqCfgSeqInfo seqs[SEQ_CFG_MAX_SEQ_IDS];
} SeqCfgInfo;
typedef struct SeqType
{
    n32 seqID;
    n32 seqOpt;
    char *pName;
} SeqType;
typedef enum {
    DABNORM,
    DABCINE,
    DABON,
    DABOFF
} TYPDAB_PACKETS;
typedef enum {
    NOPASS,
    PASSTHROUGH
} TYPACQ_PASS;
typedef SeqType SeqData;
typedef long WF_HW_WAVEFORM_PTR;
typedef long WF_HW_INSTR_PTR;
typedef ADDRESS WF_PULSE_FORWARD_ADDR;
typedef ADDRESS WF_INSTR_PTR;
typedef struct INST_NODE {
    struct INST_NODE *next;
    WF_HW_INSTR_PTR wf_instr_ptr;
    long amplitude;
    long period;
    long start;
    long end;
    long entry_group;
    WF_PULSE_FORWARD_ADDR pulse_hdr;
    WF_HW_INSTR_PTR wf_instr_ptr_secssp[SEQ_CFG_MAX_CORES];
    int num_iters;
    long* ampl_iters;
} WF_INSTR_HDR;
typedef struct {
    short amplitude;
} CONST_EXT;
typedef struct {
    short amplitude;
    float separation;
    float nsinc_cycles;
    float alpha;
} HADAMARD_EXT;
typedef struct {
    short start_amplitude;
    short end_amplitude;
} RAMP_EXT;
typedef struct {
    short amplitude;
    float nsinc_cycles;
    float alpha;
} SINC_EXT;
typedef struct {
    short amplitude;
    float start_phase;
    float phase_length;
    short offset;
} SINUSOID_EXT;
typedef union {
    CONST_EXT constext;
    HADAMARD_EXT hadamard;
    RAMP_EXT ramp;
    SINC_EXT sinc;
    SINUSOID_EXT sinusoid;
} WF_PULSE_EXT;
typedef enum {
    TYPBITS,
    TYPBRIDGED_CONST,
    TYPBRIDGED_RAMP,
    TYPCONSTANT,
    TYPEXTERNAL,
    TYPHADAMARD,
    TYPRAMP,
    TYPRESERVE,
    TYPSINC,
    TYPSINUSOID
} WF_PULSE_TYPES;
typedef enum {
    SSPUNKN,
    SSPDAB,
    SSPRBA,
    SSPXTR,
    SSPSYNC,
    SSPFREQ,
    SSPUBR,
    SSPPA,
    SSPPD,
    SSPPM,
    SSPPMD,
    SSPPEA,
    SSPPED,
    SSPPEM,
    SSPRFBITS,
    SSPSEQ,
    SSPSCP,
    SSPPASS,
    SSPATTEN,
    SSP3DIM,
    SSPTREG,
    SSPTNS
} WF_PGMTAG;
typedef enum {
    PSDREUSEP,
    PSDNEWP
} WF_PGMREUSE;
typedef enum {
    UNKNOWN_PURPOSE = 0,
    WAIT_GRAD,
    RF_SELECT_GRAD,
    WINDER_GRAD,
    COMPENSATION_GRAD,
    STEP_ENCODER_GRAD,
    CRUSHER_GRAD,
    READOUT_GRAD,
    KILLER_GRAD,
    OTHER_GRAD,
    WAIT_RF = 50,
    EXCITATION_RF,
    REFOCUS_RF,
    INVERSION_RF,
    SATURATION_RF,
    OTHER_RF,
    WAIT_SSP = 100,
    OTHER_SSP
} WF_PURPOSE;
typedef struct PULSE {
    const char *pulsename;
    long ninsts;
    WF_HW_WAVEFORM_PTR wave_addr;
    int board_type;
    WF_PGMREUSE reusep;
    WF_PGMTAG tag;
    long addtag;
    int id;
    long ctrlfield;
    WF_PURPOSE purpose;
    WF_INSTR_HDR *inst_hdr_tail;
    WF_INSTR_HDR *inst_hdr_head;
    WF_PROCESSOR wavegen_type;
    WF_PULSE_TYPES type;
    short resolution;
    struct PULSE *assoc_pulse;
    WF_PULSE_EXT *ext;
    int rfgroup;
    int ptx_flag;
    int seq_id;
    int rx_flag;
    WF_HW_WAVEFORM_PTR wave_addr_secssp[SEQ_CFG_MAX_CORES];
} WF_PULSE;
typedef WF_PULSE * WF_PULSE_ADDR;
typedef struct INST_QUEUE_NODE {
    WF_INSTR_HDR *instr;
    struct INST_QUEUE_NODE *next;
    struct INST_QUEUE_NODE *new_queue;
    struct INST_QUEUE_NODE *last_queue;
} WF_INSTR_QUEUE;
typedef s32 SEQUENCE_ENTRIES[SEQ_CFG_MAX_SEQ_IDS];
typedef struct ENTRY_PT_NODE{
    WF_PULSE_ADDR ssp_pulse;
    long *entry_addresses;
    long time;
    struct ENTRY_PT_NODE *next;
} SEQUENCE_LIST;
typedef enum rbw_update_type {OVERWRITE_NONE, OVERWRITE_OPRBW, OVERWRITE_OPRBW2} RBW_UPDATE_TYPE;
typedef enum filter_block_type {SCAN, PRESCAN} FILTER_BLOCK_TYPE;
typedef struct {
  float decimation;
  int tdaq;
  float bw;
  float tsp;
  int fslot;
  int outputs;
  int prefills;
  int taps;
  } FILTER_INFO;
typedef struct
{
    int fit_order;
    int total_bases_per_axis;
    int num_terms[3][56];
    float alpha[3][56][6];
    float tau[3][56][6];
    int termIndex2xyzOrderMapping[3][56];
    int xyzOrder2termIndexMapping[6][6][6];
} HOEC_CAL_INFO;
typedef struct
{
    float hoec_coef[56][3];
    int hoec_xorder[56];
    int hoec_yorder[56];
    int hoec_zorder[56];
} RDB_HOEC_BASES_TYPE;
typedef struct {
    int xfull;
    int yfull;
    int zfull;
    float xfs;
    float yfs;
    float zfs;
    int xrt;
    int yrt;
    int zrt;
    int xft;
    int yft;
    int zft;
    float xcc;
    float ycc;
    float zcc;
    float xbeta;
    float ybeta;
    float zbeta;
    float xirms;
    float yirms;
    float zirms;
    float xipeak;
    float yipeak;
    float zipeak;
    float xamptran;
    float yamptran;
    float zamptran;
    float xiavrgabs;
    float yiavrgabs;
    float ziavrgabs;
    float xirmspos;
    float yirmspos;
    float zirmspos;
    float xirmsneg;
    float yirmsneg;
    float zirmsneg;
    float xpwmdc;
    float ypwmdc;
    float zpwmdc;
} PHYS_GRAD;
typedef struct {
    int x;
    int xy;
    int xz;
    int xyz;
} t_xact;
typedef struct {
    int y;
    int xy;
    int yz;
    int xyz;
} t_yact;
typedef struct {
    int z;
    int xz;
    int yz;
    int xyz;
} t_zact;
typedef struct {
    int xrt;
    int yrt;
    int zrt;
    int xft;
    int yft;
    int zft;
} ramp_t;
typedef struct {
    int xrt;
    int yrt;
    int zrt;
    int xft;
    int yft;
    int zft;
    ramp_t opt;
    t_xact xrta;
    t_yact yrta;
    t_zact zrta;
    t_xact xfta;
    t_yact yfta;
    t_zact zfta;
    float xbeta;
    float ybeta;
    float zbeta;
    float tx_xyz;
    float ty_xyz;
    float tz_xyz;
    float tx_xy;
    float tx_xz;
    float ty_xy;
    float ty_yz;
    float tz_xz;
    float tz_yz;
    float tx;
    float ty;
    float tz;
    float xfs;
    float yfs;
    float zfs;
    float xirms;
    float yirms;
    float zirms;
    float xipeak;
    float yipeak;
    float zipeak;
    float xamptran;
    float yamptran;
    float zamptran;
    float xiavrgabs;
    float yiavrgabs;
    float ziavrgabs;
    float xirmspos;
    float yirmspos;
    float zirmspos;
    float xirmsneg;
    float yirmsneg;
    float zirmsneg;
    float xpwmdc;
    float ypwmdc;
    float zpwmdc;
    float scale_1axis_risetime;
    float scale_2axis_risetime;
    float scale_3axis_risetime;
} LOG_GRAD;
typedef struct {
    float xfs;
    float yfs;
    float zfs;
    int xrt;
    int yrt;
    int zrt;
    float xbeta;
    float ybeta;
    float zbeta;
    float xfov;
    float yfov;
    int xres;
    int yres;
    int ileaves;
    float xdis;
    float ydis;
    float zdis;
    float tsp;
    int osamps;
    float fbhw;
    int vvp;
    float pnsf;
    float taratio;
    float zarea;
} OPT_GRAD_INPUT;
typedef struct {
    float *agxw;
    int *pwgxw;
    int *pwgxwa;
    float *agyb;
    int *pwgyb;
    int *pwgyba;
    float *agzb;
    int *pwgzb;
    int *pwgzba;
    int *frsize;
    int *pwsamp;
    int *pwxgap;
} OPT_GRAD_PARAMS;


typedef __clock_t clock_t;



typedef __time_t time_t;


typedef __clockid_t clockid_t;
typedef __timer_t timer_t;
struct timespec
  {
    __time_t tv_sec;
    __syscall_slong_t tv_nsec;
  };

struct tm
{
  int tm_sec;
  int tm_min;
  int tm_hour;
  int tm_mday;
  int tm_mon;
  int tm_year;
  int tm_wday;
  int tm_yday;
  int tm_isdst;
  long int tm_gmtoff;
  const char *tm_zone;
};


struct itimerspec
  {
    struct timespec it_interval;
    struct timespec it_value;
  };
struct sigevent;
typedef __pid_t pid_t;

extern clock_t clock (void) __attribute__ ((__nothrow__ , __leaf__));
extern time_t time (time_t *__timer) __attribute__ ((__nothrow__ , __leaf__));
extern double difftime (time_t __time1, time_t __time0)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));
extern time_t mktime (struct tm *__tp) __attribute__ ((__nothrow__ , __leaf__));
extern size_t strftime (char *__restrict __s, size_t __maxsize,
   const char *__restrict __format,
   const struct tm *__restrict __tp) __attribute__ ((__nothrow__ , __leaf__));

typedef struct __locale_struct
{
  struct __locale_data *__locales[13];
  const unsigned short int *__ctype_b;
  const int *__ctype_tolower;
  const int *__ctype_toupper;
  const char *__names[13];
} *__locale_t;
typedef __locale_t locale_t;
extern size_t strftime_l (char *__restrict __s, size_t __maxsize,
     const char *__restrict __format,
     const struct tm *__restrict __tp,
     __locale_t __loc) __attribute__ ((__nothrow__ , __leaf__));

extern struct tm *gmtime (const time_t *__timer) __attribute__ ((__nothrow__ , __leaf__));
extern struct tm *localtime (const time_t *__timer) __attribute__ ((__nothrow__ , __leaf__));

extern struct tm *gmtime_r (const time_t *__restrict __timer,
       struct tm *__restrict __tp) __attribute__ ((__nothrow__ , __leaf__));
extern struct tm *localtime_r (const time_t *__restrict __timer,
          struct tm *__restrict __tp) __attribute__ ((__nothrow__ , __leaf__));

extern char *asctime (const struct tm *__tp) __attribute__ ((__nothrow__ , __leaf__));
extern char *ctime (const time_t *__timer) __attribute__ ((__nothrow__ , __leaf__));

extern char *asctime_r (const struct tm *__restrict __tp,
   char *__restrict __buf) __attribute__ ((__nothrow__ , __leaf__));
extern char *ctime_r (const time_t *__restrict __timer,
        char *__restrict __buf) __attribute__ ((__nothrow__ , __leaf__));
extern char *__tzname[2];
extern int __daylight;
extern long int __timezone;
extern char *tzname[2];
extern void tzset (void) __attribute__ ((__nothrow__ , __leaf__));
extern int daylight;
extern long int timezone;
extern int stime (const time_t *__when) __attribute__ ((__nothrow__ , __leaf__));
extern time_t timegm (struct tm *__tp) __attribute__ ((__nothrow__ , __leaf__));
extern time_t timelocal (struct tm *__tp) __attribute__ ((__nothrow__ , __leaf__));
extern int dysize (int __year) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));
extern int nanosleep (const struct timespec *__requested_time,
        struct timespec *__remaining);
extern int clock_getres (clockid_t __clock_id, struct timespec *__res) __attribute__ ((__nothrow__ , __leaf__));
extern int clock_gettime (clockid_t __clock_id, struct timespec *__tp) __attribute__ ((__nothrow__ , __leaf__));
extern int clock_settime (clockid_t __clock_id, const struct timespec *__tp)
     __attribute__ ((__nothrow__ , __leaf__));
extern int clock_nanosleep (clockid_t __clock_id, int __flags,
       const struct timespec *__req,
       struct timespec *__rem);
extern int clock_getcpuclockid (pid_t __pid, clockid_t *__clock_id) __attribute__ ((__nothrow__ , __leaf__));
extern int timer_create (clockid_t __clock_id,
    struct sigevent *__restrict __evp,
    timer_t *__restrict __timerid) __attribute__ ((__nothrow__ , __leaf__));
extern int timer_delete (timer_t __timerid) __attribute__ ((__nothrow__ , __leaf__));
extern int timer_settime (timer_t __timerid, int __flags,
     const struct itimerspec *__restrict __value,
     struct itimerspec *__restrict __ovalue) __attribute__ ((__nothrow__ , __leaf__));
extern int timer_gettime (timer_t __timerid, struct itimerspec *__value)
     __attribute__ ((__nothrow__ , __leaf__));
extern int timer_getoverrun (timer_t __timerid) __attribute__ ((__nothrow__ , __leaf__));

typedef struct timespec GEtimespec;
typedef unsigned short int dbkey_exam_type;
typedef short int dbkey_magic_type;
typedef short int dbkey_series_type;
typedef int dbkey_image_type;
typedef struct {
   char su_id[4];
   dbkey_magic_type mg_no;
   dbkey_exam_type ex_no;
   dbkey_series_type se_no;
   dbkey_image_type im_no;
} DbKey;
typedef char OP_NMRID_TYPE[12];
typedef struct {
 n16 rev;
 n16 length;
 OP_NMRID_TYPE req_nmrid;
 OP_NMRID_TYPE resp_nmrid;
 n16 opcode;
 n16 packet_type;
 n16 seq_num;
 n32 status;
 } OP_HDR1_TYPE;
typedef struct _OP_HDR_TYPE {
 s8 rev;
 s8 endian;
 n16 length;
 OP_NMRID_TYPE req_nmrid;
 OP_NMRID_TYPE resp_nmrid;
 n16 opcode;
 n16 packet_type;
 n16 seq_num;
 n16 pad;
 n32 status;
 } OP_HDR_TYPE;
typedef struct _OP_RECN_READY_TYPE
{
    DbKey dbkey;
    s32 seq_number;
    GEtimespec time_stamp;
    s32 run_no;
    s32 prep_flag;
    n32 patient_checksum;
    char clinicalCoilName[32];
} OP_RECN_READY_TYPE;
typedef struct _OP_RECN_READY_PACK_TYPE
{
    OP_HDR_TYPE hdr;
    OP_RECN_READY_TYPE req;
} OP_RECN_READY_PACK_TYPE;
typedef struct
{
    s32 somes32bitint;
    n16 somen16bitint;
    char somechar;
    unsigned long someulong;
    float somefloat;
} OP_RECN_FOO_TYPE;
typedef struct
{
    OP_HDR_TYPE hdr;
    OP_RECN_FOO_TYPE req;
} OP_RECN_FOO_PACK_TYPE;
typedef struct _OP_RECN_START_TYPE
{
    s32 seq_number;
    GEtimespec time_stamp;
} OP_RECN_START_TYPE;
typedef struct _OP_RECN_START_PACK_TYPE
{
    OP_HDR_TYPE hdr;
    OP_RECN_START_TYPE req;
} OP_RECN_START_PACK_TYPE;
typedef struct
{
    s32 seq_number;
    s32 status;
    s32 aborted_pass_num;
} OP_RECN_SCAN_STOPPED_TYPE;
typedef struct
{
    OP_HDR_TYPE hdr;
    OP_RECN_SCAN_STOPPED_TYPE req;
} OP_RECN_SCAN_STOPPED_PACK_TYPE;
typedef struct
{
    DbKey dbkey;
    s32 seq_number;
    char scan_initiator[12];
} OP_RECN_STOP_TYPE;
typedef struct
{
    OP_HDR_TYPE hdr;
    OP_RECN_STOP_TYPE req;
} OP_RECN_STOP_PACK_TYPE;
typedef struct
{
    s32 seq_number;
} OP_RECN_IM_ALLOC_TYPE;
typedef struct
{
    OP_HDR_TYPE hdr;
    OP_RECN_IM_ALLOC_TYPE req;
} OP_RECN_IM_ALLOC_PACK_TYPE;
typedef struct
{
    s32 seq_number;
} OP_RECN_SCAN_STARTED_TYPE;
typedef struct
{
    OP_HDR_TYPE hdr;
    OP_RECN_SCAN_STARTED_TYPE req;
} OP_RECN_SCAN_STARTED_PACK_TYPE;
extern int fastcard_viewtable[2048];
typedef struct
{
    s32 table_size;
    s32 block_size;
    s32 first_entry_index;
    s32 table[256];
} OP_VIEWTABLE_UPDATE_TYPE;
typedef struct
{
    OP_HDR_TYPE hdr;
    OP_VIEWTABLE_UPDATE_TYPE pkt;
} OP_VIEWTABLE_UPDATE_PACK_TYPE;
typedef struct
{
    n64 mrhdr;
    n64 pixelhdr;
    n64 pixeldata;
    n64 raw_offset;
    n64 raw_receivers;
    n64 pixeldata3;
} MROR_ADDR_BLOCK;
typedef struct
{
    OP_HDR_TYPE hdr;
    MROR_ADDR_BLOCK mrab;
} MROR_ADDR_BLOCK_PKT;
typedef struct
{
    n32 recon_ts;
} MROR_RETRIEVAL_DONE_TYPE;
typedef struct
{
    OP_HDR_TYPE hdr;
    MROR_RETRIEVAL_DONE_TYPE retrieve_done;
} __attribute__((__may_alias__)) MROR_ADDR_BLOCK_PACK_TYPE;
typedef struct
{
    s32 exam_number;
    s32 calib_flag;
} SCAN_CALIB_INFO_TYPE;
typedef struct
{
    OP_HDR_TYPE hdr;
    SCAN_CALIB_INFO_TYPE info;
} SCAN_CALIB_INFO_PACK_TYPE;
typedef struct _OP_RECN_SIZE_CHECK_TYPE
{
    n64 total_bam_size;
    n64 total_disk_size;
} OP_RECN_SIZE_CHECK_TYPE;
typedef struct _OP_RECN_SIZE_CHECK_PACK_TYPE
{
    OP_HDR_TYPE hdr;
    OP_RECN_SIZE_CHECK_TYPE req;
} OP_RECN_SIZE_CHECK_PACK_TYPE;
typedef struct
{
    s32 exam_number;
} EXAM_SCAN_DONE_TYPE;
typedef struct
{
    OP_HDR_TYPE hdr;
    EXAM_SCAN_DONE_TYPE info;
} EXAM_SCAN_DONE_PACK_TYPE;
typedef struct _POSITION_DETECTION_DONE_TYPE
{
    n32 object_detected;
    f32 object_si_position_mm;
    f32 right_most_voxel_mm;
    f32 anterior_most_voxel_mm;
    f32 superior_most_voxel_mm;
    n32 checksum;
} POSITION_DETECTION_DONE_TYPE;
typedef struct _POSITION_DETECTION_DONE_PACK_TYPE
{
    OP_HDR_TYPE hdr;
    POSITION_DETECTION_DONE_TYPE info;
} POSITION_DETECTION_DONE_PACK_TYPE;
typedef struct _OP_CTT_UPDATE_TYPE
{
    s64 calUniqueNo;
    ChannelTransTableEntryType cttentry[4];
    n32 errorCode;
} OP_CTT_UPDATE_TYPE;
typedef struct _OP_CTT_UPDATE_PACK_TYPE
{
    OP_HDR_TYPE hdr;
    OP_CTT_UPDATE_TYPE req;
} OP_CTT_UPDATE_PACK_TYPE;
typedef struct _MAVRIC_CALIBRATION_DONE_TYPE
{
    n32 spectral_bins;
} MAVRIC_CALIBRATION_DONE_TYPE;
typedef struct _MAVRIC_CALIBRATION_DONE_PACK_TYPE
{
    OP_HDR_TYPE hdr;
    MAVRIC_CALIBRATION_DONE_TYPE info;
} MAVRIC_CALIBRATION_DONE_PACK_TYPE;
typedef enum PSD_PSC_CONTROL
{
    PSD_CONTROL_PSC_SKIP = -1,
    APS_CONTROL_PSC = 0,
    PSD_CONTROL_PSC_RUN = 1,
    PSD_CONTROL_PSC_SPECIAL = 2
} PSD_PSC_CONTROL_E;
typedef enum GRADSHIM_SELECTION
{
    GRADSHIM_OFF = 0,
    GRADSHIM_ON = 1,
    GRADSHIM_AUTO = 2
} GRADSHIM_SELECTION_E;
typedef enum PRESSCFH_EXCITATION_TYPE {
    PRESSCFH_SLICE = 1,
    PRESSCFH_SLAB = 2,
    PRESSCFH_SHIMVOL = 3,
    PRESSCFH_SHIMVOL_SLICE = 4,
    PRESSCFH_NONE = 5
} PRESSCFH_EXCITATION_TYPE_E;
typedef struct zy_index {
    n16 view;
    n16 slice;
    n16 flags;
} ZY_INDEX;
typedef struct zy_dist1 {
    float distance;
    n16 view;
    n16 slice;
    n16 flags;
} ZY_DIST1;
typedef struct _RDB_SLICE_INFO_ENTRY
{
    short pass_number;
    short slice_in_pass;
    float gw_point1[3];
    float gw_point2[3];
    float gw_point3[3];
    short transpose;
    short rotate;
    unsigned int coilConfigUID;
    float fov_freq_scale;
    float fov_phase_scale;
    float slthick_scale;
    float freq_loc_shift;
    float phase_loc_shift;
    float slice_loc_shift;
    short sliceGroupId;
    short sliceIndexInGroup;
} RDB_SLICE_INFO_ENTRY;
s32 seqCfgInit(SeqCfgInfo *pSeqCfg,
               const SeqCfgSysCfgInfo *pSysCfg,
               n32 debugOptions);
s32 seqCfgSetRfTxInfo(SeqCfgInfo *pSeqCfg,
                      n32 rfGroupId,
                      n32 txAmp,
                      n32 txCoilType,
                      n32 txNucleus,
                      n32 txChannels);
s32 seqCfgSetAppRfSeqUsage(SeqCfgInfo *pSeqCfg,
                           n32 rfGroupId,
                           n32 txSeqTypes,
                           n32 rxFlag,
                           n32 rxSeqTypes);
s32 seqCfgGetTxConfigs(const SeqCfgInfo *pSeqCfg,
                       n32 rfGroupId,
                       n32 *pTxConfigs,
                       n32 *pNumTxConfigs);
s32 seqCfgSetAppTxUsage(SeqCfgInfo *pSeqCfg,
                        n32 rfGroupId,
                        n32 numAppTxChannels);
s32 seqCfgValidate(SeqCfgInfo *pSeqCfg);
s32 seqCfgGetNumAppSeqs(const SeqCfgInfo *pSeqCfg,
                        n32 *pNumAppSeqs);
s32 seqCfgGetNumSeqs(const SeqCfgInfo *pSeqCfg,
                     n32 *pNumSeqs);
s32 seqCfgLookupSeqId(const SeqCfgInfo *pSeqCfg,
                      n32 rfGroupId,
                      n32 rfGroupTxChannel,
                      n32 rfTxRxType,
                      n32 seqType,
                      n32 *pSeqId);
s32 seqCfgLookupSeqIds(const SeqCfgInfo *pSeqCfg,
                       n32 rfGroupId,
                       n32 rfTxRxType,
                       n32 seqType,
                       n32 *pSeqIds,
                       n32 *pNumSeqIds);
const SeqCfgSeqInfo * seqCfgGetSeqInfo(const SeqCfgInfo *pSeqCfg,
                                       n32 seqId);
extern int cfswgut;
extern int cfswrfut;
extern int cfswssput;
extern int cfhwgut;
extern int cfhwrfut;
extern int cfhwssput;
typedef char EXTERN_FILENAME[80];
typedef char *EXTERN_FILENAME2;


extern void *memcpy (void *__restrict __dest, const void *__restrict __src,
       size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern void *memmove (void *__dest, const void *__src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern void *memccpy (void *__restrict __dest, const void *__restrict __src,
        int __c, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern void *memset (void *__s, int __c, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
extern int memcmp (const void *__s1, const void *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
extern void *memchr (const void *__s, int __c, size_t __n)
      __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));


extern char *strcpy (char *__restrict __dest, const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *strncpy (char *__restrict __dest,
        const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *strcat (char *__restrict __dest, const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *strncat (char *__restrict __dest, const char *__restrict __src,
        size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern int strcmp (const char *__s1, const char *__s2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
extern int strncmp (const char *__s1, const char *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
extern int strcoll (const char *__s1, const char *__s2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
extern size_t strxfrm (char *__restrict __dest,
         const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));

extern int strcoll_l (const char *__s1, const char *__s2, __locale_t __l)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2, 3)));
extern size_t strxfrm_l (char *__dest, const char *__src, size_t __n,
    __locale_t __l) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4)));
extern char *strdup (const char *__s)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __attribute__ ((__nonnull__ (1)));
extern char *strndup (const char *__string, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __attribute__ ((__nonnull__ (1)));

extern char *strchr (const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
extern char *strrchr (const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));


extern size_t strcspn (const char *__s, const char *__reject)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
extern size_t strspn (const char *__s, const char *__accept)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *strpbrk (const char *__s, const char *__accept)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *strstr (const char *__haystack, const char *__needle)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *strtok (char *__restrict __s, const char *__restrict __delim)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));

extern char *__strtok_r (char *__restrict __s,
    const char *__restrict __delim,
    char **__restrict __save_ptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));
extern char *strtok_r (char *__restrict __s, const char *__restrict __delim,
         char **__restrict __save_ptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));

extern size_t strlen (const char *__s)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));

extern size_t strnlen (const char *__string, size_t __maxlen)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));

extern char *strerror (int __errnum) __attribute__ ((__nothrow__ , __leaf__));

extern int strerror_r (int __errnum, char *__buf, size_t __buflen) __asm__ ("" "__xpg_strerror_r") __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));
extern char *strerror_l (int __errnum, __locale_t __l) __attribute__ ((__nothrow__ , __leaf__));
extern void __bzero (void *__s, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
extern void bcopy (const void *__src, void *__dest, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern void bzero (void *__s, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
extern int bcmp (const void *__s1, const void *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *index (const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
extern char *rindex (const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
extern int ffs (int __i) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));
extern int strcasecmp (const char *__s1, const char *__s2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
extern int strncasecmp (const char *__s1, const char *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *strsep (char **__restrict __stringp,
       const char *__restrict __delim)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *strsignal (int __sig) __attribute__ ((__nothrow__ , __leaf__));
extern char *__stpcpy (char *__restrict __dest, const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *stpcpy (char *__restrict __dest, const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *__stpncpy (char *__restrict __dest,
   const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *stpncpy (char *__restrict __dest,
        const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

STATUS EpicConf(void);
extern SHORT DAB_length[2];
extern SHORT DAB_bits[2][16];
extern LONG DAB_start;
extern SHORT PROPDAB_length[2];
extern SHORT PROPDAB_bits[2][23];
extern LONG PROPDAB_start;
extern SHORT XTR_length[2];
extern SHORT XTR_bits[2][18];
extern LONG XTR_start;
extern SHORT RBA_length[2];
extern SHORT RBA_bits[2][12];
extern LONG RBA_start;
extern SHORT FAST_RBA_length;
extern SHORT FAST_RBA_bits[];
extern LONG FAST_RBA_start;
extern SHORT FAST_PROG_length;
extern SHORT FAST_PROG_bits[];
extern LONG FAST_PROG_start;
extern SHORT FAST_DIAG_length;
extern SHORT FAST_DIAG_bits[];
extern LONG FAST_DIAG_start;
extern SHORT SUF_length;
extern SHORT SUF_bits[];
extern LONG SUF_start;
extern SHORT HSDAB_length;
extern SHORT HSDAB_bits[];
extern SHORT HSDAB_start;
extern SHORT DIFFDAB_length;
extern SHORT DIFFDAB_bits[];
extern SHORT DIFFDAB_start;
extern SHORT COPY_DAB_length;
extern SHORT COPY_DAB_bits[];
extern SHORT COPY_DAB_start;
extern SHORT txatten_bits[17];
extern SHORT DIM_length;
extern SHORT DIM_bits[];
extern LONG DIM_start;
extern SHORT DIM2_length;
extern SHORT DIM2_bits[];
extern LONG DIM2_start;
extern SHORT sq_sync_length[2];
extern SHORT sq_sync_bits[2][13];
extern SHORT sq_lockout_length;
extern SHORT sq_lockout_bits[];
extern SHORT pass_length;
extern SHORT pass_bits[];
extern LONG pass_start;
extern SHORT ATTEN_unlock_length[2];
extern SHORT ATTEN_unlock_bits[2][6];
extern LONG ATTEN_start;
extern INT psd_gxwcnt;
extern INT psd_pulsepos;
extern INT psd_eparity;
extern FLOAT psd_etbetax, psd_etbetay;
extern CHAR psd_epstring[];
extern LONG rfupa;
extern LONG rfupd;
extern LONG rfublwait;
extern INT EDC;
extern INT RDC;
extern INT ECF;
extern INT EMISC;
extern INT ESSL;
extern INT ESYNC;
extern INT ETHETA;
extern INT EUBL;
extern INT EXTATTEN;
extern INT ERFREQ;
extern INT ERPHASE;
extern INT RFLTRS;
extern INT RFLTRC;
extern INT RFUBL;
extern INT RSYNC;
extern INT RATTEN;
extern INT RRFSEL;
extern INT ESEL0;
extern INT ESEL1;
extern INT ESEL_ALL;
extern INT RSEL0;
extern INT RSEL1;
extern INT RSEL_ALL;
extern INT RATTEN_ALL;
extern INT RATTEN_1;
extern INT RATTEN_2;
extern INT RATTEN_3;
extern INT RATTEN_4;
extern INT RLOOP;
extern INT RHEADI;
extern INT RFAUX;
extern INT RFBODYI;
extern INT ECCF;
extern INT EDSYNC;
extern INT EMRST;
extern INT EMSSS1;
extern INT EMSSS2;
extern INT EMSSS3;
extern INT ESSP;
extern INT EXUBL;
extern INT EDDSP;
extern INT EATTEN_TEST;
extern INT ETHETA_L;
extern INT EOMEGA_L;
extern INT RBA;
extern INT RBL;
extern INT RFF;
extern INT RDSYNC;
extern INT RSAD;
extern INT RSUF;
extern INT RUBL;
extern INT RUBL_1;
extern INT RUBL_2;
extern INT RUBL_3;
extern INT RUBL_4;
extern INT RATTEN_FSEL;
extern INT RATTEN_3DB;
extern INT RATTEN_6DB;
extern INT RATTEN_12DB;
extern INT RATTEN_23DB;
extern INT FAST_EDC;
extern INT FAST_RDC;
extern INT FAST_RFLTRS;
extern INT RFHUBSEL;
extern INT HUBIND;
extern INT R1IND;
extern INT EXTATTEN_Q;
extern INT DB_I;
extern INT DB_Q;
extern INT PHASELAG_Q;
extern INT SRI_C;
ADDRESS
AllocNode( LONG size );
STATUS
FreeNode( ADDRESS address );
STATUS
FreePSDHeap( void );
ADDRESS
TempAllocNode( LONG size );
STATUS
acqq( WF_PULSE_ADDR pulse,
      const int pos_ref,
      const int dab_ref,
      const int xtr_ref,
      const int fslot_value,
      TYPDAB_PACKETS cine_flag );
STATUS
acqq2( WF_PULSE_ADDR dabpulse,
       WF_PULSE_ADDR rcvpulse,
       LONG pos_ref,
       LONG fslot_value,
       LONG dabstart,
       TYPDAB_PACKETS cine_flag,
       TYPACQ_PASS passthrough_flag );
STATUS
addrfbits( WF_PULSE_ADDR pulse,
           LONG offset,
           LONG refstart,
           LONG refduration );
STATUS
AddToInstrQueue( WF_INSTR_QUEUE *queue,
                 WF_INSTR_HDR *instr_ptr );
STATUS
AddToPsdQ( WF_PULSE_ADDR pulse );
STATUS
addubr( WF_PULSE_ADDR pulse,
        LONG pos_ref );
STATUS
bridgeTrap( WF_PULSE_ADDR *pulses,
            LONG n_pulses,
            bool bridge_first,
            WF_INSTR_QUEUE *queue );
STATUS
BuildBridgesIn( WF_INSTR_QUEUE *queue );
STATUS
buildinstr( void );
void
CleanUp( void );
STATUS
create3dim( WF_PULSE_ADDR pulse,
            LONG pos_readout,
            LONG pos_ref );
STATUS
create3dim2( WF_PULSE_ADDR pulse,
             LONG pos_readout,
             LONG pos_ref );
STATUS
createatten( WF_PULSE_ADDR pulse,
             LONG start );
STATUS
createbits( WF_PULSE_ADDR pulse,
            WF_PROCESSOR waveform_gen,
            INT resol,
            SHORT *bits_array );
STATUS
createcine( WF_PULSE *pulse,
            const CHAR *name );
STATUS
createconst( WF_PULSE_ADDR pulse,
             WF_PROCESSOR waveform_gen,
             LONG pulse_width,
             INT amplitude );
STATUS
creatediffdab( WF_PULSE_ADDR pulse,
             LONG pos_ref );
STATUS
createextwave( WF_PULSE_ADDR pulse,
               WF_PROCESSOR waveform_gen,
               INT resol,
               CHAR *ext_wave_pathname );
STATUS
createhadamard( WF_PULSE_ADDR pulse,
                WF_PROCESSOR waveform_gen,
                INT resol,
                INT amplitude,
                DOUBLE sep,
                DOUBLE ncycles,
                DOUBLE alpha );
STATUS
createhscdab( WF_PULSE_ADDR pulse,
              LONG pos_ref,
              TYPDAB_PACKETS cine_flag );
STATUS
createhsdab( WF_PULSE_ADDR pulse,
             LONG pos_ref );
STATUS
createinstr( WF_PULSE_ADDR pulse,
             LONG start,
             LONG pulse_width,
             LONG ampl );
STATUS
createpass( WF_PULSE_ADDR pulse,
            LONG start );
STATUS
CreatePulse( WF_PULSE_ADDR pulse,
             SeqData seqdata,
             WF_PROCESSOR waveform_gen,
             WF_PULSE_TYPES waveform_type,
             INT resol,
             WF_PULSE_EXT *extension,
             WF_HW_WAVEFORM_PTR wave_addr );
STATUS
createramp( WF_PULSE_ADDR pulse,
            WF_PROCESSOR waveform_gen,
            LONG pulse_width,
            INT start_amp,
            INT end_amp,
            INT resol,
            DOUBLE ramp_beta );
STATUS
createreserve( WF_PULSE_ADDR pulse,
               WF_PROCESSOR waveform_gen,
               INT resol );
STATUS
createsinc( WF_PULSE_ADDR pulse,
            WF_PROCESSOR waveform_gen,
            INT resol,
            INT amplitude,
            DOUBLE ncycles,
            DOUBLE alpha );
STATUS
createsinusoid( WF_PULSE_ADDR pulse,
                WF_PROCESSOR waveform_gen,
                INT resol,
                INT amplitude,
                DOUBLE start_phase,
                DOUBLE phase_length,
                INT offset );
STATUS
createseq( WF_PULSE_ADDR ssp_pulse,
           LONG length,
           long int *entry_array );
STATUS
createtraps( WF_PROCESSOR wgname,
             WF_PULSE *traparray,
             WF_PULSE *traparraya,
             WF_PULSE *traparrayd,
             INT ia_start,
             INT ia_end,
             DOUBLE a_base,
             DOUBLE a_delta,
             INT nsteps,
             INT pw_plateau,
             INT pw_attack,
             INT pw_decay,
             INT slope_direction,
             DOUBLE target_amp,
             DOUBLE beta );
STATUS
createubr( WF_PULSE_ADDR pulse,
           LONG pos_ref,
           const INT index );
INT
createwramp( WF_PULSE_ADDR pulse,
            WF_PROCESSOR waveform_gen,
            INT resol,
            INT start_amp,
            INT end_amp,
            DOUBLE ramp_beta );
INT
createwreserve( WF_PULSE_ADDR pulse,
               WF_PROCESSOR waveform_gen,
               INT resol );
void
destroyExtWave( void );
STATUS
epiacqq( WF_PULSE_ADDR pulse,
         LONG pos_ref,
         LONG dab_ref,
         LONG xtr_ref,
         LONG fslot_value,
         TYPDAB_PACKETS cine_flag,
         LONG receiver_type,
         LONG dab_on );
STATUS
fastAddrfbits( WF_PULSE_ADDR pulse,
               LONG offset,
               LONG refstart,
               LONG refduration,
               LONG init_ublnk_time );
STATUS
FreePsdsQ( void );
int
get_disable_amplifier_unblank( void );
int
get_disable_exciter_unblank( void );
int
getAppTxChannels( void );
WF_INSTR_HDR*
GetFreqInstrNode( WF_PULSE *this_pulse,
                   LONG index,
                   const CHAR *name );
STATUS
getInstrSeqDataPulse(SeqData * seqdata,
                     WF_PULSE_ADDR pulse,
                     int opmode);
STATUS
getInstrSeqDataPulsePtx(SeqData * seqdata,
                        WF_PULSE_ADDR pulse,
                        int channel_index);
STATUS
getInstrSeqDataSeqID(SeqData * seqdata,
                     int seqid,
                     int opmode);
STATUS
getInstrSeqOpt(int * seqopt,
               int seqid,
               int opmode);
LONG
GetMinPeriod( WF_PROCESSOR waveform_gen,
              LONG pulse_width,
              const INT sworhw_flag );
int
getNumAppTxChannels(int rfgroup);
int
getNumSecSsps(void);
STATUS
getNumSeqIDs(int * numIDs);
int
getNumSeqs(void);
WF_INSTR_HDR*
GetPulseInstrNode( WF_PULSE_ADDR pulse,
                    LONG position );
int
getSecSspId(int seqid);
void *
getSeqCfgData(void);
STATUS
getSeqID(int * seqid,
         int rfgroup,
         int seqname,
         int txchannel,
         int rxflag);
const SeqCfgSeqInfo *
getSeqInfo(int seqID);
int
getSeqLegacyName(int seqid);
int
getTxRxType(int seqname,
            int rxflag);
STATUS
getWaveSeqDataPulse(SeqData * seqdata,
                    WF_PULSE_ADDR pulse, int opmode);
STATUS
getWaveSeqDataPulsePtx(SeqData * seqdata,
                       WF_PULSE_ADDR pulse, int channel_index);
STATUS
getWaveSeqDataWavegen(SeqData * seqdata,
                      WF_PROCESSOR wgen,
                      int rfgroup,
                      int ptxflag,
                      int rxflag, int opmode);
STATUS
getWaveSeqOpt(int * seqopt,
              int rfgroup,
              int seqname,
              int ptxflag,
              int rxflag,
              int opmode);
void
init_pgen_times( void );
void
init_wf_queue(void);
STATUS
initSeqCfg(void);
int
isPgenSeq(int seqid);
int
isRFEnvelopeWaveformGenerator( const WF_PROCESSOR waveform_gen_rf );
int
isRFWaveformGenerator( const WF_PROCESSOR waveform_gen_rf );
int
isTxSeq(int seqid);
STATUS
linkpulses( INT l_arg,
            ... );
STATUS
mapWavegen2SeqName(int * seqname,
                   WF_PROCESSOR waveform_gen);
STATUS
movestretchedwave( const char* fileloc,
                   const int old_res,
                   WF_PULSE_ADDR pulse,
                   const int pulse_index,
                   const int new_res );
STATUS
movewave( SHORT *pulse_mem,
          WF_PULSE_ADDR pulse,
          LONG index,
          INT resolution,
          HW_DIRECTION direction );
STATUS
movewaveimm( SHORT *pulse_mem,
             WF_PULSE_ADDR pulse,
             LONG index,
             INT resolution,
             HW_DIRECTION direction );
STATUS
movewaveimmPtx(SHORT *pulse_mem,
               WF_PULSE_ADDR pulse,
               LONG index,
               INT resolution,
               HW_DIRECTION direction,
               INT channel_index);
STATUS
movewaveimmPtxall(SHORT **pulse_mem,
                  INT arraysize,
                  WF_PULSE_ADDR pulse,
                  LONG index,
                  INT resolution,
                  HW_DIRECTION direction);
STATUS
movewavememimm(WF_PULSE_ADDR pulse,
             WF_PROCESSOR waveform_gen,
             SHORT * pulse_mem,
             WF_HW_WAVEFORM_PTR moveto_mem,
             INT resolution,
             HW_DIRECTION direction );
STATUS
movewaversp( void );
LONG
pbeg( WF_PULSE_ADDR pulse,
      const CHAR *pulse_name,
      LONG index );
LONG
pbegall( WF_PULSE_ADDR pulse,
         LONG index );
LONG
pbegallssp( WF_PULSE_ADDR pulse,
            LONG index );
LONG
pend( WF_PULSE_ADDR pulse,
      const CHAR *pulse_name,
      LONG index );
LONG
pendall( WF_PULSE_ADDR pulse,
         LONG index );
LONG
pendallssp( WF_PULSE_ADDR pulse,
            LONG index );
LONG
pmid( WF_PULSE_ADDR pulse,
      const CHAR *pulse_name,
      LONG index );
LONG
pmidall( WF_PULSE_ADDR pulse,
         LONG index );
void
print_pgen_times( void );
void
printExtWave( void );
STATUS
propAcqq( WF_PULSE_ADDR pulse,
      LONG pos_ref,
      LONG dab_ref,
      LONG xtr_ref,
      LONG fslot_value);
STATUS
pulsename( WF_PULSE_ADDR pulse,
           const CHAR *pulse_name );
void
requestTransceiver( int bd_type,
                    exciterSelection e,
                    receiverSelection r );
void
requestTransceiverDemod( int bd_type,
                         exciterSelection e,
                         receiverSelection r,
                         demodSelection o,
                         navSelection n );
void
RFEnvelopeWaveformGeneratorCheck( const CHAR *pulse_name,
                                  const WF_PROCESSOR waveform_gen );
void
RFWaveformGeneratorCheck( const CHAR *pulse_name,
                          const WF_PROCESSOR waveform_gen );
void
SetHWMem( void );
STATUS
setnullpulsename( WF_PULSE_ADDR pulse);
STATUS
setPgenSeqFlag(int seqtype,
          int seqid,
          int * pgenflag);
STATUS
setPSDtags( WF_PULSE_ADDR pulse,
            WF_PGMREUSE reuse,
            WF_PGMTAG tag,
            LONG addtag,
            INT id,
            INT board_type,
            STATUS force );
STATUS
setptxflag(WF_PULSE_ADDR pulse,
           int ptxflag);
INT
SetResol( LONG pulse_width,
          LONG min_period );
STATUS
setrfcontrol( SHORT selectamp,
              int mod_number,
              WF_PULSE_ADDR pulse,
              LONG index );
STATUS
setrfgroup(WF_PULSE_ADDR pulse,
           int rfgroup);
STATUS
setrxflag(WF_PULSE_ADDR pulse,
          int rxflag);
STATUS
setSeqLegacyName(int seqtype,
                  int * legacyname);
STATUS
settransceiver( INT board );
STATUS
setTxSeqFlag(int seqtype,
        int * txflag);
STATUS
setupSeqCfg(int rfgroup,
            int numapptxchannels,
            int rxflag,
            int rxtheta,
            int rxomega);
STATUS
setweos( INT eos_flag,
         WF_PULSE_ADDR pulse,
         LONG index );
STATUS
sortOutSeqs(int rfgroup);
STATUS
sspinit( INT psd_board_type );
STATUS
stretchpulse( INT oldres,
              INT newres,
              SHORT *opulse,
              SHORT *newpulse );
STATUS
trapezoid( WF_PROCESSOR wgname,
           const CHAR *name,
           WF_PULSE_ADDR pulseptr,
           WF_PULSE_ADDR pulseptra,
           WF_PULSE_ADDR pulseptrd,
           LONG pw_pulse,
           LONG pw_pulsea,
           LONG pw_pulsed,
           LONG ia_pulse,
           LONG ia_pulsewa,
           LONG ia_pulsewb,
           LONG ia_start,
           LONG ia_end,
           LONG position,
           LONG trp_parts,
           LOG_GRAD *loggrd );
typedef enum DATA_FRAME_DESTINATION
{
    ROUTE_TO_RECON = 0,
    ROUTE_TO_RTP
} DATA_FRAME_DESTINATION_E;
STATUS
acqctrl( TYPDAB_PACKETS acqon_flag,
         RECEIVER_SPEED_E recvr,
         WF_PULSE_ADDR pulse );
STATUS
copyframe( WF_PULSE_ADDR pulse,
           LONG frame_control,
           s32 pass_src,
           LONG slice_src,
           LONG echo_src,
           s32 view_src,
           s32 pass_des,
           LONG slice_des,
           LONG echo_des,
           s32 view_des,
           LONG nframes,
           TYPDAB_PACKETS acqon_flag );
STATUS
dabrecorder( int record_mask );
STATUS
initfastrec( WF_PULSE_ADDR pulse,
             LONG pos_ref,
             LONG xres,
             LONG tsptics,
             LONG deltics,
             LONG lpf );
STATUS
loaddab( WF_PULSE_ADDR pulse,
         LONG slice,
         LONG echo,
         LONG oper,
         LONG view,
         TYPDAB_PACKETS acqon_flag,
         LONG ctrlmask );
STATUS
loaddab_hub_r1( WF_PULSE_ADDR pulse,
                LONG slice,
                LONG echo,
                LONG oper,
                LONG view,
                LONG hubIndex,
                LONG r1Index,
                TYPDAB_PACKETS acqon_flag,
                LONG ctrlmask );
STATUS
loadpropdab( WF_PULSE_ADDR pulse,
             LONG oper,
             LONG frameType,
             LONG instanceIndex,
             s32 sliceIndex,
             s32 echotrainIndex,
             s32 bladeIndex,
             s32 bladeViewIndex,
             s32 bladeAngle,
             LONG bValIndex,
             s32 diffDirIndex,
             LONG volIndex,
             TYPDAB_PACKETS acqon_flag,
             LONG ctrlmask );
STATUS
loaddabwithnex( WF_PULSE_ADDR pulse,
                s32 nex,
                LONG slice,
                LONG echo,
                LONG oper,
                LONG view,
                TYPDAB_PACKETS acqon_flag,
                LONG ctrlmask );
STATUS
loaddabwithangle( WF_PULSE_ADDR pulse,
                  s32 angle,
                  LONG slice,
                  LONG echo,
                  LONG oper,
                  LONG view,
                  TYPDAB_PACKETS acqon_flag,
                  LONG ctrlmask );
STATUS
loaddab2( WF_PULSE_ADDR pulse,
          WF_PULSE_ADDR rbapulse,
          LONG slice,
          LONG echo,
          LONG oper,
          LONG view,
          TYPDAB_PACKETS acqon_flag );
STATUS
load3d( WF_PULSE_ADDR pulse,
        s32 view,
        TYPDAB_PACKETS acqon_flag );
STATUS
loaddabecho( WF_PULSE_ADDR pulse,
             LONG echo );
STATUS
loaddaboper( WF_PULSE_ADDR pulse,
             LONG oper );
STATUS
loaddabset( WF_PULSE_ADDR pulse,
            TYPDAB_PACKETS dab_acq,
            TYPDAB_PACKETS rba_acq );
STATUS
loaddabslice( WF_PULSE_ADDR pulse,
              LONG slice );
STATUS
loaddabview( WF_PULSE_ADDR pulse,
             LONG view );
STATUS
load3decho( WF_PULSE_ADDR pulse,
            s32 view,
            s32 echo,
            TYPDAB_PACKETS acqon_flag );
STATUS
loadcine( WF_PULSE_ADDR pulse,
          INT arr,
          INT op,
          s32 pview,
          INT frame1,
          INT frame2,
          INT frame3,
          INT frame4,
          s32 delay,
          s32 fslice,
          TYPDAB_PACKETS acqon_flag );
STATUS
loaddiffdab( WF_PULSE_ADDR pulse,
             LONG ecno,
             LONG dab_op,
             LONG frame,
             LONG instance,
             s32 slnum,
             s32 vstart,
             s32 vskip,
             s32 numv,
             LONG bindex,
             s32 dirindex,
             LONG vol,
             LONG gradpol,
             TYPDAB_PACKETS acqon_flag,
             LONG ctrlmask );
STATUS
loadhsdab( WF_PULSE_ADDR pulse,
           s32 slnum,
           LONG ecno,
           LONG dab_op,
           s32 vstart,
           s32 vskip,
           s32 vnum,
           LONG card_rpt,
           LONG k_read,
           TYPDAB_PACKETS acqon_flag,
           LONG ctrlmask );
STATUS
routeDataFrameDab( WF_PULSE_ADDR dab_pulse,
                   const DATA_FRAME_DESTINATION_E destination,
                   const INT coilswitchmethod );
STATUS
routeDataFrameXtr( WF_PULSE_ADDR xtr_pulse,
                   const DATA_FRAME_DESTINATION_E destination,
                   const INT coilswitchmethod );
STATUS
setEpifilter( s32 filter_no,
              WF_PULSE_ADDR pulse );
STATUS
setrfltrs( s32 filter_no,
           WF_PULSE_ADDR pulse );
typedef enum DABOUTHUBINDEX
{
    DABOUTHUBINDEX_NOSWITCH = 0,
    DABOUTHUBINDEX_PRIMARY,
    DABOUTHUBINDEX_SECONDARY
} DABOUTHUBINDEX_E;
STATUS
attenflagoff( WF_PULSE_ADDR pulse,
              LONG index );
STATUS
attenflagon( WF_PULSE_ADDR pulse,
             LONG index );
STATUS
attenlockoff( WF_PULSE_ADDR pulse );
STATUS
attenlockon( WF_PULSE_ADDR pulse );
STATUS
boffset( s32* offsets );
STATUS
BoreOverTemp( INT monitor_temp,
              INT debug );
STATUS
calcdelay( FLOAT *delay_val,
           INT control,
           DOUBLE gldelayx,
           DOUBLE gldelayy,
           DOUBLE gldelayz,
           INT *defaultdelay,
           INT nslices,
           INT gradmode,
           INT debug,
           long(*rsprot)[9] );
STATUS
calcdelayfile( FLOAT *delay_val,
               INT control,
               DOUBLE gldelayx,
               DOUBLE gldelayy,
               DOUBLE gldelayz,
               INT *defaultdelay,
               INT nslices,
               INT debug,
               long(*rsprot)[9],
               FLOAT *buffer );
LONG
calciphase( DOUBLE phase );
STATUS
getctrl( long *ctrl,
         WF_PULSE_ADDR pulse,
         LONG index );
STATUS
getiamp( SHORT *amplitude,
         WF_PULSE_ADDR pulse,
         LONG index );
STATUS
getieos( SHORT *eos,
         WF_PULSE_ADDR pulse,
         LONG index );
STATUS
getiphase( INT *phase,
           WF_PULSE_ADDR pulse,
           LONG index );
STATUS
getiwave( long *waveform_ix,
          WF_PULSE_ADDR pulse,
          LONG index );
STATUS
getperiod( long *period,
           WF_PULSE_ADDR pulse,
           LONG index );
STATUS
getphase( FLOAT *phase,
          WF_PULSE_ADDR pulse,
          LONG index );
STATUS
getpulse( WF_PULSE_ADDR *ret_pulse,
          WF_PULSE_ADDR pulse,
          WF_PGMTAG tagfield,
          INT id,
          LONG index );
STATUS
getssppulse( WF_PULSE_ADDR *ssppulse,
             WF_PULSE_ADDR pulse,
             const CHAR *pulsesuff,
             LONG index );
STATUS
getssppulse_modal( WF_PULSE_ADDR *ssppulse,
                   WF_PULSE_ADDR pulse,
                   const CHAR *pulsesuff,
                   LONG index,
                   LONG exit_mode );
STATUS
getwamp( SHORT *amplitude,
         WF_PULSE_ADDR pulse,
         LONG index );
STATUS
getwave( LONG *waveform_ix,
         WF_PULSE_ADDR pulse );
STATUS
getweos( SHORT *eos,
         WF_PULSE_ADDR pulse,
         LONG index );
void
init_wf_queue(void);
int
isRFEnvelopeWaveformGenerator( const WF_PROCESSOR waveform_gen_rf );
int
isRFWaveformGenerator( const WF_PROCESSOR waveform_gen_rf );
STATUS
movewave( SHORT *pulse_mem,
          WF_PULSE_ADDR pulse,
          LONG index,
          INT resolution,
          HW_DIRECTION direction );
STATUS
movewaveimmPtx(SHORT *pulse_mem,
               WF_PULSE_ADDR pulse,
               LONG index,
               INT resolution,
               HW_DIRECTION direction,
               INT channel_index);
STATUS
movewaveimmPtxall(SHORT **pulse_mem,
                  INT arraysize,
                  WF_PULSE_ADDR pulse,
                  LONG index,
                  INT resolution,
                  HW_DIRECTION direction);
void
psdexit( INT ermes_no,
         INT abcode,
         const CHAR *txt_str,
         const CHAR *routine,
         ... );
STATUS
psd_update_spu_hrate( LONG hrate );
STATUS
psd_update_spu_trigger_window( LONG trigger_window );
STATUS
rfoff( WF_PULSE_ADDR pulse,
       LONG index );
STATUS
rfon( WF_PULSE_ADDR pulse,
      LONG index );
STATUS
scopeoff( WF_PULSE_ADDR pulse );
STATUS
scopeon( WF_PULSE_ADDR pulse );
const char*
segmentName( const s32* segment );
void
segmentToPlay( const s32* segment );
STATUS
setattenlock( STATUS restore_flag,
              WF_PULSE_ADDR pulse );
STATUS
setctrl( LONG ctrl_mask,
         WF_PULSE_ADDR pulse,
         LONG index );
STATUS
setdaboutcoilswitchhubindex( WF_PULSE_ADDR dab_pulse,
                             const DABOUTHUBINDEX_E index,
                             const INT coilswitchmethod );
STATUS
setfastdly( WF_PULSE_ADDR pulse,
            LONG deltics );
STATUS
setfreqarray( s32* frequency,
              WF_PULSE_ADDR pulse,
              LONG arraySize );
STATUS
setfreqphase( s32 frequency,
              s32 phase,
              WF_PULSE_ADDR pulse );
STATUS
setfrequency( LONG frequency,
              WF_PULSE_ADDR pulse,
              LONG index );
void
SetHWMem( void );
STATUS
setiamp( INT amplitude,
         WF_PULSE_ADDR pulse,
         LONG index );
STATUS
setiampall( INT amplitude,
            WF_PULSE_ADDR pulse,
            LONG index );
STATUS
setiamparray(SHORT* amplitude,
             WF_PULSE_ADDR pulse,
             LONG arraySize);
STATUS
setiampimm( INT amplitude,
            WF_PULSE_ADDR pulse,
            LONG index );
STATUS
setiampiter( INT * amplitude,
             INT num_iters,
             WF_PULSE_ADDR pulse,
             LONG index,
             INT sign_flag);
STATUS
setiampPtx(INT amplitude,
           WF_PULSE_ADDR pulse,
           LONG index,
           INT channel_index);
STATUS
setiampPtxall(INT * amplitude,
              INT arrarsize,
              WF_PULSE_ADDR pulse,
              LONG index);
STATUS
setiampPtxallsign(INT * amplitude,
                  INT sign_flag,
                  INT arrarsize,
                  WF_PULSE_ADDR pulse,
                  LONG index);
STATUS
setiampssp( LONG amplitude,
            WF_PULSE_ADDR pulse,
            LONG index );
STATUS
setiampt( INT amplitude,
          WF_PULSE_ADDR pulse,
          LONG index );
STATUS
setiamptimm( INT amplitude,
             WF_PULSE_ADDR pulse,
             LONG index );
STATUS
setiamptiter( INT * amplitude,
              INT num_iters,
              WF_PULSE_ADDR pulse,
              LONG index,
              INT sign_flag);
STATUS
setieos( INT eos_flag,
         WF_PULSE_ADDR pulse,
         LONG index );
STATUS
setiphase( s32 phase,
           WF_PULSE_ADDR pulse,
           LONG index );
STATUS
setiphasePtx(LONG phase,
             WF_PULSE_ADDR pulse,
             LONG index,
             INT channel_index);
STATUS
setiphasePtxall(LONG * phase,
                INT arraysize,
                WF_PULSE_ADDR pulse,
                LONG index);
STATUS
setiphasePtxallplus(LONG phase0,
                    LONG * phase,
                    INT arraysize,
                    WF_PULSE_ADDR pulse,
                    LONG index);
STATUS
setmrtouchdriver( const float freq,
                  const int cycles,
                  const int amp );
STATUS
setperiod( LONG period,
           WF_PULSE_ADDR pulse,
           LONG index );
STATUS
setphase( DOUBLE phase,
          WF_PULSE_ADDR pulse,
          LONG index );
STATUS
setphasearray( s32* phase,
               WF_PULSE_ADDR pulse,
               LONG arraySize );
STATUS
setphasePtx(DOUBLE phase,
            WF_PULSE_ADDR pulse,
            LONG index,
            INT channel_index);
STATUS
setphasePtxall(DOUBLE * phase,
               INT arraysize,
               WF_PULSE_ADDR pulse,
               LONG index);
STATUS
setphasePtxallplus(DOUBLE phase0,
                   DOUBLE * phase,
                   INT arraysize,
                   WF_PULSE_ADDR pulse,
                   LONG index);
STATUS
setrf( STATUS restore_flag,
       WF_PULSE_ADDR pulse,
       LONG index );
STATUS
settransceiver( INT board );
STATUS
settxattenabs( WF_PULSE_ADDR pulse,
               int wavegen_type,
               int txAttenI,
               int txAttenQ,
               float phaseQoffset );
STATUS
settxattendelta( WF_PULSE_ADDR pulse,
                 int wavegen_type,
                 int deltaTxAttenI,
                 int deltaTxAttenQ,
                 float deltaPhaseQoffset );
STATUS
setwamp( INT amplitude,
         WF_PULSE_ADDR pulse,
         LONG index );
STATUS
setwampimm( INT amplitude,
            WF_PULSE_ADDR pulse,
            LONG index );
STATUS
setwave( WF_HW_WAVEFORM_PTR waveform_ix,
         WF_PULSE_ADDR pulse,
         LONG index );
void
simulationInit( long *rot_ptr );
STATUS
sspextload( s32 *loc_addr,
            WF_PULSE_ADDR pulse,
            LONG index,
            INT resolution,
            HW_DIRECTION direction,
            SSP_S_ATTRIB s_attr );
STATUS
sspextloadPtx(LONG *loc_addr1,
              WF_PULSE_ADDR pulse,
              LONG index, INT resolution,
              HW_DIRECTION direction,
              SSP_S_ATTRIB s_attr,
              INT channel_index);
STATUS
sspload( SHORT *loc_addr,
         WF_PULSE_ADDR pulse,
         LONG index,
         INT resolution,
         HW_DIRECTION direction,
         SSP_S_ATTRIB s_attr );
STATUS
startseq( s16 slice_index,
          s16 pause_attribute );
STATUS
stretchpulse( INT oldres,
              INT newres,
              SHORT *opulse,
              SHORT *newpulse );
STATUS
syncon( WF_PULSE_ADDR pulse );
STATUS
syncoff( WF_PULSE_ADDR pulse );
STATUS
TimeHist( const CHAR *ipgname );
void epic_error( const int ermes, const char *plain_fmt, const int ermes_num,
                 const int num_args, ... );
int log_error(const char* pathname, const char* filename, const int headerinfo,
              const char* format, ...);
STATUS aps1( void );
STATUS aps2( void );
STATUS autoshim( void );
STATUS calcPulseParams( int max_encode_mode );
STATUS cfh( void );
STATUS cfl( void );
STATUS cvcheck( void );
STATUS cveval( void );
STATUS cvevaliopts( void );
STATUS cvfeatureiopts( void );
STATUS cvinit( void );
STATUS cvsetfeatures( void );
STATUS fasttg( void );
STATUS expresstg( void );
STATUS mps1( void );
STATUS mps2( void );
STATUS mapTg( void );
STATUS predownload( void );
n32 psdcleanup(n32 abort);
STATUS psdinit( void );
void psd_init_iopts( void );
STATUS pulsegen( void );
STATUS scan( void );
STATUS scanloop( void );
STATUS syscheck( INT *syscheck_safety_limit, int *status_flag );
extern INT EDC;
extern INT RDC;
extern INT ECF;
extern INT EMISC;
extern INT ESSL;
extern INT ESYNC;
extern INT ETHETA;
extern INT EUBL;
extern INT EXTATTEN;
extern INT EXTATTEN_Q;
extern INT PHASELAG_Q;
extern INT DDIQSWOC;
extern INT DB_I;
extern INT DB_Q;
extern INT SRI_C;
extern INT RFHUBSEL;
extern INT HUBIND;
extern INT R1IND;
extern INT ERFREQ;
extern INT ERPHASE;
extern INT RFLTRS;
extern INT RFLTRC;
extern INT RFUBL;
extern INT RSYNC;
extern INT RATTEN;
extern INT RRFSEL;
extern INT ESEL0;
extern INT ESEL1;
extern INT ESEL_ALL;
extern INT RSEL0;
extern INT RSEL1;
extern INT RSEL_ALL;
extern INT RATTEN_ALL;
extern INT RATTEN_1;
extern INT RATTEN_2;
extern INT RATTEN_3;
extern INT RATTEN_4;
extern INT RLOOP;
extern INT RHEADI;
extern INT RFAUX;
extern INT RFBODYI;
extern INT ECCF;
extern INT EDSYNC;
extern INT EMRST;
extern INT EMSSS1;
extern INT EMSSS2;
extern INT EMSSS3;
extern INT ESSP;
extern INT EXUBL;
extern INT EDDSP;
extern INT EATTEN_TEST;
extern INT ETHETA_L;
extern INT EOMEGA_L;
extern INT RBA;
extern INT RBL;
extern INT RFF;
extern INT RDSYNC;
extern INT RSAD;
extern INT RSUF;
extern INT RUBL;
extern INT RUBL_1;
extern INT RUBL_2;
extern INT RUBL_3;
extern INT RUBL_4;
extern INT RATTEN_FSEL;
extern INT RATTEN_3DB;
extern INT RATTEN_6DB;
extern INT RATTEN_12DB;
extern INT RATTEN_23DB;
extern INT FAST_EDC;
extern INT FAST_RDC;
extern INT FAST_RFLTRS;
extern INT RRFMISC;
extern INT LOSOURCE;
extern INT cfrfupa;
extern INT cfrfupd;
extern INT cfrfminunblk;
extern INT cfrfminblank;
extern INT cfrfminblanktorcv;
extern float cfrfampftconst;
extern float cfrfampftlinear;
extern float cfrfampftquadratic;
extern INT SEDC;
extern const INT opcode_xcvr[NUM_PSD_BOARD_TYPES][66];
extern int psd_board_type;
extern int psd_id_count;
extern int bd_index;
int epic_loadcvs( const char *file );
void InitAdvPnlCVs(void);
STATUS PScvinit(void);
STATUS PS1cvinit(void);
STATUS CFLcvinit(void);
STATUS CFHcvinit(void);
STATUS FTGcvinit(void);
STATUS XTGcvinit(void);
STATUS RGcvinit(void);
STATUS AScvinit(void);
STATUS RCVNcvinit(void);
STATUS DTGcvinit(void);
STATUS RScvinit(void);
STATUS ExtCalcvinit(void);
STATUS AutoCoilcvinit(void);
STATUS PScveval(void);
STATUS PScveval1(int local_ps_te);
STATUS PS1cveval(FLOAT *opthickPS);
STATUS CFLcveval(FLOAT opthickPS);
STATUS CFHfilter(int xres);
STATUS CFHcveval(FLOAT opthickPS);
STATUS FTGcveval(void);
STATUS XTGcveval(void);
STATUS RGcveval(void);
STATUS AScveval(void);
STATUS RCVNcveval(void);
STATUS DTGcveval(void);
STATUS RScveval(void);
STATUS ExtCalcveval(void);
STATUS AutoCoilcveval(void);
STATUS PSfilter(void);
STATUS PSpredownload(void);
STATUS PS1predownload(void);
STATUS CFLpredownload(void);
STATUS CFHpredownload(void);
STATUS FTGpredownload(void);
STATUS XTGpredownload(void);
STATUS ASpredownload(void);
STATUS DTGpredownload(void);
STATUS RSpredownload(void);
STATUS ExtCalpredownload(void);
STATUS AutoCoilpredownload(void);
STATUS RCVNpredownload(void);
STATUS
generateZyIndex(ZY_INDEX * zy_index,
                const int zy_views,
                const int zy_slices,
                const float yFov,
                const float zFov,
                const int psc_pfkr_flag,
                const float psc_pfkr_fraction,
                int *zy_sampledPoints);
int psc_dist_compare(const void *dist1, const void *dist2);
STATUS mps1(void);
STATUS aps1(void);
STATUS cfl(void);
STATUS cfh(void);
STATUS fasttg(void);
STATUS expresstg(void);
STATUS RFshim(void);
STATUS DynTG(void);
STATUS mapTg(void);
STATUS Autocoil(void);
STATUS extcal(void);
STATUS autoshim(void);
STATUS rcvn(void);
STATUS avg(void);
STATUS single1(void);
STATUS aws(void);
STATUS PSpulsegen(void);
STATUS PS1pulsegen(INT posstart);
STATUS CFLpulsegen(INT posstart);
STATUS CFHpulsegen(INT posstart);
STATUS FTGpulsegen(void);
STATUS XTGpulsegen(void);
STATUS ASpulsegen(void);
STATUS RCVNpulsegen(INT posstart);
STATUS DTGpulsegen(void);
STATUS ExtCalpulsegen(void);
STATUS AutoCoilpulsegen(void);
STATUS SliceAcqOrder(int *sl_acq_order, int rx_sls);
STATUS RSpulsegen(void);
STATUS PSmps1(INT mps1nex);
STATUS PScfl(void);
STATUS PScfh(void);
STATUS PSrcvn(void);
STATUS NoiseCalrcvn(void);
void StIRMod(void);
STATUS PSinit(long (*PSrotmat)[9]);
STATUS PSfasttg(INT pre_slice, INT debugstate);
STATUS PSexpresstg(INT pre_slice, INT debugstate);
STATUS PSrfshim(void);
STATUS PSdyntg(void);
STATUS PSextcal(void);
STATUS PSautocoil(void);
STATUS FastTGCore( DOUBLE slice_loc, INT ftg_disdaqs, INT ftg_views,
                   INT ftg_nex, INT ftg_debug );
STATUS eXpressTGCore( DOUBLE slice_loc, INT xtg_disdaqs, INT xtg_views,
                   INT xtg_nex, INT xtg_debug );
INT ASautoshim(INT rspsct);
STATUS CoilSwitchSetCoil( const COIL_INFO coil,
                          const INT setRcvPortFlag);
int CoilSwitchGetTR(const int setRcvPortFlag);
int doTG(int psd_psc_control);
int doAS(int psd_psc_control);
STATUS phase_ordering(SHORT *view_tab, const INT phase_order, const INT yviews, const INT yetl);
void SDL_PrintFStrengthWarning( const int psdCode,
                                const int fieldStrength,
                                const char * const fileName,
                                const int lineNo );
void SDL_Print0_7Debug( const int psdCode,
                        const char *const fileName,
                        const int lineNo);
void SDL_Print3_0Debug( const int psdCode,
                        const char *const fileName,
                        const int lineNo);
void SDL_Print4_0Debug( const int psdCode,
                        const char *const fileName,
                        const int lineNo);
void SDL_Print7_0Debug( const int psdCode,
                        const char *const fileName,
                        const int lineNo);
void SDL_FStrengthPanic( const int psdCode,
                         const int fieldStrength,
                         const char *const fileName,
                         const int lineNo);
STATUS SDL_CheckValidFieldStrength( const int psdCode,
                                    const int fieldStrength,
                                    const int use_ermes );
void SDL_SetLimTE( const int psdCode,
                   const int fStrength,
                   const int opautote,
                   int * const llimte1,
                   int * const llimte2,
                   int * const llimte3,
                   int * const ulimte1,
                   int * const ulimte2,
                   int * const ulimte3 );
void SDL_CalcRF1RF2Scale( const int psdCode,
                          const int fStrength,
                          const int coilType,
                          const float slThickness,
                          float * const gscale_rf1,
                          float * const gscale_rf2,
                          float * const gscale_rf1se1,
                          float * const gscale_rf1se2 );
void SDL_SetFOV( const int psdCode,
                 const int fStrength );
void SDL_SetSLTHICK( const int psdCode,
                     const int fStrength );
void SDL_SetCS( const int psdCode,
                const int fStrength );
    float SDL_GetChemicalShift( const int fStrength );
    STATUS SDL_RFDerating( double * const deRateB1,
                           const int fStrength,
                           const double weight,
                           const TX_COIL_INFO txCoil,
                           const GRADIENT_COIL_E gcoiltype );
    STATUS SDL_RFDerating_calc( double * const deRateB1,
                                const int fStrength,
                                const double weight,
                                const TX_COIL_INFO txCoil,
                                const GRADIENT_COIL_E gcoiltype,
                                const int prescan_entry,
                                double safety_factor );
    STATUS SDL_RFDerating_entry( double * const deRateB1,
                                 const int fStrength,
                                 const double weight,
                                 const TX_COIL_INFO txCoil,
                                 const GRADIENT_COIL_E gcoiltype,
                                 const int entry );
    STATUS SDL_RFDerating_entry_sat( double * const deRateB1,
                                     const int fStrength,
                                     const double weight,
                                     const TX_COIL_INFO txCoil,
                                     const GRADIENT_COIL_E gcoiltype,
                                     const int entry,
                                     const double safetyfactor );
    void SDL_InitSPSATRFPulseInfo( const int fStrength,
                                   const int rfSlot,
                                   int * const pw_rfse1,
                                   RF_PULSE_INFO rfPulseInfo[] );
int dynTG_sliceloc(float *dynTG_sliceloc, const int dynTG_nslices, const int imaging_nslices, const int debug_flag);
int debugstate = 1;
long _firstcv = 0;
int psd_annefact_level = 0
;
int rhpsd_annefact_level = 0
;
float psd_relative_excited_volume_freq = -1.0
;
float psd_relative_excited_volume_phase = -1.0
;
float psd_relative_excited_volume_slice = 1.0
;
float psd_relative_encoded_volume_freq = -1.0
;
float psd_relative_encoded_volume_phase = 1.0
;
float psd_relative_encoded_volume_slice = 1.0
;
int opresearch = 0
;
int opdnr = 0
;
int rhdnr_enabled = 0
;
int rhdnr_control = 3
;
float rhdnr_snr_ratio = 0.4
;
float rhdnr_noise_ratio = 0.5
;
float rhdnr_signal_threshold_ratio = 1.6
;
float rhdnr_background_noise_ratio = 1.0
;
float rhdnr_edge_ratio = 1.0
;
float rhdnr_sharpness_ratio = 1.0
;
float rhdnr_iteration_end_ratio = 0.5
;
float rhdnr_amplitude_ratio = 0.2
;
float rhdnr_amplitude_scale_factor = 0.3
;
float opweight = 50
;
int oplandmark = 0
;
int optabent = 0
;
int opentry = 1
;
int oppos = 1
;
int opplane = 1
;
int opphysplane = 1
;
int opobplane = 1
;
int opimode = 1
;
int oppseq = 1
;
int opgradmode = 0
;
int opanatomy = 0
;
int piimgoptlist = 0
;
int opcgate = 0
;
int opexor = 0
;
int opcmon = 0
;
int opfcomp = 0
;
int opgrx = 0
;
int opgrxroi = 0
;
int opnopwrap = 0
;
int opptsize = 2
;
int oppomp = 0
;
int opscic = 0
;
int oprect = 0
;
int opsquare = 0
;
int opvbw = 0
;
int opblim = 0
;
int opfast = 0
;
int opcs = 0
;
int opdeprep = 0
;
int opirprep = 0
;
int opsrprep = 0
;
int opmph = 0
;
int opdynaplan = 0
;
int opdynaplan_mask_phase = 0
;
int opbsp = 0
;
int oprealtime = 0
;
int opfluorotrigger = 0
;
int opET = 0
;
int opmultistation = 0
;
int opepi = 0
;
int opflair = 0
;
int opt1flair = 0
;
int opt2flair = 0
;
int opdoubleir = 0
;
int optissuet1 = 0
;
int opautotissuet1 = 0
;
int optlrdrf = 0
;
int opfulltrain = 0
;
int opirmode = 1
;
int opmt = 0
;
int opzip512 = 0
;
int opzip1024 = 0
;
int opslzip2 = 0
;
int opslzip4 = 0
;
int opsmartprep = 0
;
int opssrf = 0
;
int opt2prep = 0
;
int opspiral = 0
;
int opnav = 0
;
int opfmri = 0
;
int opectricks = 0
;
int optricksdel = 1000000
;
int optrickspause = 1
;
int opfr = 0
;
int opcube = 0
;
int ophydro = 0
;
int opphasecycle = 0
;
int oplava = 0
;
int op3dcine_fiesta = 0
;
int op3dcine_spgr = 0
;
int op4dflow = 0
;
int opbrava = 0
;
int opcosmic = 0
;
int opvibrant = 0
;
int opbravo = 0
;
int opdisco = 0
;
int opmprage = 0
;
int oppromo = 0
;
int opprop = 0
;
int opdwprop = 0
;
int opdwpropduo = 0
;
int opmuse = 0
;
int opallowedrescantime = 0
;
int opbreastmrs = 0
;
int opjrmode = 0
;
int opssfse = 0
;
int t1flair_flag = 0
;
int opphsen = 0
;
int opbc = 0
;
int opfatwater = 0
;
int oprtbc = 0
;
int opnseg = 1
;
int opnnex = 0
;
int opsilent = 0
;
int opsilentlevel = 1
;
int opmerge = 0
;
int opswan = 0
;
int opphaseimage = 0
;
int opdixon = 0
;
int opmoco = 0
;
int opdixproc = 0
;
int opmedal = 0
;
int opquickstep = 0
;
int opidealiq = 0
;
int opsilentmr = 0
;
int opmagic = 0
;
float opzoom_fov_xy = 440.0
;
float opzoom_fov_z = 350.0
;
float opzoom_dist_ax = 120.0
;
float opzoom_dist_cor = 120.0
;
float opzoom_dist_sag = 150.0
;
int app_grad_type = 0
;
int opzoom_coil_ind = 0
;
int pizoom_index = 0
;
int opsat = 0
;
int opsatx = 0
;
int opsaty = 0
;
int opsatz = 0
;
float opsatxloc1 = 9999
;
float opsatxloc2 = 9999
;
float opsatyloc1 = 9999
;
float opsatyloc2 = 9999
;
float opsatzloc1 = 9999
;
float opsatzloc2 = 9999
;
float opsatxthick = 40.0
;
float opsatythick = 40.0
;
float opsatzthick = 40.0
;
int opsatmask = 0
;
int opfat = 0
;
int opwater = 0
;
int opccsat = 0
;
int opfatcl = 0
;
int opspecir = 0
;
int opexsatmask = 0
;
float opexsathick1 = 40.0
;
float opexsathick2 = 40.0
;
float opexsathick3 = 40.0
;
float opexsathick4 = 40.0
;
float opexsathick5 = 40.0
;
float opexsathick6 = 40.0
;
float opexsatloc1 = 9999
;
float opexsatloc2 = 9999
;
float opexsatloc3 = 9999
;
float opexsatloc4 = 9999
;
float opexsatloc5 = 9999
;
float opexsatloc6 = 9999
;
int opexsatparal = 0
;
int opexsatoff1 = 0
;
int opexsatoff2 = 0
;
int opexsatoff3 = 0
;
int opexsatoff4 = 0
;
int opexsatoff5 = 0
;
int opexsatoff6 = 0
;
int opexsatlen1 = 480
;
int opexsatlen2 = 480
;
int opexsatlen3 = 480
;
int opexsatlen4 = 480
;
int opexsatlen5 = 480
;
int opexsatlen6 = 480
;
float opdfsathick1 = 40.0
;
float opdfsathick2 = 40.0
;
float opdfsathick3 = 40.0
;
float opdfsathick4 = 40.0
;
float opdfsathick5 = 40.0
;
float opdfsathick6 = 40.0
;
float exsat1_normth_R = 0;
float exsat1_normth_A = 0;
float exsat1_normth_S = 0;
float exsat2_normth_R = 0;
float exsat2_normth_A = 0;
float exsat2_normth_S = 0;
float exsat3_normth_R = 0;
float exsat3_normth_A = 0;
float exsat3_normth_S = 0;
float exsat4_normth_R = 0;
float exsat4_normth_A = 0;
float exsat4_normth_S = 0;
float exsat5_normth_R = 0;
float exsat5_normth_A = 0;
float exsat5_normth_S = 0;
float exsat6_normth_R = 0;
float exsat6_normth_A = 0;
float exsat6_normth_S = 0;
float exsat1_dist = 0;
float exsat2_dist = 0;
float exsat3_dist = 0;
float exsat4_dist = 0;
float exsat5_dist = 0;
float exsat6_dist = 0;
int pigirscrn = 0;
int piautoirbands = 0;
float pigirdefthick = 200.0;
int pinumgir = 2
;
int opnumgir = 0
;
int pigirmode = 3
;
int opgirmode = 0
;
int optagging = 0
;
int optagspc = 7
;
float optagangle = 45.0
;
float opvenc = 50.0
;
int opflaxx = 0
;
int opflaxy = 0
;
int opflaxz = 0
;
int opflaxall = 0
;
int opproject = 0
;
int opcollapse = 1
;
int oprlflow = 0
;
int opapflow = 0
;
int opsiflow = 0
;
int opmagc = 1
;
int opflrecon = 0
;
int oprampdir = 0
;
int project = 0
;
int vas_ovrhd = 0
;
int slice_col = 1
;
int phase_col = 0
;
int read_col = 0
;
int mag_mask = 1
;
int phase_cor = 1
;
int extras = 0
;
int mag_create = 1
;
int rl_flow = 0
;
int ap_flow = 0
;
int si_flow = 0
;
int imagenum = 1
;
int motsa_ovrhd = 0
;
int opslinky = 0
;
int opinhance = 0
;
int opmavric = 0
;
int opinhsflow = 0
;
int opmsde = 0
;
float opvest = 50.0
;
int opmsdeaxx = 0
;
int opmsdeaxy = 0
;
int opmsdeaxz = 0
;
int opbreathhold= 0
;
int opautosubtract = 0
;
int opsepseries = 0
;
int pititle = 0 ;
float opuser0 = 0 ;
float opuser1 = 0 ;
float opuser2 = 0 ;
float opuser3 = 0 ;
float opuser4 = 0 ;
float opuser5 = 0 ;
float opuser6 = 0 ;
float opuser7 = 0 ;
float opuser8 = 0 ;
float opuser9 = 0 ;
float opuser10 = 0 ;
float opuser11 = 0 ;
float opuser12 = 0 ;
float opuser13 = 0 ;
float opuser14 = 0 ;
float opuser15 = 0 ;
float opuser16 = 0 ;
float opuser17 = 0 ;
float opuser18 = 0 ;
float opuser19 = 0 ;
float opuser20 = 0 ;
float opuser21 = 0 ;
float opuser22 = 0 ;
float opuser23 = 0 ;
float opuser24 = 0 ;
float opuser25 = 0 ;
float opuser26 = 0 ;
float opuser27 = 0 ;
float opuser28 = 0 ;
float opuser29 = 0 ;
float opuser30 = 0 ;
float opuser31 = 0 ;
float opuser32 = 0 ;
float opuser33 = 0 ;
float opuser34 = 0 ;
float opuser35 = 0 ;
float opuser36 = 0 ;
float opuser37 = 0 ;
float opuser38 = 0 ;
float opuser39 = 0 ;
float opuser40 = 0 ;
float opuser41 = 0 ;
float opuser42 = 0 ;
float opuser43 = 0 ;
float opuser44 = 0 ;
float opuser45 = 0 ;
float opuser46 = 0 ;
float opuser47 = 0 ;
float opuser48 = 0 ;
int opnostations = 1
;
int opstation = 1
;
int oploadprotocol = 0
;
int opmask = 0
;
int opvenous = 0
;
int opprotRxMode = 0
;
int opacqo = 1
;
int opfphases = 1
;
int opsldelay = 50000
;
int avminsldelay = 50000
;
int optphases = 1
;
int opdynaplan_nphases = 1
;
int opvsphases = 1
;
int opdiffuse = 0
;
int opsavedf = 0
;
int opmintedif = 1
;
int opseparatesynb = 1
;
int opdfaxx = 0;
int opdfaxy = 0;
int opdfaxz = 0;
int opdfaxall = 0;
int opdfaxtetra = 0;
int opdfax3in1 = 0;
int opbval = 0
;
int opnumbvals = 1
;
int opautonumbvals = 0
;
int opnumsynbvals = 0
;
float opdifnext2 = 1
;
int opautodifnext2 = 0
;
int optensor = 0
;
int opdifnumdirs = 1
;
int opdifnumt2 = 1
;
int opautodifnumt2 = 0
;
int opdualspinecho = 0
;
int opdifproctype = 0
;
int opdifnumbvalues = 1
;
int dti_plus_flag = 0
;
int optouch = 0
;
int optouchfreq = 60
;
int optouchmegfreq = 60
;
int optouchamp = 30
;
int optouchtphases = 4
;
int optouchcyc = 3
;
int optouchax = 4
;
int opaslprep = 0
;
int opasl = 0
;
float oppostlabeldelay = 1525.0
;
int rhchannel_combine_method = 0
;
int rhasl_perf_weighted_scale = 32
;
float cfslew_artmedium = 2.0
;
float cfgmax_artmedium = 3.3
;
float cfslew_arthigh = 2.0
;
float cfgmax_arthigh = 3.3
;
int cfnumartlevels = 0
;
int pinumartlevels = 0
;
float cfslew_artmediumopt = 5.0
;
float cfgmax_artmediumopt = 2.2
;
int oprep_active = 1
;
int oprep_rest = 1
;
int opdda = 0
;
int opinit_state = 0
;
int opfMRIPDTYPE = 0
;
int opview_order = 1
;
int opslice_order = 0
;
int oppsd_trig = 0
;
int oppdgm_str = -1
;
int opbwrt = 0
;
int cont_flag = 0
;
int opautonecho = 1
;
int opnecho = 1
;
int opnshots = 1
;
int opautote = 0
;
int opte = 25000
;
int opte2 = 50000
;
int optefw = 0
;
int opti = 50000
;
int opbspti = 50000
;
int opautoti = 0
;
int opautobti = 0
;
int optrecovery = 0
;
int optlabel = 2000000
;
int opt2prepte = 25000
;
int opautotr = 0
;
int opnspokes = 128
;
float opoversamplingfactor = 1.0
;
int opacs = 4
;
int opharmonize = 0
;
int pieffbladewidth = 1
;
int opinrangetr = 0
;
int opinrangetrmin = 160000
;
int opinrangetrmax = 10000000
;
int optr = 400000
;
float opflip = 90
;
int opautoflip = 0
;
int opautoetl = 0
;
int opetl = 8
;
int opautorbw = 0
;
float oprbw = 16.0
;
float oprbw2 = 16.0
;
float opfov = 500
;
float opphasefov = 1
;
float opnpwfactor = 1.0
;
float opfreqfov = 1
;
int opautoslquant = 0
;
int opslquant = 1
;
int opsllocs = 1
;
float opslthick = 5
;
float opslspace = 10
;
int opileave = 0
;
int opcoax = 1
;
float opvthick = 320
;
int opvquant = 1
;
int opovl = 0
;
float oplenrl = 0
;
float oplenap = 0
;
float oplensi = 0
;
float oplocrl = 0
;
float oplocap = 0
;
float oplocsi = 0
;
float oprlcsiis = 1
;
float opapcsiis = 2
;
float opsicsiis = 3
;
float opmonfov = 200
;
float opmonthick = 20
;
float opinittrigdelay = 1000000
;
int opxres = 256
;
int opyres = 128
;
int opautonex = 0
;
float opnex = 1
;
int opslicecnt = 0
;
int opnbh = 0
;
int opspf = 0
;
int opcfsel = 2
;
int opfcaxis = 0
;
int opphcor = 0
;
float opdose = 0
;
int opcontrast = 0
;
int opchrate = 100
;
int opcphases = 1
;
int opaphases = 1
;
int opclocs = 1
;
int ophrate = 60
;
int oparr = 10
;
int ophrep = 1
;
int opautotdel1 = 0
;
int optdel1 = 20000
;
int optseq = 1
;
int opphases = 1
;
int opcardseq = 0
;
int opmphases = 0
;
int oparrmon = 1
;
int opvps = 8
;
int opautovps = 0
;
int opcgatetype = CARDIAC_GATE_TYPE_NONE
;
int opadvgate = 0
;
int opfcine = 0
;
int opcineir = 0
;
int opstress = 0
;
int opnrr = 0
;
int opnrr_dda = 8
;
int oprtcgate = 0
;
int oprtrate = 12
;
int oprtrep = 1
;
int oprttdel1 = 20000
;
int oprttseq = 1
;
int oprtcardseq = 0
;
int oprtarr = 10
;
int oprtpoint= 10
;
int opnavrrmeas = 0
;
int opnavrrmeastime = 20
;
int opnavrrmeasrr = 12
;
int opnavsltrack = 0
;
int opnavautoaccwin = 0
;
float opnavaccwin = 2.0
;
int opnavautotrigtime = 10
;
int opnavpsctime = 10
;
int opnavmaxinterval = 200
;
int opnavtype = PSD_NAV_TYPE_90_180
;
int opnavpscpause = 0
;
int opnavsigenhance = 0
;
int opasset = 0
;
int opassetcal = 0
;
int opassetscan = 0
;
int rhcoilno = 0
;
int rhcal_options = 0
;
int rhasset = 0
;
int rhasset_calthresh = 10000
;
float rhasset_R = 0.5
;
int rhasset_phases = 1
;
float rhscancent = 0.0
;
int rhasset_alt_cal = 0
;
int rhasset_torso = 0
;
int rhasset_localTx = 0
;
float rhasset_TuningFactor = 15.0
;
float rhasset_SnrMin = 15.0
;
float rhasset_SnrMax = 75.0
;
float rhasset_SnrScalar = 1.0
;
int oppure = 0
;
int rhpure = 0
;
int oppurecal = 0
;
int rhpurechannel = 0
;
int rhpurefilter= 0
;
float rhpure_scale_factor = 1.0
;
int cfpure_filtering_mode = 1
;
int rhpure_filtering_mode = 1
;
float rhpure_lambda = 10.0
;
float rhpure_tuning_factor_surface = 0.0
;
float rhpure_tuning_factor_body = 1.0
;
float rhpure_derived_cal_fraction = 0.0
;
float rhpure_cal_reapodization = 12.0
;
int opcalrequired = 0
;
int rhpure_blur_enable = 0
;
float rhpure_blur = 0.0
;
float rhpure_mix_lambda = 10.0
;
float rhpure_mix_tuning_factor_surface = 0.0
;
float rhpure_mix_tuning_factor_body = 1.0
;
int rhpure_mix_blur_enable = 0
;
float rhpure_mix_blur = 0.0
;
float rhpure_mix_alpha = 0.0
;
int rhpure_mix_otsu_class_qty = 2
;
float rhpure_mix_exp_wt = 0.0
;
int rhpure_mix_erode_dist = 0
;
int rhpure_mix_dilate_dist = 0
;
int rhpure_mix_aniso_blur = 0
;
int rhpure_mix_aniso_erode_dist = 0
;
int rhpure_mix_aniso_dilate_dist = 0
;
int opcalmode = CAL_MODE_STANDARD
;
int rhcalmode = 0
;
int opcaldelay = 5000000
;
int rhcal_pass_set_vector = 12
;
int rhcal_nex_vector = 101
;
int rhcal_weight_vector = 101
;
int sifsetwokey = 0
;
int opautosldelay = 0
;
int specnuc = 1
;
int specpts = 256
;
int specwidth = 2000
;
int specnavs = 1
;
int specnex = 2
;
int specdwells = 1
;
int acquire_type = 0
;
int pixmtband = 1
;
int pibbandfilt = 0
;
int opwarmup = 0
;
int pscahead = 0
;
int opprescanopt = 0
;
int autoadvtoscn = 0
;
int opapa = 0
;
int oppscapa = 0
;
int PSslice_ind = 0
;
int oppscshimtg = 0
;
int opdyntg = 0
;
float dynTG_fov = 500
;
int dynTG_slquant = 1
;
float dynTG_flipangle = 60.0
;
float dynTG_slthick = 10.0
;
int dynTG_xres = 64
;
int dynTG_yres = 64
;
int dynTG_baseline = 0
;
int dynTG_ptsize = 4
;
float dynTG_b1factor = 1.0
;
float rfshim_fov = 500
;
int rfshim_slquant = 1
;
float rfshim_flipangle = 60.0
;
float rfshim_slthick = 10.0
;
int rfshim_xres = 64
;
int rfshim_yres = 64
;
int rfshim_baseline = 0
;
int rfshim_ptsize = 4
;
float rfshim_b1factor = 1.0
;
int cal_xres = 32
;
int cal_yres = 32
;
int cal_slq = 36
;
int cal_nex = 2
;
int cal_interleave = 0
;
float cal_fov = 500
;
float cal_slthick = 15
;
int cal_pass = 2
;
int coil_xres = 32
;
int coil_yres = 32
;
int coil_slq = 36
;
int coil_nex = 2
;
float coil_fov = 500
;
float coil_slthick = 15
;
int coil_pass = 1
;
int coil_interleave = 0
;
float asfov = 500
;
int asslquant = 1
;
float asflip = 20
;
float asslthick = 10
;
int asxres = 256
;
int asyres = 128
;
int asbaseline = 8
;
int asrhblank = 4
;
int asptsize = 4
;
int opascalcfov = 0
;
float tgfov = 500
;
int tgcap = 200
;
int tgwindow = 200
;
int oppscvquant = 0
;
int opdrivemode = 1
;
int pidrivemodenub = 7
;
int opexcitemode = 0
;
float lp_stretch = 2.0
;
int lp_mode = 0
;
float derateb1_body_factor = 1.0
;
float SAR_bodyNV_weight_lim = 110.0
;
float derateb1_NV_factor = 1.0
;
float jstd_multiplier_body = 0.145
;
float jstd_multiplier_NV = 0.0137
;
float jstd_exponent_body = 0.763
;
float jstd_exponent_NV = 1.154
;
int pidiffmode = 0;
int pifmriscrn = 0;
int piresol = 0
;
int pioverlap = 0
;
int piforkvrgf = 0;
int pinofreqoffset = 0;
int pirepactivenub = 0;
int pireprestnub = 0;
int piddanub = 0;
int piinitstatnub = 0;
int piviewordernub = 0;
int pisliceordnub = 0;
int pipsdtrignub = 0;
int pispssupnub = 1;
int pi_neg_sp = 0
;
float piisvaldef = 2.0
;
int pi2dmde = 0
;
int pidmode = 0
;
int piviews = 0
;
int piclckcnt = 1
;
float avmintscan = 0.0
;
float pitslice = 0.0
;
float pitscan = 0.0
;
float pimscan = 0.0
;
float pivsscan = 0.0
;
float pireconlag = -3.0
;
float pitres = 0.0
;
float pitres2 = 0.0
;
int pisaveinter = 0
;
int pivextras = 0
;
int pinecho = 0
;
float piscancenter = 0.0
;
float pilandmark = 0.0
;
float pitableposition = 0.0
;
int pismode = 0
;
int pishldctrl = 0
;
int pinolr = 1
;
int pinoadc = 0
;
int pimixtime = 0
;
int pishim2 = 0
;
int pi1stshimb = 0
;
float pifractecho = 1.0
;
int nope = 0
;
int opuser_usage_tag = (int)(0x00000000)
;
int rhuser_usage_tag = (int)(0x00000000)
;
int rhFillMapMSW = (int)(0x00000000)
;
int rhFillMapLSW = (int)(0x00000000)
;
int rhbline = 0
;
int rhblank = 4
;
int rhnex = 1
;
int rhnavs = 1
;
int rhnslices = 1
;
int rhnrefslices = 0
;
int rhnframes = 256
;
int rhfrsize = 256
;
int rhnecho = 1
;
int rhnphases = 1
;
int rhmphasetype = 0
;
int rhtrickstype = 0
;
int rhtype = 0
;
int rhtype1 = 0
;
int rhformat = 0
;
int rhptsize = 2
;
int rhnpomp = 1
;
int rhrcctrl = 1
;
int rhdacqctrl = 2
;
int rhexecctrl = (0x0001 | 0x0008)
;
int rhfdctrl = 0
;
float rhxoff = 0.0
;
float rhyoff = 0.0
;
int rhrecon = 0
;
int rhdatacq = 0
;
int rhvquant = 0
;
int rhslblank = 2
;
int rhhnover = 0
;
int rhfeextra = 0
;
int rhheover = 0
;
int rhoscans = 0
;
int rhddaover = 0
;
float rhzeroph = 128.5
;
float rhalpha = 0.46
;
float rhnwin = 0.0
;
float rhntran = 2.0
;
int rhherawflt = 0
;
float rhherawflt_befnwin = 1.0
;
float rhherawflt_befntran = 2.0
;
float rhherawflt_befamp = 1.0
;
float rhherawflt_hpfamp = 1.0
;
float rhfermw = 10.0
;
float rhfermr = 128.0
;
float rhferme = 1.0
;
float rhclipmin = 0.0
;
float rhclipmax = 16383.0
;
float rhdoffset = 0.0
;
int rhudasave = 0
;
int rhsspsave = 0
;
float rh2dscale = 1.0
;
float rh3dscale = 1.0
;
int rhnpasses = 1
;
int rhincrpass = 1
;
int rhinitpass = 1
;
int rhmethod = 0
;
int rhdaxres = 256
;
int rhdayres = 256
;
int rhrcxres = 256
;
int rhrcyres = 256
;
int rhimsize = 256
;
int rhnoncart_dual_traj = 0
;
int rhnoncart_traj_kmax_ratio = 8
;
int rhnspokes_lowres = 8192
;
int rhnspokes_highres = 8192
;
int rhnoncart_traj_merge_start = 3
;
int rhnoncart_traj_merge_end = 5
;
float rhoversamplingfactor = 1.0
;
float rhnoncart_grid_factor = 2.0
;
int rhnoncart_traj_mode = 0x00
;
int rhviewSharing3D = 0
;
int rhdaviewsPerBlade = 24
;
float rhrotationThreshold = 2.0
;
float rhshiftThreshold = 0.01
;
float rhcorrelationThreshold = 0.50
;
float rhphaseCorrFiltFreqRadius = 1.0
;
float rhphaseCorrFiltPhaseRadius = 1.0
;
float rhnpwfactor = 1.0
;
float rhuser0 = 0 ;
float rhuser1 = 0 ;
float rhuser2 = 0 ;
float rhuser3 = 0 ;
float rhuser4 = 0 ;
float rhuser5 = 0 ;
float rhuser6 = 0 ;
float rhuser7 = 0 ;
float rhuser8 = 0 ;
float rhuser9 = 0 ;
float rhuser10 = 0 ;
float rhuser11 = 0 ;
float rhuser12 = 0 ;
float rhuser13 = 0 ;
float rhuser14 = 0 ;
float rhuser15 = 0 ;
float rhuser16 = 0 ;
float rhuser17 = 0 ;
float rhuser18 = 0 ;
float rhuser19 = 0 ;
float rhuser20 = 0 ;
float rhuser21 = 0 ;
float rhuser22 = 0 ;
float rhuser23 = 0 ;
float rhuser24 = 0 ;
float rhuser25 = 0 ;
float rhuser26 = 0 ;
float rhuser27 = 0 ;
float rhuser28 = 0 ;
float rhuser29 = 0 ;
float rhuser30 = 0 ;
float rhuser31 = 0 ;
float rhuser32 = 0 ;
float rhuser33 = 0 ;
float rhuser34 = 0 ;
float rhuser35 = 0 ;
float rhuser36 = 0 ;
float rhuser37 = 0 ;
float rhuser38 = 0 ;
float rhuser39 = 0 ;
float rhuser40 = 0 ;
float rhuser41 = 0 ;
float rhuser42 = 0 ;
float rhuser43 = 0 ;
float rhuser44 = 0 ;
float rhuser45 = 0 ;
float rhuser46 = 0 ;
float rhuser47 = 0 ;
float rhuser48 = 0 ;
int rhdab0s = 0
;
int rhdab0e = 0
;
float rhctr = 1.0
;
float rhcrrtime = 1.0
;
int rhcphases = 1
;
int rhaphases = 1
;
int rhovl = 0
;
int rhvtype = 0
;
float rhvenc = 0.0
;
float rhvcoefxa = 0.0
;
float rhvcoefxb = 0.0
;
float rhvcoefxc = 0.0
;
float rhvcoefxd = 0.0
;
float rhvcoefya = 0.0
;
float rhvcoefyb = 0.0
;
float rhvcoefyc = 0.0
;
float rhvcoefyd = 0.0
;
float rhvcoefza = 0.0
;
float rhvcoefzb = 0.0
;
float rhvcoefzc = 0.0
;
float rhvcoefzd = 0.0
;
float rhvmcoef1 = 0.0
;
float rhvmcoef2 = 0.0
;
float rhvmcoef3 = 0.0
;
float rhvmcoef4 = 0.0
;
float rhphasescale = 1.0
;
float rhfreqscale = 1.0
;
int rawmode = 0
;
int rhileaves = 1
;
int rhkydir = 0
;
int rhalt = 0
;
int rhreps = 1
;
int rhref = 1
;
int rhpcthrespts = 2
;
int rhpcthrespct = 15
;
int rhpcdiscbeg = 0
;
int rhpcdiscmid = 0
;
int rhpcdiscend = 0
;
int rhpcileave = 0
;
int rhpcextcorr = 0
;
int rhrefframes = 0
;
int rhpcsnore = 0
;
int rhpcspacial = 0
;
int rhpctemporal = 0
;
float rhpcbestky = 64.0
;
int rhhdbestky = 0
;
int rhpcinvft = 0
;
int rhpcctrl = 0
;
int rhpctest = 0
;
int rhpcgraph = 0
;
int rhpclin = 0
;
int rhpclinnorm = 0
;
int rhpclinnpts = 0
;
int rhpclinorder = 2
;
int rhpclinfitwt = 0
;
int rhpclinavg = 0
;
int rhpccon = 0
;
int rhpcconnorm = 0
;
int rhpcconnpts = 2
;
int rhpcconorder = 2
;
int rhpcconfitwt = 0
;
int rhvrgfxres = 128
;
int rhvrgf = 0
;
int rhbp_corr = 0
;
float rhrecv_freq_s = 0.0
;
float rhrecv_freq_e = 0.0
;
int rhhniter = 0
;
int rhfast_rec = 0
;
int rhgridcontrol = 0
;
int rhb0map = 0
;
int rhtediff = 0
;
float rhradiusa = 0
;
float rhradiusb = 0
;
float rhmaxgrad = 0.0
;
float rhslewmax = 0.0
;
float rhscanfov = 0.0
;
float rhtsamp = 0.0
;
float rhdensityfactor = 0.0
;
float rhdispfov = 0.0
;
int rhmotioncomp = 0
;
int grid_fov_factor = 2
;
int rhte = 25000
;
int rhte2 = 50000
;
int rhdfm = 0
;
int rhdfmnavsperpass = 1
;
int rhdfmnavsperview = 1
;
float rhdfmrbw = 4.0
;
int rhdfmptsize = 2
;
int rhdfmxres = 32
;
int rhdfmdebug = 0
;
float rhdfmthreshold = 0.0
;
int rh_rc_enhance_enable = 0
;
int rh_ime_scic_enable = 0
;
float rh_ime_scic_edge = 0.0
;
float rh_ime_scic_smooth = 0.0
;
float rh_ime_scic_focus = 0.0
;
int rh_ime_clariview_type = 0
;
float rh_ime_clariview_edge = 0.0
;
float rh_ime_clariview_smooth = 0.0
;
float rh_ime_clariview_focus = 0.0
;
int rh_ime_definefilter_nr = 0
;
int rh_ime_definefilter_sh = 0
;
float rh_ime_scic_reduction = 0.0
;
float rh_ime_scic_gauss = 0.0
;
float rh_ime_scic_threshold = 0.0
;
float rh_ime_scic_contrast = 0.0
;
int cfscic_allowed = 1
;
float cfscic_edge = 0.0
;
float cfscic_smooth = 0.0
;
float cfscic_focus = 0.0
;
float cfscic_reduction = 0.0
;
float cfscic_gauss = 0.0
;
float cfscic_threshold = 0.0
;
float cfscic_contrast = 0.0
;
int piscic = 0
;
int cfscenic = 0
;
int piscenic = 0
;
int opscenic = 0
;
int rhscenic_type = 0
;
int cfn4_allowed = 1
;
float cfn4_slice_down_sample_rate = 1.0
;
float cfn4_inplane_down_sample_rate = 0.15
;
int cfn4_num_levels_max = 4
;
int cfn4_num_iterations_max = 50
;
float cfn4_convergence_threshold = 0.001
;
int cfn4_gain_clamp_mode = 0
;
float cfn4_gain_clamp_value = 5.0
;
float rhn4_slice_down_sample_rate = 1.0
;
float rhn4_inplane_down_sample_rate = 0.15
;
int rhn4_num_levels_max = 4
;
int rhn4_num_iterations_max = 50
;
float rhn4_convergence_threshold = 0.002
;
int rhn4_gain_clamp_mode = 0
;
float rhn4_gain_clamp_value = 5.0
;
int rhpure_gain_clamp_mode = 0
;
float rhpure_gain_clamp_value = 5.0
;
int rhphsen_pixel_offset = 0
;
int rhapp = 0
;
int rhapp_option = 0
;
int rhncoilsel = 0
;
int rhncoillimit = 45
;
int rhrefframep = 0
;
int rhscnframe = 0
;
int rhpasframe = 0
;
int rhpcfitorig = 1
;
int rhpcshotfirst = 0
;
int rhpcshotlast = 0
;
int rhpcmultegrp = 0
;
int rhpclinfix = 1
;
float rhpclinslope = 0.0
;
int rhpcconfix = 1
;
float rhpcconslope = 0.0
;
int rhpccoil = 1
;
float rhmaxcoef1a = 0
;
float rhmaxcoef1b = 0
;
float rhmaxcoef1c = 0
;
float rhmaxcoef1d = 0
;
float rhmaxcoef2a = 0
;
float rhmaxcoef2b = 0
;
float rhmaxcoef2c = 0
;
float rhmaxcoef2d = 0
;
float rhmaxcoef3a = 0
;
float rhmaxcoef3b = 0
;
float rhmaxcoef3c = 0
;
float rhmaxcoef3d = 0
;
int rhdptype = 0
;
int rhnumbvals = 1
;
int rhdifnext2 = 1
;
int rhnumdifdirs = 1
;
int rhutctrl = 0
;
float rhzipfact = 0
;
int rhfcinemode = 0
;
int rhfcinearw = 10
;
int rhvps = 8
;
int rhvvsaimgs = 1
;
int rhvvstr = 0
;
int rhvvsgender = 0
;
int rhgradmode = 0;
int rhfatwater = 0
;
int rhfiesta = 0
;
int rhlcfiesta = 0
;
float rhlcfiesta_phase = 0.0
;
int rhdwnavview = 0
;
int rhdwnavcorecho = 2
;
int rhdwnavsview = 1
;
int rhdwnaveview = 1
;
int rhdwnavsshot = 1
;
int rhdwnaveshot = 2
;
float rhdwnavcoeff = 0.5
;
int rhdwnavcor = 0
;
float rhassetsl_R = 1.0
;
float rhasset_slwrap = 0.0
;
int rh3dwintype = 0
;
float rh3dwina = 0.1
;
float rh3dwinq = 0.0
;
int rhectricks_num_regions = 0;
int rhectricks_input_regions = 0;
int rhretro_control = 0
;
int rhetl = 0
;
int rhleft_blank = 0
;
int rhright_blank = 0
;
float rhspecwidth = 0.0
;
int rhspeccsidims = 0
;
int rhspecrescsix = 0
;
int rhspecrescsiy = 0
;
int rhspecrescsiz = 0
;
float rhspecroilenx = 0.0
;
float rhspecroileny = 0.0
;
float rhspecroilenz = 0.0
;
float rhspecroilocx = 0.0
;
float rhspecroilocy = 0.0
;
float rhspecroilocz = 0.0
;
int rhexciterusage = 1
;
int rhexciterfreqs = 1
;
int rhwiener = 0
;
float rhwienera = 0.0
;
float rhwienerb = 0.0
;
float rhwienert2 = 0.0
;
float rhwieneresp = 0.0
;
int rhflipfilter = 0
;
int rhdbgrecon = 0
;
int rhech2skip = 0
;
int rhrcideal = 0
;
int rhrcdixproc = 0
;
int rhrcidealctrl = 0
;
int rhdf = 210
;
int rhmedal_mode = 0
;
int rhmedal_nstack_size = 54
;
int rhmedal_echo_order = 0
;
int rhmedal_up_kernel_size = 15
;
int rhmedal_down_kernel_size = 8
;
int rhmedal_smooth_kernel_size = 8
;
int rhmedal_starting_slice = 0
;
int rhmedal_ending_slice = 10
;
float rhmedal_param = 3.0
;
int rhvibrant = 0
;
int rhkacq_uid = 0
;
int rhnex_unacquired = 1
;
int rhdiskacqctrl = 0
;
int rhechopc_extra_bot = 0
;
int rhechopc_ylines = 0
;
int rhechopc_primary_yfirst = 0
;
int rhechopc_reverse_yfirst = 0
;
int rhechopc_zlines = 0
;
int rhechopc_yxfitorder = 1
;
int rhechopc_ctrl = 0
;
int rhchannel_combine_filter_type = 0
;
float rhchannel_combine_filter_width = 0.3
;
float rhchannel_combine_filter_beta = 2
;
float rh_low_pass_nex_filter_width = 8.0
;
int rh3dgw_interptype = 0
;
int rhrc3dcinectrl = 0
;
int rhncycles_cine = 0
;
int rhnvircchannel = 0
;
int rhrc_cardiac_ctrl = 0
;
int rhrc_moco_ctrl = 0
;
int rhrc_algorithm_ctrl = 0
;
int ihtr = 100
;
int ihti = 0
;
int ihtdel1 = 10
;
float ihnex = 1
;
float ihflip = 90
;
int ihte1 = 0
;
int ihte2 = 0
;
int ihte3 = 0
;
int ihte4 = 0
;
int ihte5 = 0
;
int ihte6 = 0
;
int ihte7 = 0
;
int ihte8 = 0
;
int ihte9 = 0
;
int ihte10 = 0
;
int ihte11 = 0
;
int ihte12 = 0
;
int ihte13 = 0
;
int ihte14 = 0
;
int ihte15 = 0
;
int ihte16 = 0
;
int ihdixonte = 0
;
int ihdixonipte = 0
;
int ihdixonoopte = 0
;
float ihvbw1 = 16.0
;
float ihvbw2 = 16.0
;
float ihvbw3 = 16.0
;
float ihvbw4 = 16.0
;
float ihvbw5 = 16.0
;
float ihvbw6 = 16.0
;
float ihvbw7 = 16.0
;
float ihvbw8 = 16.0
;
float ihvbw9 = 16.0
;
float ihvbw10 = 16.0
;
float ihvbw11 = 16.0
;
float ihvbw12 = 16.0
;
float ihvbw13 = 16.0
;
float ihvbw14 = 16.0
;
float ihvbw15 = 16.0
;
float ihvbw16 = 16.0
;
int ihnegscanspacing = 0
;
int ihoffsetfreq = 1200
;
int ihbsoffsetfreq = 4000
;
int iheesp = 0
;
int ihfcineim = 0
;
int ihfcinent = 0
;
int ihbspti = 50000
;
float ihtagfa = 180.0
;
float ihtagor = 45.0
;
float ih_idealdbg_cv1 = 0 ;
float ih_idealdbg_cv2 = 0 ;
float ih_idealdbg_cv3 = 0 ;
float ih_idealdbg_cv4 = 0 ;
float ih_idealdbg_cv5 = 0 ;
float ih_idealdbg_cv6 = 0 ;
float ih_idealdbg_cv7 = 0 ;
float ih_idealdbg_cv8 = 0 ;
float ih_idealdbg_cv9 = 0 ;
float ih_idealdbg_cv10 = 0 ;
float ih_idealdbg_cv11 = 0 ;
float ih_idealdbg_cv12 = 0 ;
float ih_idealdbg_cv13 = 0 ;
float ih_idealdbg_cv14 = 0 ;
float ih_idealdbg_cv15 = 0 ;
float ih_idealdbg_cv16 = 0 ;
float ih_idealdbg_cv17 = 0 ;
float ih_idealdbg_cv18 = 0 ;
float ih_idealdbg_cv19 = 0 ;
float ih_idealdbg_cv20 = 0 ;
float ih_idealdbg_cv21 = 0 ;
float ih_idealdbg_cv22 = 0 ;
float ih_idealdbg_cv23 = 0 ;
float ih_idealdbg_cv24 = 0 ;
float ih_idealdbg_cv25 = 0 ;
float ih_idealdbg_cv26 = 0 ;
float ih_idealdbg_cv27 = 0 ;
float ih_idealdbg_cv28 = 0 ;
float ih_idealdbg_cv29 = 0 ;
float ih_idealdbg_cv30 = 0 ;
float ih_idealdbg_cv31 = 0 ;
float ih_idealdbg_cv32 = 0 ;
int ihlabeltime = 0
;
int ihpostlabeldelay = 0
;
int ihnew_series = 0
;
int ihcardt1map_hb_pattern = 0
;
int ihmavric_bins = 24
;
int dbdt_option_key_status = 0
;
int dbdt_mode = 0
;
int opsarmode = 0
;
int cfdbdttype = 0
;
float cfrinf = 23.4
;
int cfrfact = 334
;
float cfdbdtper_norm = 80.0
;
float cfdbdtper_cont = 100.0
;
float cfdbdtper_max = 200.0
;
int cfnumicn = 1
;
int cfdppericn = 4
;
int cfgradcoil = 2;
int cfswgut = 4;
int cfswrfut = 2;
int cfswssput = 1;
int cfhwgut = 4;
int cfhwrfut = 2;
int cfhwssput = 1;
int cfoption = -1
;
int cfrfboardtype = 0
;
int psd_board_type = PSDDVMR
;
int opdfm = 0
;
int opdfmprescan = 0
;
int cfdfm = 0
;
int cfdfmTG = 70
;
int cfdfmR1 = 13
;
int cfdfmDX = 0
;
int derate_ACGD = 0
;
int rhextra_frames_top = 0
;
int rhextra_frames_bot = 0
;
int rhpc_ref_start = 0
;
int rhpc_ref_stop = 0
;
int rhpc_ref_skip = 0
;
int opaxial_slice=0
;
int opsagittal_slice =0
;
int opcoronal_slice=0
;
int opvrg = 0
;
int opmart = 0
;
int piassetscrn = 0
;
int opseriessave = 0
;
int opt1map = 0
;
int opt2map = 0
;
int opmer2 = 0
;
int rhnew_wnd_level_flag = 1
;
int rhwnd_image_hist_area = 60
;
float rhwnd_high_hist = 1.0
;
float rhwnd_lower_hist = 1.0
;
float rhwnd_scale = 1.2
;
int rhrcmavric_control = 0
;
int rhrcmavric_image = 0
;
int rhrcmavric_bin_separation = 1000
;
int rh_airiq_config = 0
;
float rh_airiq_level_a = 0.0
;
float rh_airiq_level_b = 1.0
;
float rh_airiq_win_r = 0.85
;
float rh_airiq_win_w = 0.075
;
int cfrfupa = -50
;
int cfrfupd = 50
;
int cfrfminblank = 200
;
int cfrfminunblk = 200
;
int cfrfminblanktorcv = 50
;
float cfrfampftconst = 0.784
;
float cfrfampftlinear = 0.0
;
float cfrfampftquadratic = 15.125
;
int opradialrx = 0
;
int cfsupportreceivefreqbands = 0
;
float cfcntfreefreqlow = 0.0
;
float cfcntfreefreqhigh = 10000.0
;
int optracq = 0
;
int opswift = 0
;
int rhswiftenable = 0
;
int rhnumCoilConfigs = 0
;
int rhnumslabs = 1
;
int opncoils = 1
;
int rtsar_first_series_flag = 0
;
int rtsar_enable_flag = 0
;
int measured_TG = -1
;
int predicted_TG = -1
;
float sar_correction_factor = 1.0
;
int gradHeatMethod = 0
;
int gradHeatFile = 0
;
int gradCoilMethod = GRADIENT_COIL_METHOD_AUTO
;
int gradHeatFlag = 0
;
int xgd_optimization = 1
;
int gradChokeFlag = 0
;
int piburstmode = 0
;
int opburstmode = 0
;
int burstreps = 1
;
float piburstcooltime = 0.0
;
float opaccel_ph_stride = 1.0
;
float opaccel_sl_stride = 1.0
;
float opaccel_t_stride = 1.0
;
int opaccel_mb_stride = 2
;
int opmb = 0
;
int rhmb_factor = 1
;
int rhmb_slice_fov_shift_factor = 1
;
int rhmb_slice_order_sign = 1
;
int rhmuse = 0
;
int rhmuse_nav = 0
;
int rhmuse_nav_accel = 1
;
int rhmuse_nav_hnover = 16
;
int rhmuse_nav_yres = 96
;
float opaccel_cs_stride = 1.0
;
int opcompressedsensing = 0
;
float rhcs_factor = 1.0
;
int rhcs_flag = 0
;
int rhcs_maxiter = 3
;
float rhcs_consistency = 0
;
int rhcs_ph_stride = 1
;
int rhcs_sl_stride = 1
;
int oparc = 0
;
int opaccel_kt_stride = 8
;
int rhkt_factor = 1
;
int rhkt_cal_factor = 1
;
int rhkt_calwidth_ph = 0
;
int rhkt_calwidth_sl = 0
;
int opab1 = 0
;
int op3dgradwarp = 0
;
int opauto3dgradwarp = 1
;
int cfmaxtransmitoffsetfreq = 650000
;
int cfreceiveroffsetfreq = 0
;
int cfcoilswitchmethod = 0x0004
;
int TG_record = 0
;
int ab1_enable = 0
;
int cfreceivertype = CFG_VAL_RECEIVER_RRX
;
int cfreceiverswitchtype = CFG_VAL_RCV_SWITCH_RF_HUB
;
int cfEllipticDriveEnable = 0
;
int pi3dgradwarpnub = 1
;
int cfDualDriveCapable = 0
;
int optrip = 0
;
int oprtb0 = 0
;
int pirtb0vis = 0
;
int pirtb0nub = 0
;
int ophoecc = 0
;
int rhhoecc = 0
;
int rhhoec_fit_order = 3
;
int opdistcorr = 0
;
int pidistcorrnub = 0
;
int pidistcorrdefval = 0
;
int rhdistcorr_ctrl = 0
;
int rhdistcorr_B0_filter_size = 5
;
float rhdistcorr_B0_filter_std_dev = 1.5
;
int ihdistcorr = 0
;
int rhtensor_file_number = 0
;
int ihpepolar = 0
;
int rhesp = 500
;
int viewshd_num = 0
;
float grad_intensity_thres = 3.0
;
int anne_mask_dilation_length = 2
;
float anne_intensity_thres = 0.0
;
float anne_channel_percentage = 0.4
;
int ec3_iterations = 1
;
float combined_coil_map_thres = 0.15
;
float coil_map_smooth_factor = 0.02
;
float coil_map_2_filter_width = 0.02
;
int ec3_iteration_method = 0
;
int edr_support = 0
;
float recon_bandwidth_factor = 1.0
;
int dacq_data_type = 0
;
int rawmode_scaling = 0
;
float rawmode_scaling_factor = 1.0
;
int oprgcalmode = RG_CAL_MODE_MEASURED
;
int opnumgroups = 0
;
int opsarburst = 0
;
int opheadscout = 0
;
int rhposition_detection = 0
;
int opfus = 0
;
int opexamnum = 0
;
int opseriesnum = 0
;
int vol_shift_type = 0
;
int vol_shift_constraint_type = 0
;
int vol_scale_type = 0
;
int vol_scale_constraint_type = 0
;
int rhsnrnoise = 0
;
int rhvircpolicy = 0
;
int rhvirsenstype = 1
;
int rhvircoiltype = 1
;
int rhvircoilunif = 0
;
int rhvircoilchannels = 1
;
int cffield = 15000
;
float act_field_strength = 30000.0
;
int enableReceiveFreqBands = 0
;
int offsetReceiveFreqLower = 0
;
int offsetReceiveFreqHigher = 0
;
int cfrfamptyp = 0
;
int cfssctype = 0
;
int cfbodycoiltype = PSD_15_XRM_BODY_COIL
;
int cfptxcapable = 0
;
int cfbdcabletglimit = 1
;
int cfcablefreq = 226
;
int cfcabletg = 175
;
int cfcablebw = 500
;
int opgradshim = 2
;
int track_flag = 0
;
int mavricNumBinsCal = 24
;
int mavricCalDone = 0
;
int mavricCalFlag = 0
;
int enableMapTg = 0
;
int cfmaxnbtxchannels = 1
;
int cfmagnettype = -1
;
int rhadaptive_nex_groups = 1
;
int opairecon = 0
;
int prevent_scan_under_emul = 0
;
int acqs = 1
;
int avround = 1
;
int baseline = 0
;
int nex = 1
;
float trunex = 1.0
;
int isOddNexGreaterThanOne = 0
;
int isNonIntNexGreaterThanOne = 0
;
float fn = 1.0
;
int enablfracdec = 1
;
int npw_flag = 0
;
float nop = 1.0
;
int acq_type = 0
;
int seq_type = TYPNCAT
;
int num_images = 1
;
int recon_mag_image = 1
;
int recon_pha_image = 0
;
int recon_imag_image = 0
;
int recon_qmag_image = 0
;
int slquant1 = 1
;
int psd_grd_wait = 56
;
int psd_rf_wait = 0
;
int pos_moment_start = 0
;
int mps1rf1_inst = 0
;
int scanrf1_inst = 0
;
int cfcarddelay = 10
;
int psd_card_hdwr_delay = 0
;
float GAM = 4257.59
;
int off90 = 80
;
int TR_SLOP = 2000
;
int TR_PASS = 50000
;
int TR_PASS3D = 550000
;
int csweight= 100
;
int exnex = 1
;
float truenex = 0.0
;
int eg_phaseres = 128
;
int sp_satcard_loc = 0
;
int min_rfdycc = 0;
int min_rfavgpow = 0;
int min_rfrmsb1 = 0;
int coll_prefls = 1
;
int maxGradRes = 1
;
float dfg = 2
;
float pg_beta = 1.0
;
int split_dab = 0
;
float freq_scale = 1.0
;
int numrecv = 1
;
int pe_on = 1
;
float psd_targetscale = 1.0;
float psd_zero = 0.0
;
int lx_pwmtime = 0;
int ly_pwmtime = 0;
int lz_pwmtime = 0;
int px_pwmtime = 0;
int py_pwmtime = 0;
int pz_pwmtime = 0;
int min_seqgrad = 0;
int min_seqrfamp = 0;
float xa2s = 0;
float ya2s = 0;
float za2s = 0;
int minseqcoil_t = 0;
int minseqcoilx_t = 0;
int minseqcoily_t = 0;
int minseqcoilz_t = 0;
int minseqcoilburst_t = 0;
int minseqcoilvrms_t = 0;
int minseqgram_t = 0;
int minseqchoke_t = 0;
int minseqcable_t = 0;
int minseqcable_maxpow_t = 0;
int minseqcableburst_t = 0;
int minseqbusbar_t = 0;
int minseqps_t = 0;
int minseqpdu_t = 0;
int minseqpdubreaker_t = 0;
int minseqcoilcool_t = 0;
int minseqsyscool_t = 0;
int minseqccucool_t = 0;
int minseqxfmr_t = 0;
int minseqresist_t = 0;
int minseqgrddrv_t = 0;
int minseqgrddrv_case_t = 0;
int minseqgrddrvx_t = 0;
int minseqgrddrvy_t = 0;
int minseqgrddrvz_t = 0;
float powerx = 0;
float powery = 0;
float powerz = 0;
float pospowerx = 0;
float pospowery = 0;
float pospowerz = 0;
float negpowerx = 0;
float negpowery = 0;
float negpowerz = 0;
float amptrans_lx = 0;
float amptrans_ly = 0;
float amptrans_lz = 0;
float amptrans_px = 0;
float amptrans_py = 0;
float amptrans_pz = 0;
float abspower_lx = 0;
float abspower_ly = 0;
float abspower_lz = 0;
float abspower_px = 0;
float abspower_py = 0;
float abspower_pz = 0;
int minseqpwm_x = 0;
int minseqpwm_y = 0;
int minseqpwm_z = 0;
int minseqgpm_t = 0;
int minseqgpm_maxpow_t = 0;
float vol_ratio_est_req = 2.0;
int skip_waveform_rotmat_check = 0;
int set_realtime_rotmat = 0;
int skip_rotmat_search = 0;
int enforce_minseqseg = 0;
int enforce_dbdtopt = 0;
int skip_minseqseg = 0;
int skip_initialize_dbdtopt = 0;
int time_pgen = 0;
int cont_debug = 0
;
int maxpc_cor = 0
;
int maxpc_debug = 0
;
int maxpc_points = 500
;
int pass_thru_mode = 0
;
int tmin = 0
;
int tmin_total = 0
;
int psd_tol_value = 0
;
int bd_index = 1
;
int use_ermes = 0
;
float fieldstrength = 15000;
int asymmatrix = 0
;
int psddebugcode = 0
;
int psddebugcode2 = 0
;
int serviceMode = 0
;
int upmxdisable = 16
;
int tsamp = 4
;
int seg_debug = 0
;
int CompositeRMS_method = 0
;
int gradDriverMethod = 0
;
int gradDCsafeMethod = 1
;
int stopwatchFlag = 0
;
int seqEntryIndex = 0
;
int dbdt_debug = 0
;
int reilly_mode = 0
;
int dbdt_disable = 0
;
int use_dbdt_opt = 1
;
float srderate = 1.0
;
int config_update_mode = 0
;
int phys_record_flag = 0
;
int phys_rec_resolution = 25
;
int phys_record_channelsel = 15
;
int rotateflag = 0
;
int rhpcspacial_dynamic = 0
;
int rhpc_rationalscale = 0
;
int rhpcmag = 0
;
int mild_note_support = 0
;
int save_grad_spec_flag = 0
;
int grad_spec_change_flag = 0
;
int value_system_flag = 0
;
int rectfov_npw_support = 0
;
int pigeosrot = 0
;
int minseqrf_cal = 1
;
int min_rfampcpblty = 0
;
int b1derate_flag = 0
;
int oblmethod_dbdt_flag = 0
;
int minseqcoil_esp = 1000
;
int aspir_flag = 0
;
int rhrawsizeview = 0
;
int chksum_scaninfo_view = 0
;
int chksum_rhdacqctrl_view = 0
;
float fnecho_lim = 1.0
;
int psdcrucial_debug = 0
;
float b1max_scale = 1.0
;
int disable_exciter_unblank = 0
;
int disable_amplifier_unblank = 0
;
int TGlimit = 200;
int sat_TGlimit = 200;
int autoparams_debug = 0
;
int num_autotr_cveval_iter = 1
;
int apx_cveval_counter = 0
;
int enforce_inrangetr = 0
;
int passtime = 0
;
int retropc_extra = 0
;
int esp = 10000
;
int echoint = 1
;
int arc_flag = 0
;
int arc_ph_calwidth = 24
;
int arc_sl_calwidth = 24
;
int vrgfsamp = 0
;
float srate_x = 15.0
;
float glimit_x = 3.6
;
float srate_y = 15.0
;
float glimit_y = 3.6
;
float srate_z = 15.0
;
float glimit_z = 3.6
;
float act_srate_x = 10.0
;
float act_srate_y = 10.0
;
float act_srate_z = 10.0
;
int mkgspec_x_sr_flag = 0
;
int mkgspec_x_gmax_flag = 0
;
int mkgspec_y_sr_flag = 0
;
int mkgspec_y_gmax_flag = 0
;
int mkgspec_z_sr_flag = 0
;
int mkgspec_z_gmax_flag = 0
;
int mkgspec_flag = 0
;
int mkgspec_epi2_flag = 0
;
int pfkz_total = 32
;
float fov_freq_scale = 1.0
;
float fov_phase_scale = 1.0
;
float slthick_scale = 1.0
;
int silent_mode = 0
;
float silent_slew_rate = 3.0
;
int rhpropellerCtrl = 0
;
float prop_act_npwfactor = 1.0
;
float prop_act_oversamplingfactor = 1.0
;
int navtrig_wait_before_imaging = 200000
;
int xtg_volRecCoil = 0
;
int minseqseg_max_full = 0
;
int sphericalGradient = 0
;
int minseqcoil_option = 0
;
int minseqgrad_option = 0
;
int rtp_bodyCoilCombine = 1
;
int ntxchannels = 1
;
int napptxchannels = 1
;
int seqcfgdebug = 0
;
int enable_acoustic_model = 0
;
int acoustic_seq_repeat_time = 4
;
float avgSPL_non_weighted = -1
;
int noisecal_in_scan_flag = 1
;
float gLimitForExtHighResOpt = 3.3
;
int cal_based_optimal_recon_enabled = 0
;
int act_tr = 0
;
int AutoParam_flag = 0
;
int autolock = 0
;
int blank = 4
;
int nograd = 0
;
int nofermi = 0
;
int rawdata = 0
;
int saveinter = 0
;
int zchop = 1
;
int eepf = 0
;
int oepf = 0
;
int eeff = 0
;
int oeff = 0
;
int cine_choplet = 0
;
float fermi_rc = 0.5
;
float fermi_wc = 1.0
;
int apodize_level_flag = 0
;
float fermi_r_factor = 1.0
;
float fermi_w_factor = 1.0
;
float pure_mix_tx_scale = 1.0
;
int channel_compression = 0
;
int optimal_channel_combine = 0
;
int enforce_cal_for_channel_combine = 0
;
int override_opcalrequired = 0
;
int dump_channel_comp_optimal_recon = 0
;
int dump_scenic_parameters = 0
;
float PSsr_derate_factor = 1.0 ;
float PSamp_derate_factor = 1.0 ;
float PSassr_derate_factor = 1.0 ;
float PSasamp_derate_factor = 1.0 ;
int PSTR_PASS = 20000;
float mpsfov = 100 ;
int fastprescan = 0 ;
int pre_slice = 0 ;
int PSslice_num = 0;
float xmtaddAPS1 = 0, xmtaddCFL = 0, xmtaddCFH = 0, xmtaddFTG = 0, xmtadd = 0, xmtaddRCVN = 0;
float ps1scale = 0, cflscale = 0, cfhscale = 0, ftgscale = 0;
float extraScale = 0;
int PSdebugstate = 0 ;
int PSfield_strength = 5000 ;
int PScs_sat = 1 ;
int PSir = 1 ;
int PSmt = 1 ;
int ps1_rxcoil = 0 ;
int ps_seed = 21001;
int tg_1_2_pw = 1 ;
int tg_axial = 1 ;
float coeff_pw_tg = 1.0;
float fov_lim_mps = 350.0 ;
int TGspf = 0 ;
float flip_rf2cfh = 0;
float flip_rf3cfh = 0;
float flip_rf4cfh = 0;
int ps1_tr=2000000;
int cfl_tr=398000;
int cfh_tr=398000;
int rcvn_tr=398000;
float cfh_ec_position = (16.0/256.0) ;
int cfl_dda = 4 ;
int cfl_nex = 2 ;
int cfh_dda = 4 ;
int cfh_nex = 2 ;
int rcvn_dda = 0 ;
int rcvn_nex = 1 ;
int local_tg = 0 ;
float fov_scaling = 0.8 ;
float flip_rf1xtg = 90.0;
float gscale_rf1xtg = 1.0;
int init_xtg_deadtime = 0;
float flip_rf1mps1 = 90.0;
float gscale_rf1mps1 = 1.0;
int presscfh_override = 0 ;
int presscfh = PRESSCFH_NONE ;
int presscfh_ctrl = PRESSCFH_NONE ;
int presscfh_outrange = 0;
int presscfh_cgate = 0;
int presscfh_debug = 0 ;
int presscfh_wait_rf12 = 0;
int presscfh_wait_rf23 = 0;
int presscfh_wait_rf34 = 0;
int presscfh_minte = 20000;
float presscfh_fov = 0.0;
float presscfh_fov_ratio = 1.0;
float presscfh_pfov_ratio = 1.0;
float presscfh_slab_ratio = 1.0;
float presscfh_pfov = 0.0;
float presscfh_slthick = 10.0;
float presscfh_slice = 10.0;
float presscfh_ir_slthick = 10.0;
int presscfh_ir_noselect = 1;
float presscfh_minfov_ratio = 0.3;
int cfh_steam_flag = 0;
int steam_pg_gap = 8;
float area_gykcfl = 0;
float area_gykcfh = 0;
float area_xtgzkiller = 0;
float area_xtgykiller = 0;
int PSoff90=80 ;
int dummy_pw = 0;
int min180te = 0;
float PStloc = 0;
float PSrloc = 0;
float PSphasoff = 0;
int PStrigger = 0;
float PStloc_mod = 0;
float PSrloc_mod = 0;
float PSphasoff_mod = 0;
float thickPS_mod = 0;
float asx_killer_area = 840.0;
float asz_killer_area = 840.0;
float cfhir_killer_area = 4086.0;
float ps_crusher_area = 714.0;
float cfh_crusher_area = 4000.0;
float target_cfh_crusher = 0;
float target_cfh_crusher2 = 0;
int cfh_newmode = 1;
float cfh_rf1freq = 0 ;
float cfh_rf2freq = 0 ;
float cfh_rf3freq = 0 ;
float cfh_rf4freq = 0 ;
float cfh_fov = 0 ;
int cfh_ti = 120000;
int eff_cfh_te = 50000;
int PScfh_shimvol_debug = 0 ;
int debug_shimvol_slice = 0;
int wg_cfh_rf3 = 0;
int wg_cfh_rf4 = 0;
float FTGslthk = 20 ;
float FTGopslthickz1=80 ;
float FTGopslthickz2=80 ;
float FTGopslthickz3=20 ;
int ftgtr = 2000000 ;
float FTGfov = 480.0 ;
float FTGau = 4 ;
float FTGtecho = 4 ;
int FTGtau1 = 8192 ;
int FTGtau2 = 32768 ;
int FTGacq1 = 0 ;
int FTGacq2 = 1 ;
int epi_ir_on = 0 ;
int ssfse_ir_on = 0 ;
int ftg_dda = 0 ;
float FTGecho1bw = 3.90625 ;
int FTGtestpulse = 0 ;
int FTGxres = 256 ;
float FTGxmtadd = 0;
int pw_gxw2ftgleft = 4096;
int xtgtr = 200000 ;
int XTGtau1 = 8192 ;
float XTGfov = 480.0 ;
int pw_bsrf = 4000;
int xtg_offres_freq = 2000;
float XTGecho1bw = 15.625 ;
int XTGxres = 256 ;
float xmtaddXTG = 0, xtgscale = 0;
int xtg_dda = 0 ;
int XTGacq1 = 0 ;
float TGopslthick = 10.0 ;
float TGopslthickx = 30.0 ;
float TGopslthicky = 30.0 ;
int XTG_minimizeYKillerGap = 0 ;
int dynTG_etl = 2 ;
int dtg_iso_delay = 1280 ;
int dtg_off90 = 80;
int dtg_dda = 4 ;
int rf1dtg_type = 1 ;
float echo1bwdtg = 15.625 ;
int dtgt_exa = 0, dtgt_exb = 0, tleaddtg = 0, td0dtg = 0;
int dtgphorder = 1;
int dtgspgr_flag = 0 ;
int pw_rf1dtg = 0;
float a_rf1dtg = 0;
int min_dtgte = 0, dtg_esp = 0;
int tr_dtg = 20000;
int time_ssidtg = 400;
int rsaxial_flag = 1 ;
int rsspgr_flag = 1 ;
int multi_channel = 1 ;
int minph_iso_delay = 1280 ;
int rs_off90 = 80;
int rs_iso_delay = 1280 ;
float echo1bwrs = 15.625 ;
int rsphorder = 1;
int rs_dda = 4 ;
int rst_exa = 0, rst_exb = 0, tleadrs = 0, td0rs = 0;
int pw_rf1rs = 0;
int ia_rf1rs = 0;
float a_rf1rs = 0;
int rf1rs_type = 1 ;
float gscale_rf1rs = 0;
float flip_rf1rs = 0, flip_rfbrs = 0, cyc_rf1rs = 0;
float flip_rf1dtg = 0, flip_rfbdtg = 0, cyc_rf1dtg = 0, gscale_rf1dtg = 0;
int ia_rf1dtg = 0;
float rf1rs_scale = 0, rf1dtg_scale = 0;
float xmtaddrs = 0, xmtadddtg = 0;
int pw_acqrs1 = 0, pw_acqdtg1 = 0;
int min_rste = 0, rs_esp = 0;
int tr_rs = 0, tr_prep_rs = 0;
int rd_ext_rs = 0, rd_ext_dtg = 0;
int fast_xtr = 50;
int attenlen = 6;
int tns_len = 4;
int e2_delay_rs = 4;
int e2_delay_dtg = 4;
int time_ssirs = 400;
int rfshim_etl = 2;
int B1Cal_mode = 0 ;
int DD_delay = 2000 ;
int DD_channels = 2 ;
int DD_nCh = 1;
int DD_debug = 0 ;
int endview_iamprs = 0, endview_iampdtg = 0;
float endview_scalers = 0, endview_scaledtg = 0;
float echo1bwcal = 62.5 ;
int cal_dda = 128 ;
int cal_delay = 4000000 ;
int cal_delay_dda = 0;
int calspgr_flag = 1 ;
int cal_tr_interleave = 0;
int cal_nex_interleave = 0;
float cal_xfov = 100.0;
float cal_yfov = 100.0;
float cal_vthick = 10.0;
int cal_btw_rf_rba_ssp = 0;
int cal_grd_rf_delays = 0;
int tleadcal = 0;
int td0cal = 0;
int calt_exa = 4;
int calt_exb = 4;
int tacq_cal = 4;
int te_cal = 4;
int tr_cal = 4;
float flip_rf1cal = 0.0;
int cal_iso_delay = 0;
int endview_iampcal = 0;
int endviewz_iampcal = 0;
float endview_scalecal = 1.0;
float endviewz_scalecal = 1.0;
float a_combcal = 1.0;
float a_endcal = 1.0;
float a_combcal2 = 1.0;
float a_endcal2 = 1.0;
int time_ssical = 160;
float xmtaddcal = 0.0;
float cal_amplimit = 0.0;
float cal_slewrate = 100.0;
float cal_sr_derate = 1.0;
float cal_freq_scale = 1.0;
float cal_phase_scale = 1.0;
float area_gzkcal = 300.0;
float cal_ampscale = 1.05;
int cal_pfkr_flag = 1;
float cal_pfkr_fraction = 1.0;
int cal_sampledPts = 0;
float echo1bwcoil = 62.5 ;
int coil_dda = 4 ;
int coilspgr_flag = 1 ;
int coil_nex_interleave = 0;
float coil_xfov = 100.0;
float coil_yfov = 100.0;
float coil_vthick = 10.0;
int tleadcoil = 0;
int td0coil = 0;
int coilt_exa = 4;
int coilt_exb = 4;
int tacq_coil = 4;
int te_coil = 4;
int tr_coil = 4;
float flip_rf1coil = 0.0;
int coil_iso_delay = 0;
int endview_iampcoil = 0;
int endviewz_iampcoil = 0;
float endview_scalecoil = 1.0;
float endviewz_scalecoil = 1.0;
float a_combcoil = 1.0;
float a_endcoil = 1.0;
float a_combcoil2 = 1.0;
float a_endcoil2 = 1.0;
int time_ssicoil = 160;
float xmtaddcoil = 0.0;
float coil_amplimit = 0.0;
float coil_slewrate = 100.0;
float coil_freq_scale = 1.0;
float coil_phase_scale = 1.0;
int coil_pfkr_flag = 1;
float coil_pfkr_fraction = 1.0;
int coil_sampledPts = 0;
int CFLxres = 256 ;
int CFHxres = 256 ;
float echo1bwcfl = 2.016129 ;
float echo1bwcfh = 0.50 ;
float echo1bwrcvn = 15.625 ;
int rcvn_xres = 4096 ;
int rcvn_loops = 10;
int pw_grdtrig= 8 ;
int wait_time_before_cfh = 1000000 ;
float echo1bwas = 15.625 ;
int off90as = 80 ;
int td0as = 4 ;
int t_exaas = 0 ;
int time_ssias = 400 ;
int tleadas = 25 ;
int te_as = 0;
int tr_as = 0;
int as_dda = 4 ;
int pw_isislice= 200 ;
int pw_rotslice= 12 ;
int isi_sliceextra = 32 ;
int rgfeature_enable = 0 ;
float aslenap = 200 ;
float aslenrl = 200 ;
float aslensi = 200 ;
float aslocap = 0 ;
float aslocrl = 0 ;
float aslocsi = 0 ;
float area_gxwas = 0;
float area_gz1as = 0;
float area_readrampas = 0;
int avail_pwgx1as = 0;
int avail_pwgz1as = 0;
int bw_rf1as = 0;
float flip_pctas=1.0;
int dix_timeas = 0;
float xmtaddas = 0,xmtlogas = 0;
int ps1obl_debug = 0
;
int asobl_debug = 0
;
int ps1_newgeo = 1;
int as_newgeo = 1;
int pw_gy1as_tot = 0;
int endview_iampas = 0;
float endview_scaleas = 0;
int cfh_newgeo = 1;
int cfhobl_debug = 0
;
float deltf = 1.0 ;
int IRinCFH = 0 ;
int cfh_each = 0 ;
int cfh_slquant = 0 ;
int noswitch_slab_psc = 0 ;
int noswitch_coil_psc = 0 ;
int PStest_slab = 1 ;
int pimrsapsflg = 0 ;
int pimrsaps1 = 1
;
int pimrsaps2 = 104
;
int pimrsaps3 = 103
;
int pimrsaps4 = 4
;
int pimrsaps5 = 12
;
int pimrsaps6 = 3
;
int pimrsaps7 = 0
;
int pimrsaps8 = 0
;
int pimrsaps9 = 0
;
int pimrsaps10 = 0
;
int pimrsaps11 = 0
;
int pimrsaps12 = 0
;
int pimrsaps13 = 0
;
int pimrsaps14 = 0
;
int pimrsaps15 = 0
;
int pw_contrfhubsel = 4 ;
int delay_rfhubsel = 20;
int pw_contrfsel = 4 ;
int csw_tr = 0 ;
int csw_wait_sethubindeximm = 250000
;
int csw_wait_setrcvportimm = 100000
;
int csw_wait_before = 10000 ;
int csw_time_ssi = 50
;
float area_gxkrcvn = 10000;
float area_gykrcvn = 10000;
float area_gzkrcvn = 10000;
int pre_rcvn_tr = 20000 ;
int rcvn_flag = 1 ;
int psd_startta_override = 0 ;
int psd_psctg = APS_CONTROL_PSC
;
int psd_pscshim = APS_CONTROL_PSC
;
int psd_pscall = APS_CONTROL_PSC
;
int bw_rf1cal = 0, bw_rf1coil = 0;
int debug = 1 ;
int nl = 1 ;
int scluster = 0 ;
int nextra = 2 ;
int nframes = 1 ;
int total_views = 0;
int gating = 0x07 ;
int psdseqtime = 0;
int psdtottime = 0;
int timessi=120 ;
int trerror = 0;
int nerror = 0;
int gtype = 0 ;
float gslew = 150.0 ;
float gamp = 2.3 ;
float gfov = 24.0 ;
int gres = 0 ;
float gmax = 2.4 ;
float rtimescale = 2.1 ;
int nramp = 100 ;
float agxpre = 0.;
float agypre = 0.;
float prefudge = 1.004 ;
int pwgpre = 1000;
int tadmax = 0;
int tlead = 160;
float daqdeloff = 0.0 ;
int daqdel = 128 ;
int thetdeloff = 0 ;
int espace = 140 ;
int readpos = 0;
int daqpos = 0;
int minte = 0;
int seqtr = 0 ;
int endtime = 500000 ;
int vdflag = 1 ;
float alpha = 3.6 ;
float kmaxfrac = 0.5 ;
int slord = 0;
float satBW = 440.0 ;
float satoff = -520.0 ;
int pwrf0 = 0;
float arf0 = 0;
int fuzz = 0, fatsattime = 0;
int pwrf1 = 6400 ;
int cycrf1 = 4;
int domap = 1 ;
int mapdel = 2000;
int bmapnav = 1 ;
int off_fov = 1 ;
float tsp = 4.0 ;
float bandwidth = 125.0 ;
float decimation = 1.0;
int filter_aps2 = 1;
int psfrsize = 512 ;
int queue_size = 1024 ;
int seed = 16807 ;
int nbang = 0 ;
float zref = 1.0 ;
int trigloc = 1000 ;
int triglen = 4000 ;
int trigfreq = 1 ;
int maketrig = 1 ;
int ndisdaq = 4;
int pos_start = 0 ;
int obl_debug = 0;
int obl_method = 1
;
int t_tag = 0;
int t_delay = 0;
float B1tag_distance = 0;
int B1tag_offset = 0;
int astseqtime = 0;
int astseqtime2 = 0;
int t_adjust = 0;
int delta1 = 0 ;
int isRFon=0;
int mycrush=0;
int crushtype=1;
int mycontrol=0;
int xres=64;
int M0frames = 8;
int isOdd = 0;
int doZgrappa = 0;
int doASLcardiacTrig = 0;
float fractional_moment=0.9;
int t_rfrepeat = 1000;
int tmin_rfrepeat = 0;
int nreps = 0;
float pcasl_flip = 25;
int myramptime = 40;
float pcasl_Gmax = 0.6;
float pcasl_Gave = 0.06;
float area_gzrftag1 = 0;
float area_gzrftag2 = 0;
float area_gzrftag1c = 0;
float area_gzrftag2c = 0;
float area_gzrftag1r = 0;
float area_gzrftag2r = 0;
float area_gzrftag1rc = 0;
float area_gzrftag2rc = 0;
float myphase_increment = 0;
float my_radians_per_CM = 0;
float my_notch_distance = 0;
int closest_notch = 0;
float manual_phase_correction = 0;
int tdelaycore_fix = 11;
float myphase_increment_0 = 0;
float myPhaseCorr = 0;
int doRT=0;
int ia_gzrftag1r_0 = 0;
int multiphsFlag = 0;
int nfr_phs = 2;
int spgr_flag = 3 ;
int rfamp_flag = 0;
int rf_spoil_seed = 117 ;
float target = 0;
int rtime = 0, ftime = 0;
float zfov = 0;
float ampGzstep = 0;
float areaGzstep = 0;
int iampGzstep = 0;
int pwGzstep = 500 ;
int dopresat = 0 ;
float rf1maxTime = (456.0/ 500.0);
float area_gzrf1 = 0;
float area_gzrf1r = 0;
float rf1_bw = 0;
float slab_fraction=0.85;
int BS1_time = 200000;
int BS2_time = 1200000;
float rfscalesech = 0;
int doBS = 1;
int t_preBS = 0;
float slwid180 = 1.2 ;
int tpre=0;
int tdel=0;
int mytpre = 0;
int tcs = 0;
int cyc_rf1 = 4;
int echoshift = 0 ;
int textra_tadjust = 100;
int textra_astcore = 0;
int textra_delaycore = 300;
int textra = 0;
int fat_chemshift = -440;
  float a_rf1 = 0;
  int ia_rf1 = 0;
  int pw_rf1 = 0;
  int res_rf1 = 0;
  int off_rf1 = 0;
  int wg_rf1 = 0;
  float a_gzrf1 = 0;
  int ia_gzrf1 = 0;
  int pw_gzrf1a = 0;
  int pw_gzrf1d = 0;
  int pw_gzrf1 = 0;
  int wg_gzrf1 = 0;
  int ia_gxprew = 0;
  float a_gxpre = 0;
  int ia_gxpre = 0;
  int pw_gxpre = 0;
  int res_gxpre = 0;
  float phs_gxpre = 0;
  float phl_gxpre = 0;
  int off_gxpre = 0;
  int wg_gxpre = 0;
  int ia_gyprew = 0;
  float a_gypre = 0;
  int ia_gypre = 0;
  int pw_gypre = 0;
  int res_gypre = 0;
  float phs_gypre = 0;
  float phl_gypre = 0;
  int off_gypre = 0;
  int wg_gypre = 0;
  float a_gzrf1r = 0;
  int ia_gzrf1r = 0;
  int pw_gzrf1ra = 0;
  int pw_gzrf1rd = 0;
  int pw_gzrf1r = 0;
  int wg_gzrf1r = 0;
  float a_gxsp3 = 0;
  int ia_gxsp3 = 0;
  int pw_gxsp3a = 0;
  int pw_gxsp3d = 0;
  int pw_gxsp3 = 0;
  int wg_gxsp3 = 0;
  float a_gxsp4 = 0;
  int ia_gxsp4 = 0;
  int pw_gxsp4a = 0;
  int pw_gxsp4d = 0;
  int pw_gxsp4 = 0;
  int wg_gxsp4 = 0;
  float a_gysp3 = 0;
  int ia_gysp3 = 0;
  int pw_gysp3a = 0;
  int pw_gysp3d = 0;
  int pw_gysp3 = 0;
  int wg_gysp3 = 0;
  float a_gysp4 = 0;
  int ia_gysp4 = 0;
  int pw_gysp4a = 0;
  int pw_gysp4d = 0;
  int pw_gysp4 = 0;
  int wg_gysp4 = 0;
  float a_gzsp3 = 0;
  int ia_gzsp3 = 0;
  int pw_gzsp3a = 0;
  int pw_gzsp3d = 0;
  int pw_gzsp3 = 0;
  int wg_gzsp3 = 0;
  float a_gzsp4 = 0;
  int ia_gzsp4 = 0;
  int pw_gzsp4a = 0;
  int pw_gzsp4d = 0;
  int pw_gzsp4 = 0;
  int wg_gzsp4 = 0;
  float a_gzphase1 = 0;
  int ia_gzphase1 = 0;
  int pw_gzphase1a = 0;
  int pw_gzphase1d = 0;
  int pw_gzphase1 = 0;
  int wg_gzphase1 = 0;
  int pw_mapx = 0;
  int wg_mapx = 0;
  int pw_mapy = 0;
  int wg_mapy = 0;
  int pw_mapz = 0;
  int wg_mapz = 0;
  int pw_mapt = 0;
  int wg_mapt = 0;
  float a_gx = 0;
  int ia_gx = 0;
  int pw_gx = 0;
  int res_gx = 0;
  float a_gy = 0;
  int ia_gy = 0;
  int pw_gy = 0;
  int res_gy = 0;
  int pw_maps1 = 0;
  int wg_maps1 = 0;
  int filter_echo1 = 0;
  int pw_mapx2 = 0;
  int wg_mapx2 = 0;
  int pw_mapy2 = 0;
  int wg_mapy2 = 0;
  int pw_mapz2 = 0;
  int wg_mapz2 = 0;
  int pw_mapt2 = 0;
  int wg_mapt2 = 0;
  float a_gx2 = 0;
  int ia_gx2 = 0;
  int pw_gx2 = 0;
  int res_gx2 = 0;
  float a_gy2 = 0;
  int ia_gy2 = 0;
  int pw_gy2 = 0;
  int res_gy2 = 0;
  int pw_maps2 = 0;
  int wg_maps2 = 0;
  int filter_echo2 = 0;
  int pw_maps3 = 0;
  int wg_maps3 = 0;
  float a_gzphase2 = 0;
  int ia_gzphase2 = 0;
  int pw_gzphase2a = 0;
  int pw_gzphase2d = 0;
  int pw_gzphase2 = 0;
  int wg_gzphase2 = 0;
  float a_gzspoil = 0;
  int ia_gzspoil = 0;
  int pw_gzspoila = 0;
  int pw_gzspoild = 0;
  int pw_gzspoil = 0;
  int wg_gzspoil = 0;
  float a_gxspoil = 0;
  int ia_gxspoil = 0;
  int pw_gxspoila = 0;
  int pw_gxspoild = 0;
  int pw_gxspoil = 0;
  int wg_gxspoil = 0;
  float a_gyspoil = 0;
  int ia_gyspoil = 0;
  int pw_gyspoila = 0;
  int pw_gyspoild = 0;
  int pw_gyspoil = 0;
  int wg_gyspoil = 0;
  float a_BS0rf = 0;
  int ia_BS0rf = 0;
  int pw_BS0rf = 0;
  int res_BS0rf = 0;
  int off_BS0rf = 0;
  int wg_BS0rf = 0;
  float a_BS0rf_theta = 0;
  int ia_BS0rf_theta = 0;
  int pw_BS0rf_theta = 0;
  int res_BS0rf_theta = 0;
  int off_BS0rf_theta = 0;
  int wg_BS0rf_theta = 0;
  float a_gzBS0rfspoiler = 0;
  int ia_gzBS0rfspoiler = 0;
  int pw_gzBS0rfspoilera = 0;
  int pw_gzBS0rfspoilerd = 0;
  int pw_gzBS0rfspoiler = 0;
  int wg_gzBS0rfspoiler = 0;
  float a_rftag1 = 0;
  int ia_rftag1 = 0;
  int pw_rftag1 = 0;
  int res_rftag1 = 0;
  int off_rftag1 = 0;
  int wg_rftag1 = 0;
  float a_gzrftag1 = 0;
  int ia_gzrftag1 = 0;
  int pw_gzrftag1a = 0;
  int pw_gzrftag1d = 0;
  int pw_gzrftag1 = 0;
  int wg_gzrftag1 = 0;
  float a_gzrftag1r = 0;
  int ia_gzrftag1r = 0;
  int pw_gzrftag1ra = 0;
  int pw_gzrftag1rd = 0;
  int pw_gzrftag1r = 0;
  int wg_gzrftag1r = 0;
  float a_rftag2 = 0;
  int ia_rftag2 = 0;
  int pw_rftag2 = 0;
  int res_rftag2 = 0;
  int off_rftag2 = 0;
  int wg_rftag2 = 0;
  float a_gzrftag2 = 0;
  int ia_gzrftag2 = 0;
  int pw_gzrftag2a = 0;
  int pw_gzrftag2d = 0;
  int pw_gzrftag2 = 0;
  int wg_gzrftag2 = 0;
  float a_gzrftag2r = 0;
  int ia_gzrftag2r = 0;
  int pw_gzrftag2ra = 0;
  int pw_gzrftag2rd = 0;
  int pw_gzrftag2r = 0;
  int wg_gzrftag2r = 0;
  float a_rftag1c = 0;
  int ia_rftag1c = 0;
  int pw_rftag1c = 0;
  int res_rftag1c = 0;
  int off_rftag1c = 0;
  int wg_rftag1c = 0;
  float a_gzrftag1c = 0;
  int ia_gzrftag1c = 0;
  int pw_gzrftag1ca = 0;
  int pw_gzrftag1cd = 0;
  int pw_gzrftag1c = 0;
  int wg_gzrftag1c = 0;
  float a_gzrftag1rc = 0;
  int ia_gzrftag1rc = 0;
  int pw_gzrftag1rca = 0;
  int pw_gzrftag1rcd = 0;
  int pw_gzrftag1rc = 0;
  int wg_gzrftag1rc = 0;
  float a_rftag2c = 0;
  int ia_rftag2c = 0;
  int pw_rftag2c = 0;
  int res_rftag2c = 0;
  int off_rftag2c = 0;
  int wg_rftag2c = 0;
  float a_gzrftag2c = 0;
  int ia_gzrftag2c = 0;
  int pw_gzrftag2ca = 0;
  int pw_gzrftag2cd = 0;
  int pw_gzrftag2c = 0;
  int wg_gzrftag2c = 0;
  float a_gzrftag2rc = 0;
  int ia_gzrftag2rc = 0;
  int pw_gzrftag2rca = 0;
  int pw_gzrftag2rcd = 0;
  int pw_gzrftag2rc = 0;
  int wg_gzrftag2rc = 0;
  float a_BS1rf = 0;
  int ia_BS1rf = 0;
  int pw_BS1rf = 0;
  int res_BS1rf = 0;
  int off_BS1rf = 0;
  int wg_BS1rf = 0;
  float a_BS1rf_theta = 0;
  int ia_BS1rf_theta = 0;
  int pw_BS1rf_theta = 0;
  int res_BS1rf_theta = 0;
  int off_BS1rf_theta = 0;
  int wg_BS1rf_theta = 0;
  float a_BS2rf = 0;
  int ia_BS2rf = 0;
  int pw_BS2rf = 0;
  int res_BS2rf = 0;
  int off_BS2rf = 0;
  int wg_BS2rf = 0;
  float a_BS2rf_theta = 0;
  int ia_BS2rf_theta = 0;
  int pw_BS2rf_theta = 0;
  int res_BS2rf_theta = 0;
  int off_BS2rf_theta = 0;
  int wg_BS2rf_theta = 0;
  float a_rf0 = 0;
  int ia_rf0 = 0;
  int pw_rf0 = 0;
  int res_rf0 = 0;
  float cyc_rf0 = 0;
  int off_rf0 = 0;
  float alpha_rf0 = 0;
  int wg_rf0 = 0;
  float a_gz0 = 0;
  int ia_gz0 = 0;
  int pw_gz0a = 0;
  int pw_gz0d = 0;
  int pw_gz0 = 0;
  int wg_gz0 = 0;
  int ia_trigon = 0;
  int ia_trigoff = 0;
  int pw_TRdelay = 0;
  int wg_TRdelay = 0;
  int pw_waitStart = 0;
  int wg_waitStart = 0;
  int pw_waitEnd = 0;
  int wg_waitEnd = 0;
  float a_rf1mps1 = 0;
  int ia_rf1mps1 = 0;
  int pw_rf1mps1 = 0;
  int res_rf1mps1 = 0;
  float cyc_rf1mps1 = 0;
  int off_rf1mps1 = 0;
  float alpha_rf1mps1 = 0;
  int wg_rf1mps1 = 0;
  float a_gyrf1mps1 = 0;
  int ia_gyrf1mps1 = 0;
  int pw_gyrf1mps1a = 0;
  int pw_gyrf1mps1d = 0;
  int pw_gyrf1mps1 = 0;
  int wg_gyrf1mps1 = 0;
  float a_gy1mps1 = 0;
  int ia_gy1mps1 = 0;
  int pw_gy1mps1a = 0;
  int pw_gy1mps1d = 0;
  int pw_gy1mps1 = 0;
  int wg_gy1mps1 = 0;
  float a_gzrf1mps1 = 0;
  int ia_gzrf1mps1 = 0;
  int pw_gzrf1mps1a = 0;
  int pw_gzrf1mps1d = 0;
  int pw_gzrf1mps1 = 0;
  int wg_gzrf1mps1 = 0;
  float a_gz1mps1 = 0;
  int ia_gz1mps1 = 0;
  int pw_gz1mps1a = 0;
  int pw_gz1mps1d = 0;
  int pw_gz1mps1 = 0;
  int wg_gz1mps1 = 0;
  float a_gx1mps1 = 0;
  int ia_gx1mps1 = 0;
  int pw_gx1mps1a = 0;
  int pw_gx1mps1d = 0;
  int pw_gx1mps1 = 0;
  int wg_gx1mps1 = 0;
  float a_gzrf2mps1 = 0;
  int ia_gzrf2mps1 = 0;
  int pw_gzrf2mps1a = 0;
  int pw_gzrf2mps1d = 0;
  int pw_gzrf2mps1 = 0;
  float a_rf2mps1 = 0;
  int ia_rf2mps1 = 0;
  int pw_rf2mps1 = 0;
  int res_rf2mps1 = 0;
  int temp_res_rf2mps1 = 0;
  float cyc_rf2mps1 = 0;
  int off_rf2mps1 = 0;
  float alpha_rf2mps1 = 0.46;
  float thk_rf2mps1 = 0;
  float gscale_rf2mps1 = 1.0;
  float flip_rf2mps1 = 0;
  int wg_rf2mps1 = TYPRHO1
;
  float a_gzrf2lmps1 = 0;
  int ia_gzrf2lmps1 = 0;
  int pw_gzrf2lmps1a = 0;
  int pw_gzrf2lmps1d = 0;
  int pw_gzrf2lmps1 = 0;
  int wg_gzrf2lmps1 = 0;
  float a_gzrf2rmps1 = 0;
  int ia_gzrf2rmps1 = 0;
  int pw_gzrf2rmps1a = 0;
  int pw_gzrf2rmps1d = 0;
  int pw_gzrf2rmps1 = 0;
  int wg_gzrf2rmps1 = 0;
  float a_gxwmps1 = 0;
  int ia_gxwmps1 = 0;
  int pw_gxwmps1a = 0;
  int pw_gxwmps1d = 0;
  int pw_gxwmps1 = 0;
  int wg_gxwmps1 = 0;
  int filter_echo1mps1 = 0;
  float a_gzrf1cfl = 0;
  int ia_gzrf1cfl = 0;
  int pw_gzrf1cfla = 0;
  int pw_gzrf1cfld = 0;
  int pw_gzrf1cfl = 0;
  float a_rf1cfl = 0;
  int ia_rf1cfl = 0;
  int pw_rf1cfl = 0;
  int res_rf1cfl = 0;
  int temp_res_rf1cfl = 0;
  float cyc_rf1cfl = 0;
  int off_rf1cfl = 0;
  float alpha_rf1cfl = 0.46;
  float thk_rf1cfl = 0;
  float gscale_rf1cfl = 1.0;
  float flip_rf1cfl = 0;
  int wg_rf1cfl = TYPRHO1
;
  float a_gz1cfl = 0;
  int ia_gz1cfl = 0;
  int pw_gz1cfla = 0;
  int pw_gz1cfld = 0;
  int pw_gz1cfl = 0;
  int wg_gz1cfl = 0;
  int filter_cfl_fid = 0;
  float a_gykcfl = 0;
  int ia_gykcfl = 0;
  int pw_gykcfla = 0;
  int pw_gykcfld = 0;
  int pw_gykcfl = 0;
  int wg_gykcfl = 0;
  float a_gxkrcvn = 0;
  int ia_gxkrcvn = 0;
  int pw_gxkrcvna = 0;
  int pw_gxkrcvnd = 0;
  int pw_gxkrcvn = 0;
  int wg_gxkrcvn = 0;
  float a_gykrcvn = 0;
  int ia_gykrcvn = 0;
  int pw_gykrcvna = 0;
  int pw_gykrcvnd = 0;
  int pw_gykrcvn = 0;
  int wg_gykrcvn = 0;
  float a_gzkrcvn = 0;
  int ia_gzkrcvn = 0;
  int pw_gzkrcvna = 0;
  int pw_gzkrcvnd = 0;
  int pw_gzkrcvn = 0;
  int wg_gzkrcvn = 0;
  int pw_grd_trig = 0;
  int wg_grd_trig = 0;
  float a_gxk2rcvn = 0;
  int ia_gxk2rcvn = 0;
  int pw_gxk2rcvna = 0;
  int pw_gxk2rcvnd = 0;
  int pw_gxk2rcvn = 0;
  int wg_gxk2rcvn = 0;
  float a_gyk2rcvn = 0;
  int ia_gyk2rcvn = 0;
  int pw_gyk2rcvna = 0;
  int pw_gyk2rcvnd = 0;
  int pw_gyk2rcvn = 0;
  int wg_gyk2rcvn = 0;
  float a_gzk2rcvn = 0;
  int ia_gzk2rcvn = 0;
  int pw_gzk2rcvna = 0;
  int pw_gzk2rcvnd = 0;
  int pw_gzk2rcvn = 0;
  int wg_gzk2rcvn = 0;
  int pw_rcvn_wait = 0;
  int wg_rcvn_wait = 0;
  int ia_rcvrbl = 0;
  int filter_rcvn_fid = 0;
  int ia_rcvrbl2 = 0;
  float a_gzrf0cfh = 0;
  int ia_gzrf0cfh = 0;
  int pw_gzrf0cfha = 0;
  int pw_gzrf0cfhd = 0;
  int pw_gzrf0cfh = 0;
  int res_gzrf0cfh = 0;
  float a_rf0cfh = 0;
  int ia_rf0cfh = 0;
  int pw_rf0cfh = 0;
  int res_rf0cfh = 0;
  float cyc_rf0cfh = 0;
  int off_rf0cfh = 0;
  float alpha_rf0cfh = 0.46;
  float thk_rf0cfh = 0;
  float gscale_rf0cfh = 1.0;
  float flip_rf0cfh = 0;
  int wg_rf0cfh = TYPRHO1
;
  float a_omegarf0cfh = 0;
  int ia_omegarf0cfh = 0;
  int pw_omegarf0cfh = 0;
  int res_omegarf0cfh = 0;
  int off_omegarf0cfh = 0;
  int rfslot_omegarf0cfh = 0;
  float gscale_omegarf0cfh = 1.0;
  int n_omegarf0cfh = 0;
  int wg_omegarf0cfh = 0;
  float a_gyrf0kcfh = 0;
  int ia_gyrf0kcfh = 0;
  int pw_gyrf0kcfha = 0;
  int pw_gyrf0kcfhd = 0;
  int pw_gyrf0kcfh = 0;
  int wg_gyrf0kcfh = 0;
  int pw_zticfh = 0;
  int wg_zticfh = 0;
  int pw_rticfh = 0;
  int wg_rticfh = 0;
  int pw_xticfh = 0;
  int wg_xticfh = 0;
  int pw_yticfh = 0;
  int wg_yticfh = 0;
  int pw_sticfh = 0;
  int wg_sticfh = 0;
  float a_gzrf1cfh = 0;
  int ia_gzrf1cfh = 0;
  int pw_gzrf1cfha = 0;
  int pw_gzrf1cfhd = 0;
  int pw_gzrf1cfh = 0;
  float a_rf1cfh = 0;
  int ia_rf1cfh = 0;
  int pw_rf1cfh = 0;
  int res_rf1cfh = 0;
  int temp_res_rf1cfh = 0;
  float cyc_rf1cfh = 0;
  int off_rf1cfh = 0;
  float alpha_rf1cfh = 0.46;
  float thk_rf1cfh = 0;
  float gscale_rf1cfh = 1.0;
  float flip_rf1cfh = 0;
  int wg_rf1cfh = TYPRHO1
;
  float a_rf2cfh = 0;
  int ia_rf2cfh = 0;
  int pw_rf2cfh = 0;
  int res_rf2cfh = 0;
  float cyc_rf2cfh = 0;
  int off_rf2cfh = 0;
  float alpha_rf2cfh = 0;
  int wg_rf2cfh = 0;
  float a_rf3cfh = 0;
  int ia_rf3cfh = 0;
  int pw_rf3cfh = 0;
  int res_rf3cfh = 0;
  float cyc_rf3cfh = 0;
  int off_rf3cfh = 0;
  float alpha_rf3cfh = 0;
  int wg_rf3cfh = 0;
  float a_rf4cfh = 0;
  int ia_rf4cfh = 0;
  int pw_rf4cfh = 0;
  int res_rf4cfh = 0;
  float cyc_rf4cfh = 0;
  int off_rf4cfh = 0;
  float alpha_rf4cfh = 0;
  int wg_rf4cfh = 0;
  float a_gxrf2cfh = 0;
  int ia_gxrf2cfh = 0;
  int pw_gxrf2cfha = 0;
  int pw_gxrf2cfhd = 0;
  int pw_gxrf2cfh = 0;
  int wg_gxrf2cfh = 0;
  float a_gyrf2cfh = 0;
  int ia_gyrf2cfh = 0;
  int pw_gyrf2cfha = 0;
  int pw_gyrf2cfhd = 0;
  int pw_gyrf2cfh = 0;
  int wg_gyrf2cfh = 0;
  float a_gzrf2lcfh = 0;
  int ia_gzrf2lcfh = 0;
  int pw_gzrf2lcfha = 0;
  int pw_gzrf2lcfhd = 0;
  int pw_gzrf2lcfh = 0;
  int wg_gzrf2lcfh = 0;
  float a_gzrf2rcfh = 0;
  int ia_gzrf2rcfh = 0;
  int pw_gzrf2rcfha = 0;
  int pw_gzrf2rcfhd = 0;
  int pw_gzrf2rcfh = 0;
  int wg_gzrf2rcfh = 0;
  float a_gyrf3cfh = 0;
  int ia_gyrf3cfh = 0;
  int pw_gyrf3cfha = 0;
  int pw_gyrf3cfhd = 0;
  int pw_gyrf3cfh = 0;
  int wg_gyrf3cfh = 0;
  float a_gzrf3lcfh = 0;
  int ia_gzrf3lcfh = 0;
  int pw_gzrf3lcfha = 0;
  int pw_gzrf3lcfhd = 0;
  int pw_gzrf3lcfh = 0;
  int wg_gzrf3lcfh = 0;
  float a_gzrf3rcfh = 0;
  int ia_gzrf3rcfh = 0;
  int pw_gzrf3rcfha = 0;
  int pw_gzrf3rcfhd = 0;
  int pw_gzrf3rcfh = 0;
  int wg_gzrf3rcfh = 0;
  float a_gy1cfh = 0;
  int ia_gy1cfh = 0;
  int pw_gy1cfha = 0;
  int pw_gy1cfhd = 0;
  int pw_gy1cfh = 0;
  int wg_gy1cfh = 0;
  float a_gx1cfh = 0;
  int ia_gx1cfh = 0;
  int pw_gx1cfha = 0;
  int pw_gx1cfhd = 0;
  int pw_gx1cfh = 0;
  int wg_gx1cfh = 0;
  float a_gzrf4cfh = 0;
  int ia_gzrf4cfh = 0;
  int pw_gzrf4cfha = 0;
  int pw_gzrf4cfhd = 0;
  int pw_gzrf4cfh = 0;
  int wg_gzrf4cfh = 0;
  int pw_isi_slice1 = 0;
  int wg_isi_slice1 = 0;
  int pw_rot_slice1 = 0;
  int wg_rot_slice1 = 0;
  int pw_isi_slice2 = 0;
  int wg_isi_slice2 = 0;
  int pw_rot_slice2 = 0;
  int wg_rot_slice2 = 0;
  float a_gzrf4lcfh = 0;
  int ia_gzrf4lcfh = 0;
  int pw_gzrf4lcfha = 0;
  int pw_gzrf4lcfhd = 0;
  int pw_gzrf4lcfh = 0;
  int wg_gzrf4lcfh = 0;
  float a_gzrf4rcfh = 0;
  int ia_gzrf4rcfh = 0;
  int pw_gzrf4rcfha = 0;
  int pw_gzrf4rcfhd = 0;
  int pw_gzrf4rcfh = 0;
  int wg_gzrf4rcfh = 0;
  int filter_cfh_fid = 0;
  float a_gykcfh = 0;
  int ia_gykcfh = 0;
  int pw_gykcfha = 0;
  int pw_gykcfhd = 0;
  int pw_gykcfh = 0;
  int wg_gykcfh = 0;
  int ia_contrfhubsel = 0;
  int ia_contrfsel = 0;
  int pw_csw_wait = 0;
  int wg_csw_wait = 0;
  float a_gzrf1ftg = 0;
  int ia_gzrf1ftg = 0;
  int pw_gzrf1ftga = 0;
  int pw_gzrf1ftgd = 0;
  int pw_gzrf1ftg = 0;
  float a_rf1ftg = 0;
  int ia_rf1ftg = 0;
  int pw_rf1ftg = 0;
  int res_rf1ftg = 0;
  int temp_res_rf1ftg = 0;
  float cyc_rf1ftg = 0;
  int off_rf1ftg = 0;
  float alpha_rf1ftg = 0.46;
  float thk_rf1ftg = 0;
  float gscale_rf1ftg = 1.0;
  float flip_rf1ftg = 0;
  int wg_rf1ftg = TYPRHO1
;
  float a_gz1ftg = 0;
  int ia_gz1ftg = 0;
  int pw_gz1ftga = 0;
  int pw_gz1ftgd = 0;
  int pw_gz1ftg = 0;
  int wg_gz1ftg = 0;
  float a_gzrf2ftg = 0;
  int ia_gzrf2ftg = 0;
  int pw_gzrf2ftga = 0;
  int pw_gzrf2ftgd = 0;
  int pw_gzrf2ftg = 0;
  float a_rf2ftg = 0;
  int ia_rf2ftg = 0;
  int pw_rf2ftg = 0;
  int res_rf2ftg = 0;
  int temp_res_rf2ftg = 0;
  float cyc_rf2ftg = 0;
  int off_rf2ftg = 0;
  float alpha_rf2ftg = 0.46;
  float thk_rf2ftg = 0;
  float gscale_rf2ftg = 1.0;
  float flip_rf2ftg = 0;
  int wg_rf2ftg = TYPRHO1
;
  float a_gz2ftg = 0;
  int ia_gz2ftg = 0;
  int pw_gz2ftga = 0;
  int pw_gz2ftgd = 0;
  int pw_gz2ftg = 0;
  int wg_gz2ftg = 0;
  float a_gzrf3ftg = 0;
  int ia_gzrf3ftg = 0;
  int pw_gzrf3ftga = 0;
  int pw_gzrf3ftgd = 0;
  int pw_gzrf3ftg = 0;
  float a_rf3ftg = 0;
  int ia_rf3ftg = 0;
  int pw_rf3ftg = 0;
  int res_rf3ftg = 0;
  int temp_res_rf3ftg = 0;
  float cyc_rf3ftg = 0;
  int off_rf3ftg = 0;
  float alpha_rf3ftg = 0.46;
  float thk_rf3ftg = 0;
  float gscale_rf3ftg = 1.0;
  float flip_rf3ftg = 0;
  int wg_rf3ftg = TYPRHO1
;
  float a_gz3ftg = 0;
  int ia_gz3ftg = 0;
  int pw_gz3ftga = 0;
  int pw_gz3ftgd = 0;
  int pw_gz3ftg = 0;
  int wg_gz3ftg = 0;
  float a_gx1ftg = 0;
  int ia_gx1ftg = 0;
  int pw_gx1ftga = 0;
  int pw_gx1ftgd = 0;
  int pw_gx1ftg = 0;
  int wg_gx1ftg = 0;
  float a_gx1bftg = 0;
  int ia_gx1bftg = 0;
  int pw_gx1bftga = 0;
  int pw_gx1bftgd = 0;
  int pw_gx1bftg = 0;
  int wg_gx1bftg = 0;
  float a_gxw1ftg = 0;
  int ia_gxw1ftg = 0;
  int pw_gxw1ftga = 0;
  int pw_gxw1ftgd = 0;
  int pw_gxw1ftg = 0;
  int wg_gxw1ftg = 0;
  float a_postgxw1ftg = 0;
  int ia_postgxw1ftg = 0;
  int pw_postgxw1ftga = 0;
  int pw_postgxw1ftgd = 0;
  int pw_postgxw1ftg = 0;
  int wg_postgxw1ftg = 0;
  int filter_echo1ftg = 0;
  float a_gz2bftg = 0;
  int ia_gz2bftg = 0;
  int pw_gz2bftga = 0;
  int pw_gz2bftgd = 0;
  int pw_gz2bftg = 0;
  int wg_gz2bftg = 0;
  float a_gx2ftg = 0;
  int ia_gx2ftg = 0;
  int pw_gx2ftga = 0;
  int pw_gx2ftgd = 0;
  int pw_gx2ftg = 0;
  int wg_gx2ftg = 0;
  float a_gxw2ftg = 0;
  int ia_gxw2ftg = 0;
  int pw_gxw2ftga = 0;
  int pw_gxw2ftgd = 0;
  int pw_gxw2ftg = 0;
  int wg_gxw2ftg = 0;
  float a_gx2test = 0;
  int ia_gx2test = 0;
  int pw_gx2testa = 0;
  int pw_gx2testd = 0;
  int pw_gx2test = 0;
  int wg_gx2test = 0;
  int filter_echo2ftg = 0;
  float a_rf1xtg = 0;
  int ia_rf1xtg = 0;
  int pw_rf1xtg = 0;
  int res_rf1xtg = 0;
  float cyc_rf1xtg = 0;
  int off_rf1xtg = 0;
  float alpha_rf1xtg = 0;
  int wg_rf1xtg = 0;
  float a_gyrf1xtg = 0;
  int ia_gyrf1xtg = 0;
  int pw_gyrf1xtga = 0;
  int pw_gyrf1xtgd = 0;
  int pw_gyrf1xtg = 0;
  int wg_gyrf1xtg = 0;
  float a_gzrf1xtg = 0;
  int ia_gzrf1xtg = 0;
  int pw_gzrf1xtga = 0;
  int pw_gzrf1xtgd = 0;
  int pw_gzrf1xtg = 0;
  int wg_gzrf1xtg = 0;
  float a_gykxtgl = 0;
  int ia_gykxtgl = 0;
  int pw_gykxtgla = 0;
  int pw_gykxtgld = 0;
  int pw_gykxtgl = 0;
  int wg_gykxtgl = 0;
       float a_rf3xtg = 0;
       int ia_rf3xtg = 0;
       int pw_rf3xtg = 0;
       int res_rf3xtg = 0;
       int off_rf3xtg = 0;
       float alpha_rf3xtg = 0.46;
       float gscale_rf3xtg = 1.0;
       float flip_rf3xtg = 0;
       int ia_phs_rf3xtg = 0;
       int wg_rf3xtg = TYPRHO1
;
  float a_gz1xtg = 0;
  int ia_gz1xtg = 0;
  int pw_gz1xtga = 0;
  int pw_gz1xtgd = 0;
  int pw_gz1xtg = 0;
  int wg_gz1xtg = 0;
  float a_gzrf2xtg = 0;
  int ia_gzrf2xtg = 0;
  int pw_gzrf2xtga = 0;
  int pw_gzrf2xtgd = 0;
  int pw_gzrf2xtg = 0;
  float a_rf2xtg = 0;
  int ia_rf2xtg = 0;
  int pw_rf2xtg = 0;
  int res_rf2xtg = 0;
  int temp_res_rf2xtg = 0;
  float cyc_rf2xtg = 0;
  int off_rf2xtg = 0;
  float alpha_rf2xtg = 0.46;
  float thk_rf2xtg = 0;
  float gscale_rf2xtg = 1.0;
  float flip_rf2xtg = 0;
  int wg_rf2xtg = TYPRHO1
;
  float a_gz2xtg = 0;
  int ia_gz2xtg = 0;
  int pw_gz2xtga = 0;
  int pw_gz2xtgd = 0;
  int pw_gz2xtg = 0;
  int wg_gz2xtg = 0;
       float a_rf4xtg = 0;
       int ia_rf4xtg = 0;
       int pw_rf4xtg = 0;
       int res_rf4xtg = 0;
       int off_rf4xtg = 0;
       float alpha_rf4xtg = 0.46;
       float gscale_rf4xtg = 1.0;
       float flip_rf4xtg = 0;
       int ia_phs_rf4xtg = 0;
       int wg_rf4xtg = TYPRHO1
;
  float a_gykxtgr = 0;
  int ia_gykxtgr = 0;
  int pw_gykxtgra = 0;
  int pw_gykxtgrd = 0;
  int pw_gykxtgr = 0;
  int wg_gykxtgr = 0;
  float a_gx1bxtg = 0;
  int ia_gx1bxtg = 0;
  int pw_gx1bxtga = 0;
  int pw_gx1bxtgd = 0;
  int pw_gx1bxtg = 0;
  int wg_gx1bxtg = 0;
  float a_gxw1xtg = 0;
  int ia_gxw1xtg = 0;
  int pw_gxw1xtga = 0;
  int pw_gxw1xtgd = 0;
  int pw_gxw1xtg = 0;
  int wg_gxw1xtg = 0;
  int filter_echo1xtg = 0;
  float a_gzrf1as = 0;
  int ia_gzrf1as = 0;
  int pw_gzrf1asa = 0;
  int pw_gzrf1asd = 0;
  int pw_gzrf1as = 0;
  float a_rf1as = 0;
  int ia_rf1as = 0;
  int pw_rf1as = 0;
  int res_rf1as = 0;
  int temp_res_rf1as = 0;
  float cyc_rf1as = 0;
  int off_rf1as = 0;
  float alpha_rf1as = 0.46;
  float thk_rf1as = 0;
  float gscale_rf1as = 1.0;
  float flip_rf1as = 0;
  int wg_rf1as = TYPRHO1
;
  float a_gz1as = 0;
  int ia_gz1as = 0;
  int pw_gz1asa = 0;
  int pw_gz1asd = 0;
  int pw_gz1as = 0;
  int wg_gz1as = 0;
  float a_gxwas = 0;
  int ia_gxwas = 0;
  int pw_gxwasa = 0;
  int pw_gxwasd = 0;
  int pw_gxwas = 0;
  int wg_gxwas = 0;
  int filter_echo1as = 0;
  float a_gx1as = 0;
  int ia_gx1as = 0;
  int pw_gx1asa = 0;
  int pw_gx1asd = 0;
  int pw_gx1as = 0;
  int wg_gx1as = 0;
  float a_gy1as = 0;
  float a_gy1asa = 0;
  float a_gy1asb = 0;
  int ia_gy1as = 0;
  int ia_gy1aswa = 0;
  int ia_gy1aswb = 0;
  int pw_gy1asa = 0;
  int pw_gy1asd = 0;
  int pw_gy1as = 0;
  int wg_gy1as = 0;
  float a_gy1ras = 0;
  float a_gy1rasa = 0;
  float a_gy1rasb = 0;
  int ia_gy1ras = 0;
  int ia_gy1raswa = 0;
  int ia_gy1raswb = 0;
  int pw_gy1rasa = 0;
  int pw_gy1rasd = 0;
  int pw_gy1ras = 0;
  int wg_gy1ras = 0;
  float a_gxkas = 0;
  int ia_gxkas = 0;
  int pw_gxkasa = 0;
  int pw_gxkasd = 0;
  int pw_gxkas = 0;
  int wg_gxkas = 0;
  float a_gzkas = 0;
  int ia_gzkas = 0;
  int pw_gzkasa = 0;
  int pw_gzkasd = 0;
  int pw_gzkas = 0;
  int wg_gzkas = 0;
  float a_xdixon = 0;
  int ia_xdixon = 0;
  int pw_xdixon = 0;
  int wg_xdixon = 0;
  float a_ydixon = 0;
  int ia_ydixon = 0;
  int pw_ydixon = 0;
  int wg_ydixon = 0;
  float a_zdixon = 0;
  int ia_zdixon = 0;
  int pw_zdixon = 0;
  int wg_zdixon = 0;
  float a_sdixon = 0;
  int ia_sdixon = 0;
  int pw_sdixon = 0;
  int wg_sdixon = 0;
  float a_sdixon2 = 0;
  int ia_sdixon2 = 0;
  int pw_sdixon2 = 0;
  int wg_sdixon2 = 0;
  int ia_dDDIQ = 0;
  int res_rf1rs = 0;
  int wg_rf1rs = 0;
  float a_gzrf1rs = 0;
  int ia_gzrf1rs = 0;
  int pw_gzrf1rsa = 0;
  int pw_gzrf1rsd = 0;
  int pw_gzrf1rs = 0;
  int wg_gzrf1rs = 0;
  float a_gxkbsrs = 0;
  int ia_gxkbsrs = 0;
  int pw_gxkbsrsa = 0;
  int pw_gxkbsrsd = 0;
  int pw_gxkbsrs = 0;
  int wg_gxkbsrs = 0;
  float a_gz1rs = 0;
  int ia_gz1rs = 0;
  int pw_gz1rsa = 0;
  int pw_gz1rsd = 0;
  int pw_gz1rs = 0;
  int wg_gz1rs = 0;
  float a_rfbrs = 0;
  int ia_rfbrs = 0;
  int pw_rfbrs = 0;
  int res_rfbrs = 0;
  int off_rfbrs = 0;
  int rfslot_rfbrs = 0;
  float gscale_rfbrs = 1.0;
  int n_rfbrs = 0;
  int wg_rfbrs = 0;
  float a_thetarfbrs = 0;
  int ia_thetarfbrs = 0;
  int pw_thetarfbrs = 0;
  int res_thetarfbrs = 0;
  int off_thetarfbrs = 0;
  int rfslot_thetarfbrs = 0;
  float gscale_thetarfbrs = 1.0;
  int n_thetarfbrs = 0;
  int wg_thetarfbrs = 0;
  float a_gzkbsrs = 0;
  int ia_gzkbsrs = 0;
  int pw_gzkbsrsa = 0;
  int pw_gzkbsrsd = 0;
  int pw_gzkbsrs = 0;
  int wg_gzkbsrs = 0;
  float a_gxwrs = 0;
  int ia_gxwrs = 0;
  int pw_gxwrsa = 0;
  int pw_gxwrsd = 0;
  int pw_gxwrs = 0;
  int wg_gxwrs = 0;
  int filter_echo1rs = 0;
  float a_gx2rs = 0;
  int ia_gx2rs = 0;
  int pw_gx2rsa = 0;
  int pw_gx2rsd = 0;
  int pw_gx2rs = 0;
  int wg_gx2rs = 0;
  float a_gy2rs = 0;
  float a_gy2rsa = 0;
  float a_gy2rsb = 0;
  int ia_gy2rs = 0;
  int ia_gy2rswa = 0;
  int ia_gy2rswb = 0;
  int pw_gy2rsa = 0;
  int pw_gy2rsd = 0;
  int pw_gy2rs = 0;
  int wg_gy2rs = 0;
  float a_gxw2rs = 0;
  int ia_gxw2rs = 0;
  int pw_gxw2rsa = 0;
  int pw_gxw2rsd = 0;
  int pw_gxw2rs = 0;
  int wg_gxw2rs = 0;
  float a_gx1rs = 0;
  int ia_gx1rs = 0;
  int pw_gx1rsa = 0;
  int pw_gx1rsd = 0;
  int pw_gx1rs = 0;
  int wg_gx1rs = 0;
  float a_gy1rrs = 0;
  float a_gy1rrsa = 0;
  float a_gy1rrsb = 0;
  int ia_gy1rrs = 0;
  int ia_gy1rrswa = 0;
  int ia_gy1rrswb = 0;
  int pw_gy1rrsa = 0;
  int pw_gy1rrsd = 0;
  int pw_gy1rrs = 0;
  int wg_gy1rrs = 0;
  float a_gy1rs = 0;
  float a_gy1rsa = 0;
  float a_gy1rsb = 0;
  int ia_gy1rs = 0;
  int ia_gy1rswa = 0;
  int ia_gy1rswb = 0;
  int pw_gy1rsa = 0;
  int pw_gy1rsd = 0;
  int pw_gy1rs = 0;
  int wg_gy1rs = 0;
  float a_gzkrs = 0;
  int ia_gzkrs = 0;
  int pw_gzkrsa = 0;
  int pw_gzkrsd = 0;
  int pw_gzkrs = 0;
  int wg_gzkrs = 0;
  float a_gxkrs = 0;
  int ia_gxkrs = 0;
  int pw_gxkrsa = 0;
  int pw_gxkrsd = 0;
  int pw_gxkrs = 0;
  int wg_gxkrs = 0;
  int res_rf1dtg = 0;
  int wg_rf1dtg = 0;
  float a_gzrf1dtg = 0;
  int ia_gzrf1dtg = 0;
  int pw_gzrf1dtga = 0;
  int pw_gzrf1dtgd = 0;
  int pw_gzrf1dtg = 0;
  int wg_gzrf1dtg = 0;
  float a_gxkbsdtg = 0;
  int ia_gxkbsdtg = 0;
  int pw_gxkbsdtga = 0;
  int pw_gxkbsdtgd = 0;
  int pw_gxkbsdtg = 0;
  int wg_gxkbsdtg = 0;
  float a_gz1dtg = 0;
  int ia_gz1dtg = 0;
  int pw_gz1dtga = 0;
  int pw_gz1dtgd = 0;
  int pw_gz1dtg = 0;
  int wg_gz1dtg = 0;
  float a_rfbdtg = 0;
  int ia_rfbdtg = 0;
  int pw_rfbdtg = 0;
  int res_rfbdtg = 0;
  int off_rfbdtg = 0;
  int rfslot_rfbdtg = 0;
  float gscale_rfbdtg = 1.0;
  int n_rfbdtg = 0;
  int wg_rfbdtg = 0;
  float a_thetarfbdtg = 0;
  int ia_thetarfbdtg = 0;
  int pw_thetarfbdtg = 0;
  int res_thetarfbdtg = 0;
  int off_thetarfbdtg = 0;
  int rfslot_thetarfbdtg = 0;
  float gscale_thetarfbdtg = 1.0;
  int n_thetarfbdtg = 0;
  int wg_thetarfbdtg = 0;
  float a_gzkbsdtg = 0;
  int ia_gzkbsdtg = 0;
  int pw_gzkbsdtga = 0;
  int pw_gzkbsdtgd = 0;
  int pw_gzkbsdtg = 0;
  int wg_gzkbsdtg = 0;
  float a_gxwdtg = 0;
  int ia_gxwdtg = 0;
  int pw_gxwdtga = 0;
  int pw_gxwdtgd = 0;
  int pw_gxwdtg = 0;
  int wg_gxwdtg = 0;
  int filter_echo1dtg = 0;
  float a_gx2dtg = 0;
  int ia_gx2dtg = 0;
  int pw_gx2dtga = 0;
  int pw_gx2dtgd = 0;
  int pw_gx2dtg = 0;
  int wg_gx2dtg = 0;
  float a_gy2dtg = 0;
  float a_gy2dtga = 0;
  float a_gy2dtgb = 0;
  int ia_gy2dtg = 0;
  int ia_gy2dtgwa = 0;
  int ia_gy2dtgwb = 0;
  int pw_gy2dtga = 0;
  int pw_gy2dtgd = 0;
  int pw_gy2dtg = 0;
  int wg_gy2dtg = 0;
  float a_gxw2dtg = 0;
  int ia_gxw2dtg = 0;
  int pw_gxw2dtga = 0;
  int pw_gxw2dtgd = 0;
  int pw_gxw2dtg = 0;
  int wg_gxw2dtg = 0;
  float a_gx1dtg = 0;
  int ia_gx1dtg = 0;
  int pw_gx1dtga = 0;
  int pw_gx1dtgd = 0;
  int pw_gx1dtg = 0;
  int wg_gx1dtg = 0;
  float a_gy1rdtg = 0;
  float a_gy1rdtga = 0;
  float a_gy1rdtgb = 0;
  int ia_gy1rdtg = 0;
  int ia_gy1rdtgwa = 0;
  int ia_gy1rdtgwb = 0;
  int pw_gy1rdtga = 0;
  int pw_gy1rdtgd = 0;
  int pw_gy1rdtg = 0;
  int wg_gy1rdtg = 0;
  float a_gy1dtg = 0;
  float a_gy1dtga = 0;
  float a_gy1dtgb = 0;
  int ia_gy1dtg = 0;
  int ia_gy1dtgwa = 0;
  int ia_gy1dtgwb = 0;
  int pw_gy1dtga = 0;
  int pw_gy1dtgd = 0;
  int pw_gy1dtg = 0;
  int wg_gy1dtg = 0;
  float a_gzkdtg = 0;
  int ia_gzkdtg = 0;
  int pw_gzkdtga = 0;
  int pw_gzkdtgd = 0;
  int pw_gzkdtg = 0;
  int wg_gzkdtg = 0;
  float a_gxkdtg = 0;
  int ia_gxkdtg = 0;
  int pw_gxkdtga = 0;
  int pw_gxkdtgd = 0;
  int pw_gxkdtg = 0;
  int wg_gxkdtg = 0;
  float a_rf1cal = 0;
  int ia_rf1cal = 0;
  int pw_rf1cal = 0;
  int res_rf1cal = 0;
  int off_rf1cal = 0;
  int rfslot_rf1cal = 0;
  float gscale_rf1cal = 1.0;
  int n_rf1cal = 0;
  int wg_rf1cal = 0;
  float a_gzrf1cal = 0;
  int ia_gzrf1cal = 0;
  int pw_gzrf1cala = 0;
  int pw_gzrf1cald = 0;
  int pw_gzrf1cal = 0;
  int wg_gzrf1cal = 0;
  float a_gzcombcal = 0;
  float a_gzcombcala = 0;
  float a_gzcombcalb = 0;
  int ia_gzcombcal = 0;
  int ia_gzcombcalwa = 0;
  int ia_gzcombcalwb = 0;
  int pw_gzcombcala = 0;
  int pw_gzcombcald = 0;
  int pw_gzcombcalf = 0;
  int pw_gzcombcal = 0;
  int res_gzcombcal = 0;
  int per_gzcombcal = 0;
  int wg_gzcombcal = 0;
  float a_gzprcal = 0;
  float a_gzprcala = 0;
  float a_gzprcalb = 0;
  int ia_gzprcal = 0;
  int ia_gzprcalwa = 0;
  int ia_gzprcalwb = 0;
  int pw_gzprcala = 0;
  int pw_gzprcald = 0;
  int pw_gzprcalf = 0;
  int pw_gzprcal = 0;
  int res_gzprcal = 0;
  int per_gzprcal = 0;
  int wg_gzprcal = 0;
  float a_gxwcal = 0;
  int ia_gxwcal = 0;
  int pw_gxwcala = 0;
  int pw_gxwcald = 0;
  int pw_gxwcal = 0;
  int wg_gxwcal = 0;
  int filter_echo1cal = 0;
  float a_gx1cal = 0;
  float a_gx1cala = 0;
  float a_gx1calb = 0;
  int ia_gx1cal = 0;
  int ia_gx1calwa = 0;
  int ia_gx1calwb = 0;
  int pw_gx1cala = 0;
  int pw_gx1cald = 0;
  int pw_gx1calf = 0;
  int pw_gx1cal = 0;
  int res_gx1cal = 0;
  int per_gx1cal = 0;
  int wg_gx1cal = 0;
  float a_gy1cal = 0;
  float a_gy1cala = 0;
  float a_gy1calb = 0;
  int ia_gy1cal = 0;
  int ia_gy1calwa = 0;
  int ia_gy1calwb = 0;
  int pw_gy1cala = 0;
  int pw_gy1cald = 0;
  int pw_gy1calf = 0;
  int pw_gy1cal = 0;
  int res_gy1cal = 0;
  int per_gy1cal = 0;
  int wg_gy1cal = 0;
  float a_gy1rcal = 0;
  float a_gy1rcala = 0;
  float a_gy1rcalb = 0;
  int ia_gy1rcal = 0;
  int ia_gy1rcalwa = 0;
  int ia_gy1rcalwb = 0;
  int pw_gy1rcala = 0;
  int pw_gy1rcald = 0;
  int pw_gy1rcalf = 0;
  int pw_gy1rcal = 0;
  int res_gy1rcal = 0;
  int per_gy1rcal = 0;
  int wg_gy1rcal = 0;
  float a_rf1coil = 0;
  int ia_rf1coil = 0;
  int pw_rf1coil = 0;
  int res_rf1coil = 0;
  int off_rf1coil = 0;
  int rfslot_rf1coil = 0;
  float gscale_rf1coil = 1.0;
  int n_rf1coil = 0;
  int wg_rf1coil = 0;
  float a_gzrf1coil = 0;
  int ia_gzrf1coil = 0;
  int pw_gzrf1coila = 0;
  int pw_gzrf1coild = 0;
  int pw_gzrf1coil = 0;
  int wg_gzrf1coil = 0;
  float a_gzcombcoil = 0;
  float a_gzcombcoila = 0;
  float a_gzcombcoilb = 0;
  int ia_gzcombcoil = 0;
  int ia_gzcombcoilwa = 0;
  int ia_gzcombcoilwb = 0;
  int pw_gzcombcoila = 0;
  int pw_gzcombcoild = 0;
  int pw_gzcombcoilf = 0;
  int pw_gzcombcoil = 0;
  int res_gzcombcoil = 0;
  int per_gzcombcoil = 0;
  int wg_gzcombcoil = 0;
  float a_gzprcoil = 0;
  float a_gzprcoila = 0;
  float a_gzprcoilb = 0;
  int ia_gzprcoil = 0;
  int ia_gzprcoilwa = 0;
  int ia_gzprcoilwb = 0;
  int pw_gzprcoila = 0;
  int pw_gzprcoild = 0;
  int pw_gzprcoilf = 0;
  int pw_gzprcoil = 0;
  int res_gzprcoil = 0;
  int per_gzprcoil = 0;
  int wg_gzprcoil = 0;
  float a_gxwcoil = 0;
  int ia_gxwcoil = 0;
  int pw_gxwcoila = 0;
  int pw_gxwcoild = 0;
  int pw_gxwcoil = 0;
  int wg_gxwcoil = 0;
  int filter_echo1coil = 0;
  float a_gx1coil = 0;
  float a_gx1coila = 0;
  float a_gx1coilb = 0;
  int ia_gx1coil = 0;
  int ia_gx1coilwa = 0;
  int ia_gx1coilwb = 0;
  int pw_gx1coila = 0;
  int pw_gx1coild = 0;
  int pw_gx1coilf = 0;
  int pw_gx1coil = 0;
  int res_gx1coil = 0;
  int per_gx1coil = 0;
  int wg_gx1coil = 0;
  float a_gy1coil = 0;
  float a_gy1coila = 0;
  float a_gy1coilb = 0;
  int ia_gy1coil = 0;
  int ia_gy1coilwa = 0;
  int ia_gy1coilwb = 0;
  int pw_gy1coila = 0;
  int pw_gy1coild = 0;
  int pw_gy1coilf = 0;
  int pw_gy1coil = 0;
  int res_gy1coil = 0;
  int per_gy1coil = 0;
  int wg_gy1coil = 0;
  float a_gy1rcoil = 0;
  float a_gy1rcoila = 0;
  float a_gy1rcoilb = 0;
  int ia_gy1rcoil = 0;
  int ia_gy1rcoilwa = 0;
  int ia_gy1rcoilwb = 0;
  int pw_gy1rcoila = 0;
  int pw_gy1rcoild = 0;
  int pw_gy1rcoilf = 0;
  int pw_gy1rcoil = 0;
  int res_gy1rcoil = 0;
  int per_gy1rcoil = 0;
  int wg_gy1rcoil = 0;
long _lastcv = 0;
RSP_INFO rsp_info[(2048)] = { {0,0,0,0} };
long rsprot[2*(2048)][9]= {{0}};
long rsptrigger[2*(2048)]= {0};
long ipg_alloc_instr[9] = {
4096,
4096,
4096,
4096,
4096,
4096,
4096,
8192,
64};
RSP_INFO asrsp_info[3] = { {0,0,0,0} };
long sat_rot_matrices[14][9]= {{0}};
int sat_rot_ex_indices[7]= {0};
PHYS_GRAD phygrd = { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 };
LOG_GRAD loggrd = {0,0,0,0,0,0,{0,0,0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0 };
LOG_GRAD satloggrd = {0,0,0,0,0,0,{0,0,0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0 };
LOG_GRAD asloggrd = {0,0,0,0,0,0,{0,0,0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0 };
SCAN_INFO asscan_info[3] = { {0,0,0,0,0,0,0,0,0,{0},1} };
long PSrot[1][9]= {{0}};
long PSrot_mod[1][9]= {{0}};
PHASE_OFF phase_off[(2048)] = { {0,0} };
int yres_phase= {0};
int yoffs1= {0};
int off_rfcsz_base[(2048)]= {0};
SCAN_INFO scan_info_base[1] = { {0,0,0,0,0,0,0,0,0,{0},1} };
float xyz_base[(2048)][3]= {{0}};
long rsprot_base[2*(2048)][9]= {{0}};
int rtia_first_scan_flag = 1 ;
RSP_PSC_INFO rsp_psc_info[5] = { {0,0,0,{0},0,0,0} };
COIL_INFO coilInfo_tgt[10] = { { {0},0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 } };
COIL_INFO volRecCoilInfo_tgt[10] = { { {0},0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 } };
COIL_INFO fullRecCoilInfo_tgt[10] = { { {0},0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 } };
TX_COIL_INFO txCoilInfo_tgt[5] = { { 0,0,0,0,0,0,0,0,0,{0},0,0,{0},{0},{0},{0},0 } };
int cframpdir_tgt = 1;
int chksum_rampdir_tgt = 1447292810UL;
SeqCfgInfo seqcfginfo = {0,0,0,0,0,0,{0,0,0,0,0},{{0,0,0,0,0,0,{0,0,0,0}}},{{0,0,{0},0,{0}}},{{0,0,0,0,0,0,0,0}}};
char PSattribute_codeMeaning[80] = "";
int PSfreq_offset[20]= {0};
int cfl_tdaq= {0};
int cfh_tdaq= {0};
int rcvn_tdaq= {0};
long rsp_PSrot[5] [9]= {{0}};
long rsp_rcvnrot[1][9]= {{0}};
long rsrsprot[1][9] = {{0}};
long dtgrsprot[5][9] = {{0}};
long calrsprot[64 + 1][9] = {{0}};
long coilrsprot[64 + 1][9] = {{0}};
int min_ssp= {0};
RSP_INFO rsrsp_info[1] = { {0,0,0,0} };
RSP_INFO dtgrsp_info[5] = { {0,0,0,0} };
RSP_INFO calrsp_info[64] = { {0,0,0,0} };
RSP_INFO coilrsp_info[64] = { {0,0,0,0} };
ZY_INDEX cal_zyindex[64*64] = { {0,0,0} };
ZY_INDEX coil_zyindex[64*64] = { {0,0,0} };
PSC_INFO presscfh_info[5]={ {0,0,0,{0},0,0,0} };
LOG_GRAD cflloggrd = {0,0,0,0,0,0,{0,0,0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0 };
LOG_GRAD ps1loggrd = {0,0,0,0,0,0,{0,0,0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0 };
LOG_GRAD cfhloggrd = {0,0,0,0,0,0,{0,0,0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0 };
LOG_GRAD rcvnloggrd = {0,0,0,0,0,0,{0,0,0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0 };
LOG_GRAD rsloggrd = {0,0,0,0,0,0,{0,0,0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0 };
LOG_GRAD dtgloggrd = {0,0,0,0,0,0,{0,0,0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0 };
LOG_GRAD calloggrd = {0,0,0,0,0,0,{0,0,0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0 };
LOG_GRAD coilloggrd = {0,0,0,0,0,0,{0,0,0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0 };
LOG_GRAD maptgloggrd = {0,0,0,0,0,0,{0,0,0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0, 0, 0 };
PHYS_GRAD original_pgrd = { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 };
WF_PROCESSOR read_axis = TYPXGRAD;
WF_PROCESSOR killer_axis = TYPYGRAD;
WF_PROCESSOR tg_killer_axis = TYPYGRAD;
WF_PROCESSOR tg_read_axis = TYPXGRAD;
long savrot[2*(2048)][9]= {{0}};
RF_PULSE_INFO rfpulseInfo[(0 +24)]= {{0}};
int Gx[21000]= {0};
int Gy[21000]= {0};
long _lasttgtex = 0;
