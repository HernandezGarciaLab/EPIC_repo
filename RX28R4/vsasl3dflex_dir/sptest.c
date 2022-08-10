#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include "genspiral.h"
#include "genviews.h"

#define GRESMAX 50000

float genspiral(float* gx, float* gy, float* gz, int Grad_len,
		float R_accel, float THETA_accel,
		int N_center, float ramp_frac, int isSOS,
		float fov, int dim, float dt, float slthick,
		int N_slices, int N_leaves,
		float SLEWMAX, float GMAX);

int genviews(float* T_0,
		int N_slices, int N_leaves,
		char* rotorder, int doCAIPI,
		float rotAnglex, float rotAngley, float rotAnglez);

int main(void)
{
	int Grad_len = 2000;
	float gx[GRESMAX];
	float gy[GRESMAX];
	float gz[GRESMAX];
	float R_accel = 0.5;
	float THETA_accel = 1;
	int N_center = 50;
	float ramp_frac = 0.75;
	float angleXrot = M_PI * (3 - sqrt(5));
	float angleYrot = M_PI * (3 - sqrt(5));
	float SLEWMAX = 15000;
	float GMAX = 2.9;

	float fov = 24; /* cm */
	int dim = 64;
	float dt = 4.0e-6;
	float slthick = 0.8; /* cm */
	int N_slices = 17;
	int N_leaves = 1;

	int isSOS = (angleXrot > 0.0 || angleYrot > 0.0) ? (0) : (1);
	float angleZrot = M_PI / N_leaves;
	float tol_slowDown = 1e-4;
	float slowDown = 1.0;
	int itr_slowDown = 0;
	do {
		for (int n = 0; n < GRESMAX; n++) {
			gx[n] = 0;
			gy[n] = 0;
			gz[n] = 0;
		}
		itr_slowDown++;
		
		Grad_len = round((float)Grad_len * slowDown);
		while (Grad_len % 4 > 0) Grad_len++;
		slowDown = genspiral(gx, gy, gz, Grad_len,
				R_accel, THETA_accel,
				N_center, ramp_frac, isSOS,
				fov, dim, dt, slthick,
				N_slices, N_leaves,
				SLEWMAX, GMAX);
	} while (pow(slowDown - 1.0, 2) > tol_slowDown && itr_slowDown <= 50);

	if (itr_slowDown == 50)
		fprintf(stderr,"warning: max iteration for genspiral slowDown reached, slowDown = %f\n", slowDown);

	float T_0[9] = {1,0,0,
		0,1,0,
		0,0,1};
	char rotorder[3] = "yxz";
	genviews(T_0,N_slices,N_leaves,rotorder,1,angleXrot,angleYrot,angleZrot);

	return 0;
};
