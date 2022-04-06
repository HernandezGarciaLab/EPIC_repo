
/* Converters */
void
cv_cnv_endian_ptrdiff_t( ptrdiff_t *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *)_ecnv_target_ );
}

void
cv_cnv_endian_size_t( size_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_int( (unsigned int *)_ecnv_target_ );
}

void
cv_cnv_endian_wchar_t( wchar_t *_ecnv_target_ ) {
	cv_cnv_endian_long( (long *)_ecnv_target_ );
}

void
cv_cnv_endian_int8_t( int8_t *_ecnv_target_ ) {
	cv_cnv_endian_signed_char( (signed char *)_ecnv_target_ );
}

void
cv_cnv_endian_int16_t( int16_t *_ecnv_target_ ) {
	cv_cnv_endian_short( (short *)_ecnv_target_ );
}

void
cv_cnv_endian_int32_t( int32_t *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *)_ecnv_target_ );
}

void
cv_cnv_endian_int64_t( int64_t *_ecnv_target_ ) {
	cv_cnv_endian_long_long( (long long *)_ecnv_target_ );
}

void
cv_cnv_endian_uint8_t( uint8_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_char( (unsigned char *)_ecnv_target_ );
}

void
cv_cnv_endian_uint16_t( uint16_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_short( (unsigned short *)_ecnv_target_ );
}

void
cv_cnv_endian_uint32_t( uint32_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_int( (unsigned int *)_ecnv_target_ );
}

void
cv_cnv_endian_uint64_t( uint64_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long_long( (unsigned long long *)_ecnv_target_ );
}

void
cv_cnv_endian_int_least8_t( int_least8_t *_ecnv_target_ ) {
	cv_cnv_endian_signed_char( (signed char *)_ecnv_target_ );
}

void
cv_cnv_endian_int_least16_t( int_least16_t *_ecnv_target_ ) {
	cv_cnv_endian_short( (short *)_ecnv_target_ );
}

void
cv_cnv_endian_int_least32_t( int_least32_t *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *)_ecnv_target_ );
}

void
cv_cnv_endian_int_least64_t( int_least64_t *_ecnv_target_ ) {
	cv_cnv_endian_long_long( (long long *)_ecnv_target_ );
}

void
cv_cnv_endian_uint_least8_t( uint_least8_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_char( (unsigned char *)_ecnv_target_ );
}

void
cv_cnv_endian_uint_least16_t( uint_least16_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_short( (unsigned short *)_ecnv_target_ );
}

void
cv_cnv_endian_uint_least32_t( uint_least32_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_int( (unsigned int *)_ecnv_target_ );
}

void
cv_cnv_endian_uint_least64_t( uint_least64_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long_long( (unsigned long long *)_ecnv_target_ );
}

void
cv_cnv_endian_int_fast8_t( int_fast8_t *_ecnv_target_ ) {
	cv_cnv_endian_signed_char( (signed char *)_ecnv_target_ );
}

void
cv_cnv_endian_int_fast16_t( int_fast16_t *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *)_ecnv_target_ );
}

void
cv_cnv_endian_int_fast32_t( int_fast32_t *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *)_ecnv_target_ );
}

void
cv_cnv_endian_int_fast64_t( int_fast64_t *_ecnv_target_ ) {
	cv_cnv_endian_long_long( (long long *)_ecnv_target_ );
}

void
cv_cnv_endian_uint_fast8_t( uint_fast8_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_char( (unsigned char *)_ecnv_target_ );
}

void
cv_cnv_endian_uint_fast16_t( uint_fast16_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_int( (unsigned int *)_ecnv_target_ );
}

void
cv_cnv_endian_uint_fast32_t( uint_fast32_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_int( (unsigned int *)_ecnv_target_ );
}

void
cv_cnv_endian_uint_fast64_t( uint_fast64_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long_long( (unsigned long long *)_ecnv_target_ );
}

void
cv_cnv_endian_intptr_t( intptr_t *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *)_ecnv_target_ );
}

void
cv_cnv_endian_uintptr_t( uintptr_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_int( (unsigned int *)_ecnv_target_ );
}

void
cv_cnv_endian_intmax_t( intmax_t *_ecnv_target_ ) {
	cv_cnv_endian_long_long( (long long *)_ecnv_target_ );
}

void
cv_cnv_endian_uintmax_t( uintmax_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long_long( (unsigned long long *)_ecnv_target_ );
}

void
cv_cnv_endian_s8( s8 *_ecnv_target_ ) {
	cv_cnv_endian_char( (char *)_ecnv_target_ );
}

void
cv_cnv_endian_n8( n8 *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_char( (unsigned char *)_ecnv_target_ );
}

void
cv_cnv_endian_s16( s16 *_ecnv_target_ ) {
	cv_cnv_endian_int16_t( (int16_t *)_ecnv_target_ );
}

void
cv_cnv_endian_n16( n16 *_ecnv_target_ ) {
	cv_cnv_endian_uint16_t( (uint16_t *)_ecnv_target_ );
}

void
cv_cnv_endian_s32( s32 *_ecnv_target_ ) {
	cv_cnv_endian_long( (long *)_ecnv_target_ );
}

void
cv_cnv_endian_n32( n32 *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long( (unsigned long *)_ecnv_target_ );
}

void
cv_cnv_endian_s64( s64 *_ecnv_target_ ) {
	cv_cnv_endian_int64_t( (int64_t *)_ecnv_target_ );
}

void
cv_cnv_endian_n64( n64 *_ecnv_target_ ) {
	cv_cnv_endian_uint64_t( (uint64_t *)_ecnv_target_ );
}

void
cv_cnv_endian_f32( f32 *_ecnv_target_ ) {
	cv_cnv_endian_float( (float *)_ecnv_target_ );
}

void
cv_cnv_endian_f64( f64 *_ecnv_target_ ) {
	cv_cnv_endian_double( (double *)_ecnv_target_ );
}

void
cv_cnv_endian_struct_EXT_CERD_PARAMS( struct EXT_CERD_PARAMS *_ecnv_target_ )
{
	cv_cnv_endian_s32( &_ecnv_target_->alg );
	cv_cnv_endian_s32( &_ecnv_target_->demod );
}

void
cv_cnv_endian_PSD_FILTER_GEN( PSD_FILTER_GEN *_ecnv_target_ ) {
	cv_cnv_endian_f64( &_ecnv_target_->filfrq );
	cv_cnv_endian_struct_EXT_CERD_PARAMS( &_ecnv_target_->cerd );
	cv_cnv_endian_s32( &_ecnv_target_->taps );
	cv_cnv_endian_s32( &_ecnv_target_->outputs );
	cv_cnv_endian_s32( &_ecnv_target_->prefills );
	cv_cnv_endian_s32( &_ecnv_target_->filter_slot );
}

void
cv_cnv_endian_struct_CTMEntry( struct CTMEntry *_ecnv_target_ )
{
	cv_cnv_endian_n8( &_ecnv_target_->receiverID );
	cv_cnv_endian_n8( &_ecnv_target_->receiverChannel );
	cv_cnv_endian_n16( &_ecnv_target_->entryMask );
}

void
cv_cnv_endian_CTMEntryType( CTMEntryType *_ecnv_target_ ) {
	cv_cnv_endian_struct_CTMEntry( (struct CTMEntry *)_ecnv_target_ );
}

void
cv_cnv_endian_struct_QuadVolWeight( struct QuadVolWeight *_ecnv_target_ )
{
	cv_cnv_endian_n8( &_ecnv_target_->receiverID );
	cv_cnv_endian_n8( &_ecnv_target_->receiverChannel );
	{
		size_t _i0_0;
		for( _i0_0 = 0; _i0_0 < (2); ++_i0_0 ) {
			cv_cnv_endian_n8( &_ecnv_target_->pad[_i0_0] );
		}
	}
	cv_cnv_endian_f32( &_ecnv_target_->recWeight );
	cv_cnv_endian_f32( &_ecnv_target_->recPhaseDeg );
}

void
cv_cnv_endian_QuadVolWeightType( QuadVolWeightType *_ecnv_target_ ) {
	cv_cnv_endian_struct_QuadVolWeight( (struct QuadVolWeight *)_ecnv_target_ );
}

void
cv_cnv_endian_struct_CTTEntry( struct CTTEntry *_ecnv_target_ )
{
	{
		size_t _i1_0;
		for( _i1_0 = 0; _i1_0 < (128); ++_i1_0 ) {
			cv_cnv_endian_s8( &_ecnv_target_->logicalCoilName[_i1_0] );
		}
	}
	{
		size_t _i2_0;
		for( _i2_0 = 0; _i2_0 < (32); ++_i2_0 ) {
			cv_cnv_endian_s8( &_ecnv_target_->clinicalCoilName[_i2_0] );
		}
	}
	cv_cnv_endian_n32( &_ecnv_target_->configUID );
	cv_cnv_endian_n32( &_ecnv_target_->coilTypeMask );
	cv_cnv_endian_n32( &_ecnv_target_->isActiveScanConfig );
	{
		size_t _i3_0;
		for( _i3_0 = 0; _i3_0 < (256); ++_i3_0 ) {
			cv_cnv_endian_CTMEntryType( &_ecnv_target_->channelTranslationMap[_i3_0] );
		}
	}
	{
		size_t _i4_0;
		for( _i4_0 = 0; _i4_0 < (16); ++_i4_0 ) {
			cv_cnv_endian_QuadVolWeightType( &_ecnv_target_->quadVolReceiveWeights[_i4_0] );
		}
	}
	cv_cnv_endian_n32( &_ecnv_target_->numChannels );
}

void
cv_cnv_endian_ChannelTransTableEntryType( ChannelTransTableEntryType *_ecnv_target_ ) {
	cv_cnv_endian_struct_CTTEntry( (struct CTTEntry *)_ecnv_target_ );
}

void
cv_cnv_endian_CPRM_ENTRY_TYPE( CPRM_ENTRY_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_n32( &_ecnv_target_->receiverID );
	cv_cnv_endian_n32( &_ecnv_target_->connectorStartCh );
	cv_cnv_endian_n32( &_ecnv_target_->receiverStartCh );
	cv_cnv_endian_n32( &_ecnv_target_->numChannels );
}

void
cv_cnv_endian_CPRM_TYPE( CPRM_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_n32( &_ecnv_target_->numCprmEntries );
	cv_cnv_endian_n32( &_ecnv_target_->pad );
	{
		size_t _i5_0;
		for( _i5_0 = 0; _i5_0 < (2); ++_i5_0 ) {
			cv_cnv_endian_CPRM_ENTRY_TYPE( &_ecnv_target_->coilPortReceiverMap[_i5_0] );
		}
	}
}

void
cv_cnv_endian_COIL_PORTS_RX_MAPS_TYPE( COIL_PORTS_RX_MAPS_TYPE *_ecnv_target_ ) {
	{
		size_t _i6_0;
		for( _i6_0 = 0; _i6_0 < (NUM_COIL_CONNECTORS); ++_i6_0 ) {
			cv_cnv_endian_CPRM_TYPE( &_ecnv_target_->cprm[_i6_0] );
		}
	}
}

void
cv_cnv_endian_struct__INSTALL_COIL_INFO_( struct _INSTALL_COIL_INFO_ *_ecnv_target_ )
{
	{
		size_t _i7_0;
		for( _i7_0 = 0; _i7_0 < ((32 + 8)); ++_i7_0 ) {
			cv_cnv_endian_char( &_ecnv_target_->coilCode[_i7_0] );
		}
	}
	cv_cnv_endian_int( &_ecnv_target_->isInCoilDatabase );
}

void
cv_cnv_endian_INSTALL_COIL_INFO( INSTALL_COIL_INFO *_ecnv_target_ ) {
	cv_cnv_endian_struct__INSTALL_COIL_INFO_( (struct _INSTALL_COIL_INFO_ *)_ecnv_target_ );
}

void
cv_cnv_endian_struct__INSTALL_COIL_CONNECTOR_INFO_( struct _INSTALL_COIL_CONNECTOR_INFO_ *_ecnv_target_ )
{
	cv_cnv_endian_int( &_ecnv_target_->connector );
	cv_cnv_endian_int( &_ecnv_target_->needsInstall );
	{
		size_t _i8_0;
		for( _i8_0 = 0; _i8_0 < (4); ++_i8_0 ) {
			cv_cnv_endian_INSTALL_COIL_INFO( &_ecnv_target_->installCoilInfo[_i8_0] );
		}
	}
}

void
cv_cnv_endian_INSTALL_COIL_CONNECTOR_INFO( INSTALL_COIL_CONNECTOR_INFO *_ecnv_target_ ) {
	cv_cnv_endian_struct__INSTALL_COIL_CONNECTOR_INFO_( (struct _INSTALL_COIL_CONNECTOR_INFO_ *)_ecnv_target_ );
}

void
cv_cnv_endian_struct_coil_config_params( struct coil_config_params *_ecnv_target_ )
{
	{
		size_t _i9_0;
		for( _i9_0 = 0; _i9_0 < (16); ++_i9_0 ) {
			cv_cnv_endian_char( &_ecnv_target_->coilName[_i9_0] );
		}
	}
	{
		size_t _i10_0;
		for( _i10_0 = 0; _i10_0 < (24); ++_i10_0 ) {
			cv_cnv_endian_char( &_ecnv_target_->GEcoilName[_i10_0] );
		}
	}
	cv_cnv_endian_short( &_ecnv_target_->pureCorrection );
	cv_cnv_endian_int( &_ecnv_target_->maxNumOfReceivers );
	cv_cnv_endian_int( &_ecnv_target_->coilType );
	cv_cnv_endian_int( &_ecnv_target_->txCoilType );
	cv_cnv_endian_int( &_ecnv_target_->fastTGmode );
	cv_cnv_endian_int( &_ecnv_target_->fastTGstartTA );
	cv_cnv_endian_int( &_ecnv_target_->fastTGstartRG );
	cv_cnv_endian_int( &_ecnv_target_->nuclide );
	cv_cnv_endian_int( &_ecnv_target_->tRPAvolumeRecEnable );
	cv_cnv_endian_int( &_ecnv_target_->pureCompatible );
	cv_cnv_endian_int( &_ecnv_target_->aps1StartTA );
	cv_cnv_endian_int( &_ecnv_target_->cflStartTA );
	cv_cnv_endian_int( &_ecnv_target_->cfhSensitiveAnatomy );
	cv_cnv_endian_float( &_ecnv_target_->pureLambda );
	cv_cnv_endian_float( &_ecnv_target_->pureTuningFactorSurface );
	cv_cnv_endian_float( &_ecnv_target_->pureTuningFactorBody );
	cv_cnv_endian_float( &_ecnv_target_->cableLoss );
	cv_cnv_endian_float( &_ecnv_target_->coilLoss );
	cv_cnv_endian_float( &_ecnv_target_->reconScale );
	cv_cnv_endian_float( &_ecnv_target_->autoshimFOV );
	{
		size_t _i11_0, _i11_1;
		for( _i11_0 = 0; _i11_0 < (4); ++_i11_0 )
		for( _i11_1 = 0; _i11_1 < (256); ++_i11_1 ) {
			cv_cnv_endian_float( &_ecnv_target_->coilWeights[_i11_0][_i11_1] );
		}
	}
	{
		size_t _i12_0;
		for( _i12_0 = 0; _i12_0 < (4); ++_i12_0 ) {
			cv_cnv_endian_ChannelTransTableEntryType( &_ecnv_target_->cttEntry[_i12_0] );
		}
	}
}

