#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int geneye(int size, float I[]);
int genrotmatR3(int nrots, int ax[3], float ang[3], float R[9]);
int matrixmult(int size1[2], int size2[2], float mat1[], float mat2[], float matr[]);
int assignmat(int nents, float mat[], float matr[]);
int printmat(int size[2], float mat[]);

int geneye(int size, float I[]) {

	int row, col;
	for (row = 0; row<size; row++) {
		for (col = 0; col<size; col++) {
			if (row==col) I[row*size+col] = 1;
			else I[row*size+col] = 0;
		}
	}

	return 0;
}

int genrotmatR3(int nrots, int ax[3], float ang[3], float R[9]) {

	int axis;
	float angle;
	float Rax[9];
	float Rprod[9];
	float Rtot[9];
	geneye(3,Rtot);
	int size[2] = {3,3};

	int k, g;
	for (k = 0; k<nrots; k++) {
		axis = ax[nrots-1-k];
		angle = ang[nrots-1-k];
		memset(Rax,0,sizeof Rax);

		switch (axis) {
			case 0 :
				Rax[0] = 1;
				Rax[4] = cos(angle);
				Rax[5] = -sin(angle);
				Rax[7] = sin(angle);
				Rax[8] = cos(angle);
				break;
			case 1 :
				Rax[0] = cos(angle);
				Rax[2] = sin(angle);
				Rax[4] = 1;
				Rax[6] = -sin(angle);
				Rax[8] = cos(angle);
				break;
			case 2 :
				Rax[0] = cos(angle);
				Rax[1] = -sin(angle);
				Rax[3] = sin(angle);
				Rax[4] = cos(angle);
				Rax[8] = 1;
				break;
			default :
				fprintf(stderr,"Error: Invalid axis name\n");
		}

		matrixmult(size,size,Rax,Rtot,Rprod);
		assignmat(9,Rprod,Rtot);
	
	}

	assignmat(9,Rtot,R);
	
	return 0;
}

int matrixmult(int size1[2], int size2[2], float mat1[], float mat2[], float matr[]) {

	int M = size1[0];
	int N = size1[1];
	int P = size2[1];

	if (size2[0] != N)
		fprintf(stderr,"Error: Incompatible matrix sizes (%d x %d)*(%d x %d)\n", M, N, size2[0], P);

	int row, col, v, idx;
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

int assignmat(int nents, float mat[], float matr[]) {

	int g;
	for (g = 0; g<nents; g++) matr[g] = mat[g];

	return 0;
}

int printmat(int size[2], float mat[]) {

	int M = size[0];
	int N = size[1];

	int row, col;
	for (row = 0; row<M; row++) {
		for (col = 0; col<N; col++)
			fprintf(stderr,"%f \t",mat[row*N + col]);
		fprintf(stderr,"\n");
	}

	return 0;
}
