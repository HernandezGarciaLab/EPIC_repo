/*
   genspispiral3d_io
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
float genspiral3dcyl_io(
		float *gx,
		float *gy,
		float *gz,
		int   Npoints,
		int   Nshots_theta,
		int   Nshots_phi,
		float fFOV,
		float fXres,
		float fZres,
		float fDeltaT,
		float GMAX,  
		float R_accel,
		float THETA_accel,
        	int   Ncenter
		)
{

	float gamma = 26754.0; /* Gauss/(rad/s)  */
	float gammabar; /* Gauss/Hz  */
	float Kmax, deltaK, Kzmax;
	float r[Npoints+1];
	float t[Npoints+1];
	float theta[Npoints+1];
	float phi[Npoints+1];
	float slowFactor=0.0;

	float phi2;
	float Nphi;
	float Nturns_theta;  /*how many times turns of the spiral are needed in plane to get adequate deltaK*/
	float rampSlopex, rampSlopey, rampSlopez;
	float rampSlopekx, rampSlopeky, rampSlopekz;
	float rampSlopeR;
	float x, y, z;
	float areax, areay, areaz;
	float kx[Npoints];
	float ky[Npoints];
	float kz[Npoints];
	int i,j;
	float dr, dtheta, dphi, dphi2, AccelFactor;
	float  maxslewx, maxslewy, maxslewz;
	float  maxgx, maxgy, maxgz;
	FILE *fid;
	FILE *fid2;
	FILE *fid3;
	int  NRAMPDN ;
	int  NRAMPUP ;
	float Rmax;
	int count;
	float sfactor, THETA_MAX ;
	float SLEWMAX = 16000; // max allowed slew rate in G/cm/s
	float tt;
	float w;

	maxslewx = 0;
	maxslewy = 0;
	maxslewz = 0;

	maxgx = 0;
	maxgy = 0;
	maxgz = 0;

	gammabar = gamma/2.0/M_PI;

	Kzmax = 1/fZres/2;

	Kmax = 1.0/(fXres); 
	Kmax = 1.0/(fXres)/2; /*error above? 11/16.21*/
	deltaK = 1.0/(fFOV);
	Nturns_theta = Kmax/deltaK/2.0;

	Nturns_theta = THETA_accel * Nturns_theta / Nshots_theta;

	//add a turn to make up for the ramp :
	Nturns_theta++ ;

	/* Calculation using the spacing between the turns*/
	dr = 	2.0/Npoints;


	dtheta = 2.0/Npoints;  // but THEN we double the step size, so we can cover both the IN and the OUT
	THETA_MAX = Nturns_theta * M_PI ; // theta will go from -thetamax to +thetamax

	/* the first turn (2*PI) is used for the ramp up */
	NRAMPUP = (int)(M_PI*Npoints/THETA_MAX);


	fprintf(stderr, "\nGenerating spirals for:");
	fprintf(stderr, "\nFOV = %f,  xres=  %f,   \ndeltaK=%f Kmax=%f, \nNturns_theta= %f, \ndtheta= %f , dphi=%f ",
			fFOV, fXres, deltaK, Kmax, Nturns_theta, dtheta, dphi);
	fprintf(stderr, "\nNshots_theta = %d", Nshots_theta);
	fprintf(stderr, "\nNshots_phi = %d", Nshots_phi);
	fprintf(stderr, "\nNpoints = %d", Npoints);
	fprintf(stderr, "\nKmax = %f", Kmax);
	fprintf(stderr, "\nKzmax = %f", Kzmax);
	fprintf(stderr, "\nGmax = %f", GMAX);

	fprintf(stderr, "\nNRAMPUP = %d", NRAMPUP);
	fprintf(stderr, "\nR_accel factor = %f", R_accel);
	fprintf(stderr, "\nTHETA_accel = %f", THETA_accel);

	// intialize array to zeros
	for (i=0; i<Npoints; i++)
	{
		r[i]=0.0;
		theta[i] = 0.0;
		phi[i] = 0.0;
	}

	// make room for some calibration points at the center of k space
	Npoints -= Ncenter;

	dphi = M_PI/Npoints;

	for (i=0; i<Npoints/2; i++)
	{
		r[i] = fabs(i*dr - 1.0) ; // abs(linspace(-1,1,Npoints)) 
		r[i] = pow(r[i], R_accel);   // <1 means faster Radius increase near center - variable density
		r[i] *= Kmax;   // scale so that is goes from -Kmax to Kmax 

		theta[i] = fabs(i*dtheta - 1.0) * THETA_MAX;
		//theta[i] = tanh(fabs(i*dtheta - sfactor))* THETA_MAX / tanh(sfactor);
		phi[i] = 0;

	}


	// filter for a smooth trajectory near the middle

	for (i=0; i<Npoints/2; i++)
	{
		w = tanh((Npoints/2 -i) * Nturns_theta*M_PI/(Npoints/2) - M_PI) ;
		w = 0.5*(w+1);
		r[i] = r[i] *w;

	}

	//create a smooth ramp
	for (i=0; i<2*NRAMPUP; i++)
	{
		w = 0.5*(tanh(i*2*M_PI/NRAMPUP - M_PI) + 1);
		r[i] = r[i]*w;
	}

	Npoints += Ncenter ; // restore the value of Npoints 


	//The second half of the spiral is the same as the first
	int k=0;
	for (i=Npoints-1; i>Npoints/2-1 ; i--)
	{
		r[i] = r[k];
		theta[i] = theta[k] + M_PI;
		phi[i] = 0.0;
		k++ ;
	}



	/* rescale the whole thing  so that max(r) is Kmax */
	Rmax = 0;
	for (i=0; i< Npoints; i++)
		if (Rmax<=r[i]) Rmax = r[i];

	for (i=0; i< Npoints; i++)
		r[i] *= Kmax/Rmax;

	Rmax = 0;
	for (i=0; i< Npoints; i++)
		if (Rmax<=r[i]) Rmax = r[i];
	fprintf(stderr, "\nRmax (rescaled) = %f", Rmax);

	fprintf(stderr,"...done");
	fprintf(stderr,"\nTranslating from Spherical to Cartesian k-space traj ...");
	sph2cart(kx, ky, kz, r,theta, phi, Npoints);
	fprintf(stderr,"...done");

	/*Now the Kz component of the trajectory */
	for(i=0; i<Npoints;i++) kz[i] = Kzmax;

	/* ramp nicely */
	/* ramp weighting function tanh goes from -2*PI to 2*PI */
	fprintf(stderr,"\nCalculating initial TANH ramps to Kmax ...");
	dr = 2.0*M_PI/NRAMPUP;  

	for (i=0; i<NRAMPUP; i++){
		/*a nice signmoid curve from 0 to 1*/
		w = 0.5*(1 + tanh(2*i*dr-M_PI));
		kz[i] = w * kz[i];
	}
	/* the second half is the reflection of the first half */
	k=0;
	for (i=Npoints-1; i>Npoints/2-1 ; i--)
	{
		kz[i] = kz[k];
		k++ ;
	}

	/* kludge to fix discontinuity near the center */
	/*
	   float p1,p2,slope;
	   int Npatch=15;

	   p1 = kx[Npoints/2-Npatch];
	   p2 = kx[Npoints/2+Npatch];
	   slope = (p2 - p1 )/(2*Npatch);

	for (i=0; i < 2*Npatch; i++)
	{
		kx[Npoints/2 - Npatch + i] = p1 + i*slope;
	}


	p1 = ky[Npoints/2-Npatch];
	p2 = ky[Npoints/2+Npatch];
	slope = (p2 - p1 )/(2*Npatch);

	for (i=0; i < 2*Npatch; i++)
	{
		ky[Npoints/2 - Npatch + i] = p1 + i*slope;
	}

     */
	
    /* Simple Moving Average Filter */
	int window = 5; // must be odd
	//SMA(kx,ky,Npoints,window);

	fprintf(stderr,"\nCalculating grads from k-space traj ...");
	/* The Gradients are the derivative of the kspace trajectory */
	areax=0.0;
	areay=0.0;
	areaz=0.0;

	for (i=0; i<Npoints; i++)
	{
		gx[i] = 0.0; 	gy[i] = 0.0;  gz[i] = 0.0;
	}
	
	for (i=1; i<Npoints; i++)
	{
		gx[i] = (kx[i] - kx[i-1])/fDeltaT/gammabar;
		gy[i] = (ky[i] - ky[i-1])/fDeltaT/gammabar;
		gz[i] = (kz[i] - kz[i-1])/fDeltaT/gammabar;

		areax+=gx[i];
		areay+=gy[i];
		areaz+=gz[i];
		/*fprintf(stderr,"%\tgx[%d] = %f",i,gx[i]);*/

	}

	gx[Npoints]=0.0; gy[Npoints] = 0.0; gx[Npoints]=0.0;
	fprintf(stderr,"...done");

	/* apply running average filter to smooth out waveforms*/
	/*
	for (i=1; i<Npoints-1; i++)
	{
		gx[i] = (gx[i-1] + gx[i+1] + gx[i])/3;
		gy[i] = (gy[i-1] + gy[i+1] + gy[i])/3;
		gz[i] = (gz[i-1] + gz[i+1] + gz[i])/3;
	}
	*/

	fprintf(stderr, "\nChecking Max Gradients and Slew RATES ... ");
	/*  Check the slew rates */

	for (i=0; i<Npoints-2; i++)
	{

        if (fabs(gx[i+1] - gx[i])/ fDeltaT > maxslewx)
			maxslewx = fabs(gx[i+1] - gx[i]) / fDeltaT;
        
		if (fabs(gy[i+1] - gy[i])/ fDeltaT > maxslewy)
			maxslewy = fabs(gy[i+1] - gy[i])/  fDeltaT;
		
        if (fabs(gz[i+1] - gz[i])/ fDeltaT > maxslewz)
			maxslewz = fabs(gz[i+1] - gz[i]) / fDeltaT;

		if (fabs(gx[i]) > maxgx)
			maxgx = fabs(gx[i]);
		
        if (fabs(gy[i]) > maxgy)
			maxgy = fabs(gy[i]);
        
		if (fabs(gz[i]) > maxgz)
			maxgz = fabs(gz[i]);

	}
    
	fprintf(stderr, "\nMaximum Gradient Amps  are: %f %f %f (G/cm) - GMAX is %f",
			maxgx, maxgy, maxgz, GMAX);
    
	
    
	// operate at GMAX
	slowFactor = 0.0;

	// but make sure we are below slew rate
	if (fabs(maxslewx/SLEWMAX) >= slowFactor) slowFactor = sqrt(fabs(maxslewx/SLEWMAX));
	if (fabs(maxslewy/SLEWMAX) >= slowFactor) slowFactor = sqrt(fabs(maxslewy/SLEWMAX));
	if (fabs(maxslewz/SLEWMAX) >= slowFactor) slowFactor = sqrt(fabs(maxslewz/SLEWMAX));

	// is it TOO BIG?
	if ((fabs(maxgx/GMAX) ) >= slowFactor) slowFactor = fabs(maxgx/GMAX);
	if ((fabs(maxgy/GMAX) ) >= slowFactor) slowFactor = fabs(maxgy/GMAX);
	if ((fabs(maxgz/GMAX) ) >= slowFactor) slowFactor = fabs(maxgz/GMAX);


    
	/* dump to text file for later recon */
	fprintf(stderr,"\nWriting Kxyz and Gxyz output to files, Npoints=%d ...", Npoints);
	fid = fopen("grad.txt","w");
	fid2 = fopen("ktraj_cart.txt","w");
	fid3 = fopen("ktraj_sph.txt","w");
	for (i=0; i<Npoints; i++){
		fprintf(fid , "%f\t%f\t%f\n", gx[i], gy[i], gz[i]);
		fprintf(fid2, "%f\t%f\t%f\n", kx[i], ky[i], kz[i]);
		fprintf(fid3, "%f\t%f\t%f\n", r[i], theta[i], phi[i]);
	}
	fclose (fid);
	fclose (fid2);
	fclose (fid3);
	fprintf(stderr,"...done");

	
    fprintf(stderr, "\nFinal Gradient moments  are: %f %f %f",
			areax*fDeltaT, areay*(fDeltaT), areaz*fDeltaT);
    fprintf(stderr, "\nMaximum Slew RATES  are: %f %f %f (G/cm/s)",
			maxslewx, maxslewy, maxslewz);

    fprintf(stderr, "\nMax Allowed slew rate is about %f G/cm/s ", SLEWMAX);
	
    fprintf(stderr, "\nslowFactor = %f", slowFactor);
    
    if(slowFactor > 1)
		fprintf(stderr,"\n--->Exceeding max Gradient of %f. Need to slowdown by:  %f  <---",
                GMAX, slowFactor);
    
	fprintf(stderr,"\n ..... end genspiral3d_io \n");

	return slowFactor ;

}

