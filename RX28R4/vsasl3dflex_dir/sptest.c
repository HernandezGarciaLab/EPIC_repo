#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "genspiral3dcyl_io.h"

int main()
{

	fprintf(stderr,"\nGenerating a spiral ....\n");
	int   iGsize = 50000; 
	float gx[iGsize];
	float gy[iGsize];
	float gz[iGsize];
	int Nshots_theta = 6;
	int Nshots_phi = 1;
	float fFOV = 20;   /*cm*/
	float fXres = 0.3; 
    	float fZres = 0.3; 
    
	float fDeltaT = 4e-6; /*seconds*/
	float Gmax = 2;

	float Kmax, deltaK;
	int FID_len;
	float oprbw, FID_dur;
	int GRAD_len;
	float slowDown=10.0;
	float R_accel = 1;
	float THETA_accel = 1;
    	int Ncenter = 40;

    
	oprbw = 125*1e3;  /* Hz*/
	deltaK = 1 / fFOV ;  /* cm^-1*/
	Kmax = 1.0 / fXres/2;
	FID_len = (int) (Kmax*Kmax / deltaK/deltaK/4);
	FID_len = FID_len*(int)(1.0 / (3.14259*0.5*0.5));
	/* covering a circle, not a square: 
	area of square= X^2
	area of circle inside:  (X/2)^2 * PI */ 
	FID_len = (int)(FID_len/Nshots_theta);	
	FID_dur = FID_len / oprbw ; /* seconds*/
    
	FID_dur = 10e-3; // initialize with a short readout

    
	while((slowDown-1)*(slowDown-1) > 0.0001)
	{

		GRAD_len = (int)(FID_dur / fDeltaT);

		fprintf(stderr, "\nDesigning spiral IN-OUT echo with ... ");
		fprintf(stderr, "\nNshots_theta= %d \nNshots phi \nFOV= %f",
			Nshots_theta, Nshots_phi, fFOV );

		slowDown = genspiral3dcyl_io(
			gx, 
			gy, 
			gz,
			GRAD_len, 
			Nshots_theta,
			Nshots_phi,
			fFOV,
			fXres,
			fZres,
			fDeltaT,
			Gmax,
			R_accel,
			THETA_accel, 
            Ncenter
		      );
        
        fprintf(stderr, 
				"\noprbw = %f Hz \nKmax= %f \ndeltaK= %f  \nFID_dur =%f sec., \nGRAD_len = %d \nGmax = %f\n",
				oprbw, Kmax, deltaK, FID_dur, GRAD_len, Gmax );

        fprintf(stderr, "\nSLowDown factor: %f", slowDown);
		FID_dur =  FID_dur * slowDown;

	}
    fprintf(stderr, "\n...Done! \n");
    /*
    // test for kz steps:
    int count, i;
    float dk;
    int   opslquant = 20;
	int kzorder[100];
    float kzfraction[100];
    
    FILE *pfkzfile;
    

    dk = 2.0/opslquant;
    count = 1;
	for(i=1; i< opslquant; i+=2)
	{
		kzorder[i] =    opslquant/2.0 -1 + count ;
		kzorder[i+1] =  opslquant/2.0 -1 - count ;
                
		kzfraction[i] =  count * dk ;
		kzfraction[i+1] = -count*dk;
        
		count++;
	}

   	kzorder[0]    = (int)opslquant/2.0 - 1;
	kzfraction[0] = 0.0;
    
    kzorder[opslquant-1]     = opslquant-1;
    kzfraction[opslquant-1]  = 1.0;
    
    fprintf(stderr,"\nOrder of kz encoding steps :");
	for(i=0; i< opslquant; i++)
		fprintf(stderr,"\naq_oder: %d  sl = %d ---> kz fraction: %f", 
				i, kzorder[i], kzfraction[i]); 
    	
    pfkzfile = fopen("kzsteps.txt","w");

	for(i=0; i< opslquant; i++)
		fprintf(pfkzfile,"%d\t%d\t%f\n",  i, kzorder[i], kzfraction[i]);
    
	fclose(pfkzfile);
    */
	return 1;
}
