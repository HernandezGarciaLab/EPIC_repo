#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include "genspiral.h"

float genspiral(float* gx, float* gy, float* gz, int Grad_len,
		float R_accel, float THETA_accel,
		int N_center, float ramp_frac,
		int doXrot, int doYrot,
		float fov, int dim, float dt, float slthick,
		int N_slices, int N_leaves,
		float SLEWMAX, float GMAX);

int main(void)
{
	int MAX_GRAD_LEN = 50000;
	int Grad_len = 2000;
	float gx[MAX_GRAD_LEN];
	float gy[MAX_GRAD_LEN];
	float gz[MAX_GRAD_LEN];
	float R_accel = 0.5;
	float THETA_accel = 1;
	int N_center = 50;
	float ramp_frac = 1.0/10.0;
	int doXrot = 1;
	int doYrot = 1;
	float SLEWMAX = 15000;
	float GMAX = 2.9;

	float fov = 24; /* cm */
	int dim = 64;
	float dt = 4.0e-6;
	float slthick = 0.8; /* cm */
	int N_slices = 17;
	int N_leaves = 1;
	int N_ramp;

	float tol = 1e-4;
	float slowDown = 1.0;
	int itr_slowDown = 0;

	do {
		for (int n = 0; n < MAX_GRAD_LEN; n++) {
			gx[n] = 0;
			gy[n] = 0;
			gz[n] = 0;
		}
		itr_slowDown++;
		
		Grad_len = round((float)Grad_len * slowDown);
		while (Grad_len % 4 > 0) Grad_len++;
		slowDown = genspiral(gx, gy, gz, Grad_len,
				R_accel, THETA_accel,
				N_center, ramp_frac,
				doXrot, doYrot,
				fov, dim, dt, slthick,
				N_slices, N_leaves,
				SLEWMAX, GMAX);
	} while (pow(slowDown - 1.0, 2) > tol && itr_slowDown <= 50);

	if (itr_slowDown == 50)
		fprintf(stderr,"warning: max iteration for genspiral slowDown reached, slowDown = %f\n", slowDown);

	return 0;
};