/*
   sph2cart
   converts arrays of spherical coordinates into cartesian coordinates
 */
int sph2cart(
		float*	pfx,
		float*	pfy,
		float*	pfz,
		float*	pfr,
		float*	pftheta,
		float*	pfphi,
		int	Npts)
{
	int c;
	float r, cth,sth, cphi, sphi;

	for (c=0;c<Npts;c++)
	{
		sth = sin(pftheta[c]);
		cth = cos(pftheta[c]);
		sphi = sin(pfphi[c]);
		cphi = cos(pfphi[c]);
		r = pfr[c];

		/*pfx[c] = r*sphi*cth;
		  pfy[c] = r*sth*sphi;
		  pfz[c] = r*cphi;*/

		pfx[c] = r*cphi*cth;
		pfy[c] = r*cphi*sth;
		pfz[c] = r*sphi;

		/*
				fprintf(stderr, "\nCART: %f \t %f \t %f \t SPHERICAL %f \t %f \t %f \n",
				pfx[c], pfy[c], pfz[c], pfr[c], pftheta[c], pfphi[c]);
		 */
	}
	return 1;

}

/*
	Simple Moving Average Filter

*/
void SMA(float *kx, float *ky,int Npoints, int window)
{
	float runningTotal = 0;
	float kxn[Npoints];
	float kyn[Npoints];
	float kxp[Npoints+window-1];
	float kyp[Npoints+window-1];
	int lengthp = sizeof(kxp)/sizeof(kxp[0]);
	int i = 0;

	// fill kxp with zeros
	for(i=0; i<lengthp; i++)
	{
		kxp[i] = 0;
	}

	// fill kyp with zeros
	for(i=0; i<lengthp; i++)
	{
		kyp[i] = 0;
	}

	// pad kx
	for(i=(window-1)/2; i<Npoints+window-1; i++)
	{
		kxp[i] = kx[i-(window-1)/2];
	}

	// pad ky
	for(i=(window-1)/2; i<Npoints+window-1; i++)
	{
		kyp[i] = ky[i-(window-1)/2];
	}

	// SMA Filter kx
	for(i=0; i<lengthp; i++)
	{
		runningTotal += kxp[i]; // add to total
		if(i >= window)
			runningTotal -= kxp[i-window]; // sub old
		if(i >= (window-1))
			kx[i-window+1] = runningTotal/(float)window;
	}
	runningTotal = 0;
	// SMA Filter ky
	for(i=0; i<lengthp; i++)
	{
		runningTotal += kyp[i]; // add to total
		if(i >= window)
			runningTotal -= kyp[i-window]; // sub old
		if(i >= (window-1))
			ky[i-window+1] = runningTotal/(float)window;
	}
}



