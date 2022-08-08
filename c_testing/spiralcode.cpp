#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>

float genspiral(float* gx, float* gy, float* gz, int Grad_len,
		float R_accel, float THETA_accel,
		int &N_center, int &N_ramp,
		int doXrot, int doYrot,
		float fov, int dim, float slthick,
		int N_slices, int N_leaves,
		float SLEWMAX, float GMAX);
int conv(float* x, int lenx, float* h, int lenh, float* y);
int recenter(float* x, int lenx, float xmin, float xmax);
int diff(float* x, int lenx, float di, float* y);
float getmaxabs(float *x, int lenx);

int main(void)
{
	int Grad_len = 4000;
	float gx[Grad_len];
	float gy[Grad_len];
	float gz[Grad_len];
	float R_accel = 0.5;
	float THETA_accel = 1;
	int N_center = 50;
	int N_ramp = 1000;
	int doXrot = 0;
	int doYrot = 0;

	float fov = 24; /* cm */
	int dim = 64;
	float slthick = 0.8; /* cm */
	int N_slices = 17;
	int N_leaves = 1;

	genspiral(gx, gy, gz, Grad_len, R_accel, THETA_accel,
			N_center, N_ramp, doXrot, doYrot, fov, dim, slthick, N_slices, N_leaves, 15000, 2.9);

	return 0;
};

float genspiral(float* gx, float* gy, float* gz, int Grad_len,
		float R_accel, float THETA_accel,
		int &N_center, int &N_ramp,
		int doXrot, int doYrot,
		float fov, int dim, float slthick,
		int N_slices, int N_leaves,
		float SLEWMAX, float GMAX)
{	
	/* Distribute points */
	if (N_ramp % 2 > 0) { /* if N_ramp is not even, donate a point to the center */
		N_ramp--;
		N_center++;
	}
	int N_points = Grad_len - N_center;
	if (N_points % 2 > 0) { /* if N_points is not even, donate a point to the center */
		N_points--;
		N_center++;
	}
	
	/* Initialize loop variables */
	int n;
	float dn;
	float val;
	
	/* Calculate Kspace information */
	float gamma = 26754.0 / 2.0 / M_PI;
	float dt = 4.0e-6;
	float dk = 1.0 / fov;
	float Kxymax = (float)dim / fov / 2;
	float Kzmax = (doXrot || doYrot) ? (Kxymax) : (dim / (float)(slthick * N_slices) / 2.0);
	float N_turns = Kxymax / dk / 2.0 * THETA_accel / (float)N_leaves + 1;

	/* Create smoothing kernel */
	float kern[N_ramp];
	dn = 2.0 / (float)N_ramp;
	for (n = 0; n < N_ramp; n++) {
		val = exp(-pow(M_PI * dn * (n - (float)(N_ramp - 1) / 2.0), 2 ));
		kern[n] = val;
	}
	
	/* Define piece-wise unsmoothed radius function for traj polar coordinates */
	float r_spiky[Grad_len - N_ramp];
	for (n = 0; n < Grad_len - N_ramp; n++) r_spiky[n] = 0.0;
	dn = 2.0 / ((float)N_points - 2.0 * N_ramp);
	for (n = 1; n < N_points / 2 - N_ramp; n++) {
		val = pow(1.0 - (float)n * dn, R_accel);
		r_spiky[n] = val;
		r_spiky[N_points + N_center - N_ramp - 1 - n] = val;
	} 
	/* Convolve r with kernel to produced smoothed radius function */
	float r[Grad_len];
	conv(r_spiky, Grad_len - N_ramp, kern, N_ramp, r);
	recenter(r, Grad_len, 0.0, Kxymax);
	
	/* Define piece-wise angle function for traj polar coordinates */
	float theta[Grad_len];
	for (n = 0; n < Grad_len; n++) theta[n] = 0.0;
	dn = 2.0 / (float)N_points;
	for (n = 0; n < N_points/2; n++) {
		val = fabs(N_turns * M_PI * (float)(n - N_points/2) * dn);
		theta[n] = val;
		theta[N_points + N_center - n] = val + M_PI;
	}

	/* Translate polar coordinates into cartesian */
	float kx[Grad_len], ky[Grad_len], kz[Grad_len];
	for (n = 0; n < Grad_len; n++) {
		kx[n] = r[n] * cos(theta[n]);
		ky[n] = r[n] * sin(theta[n]);
		kz[n] = 0;
	}
	if ( !(doXrot || doYrot) ) { /* Create kz ramp for SOS case */
		float kz_spiky[Grad_len - N_ramp];
		kz_spiky[0] = 0.0;
		kz_spiky[Grad_len - N_ramp - 1] = 0.0;
		for (n = 1; n < Grad_len - N_ramp - 1; n++) kz_spiky[n] = 1.0;
		conv(kz_spiky, Grad_len - N_ramp, kern, N_ramp, kz);
		recenter(kz, Grad_len, 0.0, Kzmax);
	}

	/* Calculate gradient waveforms by differentiating trajectory */
	diff(kx, Grad_len, dt*gamma, gx);
	diff(ky, Grad_len, dt*gamma, gy);
	diff(kz, Grad_len, dt*gamma, gz);

	/* Calculate slew waveforms by differentiating gradient */
	float sx[Grad_len];
	float sy[Grad_len];
	float sz[Grad_len];
	diff(gx, Grad_len, dt, sx);
	diff(gy, Grad_len, dt, sy);
	diff(gz, Grad_len, dt, sz);

	/* Determine slowFactor from maximum gradient and slew amplitudes */
	float slewmax[3] = {getmaxabs(sx, Grad_len), getmaxabs(sy, Grad_len), getmaxabs(sz, Grad_len)};
	float gmax[3] = {getmaxabs(gx, Grad_len), getmaxabs(gy, Grad_len), getmaxabs(gz, Grad_len)};
	float slowFactor = fmax(getmaxabs(slewmax, 3) / SLEWMAX, getmaxabs(gmax, 3) / GMAX);

	fprintf(stderr,"Slowfactor = %f\n", slowFactor);

	/* Print trajectories to file */
	FILE* f_ktraj_sph = fopen("./ktraj_sph.txt","w");
	FILE* f_ktraj_cart = fopen("./ktraj_cart.txt","w");
	FILE* f_grad = fopen("./grad.txt","w");	
	FILE* f_slew = fopen("./slew.txt","w");
	for (n = 0; n < Grad_len; n++) {
		fprintf(f_ktraj_sph, "%f \t%f\n", r[n], theta[n]);
		fprintf(f_ktraj_cart, "%f \t%f \t%f\n", kx[n], ky[n], kz[n]);
		fprintf(f_grad, "%f \t%f \t%f\n", gx[n], gy[n], gz[n]);
		fprintf(f_slew, "%f \t%f \t%f\n", sx[n], sy[n], sz[n]);
	}
	fclose(f_ktraj_sph);
	fclose(f_ktraj_cart);
	fclose(f_grad);
	fclose(f_slew);
	
	return slowFactor;
};

