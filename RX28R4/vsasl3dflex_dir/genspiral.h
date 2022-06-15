/*
   genspispiral_djfrey
   Generate 3 spiral in-out waveforms for a 3D spiral trajectory
   to be used in a spin echo.  We want the center of k-space to
   be sampled at the center of the echo
   float *gx,		pointer to gradient waveform data
   float *gy, 		(G/cm)
   float *gz,
   int   Npoints,		length of gradient waveform data buffers
   int   iNshots_theta,	Number of interleaves along the azimuthal angle
   int   iNshots_phi,	Number of interleaves along the elevation angle
   float fFOV,		image space Field of View (cm)
   float fXres,		image space resolution (cm)
   float fZres,		image space resolution- slice thickness (cm)
   float fDeltaT		waveform sample time (granularity) in sec.
   float GMAX          Max Alow Grad. Amp.
   float R_accel    controls shape of radial position: R=t^R_accel
   float THETA_Accel controls number of turns of the spiral. 1 is default. 2 is twice as many  as calculated.
   int   Ncenter      N extra points to collect in the middle of trajectory. 
 
 */
float genspiral(
		float *gx,
		float *gy,
		float *gz,
		int   Npoints,
		int   Nshots,
        float ramp_frac,
		float fFOV,
		float fXres,
		float fZres,
		float fDeltaT,
		float GMAX,  
		float R_accel,
		float THETA_accel,
        	int   Ncenter,
		int   doSERIOS
		)
{

	/* Scanner constants/restraints */	
	float gamma = 26754.0;
	float gammabar = gamma/2.0/M_PI;
	float SLEWMAX = 16000;

	/* Output files */
	FILE *f_grad;
	FILE *f_ktraj_cart;
	FILE *f_ktraj_sph;
	FILE *f_smooth;

	/* Calculation of k-space info */
	float Kzmax = 1.0/fZres/2.0;
	float Kmax = 1.0/fXres/2.0;
	float dK = 1.0/fFOV;
	int Nturns = (int) (THETA_accel/Nshots * Kmax/dK/2.0 + 1);
	int Nramp = (int) (ramp_frac * Npoints/2.0/Nturns);

	/* Calculation of sampling spacing */
	float dn = 2.0/Npoints;
	int n;

	/* Initializing r, theta arrays and smoothing weights */
    float r_in[Npoints/2];
    float theta_in[Npoints/2];
	float r[Npoints+Ncenter];
	float theta[Npoints+Ncenter];
	float w_ramp;
    float w_rampup[Npoints/2];
    float w_rampdown[Npoints/2];
	for (n=0; n<(Npoints+Ncenter); n++)
	{
		r[n] = 0;
		theta[n] = 0;
	}

	/* Calculating r and theta with smoothing weights */
	for (n=0; n<(Npoints/2); n++)
	{
        /* Calculate r and theta for in-spiral */
        r_in[Npoints/2-1-n] = Kmax * pow(fabs(n*dn), R_accel);
        theta_in[Npoints/2-1-n] = fabs(n*dn) * Nturns * M_PI + M_PI/2;
        
        /* Calculate smoothing weights */
        w_rampup[n] = 1 - exp( -pow((float)n/Nramp,4) );
        w_rampdown[Npoints/2-1-n] = 1 - exp( -pow((float)n*2/Nramp,4) );
    }

    /* Apply in-spiral and smoothing to overall r and theta arrays */
    f_smooth = fopen("smoothing.txt","w");
    for (n=0; n<(Npoints/2); n++)
	{
        /* Calculate overall smoothing function */
        w_ramp = w_rampup[n] * w_rampdown[n];
        fprintf(f_smooth,"%f\n",w_ramp);

        /* Apply in-spiral */
        r[n] = w_ramp * r_in[n];
        theta[n] = theta_in[n];
        
        /* Apply out-spiral as mirror of in-spiral */
        r[Npoints+Ncenter-1-n] = w_ramp * r_in[n];
        theta[Npoints+Ncenter-1-n] = theta_in[n] + M_PI;
	}
    fclose(f_smooth);

	/* Rescale so max(R) = Kmax */
	float Rmax = 0;
	for (n=0; n<(Npoints+Ncenter); n++)
		if (r[n]>Rmax) Rmax = r[n];
	for (n=1; n<(Npoints+Ncenter); n++)
		r[n] *= Kmax/Rmax;

	/* Initialize k arrays for translating spherical coordinates into cartesian coordinates */
	float kx[Npoints+Ncenter];
	float ky[Npoints+Ncenter];
	float kz[Npoints+Ncenter];
	for (n=0; n<(Npoints+Ncenter); n++)
	{
		kx[n] = 0;
		ky[n] = 0;
		kz[n] = 0;
	}

	/* Calculate x and y trajectories */
	for  (n=0; n<(Npoints+Ncenter); n++)
	{
		kx[n] = r[n]*cos(theta[n]);
		ky[n] = r[n]*sin(theta[n]);
	}

	/* Calculate z trajectory */
	if (!doSERIOS)
	{
		for (n=0; n<((Npoints+Ncenter)/2); n++)
		{	
			kz[n] = Kzmax*(1 - exp( -pow((float)n/Nramp,4) ));
			kz[Npoints+Ncenter-1-n] = kz[n];
		}
	}

	/* Initialize gradient waveforms */
	for (n=0; n<(Npoints+Ncenter); n++)
	{
		gx[n] = 0;
		gy[n] = 0;
		gz[n] = 0;
	}

	/* Calculate gradient waveforms as the integral of k-space trajectory */
	float areax = 0;
	float areay =0;
	float areaz = 0;	
	for (n=1; n<(Npoints+Ncenter); n++)
	{
		gx[n] = (kx[n] - kx[n-1])/fDeltaT/gammabar;
		gy[n] = (ky[n] - ky[n-1])/fDeltaT/gammabar;
		gz[n] = (kz[n] - kz[n-1])/fDeltaT/gammabar;

		areax+=gx[n];
		areay+=gy[n];
		areaz+=gz[n];
	}

	/* Determine max slew rates and max gradients*/
	float slewx, slewy, slewz;
	float maxslewx = 0;
	float maxslewy = 0;
	float maxslewz = 0;
	float maxgx = 0;
	float maxgy = 0;
	float maxgz = 0;
	for (n=0; n<Npoints+Ncenter-2; n++)
	{
		slewx = fabs(gx[n+1] - gx[n]) / fDeltaT;
		if (slewx > maxslewx)
			maxslewx = slewx;
		if (fabs(gx[n]) > maxgx)
			maxgx = fabs(gx[n]);

		slewy = fabs(gy[n+1] - gy[n]) / fDeltaT;
		if (slewy > maxslewy)
			maxslewy = slewy;
		if (fabs(gy[n]) > maxgy)
			maxgy = fabs(gy[n]);

		slewz = fabs(gz[n+1] - gz[n]) /fDeltaT;
		if (slewz > maxslewz)
			maxslewz = slewz;
		if (fabs(gz[n]) > maxgz)
			maxgz = fabs(gz[n]);
	}

	/* Initialize slowFactor */
	float slowFactor = 0;
	
	/* Make sure max slew rate is not exceeded */
	if (fabs(maxslewx/SLEWMAX) >= slowFactor) slowFactor = sqrt(fabs(maxslewx/SLEWMAX));
	if (fabs(maxslewy/SLEWMAX) >= slowFactor) slowFactor = sqrt(fabs(maxslewy/SLEWMAX));
	if (fabs(maxslewz/SLEWMAX) >= slowFactor) slowFactor = sqrt(fabs(maxslewz/SLEWMAX));
	
	/* Make sure max gradient is not exceeded */
	if (fabs(maxgx/GMAX) >= slowFactor) slowFactor = fabs(maxgx/GMAX);
	if (fabs(maxgy/GMAX) >= slowFactor) slowFactor = fabs(maxgy/GMAX);
	if (fabs(maxgz/GMAX) >= slowFactor) slowFactor = fabs(maxgz/GMAX);

	/* Write arrays out to file */
	f_grad = fopen("grad.txt","w");
	f_ktraj_cart = fopen("ktraj_cart.txt","w");
	f_ktraj_sph = fopen("ktraj_sph.txt","w");
	for (n=0; n<Npoints+Ncenter; n++) {
		fprintf(f_grad, "%f\t%f\t%f\n", gx[n], gy[n], gz[n]);
		fprintf(f_ktraj_cart, "%f\t%f\t%f\n", kx[n], ky[n], kz[n]);
		fprintf(f_ktraj_sph, "%f\t%f\n", r[n], theta[n]);
	}
	fclose(f_grad);
	fclose(f_ktraj_cart);
	fclose(f_ktraj_sph);

	return slowFactor;
}