/*

   rotGradWaves
   rotate the gradient waveforms by a matrix

 */
int rotGradWaves(
		float* 	gx,
		float* 	gy,
		float* 	gz,
		float* 	gx2,
		float* 	gy2,
		float* 	gz2,
		int   		glen,
		float*		mat)
{
	int c;
	for(c=0; c<glen; c++)
	{
		gx2[c] = mat[0]*gx[c] + mat[1]*gy[c] + mat[2]*gz[c];
		gy2[c] = mat[3]*gx[c] + mat[4]*gy[c] + mat[5]*gz[c];
		gz2[c] = mat[6]*gx[c] + mat[7]*gy[c] + mat[8]*gz[c];

	}

	fprintf(stderr,"RotMat:  ");
	for (c=0; c<9 ; c++) fprintf(stderr,"%f \t", mat[c]);
	fprintf(stderr,"\n");


	return 1;
}



/*
euler2mat:   generates a rotation matrix from Euler angles
takes from Varian at  psg/GradientBase.cpp.... see ::calc_obl_matrix
 */
int euler2mat2(float ang1,float ang2,float ang3,float *tm)
{
	float D_R;
	float sinang1,cosang1,sinang2,cosang2,sinang3,cosang3;
	float m11,m12,m13,m21,m22,m23,m31,m32,m33;
	float im11,im12,im13,im21,im22,im23,im31,im32,im33;
	float tol = 1.0e-14;

	/* Convert the input to the basic mag_log matrix */
	D_R = M_PI / 180;
	D_R = 1.0; /*Varian works in degrees, this program is is radians, though */

	cosang1 = cos(D_R*ang1);
	sinang1 = sin(D_R*ang1);

	cosang2 = cos(D_R*ang2);
	sinang2 = sin(D_R*ang2);

	cosang3 = cos(D_R*ang3);
	sinang3 = sin(D_R*ang3);

	/*m11 = (sinang2*cosang1 - cosang2*cosang3*sinang1);
	  m12 = (-1.0*sinang2*sinang1 - cosang2*cosang3*cosang1);
	  m13 = (sinang3*cosang2);

	  m21 = (-1.0*cosang2*cosang1 - sinang2*cosang3*sinang1);
	  m22 = (cosang2*sinang1 - sinang2*cosang3*cosang1);
	  m23 = (sinang3*sinang2);

	  m31 = (sinang1*sinang3);
	  m32 = (cosang1*sinang3);
	  m33 = (cosang3);*/


	m11 = cosang1;
	m12 = -1.0*sinang1;
	m13 = 0;

	m21 = sinang1;
	m22 = cosang1;
	m23 = 0;

	m31 = 0;
	m32 = 0;
	m33 = 1;




	if (fabs(m11) < tol) m11 = 0;
	if (fabs(m12) < tol) m12 = 0;
	if (fabs(m13) < tol) m13 = 0;
	if (fabs(m21) < tol) m21 = 0;
	if (fabs(m22) < tol) m22 = 0;
	if (fabs(m23) < tol) m23 = 0;
	if (fabs(m31) < tol) m31 = 0;
	if (fabs(m32) < tol) m32 = 0;
	if (fabs(m33) < tol) m33 = 0;

	/* Generate the transform matrix for mag_log ******************/

	/*HEAD SUPINE*/
	im11 = m11;       im12 = m12;       im13 = m13;
	im21 = m21;       im22 = m22;       im23 = m23;
	im31 = m31;       im32 = m32;       im33 = m33;

	/*Transpose intermediate matrix and return***********
	 *tm11 = im11;     *tm21 = im12;     *tm31 = im13;
	 *tm12 = im21;     *tm22 = im22;     *tm32 = im23;
	 *tm13 = im31;     *tm23 = im32;     *tm33 = im33;
	 */
	/*Transpose intermediate matrix and return***********/
	tm[0] = im11;     tm[1] = im12;     tm[2] = im13;
	tm[3] = im21;     tm[4] = im22;     tm[5] = im23;
	tm[6] = im31;     tm[7] = im32;     tm[8] = im33;


	return 1;
}