int conv(float* x, int lenx, float* h, int lenh, float* y)
{
	int leny = lenx + lenh;
	int i, j;
	int h_start, x_start, x_end;
	float val;

	for (i = 0; i < leny; i++) {
		x_start = fmax(0, i-lenh+1);
		x_end = fmin(i+1, lenx);
		h_start = fmin(i, lenh-1);

		val = 0;
		for (j = x_start; j < x_end; j++)
			val += h[h_start--] * x[j];

		y[i] = val;
	}

	return 0;
};

int recenter(float* x, int lenx, float xmin, float xmax)
{	
	int i;
	float recordmax = x[0];
	float recordmin = x[0];
	for (i = 1; i < lenx; i++) {
		if (x[i] > recordmax) recordmax = x[i];
		if (x[i] < recordmin) recordmin = x[i];
	}

	for (i = 1; i < lenx; i++) {
		x[i] = (x[i] - recordmin) / (recordmax - recordmin) * (xmax - xmin) - xmin;
	}
	
	return 0;
};

int diff(float* x, int lenx, float di, float* y)
{
	int i;
	y[0] = 0;
	for (i = 1; i < lenx - 1; i++)
		y[i] = (x[i] - x[i-1]) / di;
	y[lenx - 1] = 0;

	return 0;
};

float getmaxabs(float *x, int lenx)
{
	int i;
	float recordmax = x[0];
	for (i = 1; i < lenx; i++)
		if (fabs(x[i]) > recordmax) recordmax = fabs(x[i]);

	return recordmax;
};