void
cv_cnv_endian_COIL_CONFIG_PARAM_TYPE( COIL_CONFIG_PARAM_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_struct_coil_config_params( (struct coil_config_params *)_ecnv_target_ );
}

void
cv_cnv_endian_struct_application_config_param_type( struct application_config_param_type *_ecnv_target_ )
{
	cv_cnv_endian_int( &_ecnv_target_->aps1StartTA );
	cv_cnv_endian_int( &_ecnv_target_->cflStartTA );
	cv_cnv_endian_int( &_ecnv_target_->AScfPatLocChangeRL );
	cv_cnv_endian_int( &_ecnv_target_->AScfPatLocChangeAP );
	cv_cnv_endian_int( &_ecnv_target_->AScfPatLocChangeSI );
	cv_cnv_endian_int( &_ecnv_target_->TGpatLocChangeRL );
	cv_cnv_endian_int( &_ecnv_target_->TGpatLocChangeAP );
	cv_cnv_endian_int( &_ecnv_target_->TGpatLocChangeSI );
	cv_cnv_endian_int( &_ecnv_target_->autoshimFOV );
	cv_cnv_endian_int( &_ecnv_target_->fastTGstartTA );
	cv_cnv_endian_int( &_ecnv_target_->fastTGstartRG );
	cv_cnv_endian_int( &_ecnv_target_->fastTGmode );
	cv_cnv_endian_int( &_ecnv_target_->cfhSensitiveAnatomy );
	cv_cnv_endian_int( &_ecnv_target_->aps1Mod );
	cv_cnv_endian_int( &_ecnv_target_->aps1Plane );
	cv_cnv_endian_int( &_ecnv_target_->pureCompatible );
	cv_cnv_endian_int( &_ecnv_target_->maxFOV );
	cv_cnv_endian_int( &_ecnv_target_->assetThresh );
	cv_cnv_endian_int( &_ecnv_target_->scic_a_used );
	cv_cnv_endian_int( &_ecnv_target_->scic_s_used );
	cv_cnv_endian_int( &_ecnv_target_->scic_c_used );
	cv_cnv_endian_float( &_ecnv_target_->aps1ModFOV );
	cv_cnv_endian_float( &_ecnv_target_->aps1ModPStloc );
	cv_cnv_endian_float( &_ecnv_target_->aps1ModPSrloc );
	cv_cnv_endian_float( &_ecnv_target_->opthickPSMod );
	cv_cnv_endian_float( &_ecnv_target_->pureScale );
	cv_cnv_endian_float( &_ecnv_target_->pureCorrectionThreshold );
	cv_cnv_endian_float( &_ecnv_target_->pureLambda );
	cv_cnv_endian_float( &_ecnv_target_->pureTuningFactorSurface );
	cv_cnv_endian_float( &_ecnv_target_->pureTuningFactorBody );
	{
		size_t _i13_0;
		for( _i13_0 = 0; _i13_0 < (7); ++_i13_0 ) {
			cv_cnv_endian_float( &_ecnv_target_->scic_a[_i13_0] );
		}
	}
	{
		size_t _i14_0;
		for( _i14_0 = 0; _i14_0 < (7); ++_i14_0 ) {
			cv_cnv_endian_float( &_ecnv_target_->scic_s[_i14_0] );
		}
	}
	{
		size_t _i15_0;
		for( _i15_0 = 0; _i15_0 < (7); ++_i15_0 ) {
			cv_cnv_endian_float( &_ecnv_target_->scic_c[_i15_0] );
		}
	}
	cv_cnv_endian_int( &_ecnv_target_->assetSupported );
	{
		size_t _i16_0;
		for( _i16_0 = 0; _i16_0 < (3); ++_i16_0 ) {
			cv_cnv_endian_float( &_ecnv_target_->assetValues[_i16_0] );
		}
	}
	cv_cnv_endian_int( &_ecnv_target_->arcSupported );
	{
		size_t _i17_0;
		for( _i17_0 = 0; _i17_0 < (3); ++_i17_0 ) {
			cv_cnv_endian_float( &_ecnv_target_->arcValues[_i17_0] );
		}
	}
	cv_cnv_endian_int( &_ecnv_target_->sagCalEnabled );
	cv_cnv_endian_int( &_ecnv_target_->scenicEnabled );
	cv_cnv_endian_float( &_ecnv_target_->slice_down_sample_rate );
	cv_cnv_endian_float( &_ecnv_target_->inplane_down_sample_rate );
	cv_cnv_endian_int( &_ecnv_target_->num_levels_max );
	cv_cnv_endian_int( &_ecnv_target_->num_iterations_max );
	cv_cnv_endian_float( &_ecnv_target_->convergence_threshold );
	cv_cnv_endian_int( &_ecnv_target_->gain_clamp_mode );
	cv_cnv_endian_float( &_ecnv_target_->gain_clamp_value );
}

void
cv_cnv_endian_APPLICATION_CONFIG_PARAM_TYPE( APPLICATION_CONFIG_PARAM_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_struct_application_config_param_type( (struct application_config_param_type *)_ecnv_target_ );
}

void
cv_cnv_endian_struct_application_config_hdr( struct application_config_hdr *_ecnv_target_ )
{
	cv_cnv_endian_int( &_ecnv_target_->error );
	{
		size_t _i18_0;
		for( _i18_0 = 0; _i18_0 < (32); ++_i18_0 ) {
			cv_cnv_endian_char( &_ecnv_target_->clinicalName[_i18_0] );
		}
	}
	cv_cnv_endian_APPLICATION_CONFIG_PARAM_TYPE( &_ecnv_target_->appConfig );
}

void
cv_cnv_endian_APPLICATION_CONFIG_HDR( APPLICATION_CONFIG_HDR *_ecnv_target_ ) {
	cv_cnv_endian_struct_application_config_hdr( (struct application_config_hdr *)_ecnv_target_ );
}

void
cv_cnv_endian_COIL_INFO( COIL_INFO *_ecnv_target_ ) {
	{
		size_t _i19_0;
		for( _i19_0 = 0; _i19_0 < (32); ++_i19_0 ) {
			cv_cnv_endian_s8( &_ecnv_target_->coilName[_i19_0] );
		}
	}
	cv_cnv_endian_s32( &_ecnv_target_->txIndexPri );
	cv_cnv_endian_s32( &_ecnv_target_->txIndexSec );
	cv_cnv_endian_n32( &_ecnv_target_->rxCoilType );
	cv_cnv_endian_n32( &_ecnv_target_->hubIndex );
	cv_cnv_endian_n32( &_ecnv_target_->rxNucleus );
	cv_cnv_endian_n32( &_ecnv_target_->aps1Mod );
	cv_cnv_endian_n32( &_ecnv_target_->aps1ModPlane );
	cv_cnv_endian_n32( &_ecnv_target_->coilSepDir );
	cv_cnv_endian_s32( &_ecnv_target_->assetCalThreshold );
	cv_cnv_endian_f32( &_ecnv_target_->aps1ModFov );
	cv_cnv_endian_f32( &_ecnv_target_->aps1ModSlThick );
	cv_cnv_endian_f32( &_ecnv_target_->aps1ModPsTloc );
	cv_cnv_endian_f32( &_ecnv_target_->aps1ModPsRloc );
	cv_cnv_endian_f32( &_ecnv_target_->autoshimFov );
	cv_cnv_endian_f32( &_ecnv_target_->assetCalMaxFov );
	cv_cnv_endian_f32( &_ecnv_target_->maxB1Rms );
	cv_cnv_endian_n32( &_ecnv_target_->pureCompatible );
	cv_cnv_endian_f32( &_ecnv_target_->pureLambda );
	cv_cnv_endian_f32( &_ecnv_target_->pureTuningFactorSurface );
	cv_cnv_endian_f32( &_ecnv_target_->pureTuningFactorBody );
	cv_cnv_endian_n32( &_ecnv_target_->numChannels );
	cv_cnv_endian_f32( &_ecnv_target_->switchingSpeed );
}

void
cv_cnv_endian_TX_COIL_INFO( TX_COIL_INFO *_ecnv_target_ ) {
	cv_cnv_endian_s32( &_ecnv_target_->coilAtten );
	cv_cnv_endian_n32( &_ecnv_target_->txCoilType );
	cv_cnv_endian_n32( &_ecnv_target_->txPosition );
	cv_cnv_endian_n32( &_ecnv_target_->txNucleus );
	cv_cnv_endian_n32( &_ecnv_target_->txAmp );
	cv_cnv_endian_f32( &_ecnv_target_->maxB1Peak );
	cv_cnv_endian_f32( &_ecnv_target_->maxB1Squared );
	cv_cnv_endian_f32( &_ecnv_target_->cableLoss );
	cv_cnv_endian_f32( &_ecnv_target_->coilLoss );
	{
		size_t _i20_0;
		for( _i20_0 = 0; _i20_0 < (10); ++_i20_0 ) {
			cv_cnv_endian_f32( &_ecnv_target_->reflCoeffSquared[_i20_0] );
		}
	}
	cv_cnv_endian_f32( &_ecnv_target_->reflCoeffMassOffset );
	cv_cnv_endian_f32( &_ecnv_target_->reflCoeffCurveType );
	{
		size_t _i21_0;
		for( _i21_0 = 0; _i21_0 < (8); ++_i21_0 ) {
			cv_cnv_endian_f32( &_ecnv_target_->exposedMass[_i21_0] );
		}
	}
	{
		size_t _i22_0;
		for( _i22_0 = 0; _i22_0 < (8); ++_i22_0 ) {
			cv_cnv_endian_f32( &_ecnv_target_->lowSarExposedMass[_i22_0] );
		}
	}
	{
		size_t _i23_0;
		for( _i23_0 = 0; _i23_0 < (12); ++_i23_0 ) {
			cv_cnv_endian_f32( &_ecnv_target_->jstd[_i23_0] );
		}
	}
	{
		size_t _i24_0;
		for( _i24_0 = 0; _i24_0 < (12); ++_i24_0 ) {
			cv_cnv_endian_f32( &_ecnv_target_->meanJstd[_i24_0] );
		}
	}
	cv_cnv_endian_f32( &_ecnv_target_->separationStdev );
}

void
cv_cnv_endian_struct__psd_coil_info_( struct _psd_coil_info_ *_ecnv_target_ )
{
	{
		size_t _i25_0;
		for( _i25_0 = 0; _i25_0 < (10); ++_i25_0 ) {
			cv_cnv_endian_COIL_INFO( &_ecnv_target_->imgRcvCoilInfo[_i25_0] );
		}
	}
	{
		size_t _i26_0;
		for( _i26_0 = 0; _i26_0 < (10); ++_i26_0 ) {
			cv_cnv_endian_COIL_INFO( &_ecnv_target_->volRcvCoilInfo[_i26_0] );
		}
	}
	{
		size_t _i27_0;
		for( _i27_0 = 0; _i27_0 < (10); ++_i27_0 ) {
			cv_cnv_endian_COIL_INFO( &_ecnv_target_->fullRcvCoilInfo[_i27_0] );
		}
	}
	{
		size_t _i28_0;
		for( _i28_0 = 0; _i28_0 < (5); ++_i28_0 ) {
			cv_cnv_endian_TX_COIL_INFO( &_ecnv_target_->txCoilInfo[_i28_0] );
		}
	}
	cv_cnv_endian_int( &_ecnv_target_->numCoils );
}

