#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int geneye(int size, float I[]) {

	int row, col;
	for (row = 0; row<size; row++) {
		for (col = 0; col<size; col++)
			I[row*size+col] = (row==col) ? (1) : (0);
	}
	
	return 0;
}

int multiplymatrix(int M, int N, int P, float mat1[], float mat2[], float matr[]) {

	int row, col, v;
	float sum;
	for (row = 0; row < M; row++) {
		for (col = 0; col < P; col++) {
			sum = 0;
			for (v = 0; v < N; v++)
				sum += mat1[row*N + v] * mat2[v*P + col];
			matr[row*P+col] = sum;
		}
	}

	return 0;
}

int genRyxz(float ax, float ay, float az, float R[9]) {

	float R_tmp[9];

	float Rx[9] = {
		1,		0,		0,
		0,		cos(ax),	-sin(ax),
		0,		sin(ax),	cos(ax)
	};
	
	float Ry[9] = {
		cos(ay),	0,		sin(ay),
		0,		1,		0,
		-sin(ay),	0,		cos(ay)
	};

	float Rz[9] = {
		cos(az),	-sin(az),	0,
		sin(az),	cos(az),	0,
		0,		0,		1
	};

	multiplymatrix(3,3,3,Rx,Rz,R_tmp);
	multiplymatrix(3,3,3,Ry,R_tmp,R);

	return 0;
}

int printmatrix(int M, int N, float mat[]) {

	int row, col;
	for (row = 0; row<M; row++) {
		for (col = 0; col<N; col++)
			fprintf(stderr,"%f \t",mat[row*N + col]);
		fprintf(stderr,"\n");
	}

	return 0;
}

int scalematrix(int M, int N, float mat[], float maxval) {

	float max = 0;
	int k;
	for (k = 0; k<M*N; k++)
		if (fabs(mat[k])>max) max = fabs(mat[k]);

	for (k = 0; k<M*N; k++)
		mat[k] *= maxval/max;

	return 0;
}