void
cv_cnv_endian_PSD_COIL_INFO( PSD_COIL_INFO *_ecnv_target_ ) {
	cv_cnv_endian_struct__psd_coil_info_( (struct _psd_coil_info_ *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_CoolingCabinetTypeValue( enum CoolingCabinetTypeValue *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_enum_CoolingFlowModeValue( enum CoolingFlowModeValue *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_power_monitor_table_t( power_monitor_table_t *_ecnv_target_ ) {
	cv_cnv_endian_s16( &_ecnv_target_->pmPredictSAR );
	cv_cnv_endian_s16( &_ecnv_target_->pmContinuousUpdate );
}

void
cv_cnv_endian_entry_point_table_t( entry_point_table_t *_ecnv_target_ ) {
	{
		size_t _i29_0;
		for( _i29_0 = 0; _i29_0 < (16); ++_i29_0 ) {
			cv_cnv_endian_char( &_ecnv_target_->epname[_i29_0] );
		}
	}
	cv_cnv_endian_n32( &_ecnv_target_->epamph );
	cv_cnv_endian_n32( &_ecnv_target_->epampb );
	cv_cnv_endian_n32( &_ecnv_target_->epamps );
	cv_cnv_endian_n32( &_ecnv_target_->epampc );
	cv_cnv_endian_n32( &_ecnv_target_->epwidthh );
	cv_cnv_endian_n32( &_ecnv_target_->epwidthb );
	cv_cnv_endian_n32( &_ecnv_target_->epwidths );
	cv_cnv_endian_n32( &_ecnv_target_->epwidthc );
	cv_cnv_endian_n32( &_ecnv_target_->epdcycleh );
	cv_cnv_endian_n32( &_ecnv_target_->epdcycleb );
	cv_cnv_endian_n32( &_ecnv_target_->epdcycles );
	cv_cnv_endian_n32( &_ecnv_target_->epdcyclec );
	cv_cnv_endian_n8( &_ecnv_target_->epsmode );
	cv_cnv_endian_n8( &_ecnv_target_->epfilter );
	cv_cnv_endian_n8( &_ecnv_target_->eprcvrband );
	cv_cnv_endian_n8( &_ecnv_target_->eprcvrinput );
	cv_cnv_endian_n8( &_ecnv_target_->eprcvrbias );
	cv_cnv_endian_n8( &_ecnv_target_->eptrdriver );
	cv_cnv_endian_n8( &_ecnv_target_->epfastrec );
	cv_cnv_endian_s16( &_ecnv_target_->epxmtadd );
	cv_cnv_endian_s16( &_ecnv_target_->epprexres );
	cv_cnv_endian_s16( &_ecnv_target_->epshldctrl );
	cv_cnv_endian_s16( &_ecnv_target_->epgradcoil );
	cv_cnv_endian_n32( &_ecnv_target_->eppkpower );
	cv_cnv_endian_n32( &_ecnv_target_->epseqtime );
	cv_cnv_endian_s16( &_ecnv_target_->epstartrec );
	cv_cnv_endian_s16( &_ecnv_target_->ependrec );
	cv_cnv_endian_power_monitor_table_t( &_ecnv_target_->eppmtable );
	cv_cnv_endian_n8( &_ecnv_target_->epGeneralBankIndex );
	cv_cnv_endian_n8( &_ecnv_target_->epGeneralBankIndex2 );
	cv_cnv_endian_n8( &_ecnv_target_->epR1BankIndex );
	cv_cnv_endian_n8( &_ecnv_target_->epNbTransmitSelect );
	cv_cnv_endian_n8( &_ecnv_target_->epBbTransmitSelect );
	cv_cnv_endian_n32( &_ecnv_target_->epMnsConverterSelect );
	cv_cnv_endian_n32( &_ecnv_target_->epRxCoilType );
	cv_cnv_endian_f32( &_ecnv_target_->epxgd_cableirmsmax );
	cv_cnv_endian_f32( &_ecnv_target_->epcoilAC_powersum );
	cv_cnv_endian_n8( &_ecnv_target_->enableReceiveFreqBands );
	cv_cnv_endian_s32( &_ecnv_target_->offsetReceiveFreqLower );
	cv_cnv_endian_s32( &_ecnv_target_->offsetReceiveFreqHigher );
	cv_cnv_endian_n32( &_ecnv_target_->ecgCableAllowed );
}

void
cv_cnv_endian_ENTRY_POINT_TABLE( ENTRY_POINT_TABLE *_ecnv_target_ ) {
	cv_cnv_endian_entry_point_table_t( (entry_point_table_t *)_ecnv_target_ );
}

void
cv_cnv_endian_ENTRY_PNT_TABLE( ENTRY_PNT_TABLE *_ecnv_target_ ) {
	cv_cnv_endian_entry_point_table_t( (entry_point_table_t *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_ANATOMY_ATTRIBUTE( enum ANATOMY_ATTRIBUTE *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_ANATOMY_ATTRIBUTE_E( ANATOMY_ATTRIBUTE_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_ANATOMY_ATTRIBUTE( (enum ANATOMY_ATTRIBUTE *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_ANATOMY_ATTRIBUTE_CATEGORY( enum ANATOMY_ATTRIBUTE_CATEGORY *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_ANATOMY_ATTRIBUTE_CATEGORY_E( ANATOMY_ATTRIBUTE_CATEGORY_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_ANATOMY_ATTRIBUTE_CATEGORY( (enum ANATOMY_ATTRIBUTE_CATEGORY *)_ecnv_target_ );
}

void
cv_cnv_endian_SCAN_INFO( SCAN_INFO *_ecnv_target_ ) {
	cv_cnv_endian_float( &_ecnv_target_->oprloc );
	cv_cnv_endian_float( &_ecnv_target_->opphasoff );
	cv_cnv_endian_float( &_ecnv_target_->optloc );
	cv_cnv_endian_float( &_ecnv_target_->oprloc_shift );
	cv_cnv_endian_float( &_ecnv_target_->opphasoff_shift );
	cv_cnv_endian_float( &_ecnv_target_->optloc_shift );
	cv_cnv_endian_float( &_ecnv_target_->opfov_freq_scale );
	cv_cnv_endian_float( &_ecnv_target_->opfov_phase_scale );
	cv_cnv_endian_float( &_ecnv_target_->opslthick_scale );
	{
		size_t _i30_0;
		for( _i30_0 = 0; _i30_0 < (9); ++_i30_0 ) {
			cv_cnv_endian_float( &_ecnv_target_->oprot[_i30_0] );
		}
	}
	cv_cnv_endian_int( &_ecnv_target_->opslplane );
}

void
cv_cnv_endian_PSC_INFO( PSC_INFO *_ecnv_target_ ) {
	cv_cnv_endian_float( &_ecnv_target_->oppsctloc );
	cv_cnv_endian_float( &_ecnv_target_->oppscrloc );
	cv_cnv_endian_float( &_ecnv_target_->oppscphasoff );
	{
		size_t _i31_0;
		for( _i31_0 = 0; _i31_0 < (9); ++_i31_0 ) {
			cv_cnv_endian_float( &_ecnv_target_->oppscrot[_i31_0] );
		}
	}
	cv_cnv_endian_int( &_ecnv_target_->oppsclenx );
	cv_cnv_endian_int( &_ecnv_target_->oppscleny );
	cv_cnv_endian_int( &_ecnv_target_->oppsclenz );
}

void
cv_cnv_endian_GIR_INFO( GIR_INFO *_ecnv_target_ ) {
	cv_cnv_endian_float( &_ecnv_target_->opgirthick );
	cv_cnv_endian_float( &_ecnv_target_->opgirtloc );
	{
		size_t _i32_0;
		for( _i32_0 = 0; _i32_0 < (9); ++_i32_0 ) {
			cv_cnv_endian_float( &_ecnv_target_->opgirrot[_i32_0] );
		}
	}
}

void
cv_cnv_endian_DATA_ACQ_ORDER( DATA_ACQ_ORDER *_ecnv_target_ ) {
	cv_cnv_endian_short( &_ecnv_target_->slloc );
	cv_cnv_endian_short( &_ecnv_target_->slpass );
	cv_cnv_endian_short( &_ecnv_target_->sltime );
}

void
cv_cnv_endian_RSP_INFO( RSP_INFO *_ecnv_target_ ) {
	cv_cnv_endian_float( &_ecnv_target_->rsptloc );
	cv_cnv_endian_float( &_ecnv_target_->rsprloc );
	cv_cnv_endian_float( &_ecnv_target_->rspphasoff );
	cv_cnv_endian_int( &_ecnv_target_->slloc );
}

void
cv_cnv_endian_PHASE_OFF( PHASE_OFF *_ecnv_target_ ) {
	cv_cnv_endian_int( &_ecnv_target_->ysign );
	cv_cnv_endian_int( &_ecnv_target_->yoffs );
}

void
cv_cnv_endian_RSP_PSC_INFO( RSP_PSC_INFO *_ecnv_target_ ) {
	cv_cnv_endian_float( &_ecnv_target_->rsppsctloc );
	cv_cnv_endian_float( &_ecnv_target_->rsppscrloc );
	cv_cnv_endian_float( &_ecnv_target_->rsppscphasoff );
	{
		size_t _i33_0;
		for( _i33_0 = 0; _i33_0 < (10); ++_i33_0 ) {
			cv_cnv_endian_long( &_ecnv_target_->rsppscrot[_i33_0] );
		}
	}
	cv_cnv_endian_int( &_ecnv_target_->rsppsclenx );
	cv_cnv_endian_int( &_ecnv_target_->rsppscleny );
	cv_cnv_endian_int( &_ecnv_target_->rsppsclenz );
}

void
cv_cnv_endian_WF_PROCESSOR( WF_PROCESSOR *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *) _ecnv_target_ );
}

void
cv_cnv_endian_WF_HARDWARE_TYPE( WF_HARDWARE_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *) _ecnv_target_ );
}

void
cv_cnv_endian_HW_DIRECTION( HW_DIRECTION *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *) _ecnv_target_ );
}

void
cv_cnv_endian_SSP_S_ATTRIB( SSP_S_ATTRIB *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *) _ecnv_target_ );
}

void
cv_cnv_endian_PSD_EXIT_ARG( PSD_EXIT_ARG *_ecnv_target_ ) {
	cv_cnv_endian_s32( &_ecnv_target_->abcode );
	{
		size_t _i34_0;
		for( _i34_0 = 0; _i34_0 < (256); ++_i34_0 ) {
			cv_cnv_endian_char( &_ecnv_target_->text_string[_i34_0] );
		}
	}
	{
		size_t _i35_0;
		for( _i35_0 = 0; _i35_0 < (16); ++_i35_0 ) {
			cv_cnv_endian_char( &_ecnv_target_->text_arg[_i35_0] );
		}
	}
	{
		size_t _i36_0;
		for( _i36_0 = 0; _i36_0 < (4); ++_i36_0 ) {
			cv_cnv_endian_unsigned_long( &_ecnv_target_->longarg[_i36_0] );
		}
	}
}

void
cv_cnv_endian_enum_RECEIVER_SPEEDS( enum RECEIVER_SPEEDS *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_RECEIVER_SPEED_E( RECEIVER_SPEED_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_RECEIVER_SPEEDS( (enum RECEIVER_SPEEDS *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_GRADIENT_COILS( enum GRADIENT_COILS *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_GRADIENT_COIL_E( GRADIENT_COIL_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_GRADIENT_COILS( (enum GRADIENT_COILS *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_BODY_COIL_TYPES( enum BODY_COIL_TYPES *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_BODY_COIL_TYPE_E( BODY_COIL_TYPE_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_BODY_COIL_TYPES( (enum BODY_COIL_TYPES *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_PSD_BOARD_TYPE( enum PSD_BOARD_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_PSD_BOARD_TYPE_E( PSD_BOARD_TYPE_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_PSD_BOARD_TYPE( (enum PSD_BOARD_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_SSC_TYPE( enum SSC_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_SSC_TYPE_E( SSC_TYPE_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_SSC_TYPE( (enum SSC_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_GRADIENT_COIL_METHOD( enum GRADIENT_COIL_METHOD *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_GRADIENT_COIL_METHOD_E( GRADIENT_COIL_METHOD_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_GRADIENT_COIL_METHOD( (enum GRADIENT_COIL_METHOD *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_POWER_IN_HEAT_CALC( enum POWER_IN_HEAT_CALC *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_POWER_IN_HEAT_CALC_E( POWER_IN_HEAT_CALC_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_POWER_IN_HEAT_CALC( (enum POWER_IN_HEAT_CALC *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_GRADIENT_PULSE_TYPE( enum GRADIENT_PULSE_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_GRADIENT_PULSE_TYPE_E( GRADIENT_PULSE_TYPE_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_GRADIENT_PULSE_TYPE( (enum GRADIENT_PULSE_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_GRAD_PULSE( GRAD_PULSE *_ecnv_target_ ) {
	cv_cnv_endian_int( &_ecnv_target_->ptype );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->attack );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->decay );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->pw );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->amps );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->amp );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->ampd );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->ampe );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->gradfile );
	cv_cnv_endian_int( &_ecnv_target_->num );
	cv_cnv_endian_float( &_ecnv_target_->scale );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->time );
	cv_cnv_endian_int( &_ecnv_target_->tdelta );
	cv_cnv_endian_float( &_ecnv_target_->powscale );
	cv_cnv_endian_float( &_ecnv_target_->power );
	cv_cnv_endian_float( &_ecnv_target_->powpos );
	cv_cnv_endian_float( &_ecnv_target_->powneg );
	cv_cnv_endian_float( &_ecnv_target_->powabs );
	cv_cnv_endian_float( &_ecnv_target_->amptran );
	cv_cnv_endian_int( &_ecnv_target_->pwm );
	cv_cnv_endian_int( &_ecnv_target_->bridge );
	cv_cnv_endian_float( &_ecnv_target_->intabspwmcurr );
}

void
cv_cnv_endian_RF_PULSE( RF_PULSE *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long( &_ecnv_target_->pw );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->amp );
	cv_cnv_endian_float( &_ecnv_target_->abswidth );
	cv_cnv_endian_float( &_ecnv_target_->effwidth );
	cv_cnv_endian_float( &_ecnv_target_->area );
	cv_cnv_endian_float( &_ecnv_target_->dtycyc );
	cv_cnv_endian_float( &_ecnv_target_->maxpw );
	cv_cnv_endian_float( &_ecnv_target_->num );
	cv_cnv_endian_float( &_ecnv_target_->max_b1 );
	cv_cnv_endian_float( &_ecnv_target_->max_int_b1_sq );
	cv_cnv_endian_float( &_ecnv_target_->max_rms_b1 );
	cv_cnv_endian_float( &_ecnv_target_->nom_fa );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->act_fa );
	cv_cnv_endian_float( &_ecnv_target_->nom_pw );
	cv_cnv_endian_float( &_ecnv_target_->nom_bw );
	cv_cnv_endian_unsigned_int( &_ecnv_target_->activity );
	cv_cnv_endian_unsigned_char( &_ecnv_target_->reference );
	cv_cnv_endian_int( &_ecnv_target_->isodelay );
	cv_cnv_endian_float( &_ecnv_target_->scale );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->res );
	cv_cnv_endian_int( &_ecnv_target_->extgradfile );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->exciter );
	cv_cnv_endian_int( &_ecnv_target_->apply_as_hadamard_factor );
}

void
cv_cnv_endian_RF_PULSE_INFO( RF_PULSE_INFO *_ecnv_target_ ) {
	cv_cnv_endian_int( &_ecnv_target_->change );
	cv_cnv_endian_int( &_ecnv_target_->newres );
}

void
cv_cnv_endian_regulatory_control_mode_e( regulatory_control_mode_e *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *) _ecnv_target_ );
}

void
cv_cnv_endian_enum_epic_slice_order_type_e( enum epic_slice_order_type_e *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_epic_slice_order_type( epic_slice_order_type *_ecnv_target_ ) {
	cv_cnv_endian_enum_epic_slice_order_type_e( (enum epic_slice_order_type_e *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_exciter_type( enum exciter_type *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_exciterSelection( exciterSelection *_ecnv_target_ ) {
	cv_cnv_endian_enum_exciter_type( (enum exciter_type *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_receiver_type( enum receiver_type *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_receiverSelection( receiverSelection *_ecnv_target_ ) {
	cv_cnv_endian_enum_receiver_type( (enum receiver_type *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_oscillator_source( enum oscillator_source *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_demodSelection( demodSelection *_ecnv_target_ ) {
	cv_cnv_endian_enum_oscillator_source( (enum oscillator_source *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_nav_type( enum nav_type *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_navSelection( navSelection *_ecnv_target_ ) {
	cv_cnv_endian_enum_nav_type( (enum nav_type *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_VALUE_SYSTEM_TYPE( enum VALUE_SYSTEM_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_VALUE_SYSTEM_TYPE_E( VALUE_SYSTEM_TYPE_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_VALUE_SYSTEM_TYPE( (enum VALUE_SYSTEM_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_PSD_PATIENT_ENTRY( enum PSD_PATIENT_ENTRY *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_PSD_PATIENT_ENTRY_E( PSD_PATIENT_ENTRY_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_PSD_PATIENT_ENTRY( (enum PSD_PATIENT_ENTRY *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_CAL_MODE( enum CAL_MODE *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_CAL_MODE_E( CAL_MODE_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_CAL_MODE( (enum CAL_MODE *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_RG_CAL_MODE( enum RG_CAL_MODE *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_RG_CAL_MODE_E( RG_CAL_MODE_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_RG_CAL_MODE( (enum RG_CAL_MODE *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_ADD_SCAN_TYPE( enum ADD_SCAN_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_ADD_SCAN_TYPE_E( ADD_SCAN_TYPE_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_ADD_SCAN_TYPE( (enum ADD_SCAN_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_PSD_SLTHICK_LABEL( enum PSD_SLTHICK_LABEL *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_PSD_SLTHICK_LABEL_E( PSD_SLTHICK_LABEL_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_PSD_SLTHICK_LABEL( (enum PSD_SLTHICK_LABEL *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_PSD_NAV_TYPE( enum PSD_NAV_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_PSD_NAV_TYPE_E( PSD_NAV_TYPE_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_PSD_NAV_TYPE( (enum PSD_NAV_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_PSD_FLIP_ANGLE_MODE_LABEL( enum PSD_FLIP_ANGLE_MODE_LABEL *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_PSD_FLIP_ANGLE_LABEL_E( PSD_FLIP_ANGLE_LABEL_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_PSD_FLIP_ANGLE_MODE_LABEL( (enum PSD_FLIP_ANGLE_MODE_LABEL *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_PSD_AUTO_TR_MODE_LABEL( enum PSD_AUTO_TR_MODE_LABEL *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_PSD_AUTO_TR_MODE_LABEL_E( PSD_AUTO_TR_MODE_LABEL_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_PSD_AUTO_TR_MODE_LABEL( (enum PSD_AUTO_TR_MODE_LABEL *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_CARDIAC_GATE_TYPE( enum CARDIAC_GATE_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_CARDIAC_GATE_TYPE_E( CARDIAC_GATE_TYPE_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_CARDIAC_GATE_TYPE( (enum CARDIAC_GATE_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_DL_RECON_MODE( enum DL_RECON_MODE *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_DL_RECON_MODE_E( DL_RECON_MODE_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_DL_RECON_MODE( (enum DL_RECON_MODE *)_ecnv_target_ );
}

void
cv_cnv_endian_CHAR( CHAR *_ecnv_target_ ) {
	cv_cnv_endian_char( (char *)_ecnv_target_ );
}

void
cv_cnv_endian_SHORT( SHORT *_ecnv_target_ ) {
	cv_cnv_endian_s16( (s16 *)_ecnv_target_ );
}

void
cv_cnv_endian_INT( INT *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *)_ecnv_target_ );
}

void
cv_cnv_endian_LONG( LONG *_ecnv_target_ ) {
	cv_cnv_endian_INT( (INT *)_ecnv_target_ );
}

void
cv_cnv_endian_FLOAT( FLOAT *_ecnv_target_ ) {
	cv_cnv_endian_f32( (f32 *)_ecnv_target_ );
}

void
cv_cnv_endian_DOUBLE( DOUBLE *_ecnv_target_ ) {
	cv_cnv_endian_f64( (f64 *)_ecnv_target_ );
}

void
cv_cnv_endian_UCHAR( UCHAR *_ecnv_target_ ) {
	cv_cnv_endian_n8( (n8 *)_ecnv_target_ );
}

void
cv_cnv_endian_USHORT( USHORT *_ecnv_target_ ) {
	cv_cnv_endian_n16( (n16 *)_ecnv_target_ );
}

void
cv_cnv_endian_UINT( UINT *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_int( (unsigned int *)_ecnv_target_ );
}

void
cv_cnv_endian_ULONG( ULONG *_ecnv_target_ ) {
	cv_cnv_endian_UINT( (UINT *)_ecnv_target_ );
}

void
cv_cnv_endian_STATUS( STATUS *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *)_ecnv_target_ );
}

void
cv_cnv_endian_ADDRESS( ADDRESS *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long( (unsigned long *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_e_axis( enum e_axis *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_t_axis( t_axis *_ecnv_target_ ) {
	cv_cnv_endian_enum_e_axis( (enum e_axis *)_ecnv_target_ );
}

void
cv_cnv_endian___u_char( __u_char *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_char( (unsigned char *)_ecnv_target_ );
}

void
cv_cnv_endian___u_short( __u_short *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_short( (unsigned short *)_ecnv_target_ );
}

void
cv_cnv_endian___u_int( __u_int *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_int( (unsigned int *)_ecnv_target_ );
}

void
cv_cnv_endian___u_long( __u_long *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long( (unsigned long *)_ecnv_target_ );
}

void
cv_cnv_endian___int8_t( __int8_t *_ecnv_target_ ) {
	cv_cnv_endian_signed_char( (signed char *)_ecnv_target_ );
}

void
cv_cnv_endian___uint8_t( __uint8_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_char( (unsigned char *)_ecnv_target_ );
}

void
cv_cnv_endian___int16_t( __int16_t *_ecnv_target_ ) {
	cv_cnv_endian_signed_short( (signed short *)_ecnv_target_ );
}

void
cv_cnv_endian___uint16_t( __uint16_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_short( (unsigned short *)_ecnv_target_ );
}

void
cv_cnv_endian___int32_t( __int32_t *_ecnv_target_ ) {
	cv_cnv_endian_signed_int( (signed int *)_ecnv_target_ );
}

void
cv_cnv_endian___uint32_t( __uint32_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_int( (unsigned int *)_ecnv_target_ );
}

void
cv_cnv_endian___int64_t( __int64_t *_ecnv_target_ ) {
	cv_cnv_endian_signed_long_long( (signed long long *)_ecnv_target_ );
}

void
cv_cnv_endian___uint64_t( __uint64_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long_long( (unsigned long long *)_ecnv_target_ );
}

void
cv_cnv_endian___quad_t( __quad_t *_ecnv_target_ ) {
	cv_cnv_endian_long_long( (long long *)_ecnv_target_ );
}

void
cv_cnv_endian___u_quad_t( __u_quad_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long_long( (unsigned long long *)_ecnv_target_ );
}

void
cv_cnv_endian___dev_t( __dev_t *_ecnv_target_ ) {
	cv_cnv_endian___u_quad_t( (__u_quad_t *)_ecnv_target_ );
}

void
cv_cnv_endian___uid_t( __uid_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_int( (unsigned int *)_ecnv_target_ );
}

void
cv_cnv_endian___gid_t( __gid_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_int( (unsigned int *)_ecnv_target_ );
}

void
cv_cnv_endian___ino_t( __ino_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long( (unsigned long *)_ecnv_target_ );
}

void
cv_cnv_endian___ino64_t( __ino64_t *_ecnv_target_ ) {
	cv_cnv_endian___u_quad_t( (__u_quad_t *)_ecnv_target_ );
}

void
cv_cnv_endian___mode_t( __mode_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_int( (unsigned int *)_ecnv_target_ );
}

void
cv_cnv_endian___nlink_t( __nlink_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_int( (unsigned int *)_ecnv_target_ );
}

void
cv_cnv_endian___off_t( __off_t *_ecnv_target_ ) {
	cv_cnv_endian_long( (long *)_ecnv_target_ );
}

void
cv_cnv_endian___off64_t( __off64_t *_ecnv_target_ ) {
	cv_cnv_endian___quad_t( (__quad_t *)_ecnv_target_ );
}

void
cv_cnv_endian___pid_t( __pid_t *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *)_ecnv_target_ );
}

void
cv_cnv_endian___fsid_t( __fsid_t *_ecnv_target_ ) {
	{
		size_t _i37_0;
		for( _i37_0 = 0; _i37_0 < (2); ++_i37_0 ) {
			cv_cnv_endian_int( &_ecnv_target_->__val[_i37_0] );
		}
	}
}

void
cv_cnv_endian___clock_t( __clock_t *_ecnv_target_ ) {
	cv_cnv_endian_long( (long *)_ecnv_target_ );
}

void
cv_cnv_endian___rlim_t( __rlim_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long( (unsigned long *)_ecnv_target_ );
}

void
cv_cnv_endian___rlim64_t( __rlim64_t *_ecnv_target_ ) {
	cv_cnv_endian___u_quad_t( (__u_quad_t *)_ecnv_target_ );
}

void
cv_cnv_endian___id_t( __id_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_int( (unsigned int *)_ecnv_target_ );
}

void
cv_cnv_endian___time_t( __time_t *_ecnv_target_ ) {
	cv_cnv_endian_long( (long *)_ecnv_target_ );
}

void
cv_cnv_endian___useconds_t( __useconds_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_int( (unsigned int *)_ecnv_target_ );
}

void
cv_cnv_endian___suseconds_t( __suseconds_t *_ecnv_target_ ) {
	cv_cnv_endian_long( (long *)_ecnv_target_ );
}

void
cv_cnv_endian___daddr_t( __daddr_t *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *)_ecnv_target_ );
}

void
cv_cnv_endian___key_t( __key_t *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *)_ecnv_target_ );
}

void
cv_cnv_endian___clockid_t( __clockid_t *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *)_ecnv_target_ );
}

void
cv_cnv_endian___timer_t( __timer_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long( (unsigned long *)_ecnv_target_ );
}

void
cv_cnv_endian___blksize_t( __blksize_t *_ecnv_target_ ) {
	cv_cnv_endian_long( (long *)_ecnv_target_ );
}

void
cv_cnv_endian___blkcnt_t( __blkcnt_t *_ecnv_target_ ) {
	cv_cnv_endian_long( (long *)_ecnv_target_ );
}

void
cv_cnv_endian___blkcnt64_t( __blkcnt64_t *_ecnv_target_ ) {
	cv_cnv_endian___quad_t( (__quad_t *)_ecnv_target_ );
}

void
cv_cnv_endian___fsblkcnt_t( __fsblkcnt_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long( (unsigned long *)_ecnv_target_ );
}

void
cv_cnv_endian___fsblkcnt64_t( __fsblkcnt64_t *_ecnv_target_ ) {
	cv_cnv_endian___u_quad_t( (__u_quad_t *)_ecnv_target_ );
}

void
cv_cnv_endian___fsfilcnt_t( __fsfilcnt_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long( (unsigned long *)_ecnv_target_ );
}

void
cv_cnv_endian___fsfilcnt64_t( __fsfilcnt64_t *_ecnv_target_ ) {
	cv_cnv_endian___u_quad_t( (__u_quad_t *)_ecnv_target_ );
}

void
cv_cnv_endian___fsword_t( __fsword_t *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *)_ecnv_target_ );
}

void
cv_cnv_endian___ssize_t( __ssize_t *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *)_ecnv_target_ );
}

void
cv_cnv_endian___syscall_slong_t( __syscall_slong_t *_ecnv_target_ ) {
	cv_cnv_endian_long( (long *)_ecnv_target_ );
}

void
cv_cnv_endian___syscall_ulong_t( __syscall_ulong_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long( (unsigned long *)_ecnv_target_ );
}

void
cv_cnv_endian___loff_t( __loff_t *_ecnv_target_ ) {
	cv_cnv_endian___off64_t( (__off64_t *)_ecnv_target_ );
}

void
cv_cnv_endian___qaddr_t( __qaddr_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long( (unsigned long *)_ecnv_target_ );
}

void
cv_cnv_endian___caddr_t( __caddr_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long( (unsigned long *)_ecnv_target_ );
}

void
cv_cnv_endian___intptr_t( __intptr_t *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *)_ecnv_target_ );
}

void
cv_cnv_endian___socklen_t( __socklen_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_int( (unsigned int *)_ecnv_target_ );
}

void
cv_cnv_endian_FILE( FILE *_ecnv_target_ ) {
	cv_cnv_endian_struct__IO_FILE( (struct _IO_FILE *)_ecnv_target_ );
}

void
cv_cnv_endian___FILE( __FILE *_ecnv_target_ ) {
	cv_cnv_endian_struct__IO_FILE( (struct _IO_FILE *)_ecnv_target_ );
}

void
cv_cnv_endian___mbstate_t( __mbstate_t *_ecnv_target_ ) {
	cv_cnv_endian_int( &_ecnv_target_->__count );
	}

void
cv_cnv_endian__G_fpos_t( _G_fpos_t *_ecnv_target_ ) {
	cv_cnv_endian___off_t( &_ecnv_target_->__pos );
	cv_cnv_endian___mbstate_t( &_ecnv_target_->__state );
}

void
cv_cnv_endian__G_fpos64_t( _G_fpos64_t *_ecnv_target_ ) {
	cv_cnv_endian___off64_t( &_ecnv_target_->__pos );
	cv_cnv_endian___mbstate_t( &_ecnv_target_->__state );
}

void
cv_cnv_endian___gnuc_va_list( __gnuc_va_list *_ecnv_target_ ) {
	cv_cnv_endian___builtin_va_list( (__builtin_va_list *)_ecnv_target_ );
}

void
cv_cnv_endian__IO_lock_t( _IO_lock_t *_ecnv_target_ ) {
	cv_cnv_endian_void( (void *)_ecnv_target_ );
}

void
cv_cnv_endian_struct__IO_marker( struct _IO_marker *_ecnv_target_ )
{
	cv_cnv_endian_unsigned_long( &_ecnv_target_->_next );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->_sbuf );
	cv_cnv_endian_int( &_ecnv_target_->_pos );
}

void
cv_cnv_endian_enum___codecvt_result( enum __codecvt_result *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_struct__IO_FILE( struct _IO_FILE *_ecnv_target_ )
{
	cv_cnv_endian_int( &_ecnv_target_->_flags );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->_IO_read_ptr );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->_IO_read_end );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->_IO_read_base );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->_IO_write_base );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->_IO_write_ptr );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->_IO_write_end );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->_IO_buf_base );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->_IO_buf_end );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->_IO_save_base );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->_IO_backup_base );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->_IO_save_end );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->_markers );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->_chain );
	cv_cnv_endian_int( &_ecnv_target_->_fileno );
	cv_cnv_endian_int( &_ecnv_target_->_flags2 );
	cv_cnv_endian___off_t( &_ecnv_target_->_old_offset );
	cv_cnv_endian_unsigned_short( &_ecnv_target_->_cur_column );
	cv_cnv_endian_signed_char( &_ecnv_target_->_vtable_offset );
	{
		size_t _i38_0;
		for( _i38_0 = 0; _i38_0 < (1); ++_i38_0 ) {
			cv_cnv_endian_char( &_ecnv_target_->_shortbuf[_i38_0] );
		}
	}
	cv_cnv_endian_unsigned_long( &_ecnv_target_->_lock );
	cv_cnv_endian___off64_t( &_ecnv_target_->_offset );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->__pad1 );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->__pad2 );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->__pad3 );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->__pad4 );
	cv_cnv_endian_size_t( &_ecnv_target_->__pad5 );
	cv_cnv_endian_int( &_ecnv_target_->_mode );
	{
		size_t _i39_0;
		for( _i39_0 = 0; _i39_0 < (15 * sizeof (int) - 4 * sizeof (void *) - sizeof (size_t)); ++_i39_0 ) {
			cv_cnv_endian_char( &_ecnv_target_->_unused2[_i39_0] );
		}
	}
}

void
cv_cnv_endian__IO_FILE( _IO_FILE *_ecnv_target_ ) {
	cv_cnv_endian_struct__IO_FILE( (struct _IO_FILE *)_ecnv_target_ );
}

void
cv_cnv_endian_va_list( va_list *_ecnv_target_ ) {
	cv_cnv_endian___gnuc_va_list( (__gnuc_va_list *)_ecnv_target_ );
}

void
cv_cnv_endian_off_t( off_t *_ecnv_target_ ) {
	cv_cnv_endian___off_t( (__off_t *)_ecnv_target_ );
}

void
cv_cnv_endian_ssize_t( ssize_t *_ecnv_target_ ) {
	cv_cnv_endian___ssize_t( (__ssize_t *)_ecnv_target_ );
}

void
cv_cnv_endian_fpos_t( fpos_t *_ecnv_target_ ) {
	cv_cnv_endian__G_fpos_t( (_G_fpos_t *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_e_fopen_mode( enum e_fopen_mode *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_t_fopen_mode( t_fopen_mode *_ecnv_target_ ) {
	cv_cnv_endian_enum_e_fopen_mode( (enum e_fopen_mode *)_ecnv_target_ );
}

void
cv_cnv_endian_datavalue( datavalue *_ecnv_target_ ) {
	cv_cnv_endian_float( (float *)_ecnv_target_ );
}

void
cv_cnv_endian_SeqCfgSysCfgInfo( SeqCfgSysCfgInfo *_ecnv_target_ ) {
	cv_cnv_endian_n32( &_ecnv_target_->sscType );
	cv_cnv_endian_n32( &_ecnv_target_->ptxCapable );
	cv_cnv_endian_n32( &_ecnv_target_->fieldStrength );
	cv_cnv_endian_n32( &_ecnv_target_->rfAmpType );
	cv_cnv_endian_n32( &_ecnv_target_->receiverType );
}

void
cv_cnv_endian_SeqCfgSeqInfo( SeqCfgSeqInfo *_ecnv_target_ ) {
	cv_cnv_endian_s32( &_ecnv_target_->seqId );
	cv_cnv_endian_n32( &_ecnv_target_->seqType );
	cv_cnv_endian_s32( &_ecnv_target_->duplicateSeqId );
	cv_cnv_endian_s32( &_ecnv_target_->sspSeqId );
	cv_cnv_endian_s32( &_ecnv_target_->rfGroupId );
	cv_cnv_endian_s32( &_ecnv_target_->rfGroupTxChannel );
	cv_cnv_endian_n32( &_ecnv_target_->coreId );
	cv_cnv_endian_s32( &_ecnv_target_->coreRfChannel );
}

void
cv_cnv_endian_SeqCfgCoreInfo( SeqCfgCoreInfo *_ecnv_target_ ) {
	cv_cnv_endian_s32( &_ecnv_target_->coreId );
	cv_cnv_endian_n32( &_ecnv_target_->coreType );
	{
		size_t _i40_0;
		for( _i40_0 = 0; _i40_0 < (SEQ_CFG_MAX_RF_GROUPS); ++_i40_0 ) {
			cv_cnv_endian_s32( &_ecnv_target_->requiredPhysicalTxId[_i40_0] );
		}
	}
	cv_cnv_endian_n32( &_ecnv_target_->numSeqs );
	{
		size_t _i41_0;
		for( _i41_0 = 0; _i41_0 < (SEQ_CFG_MAX_CORE_SEQS); ++_i41_0 ) {
			cv_cnv_endian_n32( &_ecnv_target_->seqs[_i41_0] );
		}
	}
}

void
cv_cnv_endian_SeqCfgRfTxInfo( SeqCfgRfTxInfo *_ecnv_target_ ) {
	cv_cnv_endian_n32( &_ecnv_target_->txAmp );
	cv_cnv_endian_n32( &_ecnv_target_->txCoilType );
	cv_cnv_endian_n32( &_ecnv_target_->txNucleus );
	cv_cnv_endian_n32( &_ecnv_target_->txChannels );
}

void
cv_cnv_endian_SeqCfgRfGroupInfo( SeqCfgRfGroupInfo *_ecnv_target_ ) {
	cv_cnv_endian_n32( &_ecnv_target_->rfGroupId );
	cv_cnv_endian_n32( &_ecnv_target_->numAppTxChannels );
	cv_cnv_endian_n32( &_ecnv_target_->txSeqTypes );
	cv_cnv_endian_n32( &_ecnv_target_->rxFlag );
	cv_cnv_endian_n32( &_ecnv_target_->rxSeqTypes );
	cv_cnv_endian_n32( &_ecnv_target_->mode );
	cv_cnv_endian_SeqCfgRfTxInfo( &_ecnv_target_->txInfo );
}

void
cv_cnv_endian_SeqCfgInfo( SeqCfgInfo *_ecnv_target_ ) {
	cv_cnv_endian_s32( &_ecnv_target_->valid );
	cv_cnv_endian_n32( &_ecnv_target_->debugOptions );
	cv_cnv_endian_n32( &_ecnv_target_->numRfGroups );
	cv_cnv_endian_n32( &_ecnv_target_->numCores );
	cv_cnv_endian_n32( &_ecnv_target_->numAppSeqs );
	cv_cnv_endian_n32( &_ecnv_target_->numSeqs );
	cv_cnv_endian_SeqCfgSysCfgInfo( &_ecnv_target_->sysCfg );
	{
		size_t _i42_0;
		for( _i42_0 = 0; _i42_0 < (SEQ_CFG_MAX_RF_GROUPS); ++_i42_0 ) {
			cv_cnv_endian_SeqCfgRfGroupInfo( &_ecnv_target_->rfGroups[_i42_0] );
		}
	}
	{
		size_t _i43_0;
		for( _i43_0 = 0; _i43_0 < (SEQ_CFG_MAX_CORES); ++_i43_0 ) {
			cv_cnv_endian_SeqCfgCoreInfo( &_ecnv_target_->cores[_i43_0] );
		}
	}
	{
		size_t _i44_0;
		for( _i44_0 = 0; _i44_0 < (SEQ_CFG_MAX_SEQ_IDS); ++_i44_0 ) {
			cv_cnv_endian_SeqCfgSeqInfo( &_ecnv_target_->seqs[_i44_0] );
		}
	}
}

void
cv_cnv_endian_struct_SeqType( struct SeqType *_ecnv_target_ )
{
	cv_cnv_endian_n32( &_ecnv_target_->seqID );
	cv_cnv_endian_n32( &_ecnv_target_->seqOpt );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->pName );
}

void
cv_cnv_endian_SeqType( SeqType *_ecnv_target_ ) {
	cv_cnv_endian_struct_SeqType( (struct SeqType *)_ecnv_target_ );
}

void
cv_cnv_endian_TYPDAB_PACKETS( TYPDAB_PACKETS *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *) _ecnv_target_ );
}

void
cv_cnv_endian_TYPACQ_PASS( TYPACQ_PASS *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *) _ecnv_target_ );
}

void
cv_cnv_endian_SeqData( SeqData *_ecnv_target_ ) {
	cv_cnv_endian_SeqType( (SeqType *)_ecnv_target_ );
}

void
cv_cnv_endian_WF_HW_WAVEFORM_PTR( WF_HW_WAVEFORM_PTR *_ecnv_target_ ) {
	cv_cnv_endian_long( (long *)_ecnv_target_ );
}

void
cv_cnv_endian_WF_HW_INSTR_PTR( WF_HW_INSTR_PTR *_ecnv_target_ ) {
	cv_cnv_endian_long( (long *)_ecnv_target_ );
}

void
cv_cnv_endian_WF_PULSE_FORWARD_ADDR( WF_PULSE_FORWARD_ADDR *_ecnv_target_ ) {
	cv_cnv_endian_ADDRESS( (ADDRESS *)_ecnv_target_ );
}

void
cv_cnv_endian_WF_INSTR_PTR( WF_INSTR_PTR *_ecnv_target_ ) {
	cv_cnv_endian_ADDRESS( (ADDRESS *)_ecnv_target_ );
}

void
cv_cnv_endian_struct_INST_NODE( struct INST_NODE *_ecnv_target_ )
{
	cv_cnv_endian_unsigned_long( &_ecnv_target_->next );
	cv_cnv_endian_WF_HW_INSTR_PTR( &_ecnv_target_->wf_instr_ptr );
	cv_cnv_endian_long( &_ecnv_target_->amplitude );
	cv_cnv_endian_long( &_ecnv_target_->period );
	cv_cnv_endian_long( &_ecnv_target_->start );
	cv_cnv_endian_long( &_ecnv_target_->end );
	cv_cnv_endian_long( &_ecnv_target_->entry_group );
	cv_cnv_endian_WF_PULSE_FORWARD_ADDR( &_ecnv_target_->pulse_hdr );
	{
		size_t _i45_0;
		for( _i45_0 = 0; _i45_0 < (SEQ_CFG_MAX_CORES); ++_i45_0 ) {
			cv_cnv_endian_WF_HW_INSTR_PTR( &_ecnv_target_->wf_instr_ptr_secssp[_i45_0] );
		}
	}
	cv_cnv_endian_int( &_ecnv_target_->num_iters );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->ampl_iters );
}

void
cv_cnv_endian_WF_INSTR_HDR( WF_INSTR_HDR *_ecnv_target_ ) {
	cv_cnv_endian_struct_INST_NODE( (struct INST_NODE *)_ecnv_target_ );
}

void
cv_cnv_endian_CONST_EXT( CONST_EXT *_ecnv_target_ ) {
	cv_cnv_endian_short( &_ecnv_target_->amplitude );
}

void
cv_cnv_endian_HADAMARD_EXT( HADAMARD_EXT *_ecnv_target_ ) {
	cv_cnv_endian_short( &_ecnv_target_->amplitude );
	cv_cnv_endian_float( &_ecnv_target_->separation );
	cv_cnv_endian_float( &_ecnv_target_->nsinc_cycles );
	cv_cnv_endian_float( &_ecnv_target_->alpha );
}

void
cv_cnv_endian_RAMP_EXT( RAMP_EXT *_ecnv_target_ ) {
	cv_cnv_endian_short( &_ecnv_target_->start_amplitude );
	cv_cnv_endian_short( &_ecnv_target_->end_amplitude );
}

void
cv_cnv_endian_SINC_EXT( SINC_EXT *_ecnv_target_ ) {
	cv_cnv_endian_short( &_ecnv_target_->amplitude );
	cv_cnv_endian_float( &_ecnv_target_->nsinc_cycles );
	cv_cnv_endian_float( &_ecnv_target_->alpha );
}

void
cv_cnv_endian_SINUSOID_EXT( SINUSOID_EXT *_ecnv_target_ ) {
	cv_cnv_endian_short( &_ecnv_target_->amplitude );
	cv_cnv_endian_float( &_ecnv_target_->start_phase );
	cv_cnv_endian_float( &_ecnv_target_->phase_length );
	cv_cnv_endian_short( &_ecnv_target_->offset );
}

void
cv_cnv_endian_WF_PULSE_EXT( WF_PULSE_EXT *_ecnv_target_ ) {
}

void
cv_cnv_endian_WF_PULSE_TYPES( WF_PULSE_TYPES *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *) _ecnv_target_ );
}

void
cv_cnv_endian_WF_PGMTAG( WF_PGMTAG *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *) _ecnv_target_ );
}

void
cv_cnv_endian_WF_PGMREUSE( WF_PGMREUSE *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *) _ecnv_target_ );
}

void
cv_cnv_endian_WF_PURPOSE( WF_PURPOSE *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *) _ecnv_target_ );
}

void
cv_cnv_endian_struct_PULSE( struct PULSE *_ecnv_target_ )
{
	cv_cnv_endian_unsigned_long( &_ecnv_target_->pulsename );
	cv_cnv_endian_long( &_ecnv_target_->ninsts );
	cv_cnv_endian_WF_HW_WAVEFORM_PTR( &_ecnv_target_->wave_addr );
	cv_cnv_endian_int( &_ecnv_target_->board_type );
	cv_cnv_endian_WF_PGMREUSE( &_ecnv_target_->reusep );
	cv_cnv_endian_WF_PGMTAG( &_ecnv_target_->tag );
	cv_cnv_endian_long( &_ecnv_target_->addtag );
	cv_cnv_endian_int( &_ecnv_target_->id );
	cv_cnv_endian_long( &_ecnv_target_->ctrlfield );
	cv_cnv_endian_WF_PURPOSE( &_ecnv_target_->purpose );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->inst_hdr_tail );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->inst_hdr_head );
	cv_cnv_endian_WF_PROCESSOR( &_ecnv_target_->wavegen_type );
	cv_cnv_endian_WF_PULSE_TYPES( &_ecnv_target_->type );
	cv_cnv_endian_short( &_ecnv_target_->resolution );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->assoc_pulse );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->ext );
	cv_cnv_endian_int( &_ecnv_target_->rfgroup );
	cv_cnv_endian_int( &_ecnv_target_->ptx_flag );
	cv_cnv_endian_int( &_ecnv_target_->seq_id );
	cv_cnv_endian_int( &_ecnv_target_->rx_flag );
	{
		size_t _i46_0;
		for( _i46_0 = 0; _i46_0 < (SEQ_CFG_MAX_CORES); ++_i46_0 ) {
			cv_cnv_endian_WF_HW_WAVEFORM_PTR( &_ecnv_target_->wave_addr_secssp[_i46_0] );
		}
	}
}

void
cv_cnv_endian_WF_PULSE( WF_PULSE *_ecnv_target_ ) {
	cv_cnv_endian_struct_PULSE( (struct PULSE *)_ecnv_target_ );
}

void
cv_cnv_endian_WF_PULSE_ADDR( WF_PULSE_ADDR *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long( (unsigned long *)_ecnv_target_ );
}

void
cv_cnv_endian_struct_INST_QUEUE_NODE( struct INST_QUEUE_NODE *_ecnv_target_ )
{
	cv_cnv_endian_unsigned_long( &_ecnv_target_->instr );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->next );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->new_queue );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->last_queue );
}

void
cv_cnv_endian_WF_INSTR_QUEUE( WF_INSTR_QUEUE *_ecnv_target_ ) {
	cv_cnv_endian_struct_INST_QUEUE_NODE( (struct INST_QUEUE_NODE *)_ecnv_target_ );
}

void
cv_cnv_endian_SEQUENCE_ENTRIES( SEQUENCE_ENTRIES *_ecnv_target_ ) {
	{
		size_t _i47_0;
		for( _i47_0 = 0; _i47_0 < (SEQ_CFG_MAX_SEQ_IDS); ++_i47_0 ) {
			cv_cnv_endian_s32( (s32 *)&((*_ecnv_target_)[_i47_0]) );
		}
	}
}

void
cv_cnv_endian_struct_ENTRY_PT_NODE( struct ENTRY_PT_NODE *_ecnv_target_ )
{
	cv_cnv_endian_WF_PULSE_ADDR( &_ecnv_target_->ssp_pulse );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->entry_addresses );
	cv_cnv_endian_long( &_ecnv_target_->time );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->next );
}

void
cv_cnv_endian_SEQUENCE_LIST( SEQUENCE_LIST *_ecnv_target_ ) {
	cv_cnv_endian_struct_ENTRY_PT_NODE( (struct ENTRY_PT_NODE *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_rbw_update_type( enum rbw_update_type *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_RBW_UPDATE_TYPE( RBW_UPDATE_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_enum_rbw_update_type( (enum rbw_update_type *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_filter_block_type( enum filter_block_type *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_FILTER_BLOCK_TYPE( FILTER_BLOCK_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_enum_filter_block_type( (enum filter_block_type *)_ecnv_target_ );
}

void
cv_cnv_endian_FILTER_INFO( FILTER_INFO *_ecnv_target_ ) {
	cv_cnv_endian_float( &_ecnv_target_->decimation );
	cv_cnv_endian_int( &_ecnv_target_->tdaq );
	cv_cnv_endian_float( &_ecnv_target_->bw );
	cv_cnv_endian_float( &_ecnv_target_->tsp );
	cv_cnv_endian_int( &_ecnv_target_->fslot );
	cv_cnv_endian_int( &_ecnv_target_->outputs );
	cv_cnv_endian_int( &_ecnv_target_->prefills );
	cv_cnv_endian_int( &_ecnv_target_->taps );
}

void
cv_cnv_endian_HOEC_CAL_INFO( HOEC_CAL_INFO *_ecnv_target_ ) {
	cv_cnv_endian_int( &_ecnv_target_->fit_order );
	cv_cnv_endian_int( &_ecnv_target_->total_bases_per_axis );
	{
		size_t _i48_0, _i48_1;
		for( _i48_0 = 0; _i48_0 < (3); ++_i48_0 )
		for( _i48_1 = 0; _i48_1 < (56); ++_i48_1 ) {
			cv_cnv_endian_int( &_ecnv_target_->num_terms[_i48_0][_i48_1] );
		}
	}
	{
		size_t _i49_0, _i49_1, _i49_2;
		for( _i49_0 = 0; _i49_0 < (3); ++_i49_0 )
		for( _i49_1 = 0; _i49_1 < (56); ++_i49_1 )
		for( _i49_2 = 0; _i49_2 < (6); ++_i49_2 ) {
			cv_cnv_endian_float( &_ecnv_target_->alpha[_i49_0][_i49_1][_i49_2] );
		}
	}
	{
		size_t _i50_0, _i50_1, _i50_2;
		for( _i50_0 = 0; _i50_0 < (3); ++_i50_0 )
		for( _i50_1 = 0; _i50_1 < (56); ++_i50_1 )
		for( _i50_2 = 0; _i50_2 < (6); ++_i50_2 ) {
			cv_cnv_endian_float( &_ecnv_target_->tau[_i50_0][_i50_1][_i50_2] );
		}
	}
	{
		size_t _i51_0, _i51_1;
		for( _i51_0 = 0; _i51_0 < (3); ++_i51_0 )
		for( _i51_1 = 0; _i51_1 < (56); ++_i51_1 ) {
			cv_cnv_endian_int( &_ecnv_target_->termIndex2xyzOrderMapping[_i51_0][_i51_1] );
		}
	}
	{
		size_t _i52_0, _i52_1, _i52_2;
		for( _i52_0 = 0; _i52_0 < (6); ++_i52_0 )
		for( _i52_1 = 0; _i52_1 < (6); ++_i52_1 )
		for( _i52_2 = 0; _i52_2 < (6); ++_i52_2 ) {
			cv_cnv_endian_int( &_ecnv_target_->xyzOrder2termIndexMapping[_i52_0][_i52_1][_i52_2] );
		}
	}
}

void
cv_cnv_endian_RDB_HOEC_BASES_TYPE( RDB_HOEC_BASES_TYPE *_ecnv_target_ ) {
	{
		size_t _i53_0, _i53_1;
		for( _i53_0 = 0; _i53_0 < (56); ++_i53_0 )
		for( _i53_1 = 0; _i53_1 < (3); ++_i53_1 ) {
			cv_cnv_endian_float( &_ecnv_target_->hoec_coef[_i53_0][_i53_1] );
		}
	}
	{
		size_t _i54_0;
		for( _i54_0 = 0; _i54_0 < (56); ++_i54_0 ) {
			cv_cnv_endian_int( &_ecnv_target_->hoec_xorder[_i54_0] );
		}
	}
	{
		size_t _i55_0;
		for( _i55_0 = 0; _i55_0 < (56); ++_i55_0 ) {
			cv_cnv_endian_int( &_ecnv_target_->hoec_yorder[_i55_0] );
		}
	}
	{
		size_t _i56_0;
		for( _i56_0 = 0; _i56_0 < (56); ++_i56_0 ) {
			cv_cnv_endian_int( &_ecnv_target_->hoec_zorder[_i56_0] );
		}
	}
}

void
cv_cnv_endian_PHYS_GRAD( PHYS_GRAD *_ecnv_target_ ) {
	cv_cnv_endian_int( &_ecnv_target_->xfull );
	cv_cnv_endian_int( &_ecnv_target_->yfull );
	cv_cnv_endian_int( &_ecnv_target_->zfull );
	cv_cnv_endian_float( &_ecnv_target_->xfs );
	cv_cnv_endian_float( &_ecnv_target_->yfs );
	cv_cnv_endian_float( &_ecnv_target_->zfs );
	cv_cnv_endian_int( &_ecnv_target_->xrt );
	cv_cnv_endian_int( &_ecnv_target_->yrt );
	cv_cnv_endian_int( &_ecnv_target_->zrt );
	cv_cnv_endian_int( &_ecnv_target_->xft );
	cv_cnv_endian_int( &_ecnv_target_->yft );
	cv_cnv_endian_int( &_ecnv_target_->zft );
	cv_cnv_endian_float( &_ecnv_target_->xcc );
	cv_cnv_endian_float( &_ecnv_target_->ycc );
	cv_cnv_endian_float( &_ecnv_target_->zcc );
	cv_cnv_endian_float( &_ecnv_target_->xbeta );
	cv_cnv_endian_float( &_ecnv_target_->ybeta );
	cv_cnv_endian_float( &_ecnv_target_->zbeta );
	cv_cnv_endian_float( &_ecnv_target_->xirms );
	cv_cnv_endian_float( &_ecnv_target_->yirms );
	cv_cnv_endian_float( &_ecnv_target_->zirms );
	cv_cnv_endian_float( &_ecnv_target_->xipeak );
	cv_cnv_endian_float( &_ecnv_target_->yipeak );
	cv_cnv_endian_float( &_ecnv_target_->zipeak );
	cv_cnv_endian_float( &_ecnv_target_->xamptran );
	cv_cnv_endian_float( &_ecnv_target_->yamptran );
	cv_cnv_endian_float( &_ecnv_target_->zamptran );
	cv_cnv_endian_float( &_ecnv_target_->xiavrgabs );
	cv_cnv_endian_float( &_ecnv_target_->yiavrgabs );
	cv_cnv_endian_float( &_ecnv_target_->ziavrgabs );
	cv_cnv_endian_float( &_ecnv_target_->xirmspos );
	cv_cnv_endian_float( &_ecnv_target_->yirmspos );
	cv_cnv_endian_float( &_ecnv_target_->zirmspos );
	cv_cnv_endian_float( &_ecnv_target_->xirmsneg );
	cv_cnv_endian_float( &_ecnv_target_->yirmsneg );
	cv_cnv_endian_float( &_ecnv_target_->zirmsneg );
	cv_cnv_endian_float( &_ecnv_target_->xpwmdc );
	cv_cnv_endian_float( &_ecnv_target_->ypwmdc );
	cv_cnv_endian_float( &_ecnv_target_->zpwmdc );
}

void
cv_cnv_endian_t_xact( t_xact *_ecnv_target_ ) {
	cv_cnv_endian_int( &_ecnv_target_->x );
	cv_cnv_endian_int( &_ecnv_target_->xy );
	cv_cnv_endian_int( &_ecnv_target_->xz );
	cv_cnv_endian_int( &_ecnv_target_->xyz );
}

void
cv_cnv_endian_t_yact( t_yact *_ecnv_target_ ) {
	cv_cnv_endian_int( &_ecnv_target_->y );
	cv_cnv_endian_int( &_ecnv_target_->xy );
	cv_cnv_endian_int( &_ecnv_target_->yz );
	cv_cnv_endian_int( &_ecnv_target_->xyz );
}

void
cv_cnv_endian_t_zact( t_zact *_ecnv_target_ ) {
	cv_cnv_endian_int( &_ecnv_target_->z );
	cv_cnv_endian_int( &_ecnv_target_->xz );
	cv_cnv_endian_int( &_ecnv_target_->yz );
	cv_cnv_endian_int( &_ecnv_target_->xyz );
}

void
cv_cnv_endian_ramp_t( ramp_t *_ecnv_target_ ) {
	cv_cnv_endian_int( &_ecnv_target_->xrt );
	cv_cnv_endian_int( &_ecnv_target_->yrt );
	cv_cnv_endian_int( &_ecnv_target_->zrt );
	cv_cnv_endian_int( &_ecnv_target_->xft );
	cv_cnv_endian_int( &_ecnv_target_->yft );
	cv_cnv_endian_int( &_ecnv_target_->zft );
}

void
cv_cnv_endian_LOG_GRAD( LOG_GRAD *_ecnv_target_ ) {
	cv_cnv_endian_int( &_ecnv_target_->xrt );
	cv_cnv_endian_int( &_ecnv_target_->yrt );
	cv_cnv_endian_int( &_ecnv_target_->zrt );
	cv_cnv_endian_int( &_ecnv_target_->xft );
	cv_cnv_endian_int( &_ecnv_target_->yft );
	cv_cnv_endian_int( &_ecnv_target_->zft );
	cv_cnv_endian_ramp_t( &_ecnv_target_->opt );
	cv_cnv_endian_t_xact( &_ecnv_target_->xrta );
	cv_cnv_endian_t_yact( &_ecnv_target_->yrta );
	cv_cnv_endian_t_zact( &_ecnv_target_->zrta );
	cv_cnv_endian_t_xact( &_ecnv_target_->xfta );
	cv_cnv_endian_t_yact( &_ecnv_target_->yfta );
	cv_cnv_endian_t_zact( &_ecnv_target_->zfta );
	cv_cnv_endian_float( &_ecnv_target_->xbeta );
	cv_cnv_endian_float( &_ecnv_target_->ybeta );
	cv_cnv_endian_float( &_ecnv_target_->zbeta );
	cv_cnv_endian_float( &_ecnv_target_->tx_xyz );
	cv_cnv_endian_float( &_ecnv_target_->ty_xyz );
	cv_cnv_endian_float( &_ecnv_target_->tz_xyz );
	cv_cnv_endian_float( &_ecnv_target_->tx_xy );
	cv_cnv_endian_float( &_ecnv_target_->tx_xz );
	cv_cnv_endian_float( &_ecnv_target_->ty_xy );
	cv_cnv_endian_float( &_ecnv_target_->ty_yz );
	cv_cnv_endian_float( &_ecnv_target_->tz_xz );
	cv_cnv_endian_float( &_ecnv_target_->tz_yz );
	cv_cnv_endian_float( &_ecnv_target_->tx );
	cv_cnv_endian_float( &_ecnv_target_->ty );
	cv_cnv_endian_float( &_ecnv_target_->tz );
	cv_cnv_endian_float( &_ecnv_target_->xfs );
	cv_cnv_endian_float( &_ecnv_target_->yfs );
	cv_cnv_endian_float( &_ecnv_target_->zfs );
	cv_cnv_endian_float( &_ecnv_target_->xirms );
	cv_cnv_endian_float( &_ecnv_target_->yirms );
	cv_cnv_endian_float( &_ecnv_target_->zirms );
	cv_cnv_endian_float( &_ecnv_target_->xipeak );
	cv_cnv_endian_float( &_ecnv_target_->yipeak );
	cv_cnv_endian_float( &_ecnv_target_->zipeak );
	cv_cnv_endian_float( &_ecnv_target_->xamptran );
	cv_cnv_endian_float( &_ecnv_target_->yamptran );
	cv_cnv_endian_float( &_ecnv_target_->zamptran );
	cv_cnv_endian_float( &_ecnv_target_->xiavrgabs );
	cv_cnv_endian_float( &_ecnv_target_->yiavrgabs );
	cv_cnv_endian_float( &_ecnv_target_->ziavrgabs );
	cv_cnv_endian_float( &_ecnv_target_->xirmspos );
	cv_cnv_endian_float( &_ecnv_target_->yirmspos );
	cv_cnv_endian_float( &_ecnv_target_->zirmspos );
	cv_cnv_endian_float( &_ecnv_target_->xirmsneg );
	cv_cnv_endian_float( &_ecnv_target_->yirmsneg );
	cv_cnv_endian_float( &_ecnv_target_->zirmsneg );
	cv_cnv_endian_float( &_ecnv_target_->xpwmdc );
	cv_cnv_endian_float( &_ecnv_target_->ypwmdc );
	cv_cnv_endian_float( &_ecnv_target_->zpwmdc );
	cv_cnv_endian_float( &_ecnv_target_->scale_1axis_risetime );
	cv_cnv_endian_float( &_ecnv_target_->scale_2axis_risetime );
	cv_cnv_endian_float( &_ecnv_target_->scale_3axis_risetime );
}

void
cv_cnv_endian_OPT_GRAD_INPUT( OPT_GRAD_INPUT *_ecnv_target_ ) {
	cv_cnv_endian_float( &_ecnv_target_->xfs );
	cv_cnv_endian_float( &_ecnv_target_->yfs );
	cv_cnv_endian_float( &_ecnv_target_->zfs );
	cv_cnv_endian_int( &_ecnv_target_->xrt );
	cv_cnv_endian_int( &_ecnv_target_->yrt );
	cv_cnv_endian_int( &_ecnv_target_->zrt );
	cv_cnv_endian_float( &_ecnv_target_->xbeta );
	cv_cnv_endian_float( &_ecnv_target_->ybeta );
	cv_cnv_endian_float( &_ecnv_target_->zbeta );
	cv_cnv_endian_float( &_ecnv_target_->xfov );
	cv_cnv_endian_float( &_ecnv_target_->yfov );
	cv_cnv_endian_int( &_ecnv_target_->xres );
	cv_cnv_endian_int( &_ecnv_target_->yres );
	cv_cnv_endian_int( &_ecnv_target_->ileaves );
	cv_cnv_endian_float( &_ecnv_target_->xdis );
	cv_cnv_endian_float( &_ecnv_target_->ydis );
	cv_cnv_endian_float( &_ecnv_target_->zdis );
	cv_cnv_endian_float( &_ecnv_target_->tsp );
	cv_cnv_endian_int( &_ecnv_target_->osamps );
	cv_cnv_endian_float( &_ecnv_target_->fbhw );
	cv_cnv_endian_int( &_ecnv_target_->vvp );
	cv_cnv_endian_float( &_ecnv_target_->pnsf );
	cv_cnv_endian_float( &_ecnv_target_->taratio );
	cv_cnv_endian_float( &_ecnv_target_->zarea );
}

void
cv_cnv_endian_OPT_GRAD_PARAMS( OPT_GRAD_PARAMS *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long( &_ecnv_target_->agxw );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->pwgxw );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->pwgxwa );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->agyb );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->pwgyb );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->pwgyba );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->agzb );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->pwgzb );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->pwgzba );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->frsize );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->pwsamp );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->pwxgap );
}

void
cv_cnv_endian_clock_t( clock_t *_ecnv_target_ ) {
	cv_cnv_endian___clock_t( (__clock_t *)_ecnv_target_ );
}

void
cv_cnv_endian_time_t( time_t *_ecnv_target_ ) {
	cv_cnv_endian___time_t( (__time_t *)_ecnv_target_ );
}

void
cv_cnv_endian_clockid_t( clockid_t *_ecnv_target_ ) {
	cv_cnv_endian___clockid_t( (__clockid_t *)_ecnv_target_ );
}

void
cv_cnv_endian_timer_t( timer_t *_ecnv_target_ ) {
	cv_cnv_endian___timer_t( (__timer_t *)_ecnv_target_ );
}

void
cv_cnv_endian_struct_timespec( struct timespec *_ecnv_target_ )
{
	cv_cnv_endian___time_t( &_ecnv_target_->tv_sec );
	cv_cnv_endian___syscall_slong_t( &_ecnv_target_->tv_nsec );
}

void
cv_cnv_endian_struct_tm( struct tm *_ecnv_target_ )
{
	cv_cnv_endian_int( &_ecnv_target_->tm_sec );
	cv_cnv_endian_int( &_ecnv_target_->tm_min );
	cv_cnv_endian_int( &_ecnv_target_->tm_hour );
	cv_cnv_endian_int( &_ecnv_target_->tm_mday );
	cv_cnv_endian_int( &_ecnv_target_->tm_mon );
	cv_cnv_endian_int( &_ecnv_target_->tm_year );
	cv_cnv_endian_int( &_ecnv_target_->tm_wday );
	cv_cnv_endian_int( &_ecnv_target_->tm_yday );
	cv_cnv_endian_int( &_ecnv_target_->tm_isdst );
	cv_cnv_endian_long( &_ecnv_target_->tm_gmtoff );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->tm_zone );
}

void
cv_cnv_endian_struct_itimerspec( struct itimerspec *_ecnv_target_ )
{
	cv_cnv_endian_struct_timespec( &_ecnv_target_->it_interval );
	cv_cnv_endian_struct_timespec( &_ecnv_target_->it_value );
}

void
cv_cnv_endian_pid_t( pid_t *_ecnv_target_ ) {
	cv_cnv_endian___pid_t( (__pid_t *)_ecnv_target_ );
}

void
cv_cnv_endian_struct___locale_struct( struct __locale_struct *_ecnv_target_ )
{
	{
		size_t _i57_0;
		for( _i57_0 = 0; _i57_0 < (13); ++_i57_0 ) {
			cv_cnv_endian_unsigned_long( &_ecnv_target_->__locales[_i57_0] );
		}
	}
	cv_cnv_endian_unsigned_long( &_ecnv_target_->__ctype_b );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->__ctype_tolower );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->__ctype_toupper );
	{
		size_t _i58_0;
		for( _i58_0 = 0; _i58_0 < (13); ++_i58_0 ) {
			cv_cnv_endian_unsigned_long( &_ecnv_target_->__names[_i58_0] );
		}
	}
}

void
cv_cnv_endian___locale_t( __locale_t *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long( (unsigned long *)_ecnv_target_ );
}

void
cv_cnv_endian_locale_t( locale_t *_ecnv_target_ ) {
	cv_cnv_endian___locale_t( (__locale_t *)_ecnv_target_ );
}

void
cv_cnv_endian_GEtimespec( GEtimespec *_ecnv_target_ ) {
	cv_cnv_endian_struct_timespec( (struct timespec *)_ecnv_target_ );
}

void
cv_cnv_endian_dbkey_exam_type( dbkey_exam_type *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_short( (unsigned short *)_ecnv_target_ );
}

void
cv_cnv_endian_dbkey_magic_type( dbkey_magic_type *_ecnv_target_ ) {
	cv_cnv_endian_short( (short *)_ecnv_target_ );
}

void
cv_cnv_endian_dbkey_series_type( dbkey_series_type *_ecnv_target_ ) {
	cv_cnv_endian_short( (short *)_ecnv_target_ );
}

void
cv_cnv_endian_dbkey_image_type( dbkey_image_type *_ecnv_target_ ) {
	cv_cnv_endian_int( (int *)_ecnv_target_ );
}

void
cv_cnv_endian_DbKey( DbKey *_ecnv_target_ ) {
	{
		size_t _i59_0;
		for( _i59_0 = 0; _i59_0 < (4); ++_i59_0 ) {
			cv_cnv_endian_char( &_ecnv_target_->su_id[_i59_0] );
		}
	}
	cv_cnv_endian_dbkey_magic_type( &_ecnv_target_->mg_no );
	cv_cnv_endian_dbkey_exam_type( &_ecnv_target_->ex_no );
	cv_cnv_endian_dbkey_series_type( &_ecnv_target_->se_no );
	cv_cnv_endian_dbkey_image_type( &_ecnv_target_->im_no );
}

void
cv_cnv_endian_OP_NMRID_TYPE( OP_NMRID_TYPE *_ecnv_target_ ) {
	{
		size_t _i60_0;
		for( _i60_0 = 0; _i60_0 < (12); ++_i60_0 ) {
			cv_cnv_endian_char( (char *)&((*_ecnv_target_)[_i60_0]) );
		}
	}
}

void
cv_cnv_endian_OP_HDR1_TYPE( OP_HDR1_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_n16( &_ecnv_target_->rev );
	cv_cnv_endian_n16( &_ecnv_target_->length );
	cv_cnv_endian_OP_NMRID_TYPE( &_ecnv_target_->req_nmrid );
	cv_cnv_endian_OP_NMRID_TYPE( &_ecnv_target_->resp_nmrid );
	cv_cnv_endian_n16( &_ecnv_target_->opcode );
	cv_cnv_endian_n16( &_ecnv_target_->packet_type );
	cv_cnv_endian_n16( &_ecnv_target_->seq_num );
	cv_cnv_endian_n32( &_ecnv_target_->status );
}

void
cv_cnv_endian_struct__OP_HDR_TYPE( struct _OP_HDR_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_s8( &_ecnv_target_->rev );
	cv_cnv_endian_s8( &_ecnv_target_->endian );
	cv_cnv_endian_n16( &_ecnv_target_->length );
	cv_cnv_endian_OP_NMRID_TYPE( &_ecnv_target_->req_nmrid );
	cv_cnv_endian_OP_NMRID_TYPE( &_ecnv_target_->resp_nmrid );
	cv_cnv_endian_n16( &_ecnv_target_->opcode );
	cv_cnv_endian_n16( &_ecnv_target_->packet_type );
	cv_cnv_endian_n16( &_ecnv_target_->seq_num );
	cv_cnv_endian_n16( &_ecnv_target_->pad );
	cv_cnv_endian_n32( &_ecnv_target_->status );
}

void
cv_cnv_endian_OP_HDR_TYPE( OP_HDR_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_struct__OP_HDR_TYPE( (struct _OP_HDR_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_struct__OP_RECN_READY_TYPE( struct _OP_RECN_READY_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_DbKey( &_ecnv_target_->dbkey );
	cv_cnv_endian_s32( &_ecnv_target_->seq_number );
	cv_cnv_endian_GEtimespec( &_ecnv_target_->time_stamp );
	cv_cnv_endian_s32( &_ecnv_target_->run_no );
	cv_cnv_endian_s32( &_ecnv_target_->prep_flag );
	cv_cnv_endian_n32( &_ecnv_target_->patient_checksum );
	{
		size_t _i61_0;
		for( _i61_0 = 0; _i61_0 < (32); ++_i61_0 ) {
			cv_cnv_endian_char( &_ecnv_target_->clinicalCoilName[_i61_0] );
		}
	}
}

void
cv_cnv_endian_OP_RECN_READY_TYPE( OP_RECN_READY_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_struct__OP_RECN_READY_TYPE( (struct _OP_RECN_READY_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_struct__OP_RECN_READY_PACK_TYPE( struct _OP_RECN_READY_PACK_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_OP_HDR_TYPE( &_ecnv_target_->hdr );
	cv_cnv_endian_OP_RECN_READY_TYPE( &_ecnv_target_->req );
}

void
cv_cnv_endian_OP_RECN_READY_PACK_TYPE( OP_RECN_READY_PACK_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_struct__OP_RECN_READY_PACK_TYPE( (struct _OP_RECN_READY_PACK_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_OP_RECN_FOO_TYPE( OP_RECN_FOO_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_s32( &_ecnv_target_->somes32bitint );
	cv_cnv_endian_n16( &_ecnv_target_->somen16bitint );
	cv_cnv_endian_char( &_ecnv_target_->somechar );
	cv_cnv_endian_unsigned_long( &_ecnv_target_->someulong );
	cv_cnv_endian_float( &_ecnv_target_->somefloat );
}

void
cv_cnv_endian_OP_RECN_FOO_PACK_TYPE( OP_RECN_FOO_PACK_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_OP_HDR_TYPE( &_ecnv_target_->hdr );
	cv_cnv_endian_OP_RECN_FOO_TYPE( &_ecnv_target_->req );
}

void
cv_cnv_endian_struct__OP_RECN_START_TYPE( struct _OP_RECN_START_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_s32( &_ecnv_target_->seq_number );
	cv_cnv_endian_GEtimespec( &_ecnv_target_->time_stamp );
}

void
cv_cnv_endian_OP_RECN_START_TYPE( OP_RECN_START_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_struct__OP_RECN_START_TYPE( (struct _OP_RECN_START_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_struct__OP_RECN_START_PACK_TYPE( struct _OP_RECN_START_PACK_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_OP_HDR_TYPE( &_ecnv_target_->hdr );
	cv_cnv_endian_OP_RECN_START_TYPE( &_ecnv_target_->req );
}

void
cv_cnv_endian_OP_RECN_START_PACK_TYPE( OP_RECN_START_PACK_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_struct__OP_RECN_START_PACK_TYPE( (struct _OP_RECN_START_PACK_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_OP_RECN_SCAN_STOPPED_TYPE( OP_RECN_SCAN_STOPPED_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_s32( &_ecnv_target_->seq_number );
	cv_cnv_endian_s32( &_ecnv_target_->status );
	cv_cnv_endian_s32( &_ecnv_target_->aborted_pass_num );
}

void
cv_cnv_endian_OP_RECN_SCAN_STOPPED_PACK_TYPE( OP_RECN_SCAN_STOPPED_PACK_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_OP_HDR_TYPE( &_ecnv_target_->hdr );
	cv_cnv_endian_OP_RECN_SCAN_STOPPED_TYPE( &_ecnv_target_->req );
}

void
cv_cnv_endian_OP_RECN_STOP_TYPE( OP_RECN_STOP_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_DbKey( &_ecnv_target_->dbkey );
	cv_cnv_endian_s32( &_ecnv_target_->seq_number );
	{
		size_t _i62_0;
		for( _i62_0 = 0; _i62_0 < (12); ++_i62_0 ) {
			cv_cnv_endian_char( &_ecnv_target_->scan_initiator[_i62_0] );
		}
	}
}

void
cv_cnv_endian_OP_RECN_STOP_PACK_TYPE( OP_RECN_STOP_PACK_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_OP_HDR_TYPE( &_ecnv_target_->hdr );
	cv_cnv_endian_OP_RECN_STOP_TYPE( &_ecnv_target_->req );
}

void
cv_cnv_endian_OP_RECN_IM_ALLOC_TYPE( OP_RECN_IM_ALLOC_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_s32( &_ecnv_target_->seq_number );
}

void
cv_cnv_endian_OP_RECN_IM_ALLOC_PACK_TYPE( OP_RECN_IM_ALLOC_PACK_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_OP_HDR_TYPE( &_ecnv_target_->hdr );
	cv_cnv_endian_OP_RECN_IM_ALLOC_TYPE( &_ecnv_target_->req );
}

void
cv_cnv_endian_OP_RECN_SCAN_STARTED_TYPE( OP_RECN_SCAN_STARTED_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_s32( &_ecnv_target_->seq_number );
}

void
cv_cnv_endian_OP_RECN_SCAN_STARTED_PACK_TYPE( OP_RECN_SCAN_STARTED_PACK_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_OP_HDR_TYPE( &_ecnv_target_->hdr );
	cv_cnv_endian_OP_RECN_SCAN_STARTED_TYPE( &_ecnv_target_->req );
}

void
cv_cnv_endian_OP_VIEWTABLE_UPDATE_TYPE( OP_VIEWTABLE_UPDATE_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_s32( &_ecnv_target_->table_size );
	cv_cnv_endian_s32( &_ecnv_target_->block_size );
	cv_cnv_endian_s32( &_ecnv_target_->first_entry_index );
	{
		size_t _i63_0;
		for( _i63_0 = 0; _i63_0 < (256); ++_i63_0 ) {
			cv_cnv_endian_s32( &_ecnv_target_->table[_i63_0] );
		}
	}
}

void
cv_cnv_endian_OP_VIEWTABLE_UPDATE_PACK_TYPE( OP_VIEWTABLE_UPDATE_PACK_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_OP_HDR_TYPE( &_ecnv_target_->hdr );
	cv_cnv_endian_OP_VIEWTABLE_UPDATE_TYPE( &_ecnv_target_->pkt );
}

void
cv_cnv_endian_MROR_ADDR_BLOCK( MROR_ADDR_BLOCK *_ecnv_target_ ) {
	cv_cnv_endian_n64( &_ecnv_target_->mrhdr );
	cv_cnv_endian_n64( &_ecnv_target_->pixelhdr );
	cv_cnv_endian_n64( &_ecnv_target_->pixeldata );
	cv_cnv_endian_n64( &_ecnv_target_->raw_offset );
	cv_cnv_endian_n64( &_ecnv_target_->raw_receivers );
	cv_cnv_endian_n64( &_ecnv_target_->pixeldata3 );
}

void
cv_cnv_endian_MROR_ADDR_BLOCK_PKT( MROR_ADDR_BLOCK_PKT *_ecnv_target_ ) {
	cv_cnv_endian_OP_HDR_TYPE( &_ecnv_target_->hdr );
	cv_cnv_endian_MROR_ADDR_BLOCK( &_ecnv_target_->mrab );
}

void
cv_cnv_endian_MROR_RETRIEVAL_DONE_TYPE( MROR_RETRIEVAL_DONE_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_n32( &_ecnv_target_->recon_ts );
}

void
cv_cnv_endian_MROR_ADDR_BLOCK_PACK_TYPE( MROR_ADDR_BLOCK_PACK_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_OP_HDR_TYPE( &_ecnv_target_->hdr );
	cv_cnv_endian_MROR_RETRIEVAL_DONE_TYPE( &_ecnv_target_->retrieve_done );
}

void
cv_cnv_endian_SCAN_CALIB_INFO_TYPE( SCAN_CALIB_INFO_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_s32( &_ecnv_target_->exam_number );
	cv_cnv_endian_s32( &_ecnv_target_->calib_flag );
}

void
cv_cnv_endian_SCAN_CALIB_INFO_PACK_TYPE( SCAN_CALIB_INFO_PACK_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_OP_HDR_TYPE( &_ecnv_target_->hdr );
	cv_cnv_endian_SCAN_CALIB_INFO_TYPE( &_ecnv_target_->info );
}

void
cv_cnv_endian_struct__OP_RECN_SIZE_CHECK_TYPE( struct _OP_RECN_SIZE_CHECK_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_n64( &_ecnv_target_->total_bam_size );
	cv_cnv_endian_n64( &_ecnv_target_->total_disk_size );
}

void
cv_cnv_endian_OP_RECN_SIZE_CHECK_TYPE( OP_RECN_SIZE_CHECK_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_struct__OP_RECN_SIZE_CHECK_TYPE( (struct _OP_RECN_SIZE_CHECK_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_struct__OP_RECN_SIZE_CHECK_PACK_TYPE( struct _OP_RECN_SIZE_CHECK_PACK_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_OP_HDR_TYPE( &_ecnv_target_->hdr );
	cv_cnv_endian_OP_RECN_SIZE_CHECK_TYPE( &_ecnv_target_->req );
}

void
cv_cnv_endian_OP_RECN_SIZE_CHECK_PACK_TYPE( OP_RECN_SIZE_CHECK_PACK_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_struct__OP_RECN_SIZE_CHECK_PACK_TYPE( (struct _OP_RECN_SIZE_CHECK_PACK_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_EXAM_SCAN_DONE_TYPE( EXAM_SCAN_DONE_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_s32( &_ecnv_target_->exam_number );
}

void
cv_cnv_endian_EXAM_SCAN_DONE_PACK_TYPE( EXAM_SCAN_DONE_PACK_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_OP_HDR_TYPE( &_ecnv_target_->hdr );
	cv_cnv_endian_EXAM_SCAN_DONE_TYPE( &_ecnv_target_->info );
}

void
cv_cnv_endian_struct__POSITION_DETECTION_DONE_TYPE( struct _POSITION_DETECTION_DONE_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_n32( &_ecnv_target_->object_detected );
	cv_cnv_endian_f32( &_ecnv_target_->object_si_position_mm );
	cv_cnv_endian_f32( &_ecnv_target_->right_most_voxel_mm );
	cv_cnv_endian_f32( &_ecnv_target_->anterior_most_voxel_mm );
	cv_cnv_endian_f32( &_ecnv_target_->superior_most_voxel_mm );
	cv_cnv_endian_n32( &_ecnv_target_->checksum );
}

void
cv_cnv_endian_POSITION_DETECTION_DONE_TYPE( POSITION_DETECTION_DONE_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_struct__POSITION_DETECTION_DONE_TYPE( (struct _POSITION_DETECTION_DONE_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_struct__POSITION_DETECTION_DONE_PACK_TYPE( struct _POSITION_DETECTION_DONE_PACK_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_OP_HDR_TYPE( &_ecnv_target_->hdr );
	cv_cnv_endian_POSITION_DETECTION_DONE_TYPE( &_ecnv_target_->info );
}

void
cv_cnv_endian_POSITION_DETECTION_DONE_PACK_TYPE( POSITION_DETECTION_DONE_PACK_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_struct__POSITION_DETECTION_DONE_PACK_TYPE( (struct _POSITION_DETECTION_DONE_PACK_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_struct__OP_CTT_UPDATE_TYPE( struct _OP_CTT_UPDATE_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_s64( &_ecnv_target_->calUniqueNo );
	{
		size_t _i64_0;
		for( _i64_0 = 0; _i64_0 < (4); ++_i64_0 ) {
			cv_cnv_endian_ChannelTransTableEntryType( &_ecnv_target_->cttentry[_i64_0] );
		}
	}
	cv_cnv_endian_n32( &_ecnv_target_->errorCode );
}

void
cv_cnv_endian_OP_CTT_UPDATE_TYPE( OP_CTT_UPDATE_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_struct__OP_CTT_UPDATE_TYPE( (struct _OP_CTT_UPDATE_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_struct__OP_CTT_UPDATE_PACK_TYPE( struct _OP_CTT_UPDATE_PACK_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_OP_HDR_TYPE( &_ecnv_target_->hdr );
	cv_cnv_endian_OP_CTT_UPDATE_TYPE( &_ecnv_target_->req );
}

void
cv_cnv_endian_OP_CTT_UPDATE_PACK_TYPE( OP_CTT_UPDATE_PACK_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_struct__OP_CTT_UPDATE_PACK_TYPE( (struct _OP_CTT_UPDATE_PACK_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_struct__MAVRIC_CALIBRATION_DONE_TYPE( struct _MAVRIC_CALIBRATION_DONE_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_n32( &_ecnv_target_->spectral_bins );
}

void
cv_cnv_endian_MAVRIC_CALIBRATION_DONE_TYPE( MAVRIC_CALIBRATION_DONE_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_struct__MAVRIC_CALIBRATION_DONE_TYPE( (struct _MAVRIC_CALIBRATION_DONE_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_struct__MAVRIC_CALIBRATION_DONE_PACK_TYPE( struct _MAVRIC_CALIBRATION_DONE_PACK_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_OP_HDR_TYPE( &_ecnv_target_->hdr );
	cv_cnv_endian_MAVRIC_CALIBRATION_DONE_TYPE( &_ecnv_target_->info );
}

void
cv_cnv_endian_MAVRIC_CALIBRATION_DONE_PACK_TYPE( MAVRIC_CALIBRATION_DONE_PACK_TYPE *_ecnv_target_ ) {
	cv_cnv_endian_struct__MAVRIC_CALIBRATION_DONE_PACK_TYPE( (struct _MAVRIC_CALIBRATION_DONE_PACK_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_PSD_PSC_CONTROL( enum PSD_PSC_CONTROL *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_PSD_PSC_CONTROL_E( PSD_PSC_CONTROL_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_PSD_PSC_CONTROL( (enum PSD_PSC_CONTROL *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_GRADSHIM_SELECTION( enum GRADSHIM_SELECTION *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_GRADSHIM_SELECTION_E( GRADSHIM_SELECTION_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_GRADSHIM_SELECTION( (enum GRADSHIM_SELECTION *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_PRESSCFH_EXCITATION_TYPE( enum PRESSCFH_EXCITATION_TYPE *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_PRESSCFH_EXCITATION_TYPE_E( PRESSCFH_EXCITATION_TYPE_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_PRESSCFH_EXCITATION_TYPE( (enum PRESSCFH_EXCITATION_TYPE *)_ecnv_target_ );
}

void
cv_cnv_endian_struct_zy_index( struct zy_index *_ecnv_target_ )
{
	cv_cnv_endian_n16( &_ecnv_target_->view );
	cv_cnv_endian_n16( &_ecnv_target_->slice );
	cv_cnv_endian_n16( &_ecnv_target_->flags );
}

void
cv_cnv_endian_ZY_INDEX( ZY_INDEX *_ecnv_target_ ) {
	cv_cnv_endian_struct_zy_index( (struct zy_index *)_ecnv_target_ );
}

void
cv_cnv_endian_struct_zy_dist1( struct zy_dist1 *_ecnv_target_ )
{
	cv_cnv_endian_float( &_ecnv_target_->distance );
	cv_cnv_endian_n16( &_ecnv_target_->view );
	cv_cnv_endian_n16( &_ecnv_target_->slice );
	cv_cnv_endian_n16( &_ecnv_target_->flags );
}

void
cv_cnv_endian_ZY_DIST1( ZY_DIST1 *_ecnv_target_ ) {
	cv_cnv_endian_struct_zy_dist1( (struct zy_dist1 *)_ecnv_target_ );
}

void
cv_cnv_endian_struct__RDB_SLICE_INFO_ENTRY( struct _RDB_SLICE_INFO_ENTRY *_ecnv_target_ )
{
	cv_cnv_endian_short( &_ecnv_target_->pass_number );
	cv_cnv_endian_short( &_ecnv_target_->slice_in_pass );
	{
		size_t _i65_0;
		for( _i65_0 = 0; _i65_0 < (3); ++_i65_0 ) {
			cv_cnv_endian_float( &_ecnv_target_->gw_point1[_i65_0] );
		}
	}
	{
		size_t _i66_0;
		for( _i66_0 = 0; _i66_0 < (3); ++_i66_0 ) {
			cv_cnv_endian_float( &_ecnv_target_->gw_point2[_i66_0] );
		}
	}
	{
		size_t _i67_0;
		for( _i67_0 = 0; _i67_0 < (3); ++_i67_0 ) {
			cv_cnv_endian_float( &_ecnv_target_->gw_point3[_i67_0] );
		}
	}
	cv_cnv_endian_short( &_ecnv_target_->transpose );
	cv_cnv_endian_short( &_ecnv_target_->rotate );
	cv_cnv_endian_unsigned_int( &_ecnv_target_->coilConfigUID );
	cv_cnv_endian_float( &_ecnv_target_->fov_freq_scale );
	cv_cnv_endian_float( &_ecnv_target_->fov_phase_scale );
	cv_cnv_endian_float( &_ecnv_target_->slthick_scale );
	cv_cnv_endian_float( &_ecnv_target_->freq_loc_shift );
	cv_cnv_endian_float( &_ecnv_target_->phase_loc_shift );
	cv_cnv_endian_float( &_ecnv_target_->slice_loc_shift );
	cv_cnv_endian_short( &_ecnv_target_->sliceGroupId );
	cv_cnv_endian_short( &_ecnv_target_->sliceIndexInGroup );
}

void
cv_cnv_endian_RDB_SLICE_INFO_ENTRY( RDB_SLICE_INFO_ENTRY *_ecnv_target_ ) {
	cv_cnv_endian_struct__RDB_SLICE_INFO_ENTRY( (struct _RDB_SLICE_INFO_ENTRY *)_ecnv_target_ );
}

void
cv_cnv_endian_EXTERN_FILENAME( EXTERN_FILENAME *_ecnv_target_ ) {
	{
		size_t _i68_0;
		for( _i68_0 = 0; _i68_0 < (80); ++_i68_0 ) {
			cv_cnv_endian_char( (char *)&((*_ecnv_target_)[_i68_0]) );
		}
	}
}

void
cv_cnv_endian_EXTERN_FILENAME2( EXTERN_FILENAME2 *_ecnv_target_ ) {
	cv_cnv_endian_unsigned_long( (unsigned long *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_DATA_FRAME_DESTINATION( enum DATA_FRAME_DESTINATION *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_DATA_FRAME_DESTINATION_E( DATA_FRAME_DESTINATION_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_DATA_FRAME_DESTINATION( (enum DATA_FRAME_DESTINATION *)_ecnv_target_ );
}

void
cv_cnv_endian_enum_DABOUTHUBINDEX( enum DABOUTHUBINDEX *_ecnv_target_ )
{
	cv_cnv_endian_int((int *) _ecnv_target_);
}

void
cv_cnv_endian_DABOUTHUBINDEX_E( DABOUTHUBINDEX_E *_ecnv_target_ ) {
	cv_cnv_endian_enum_DABOUTHUBINDEX( (enum DABOUTHUBINDEX *)_ecnv_target_ );
}

