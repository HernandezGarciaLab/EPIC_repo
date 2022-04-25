#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int geneye(int size, float I[]);
int genRyxz(float ax, float ay, float az, float R[9]);
int matrixmult(int M, int N, int P, float mat1[], float mat2[], float matr[]);
int printmat(int M, int N, float mat[]);
int desclaemat(int M, int N, float mat[], float maxval);

#include "seriosmatx.h"

int main(void) {

	float v1[3] = {1,2,3};
	float v2[3] = {0,9,5};
	float v3[1];
	matrixmult(1,3,1,v1,v2,v3);

	printmat(1,3,v1);
	fprintf(stderr,"*\n");
	printmat(3,1,v2);
	fprintf(stderr,"=\n");
	printmat(1,1,v3);
	
	fprintf(stderr,"\nv2 normalized:\n");
	descalemat(3,1,v2,1);
	printmat(3,1,v2);
	fprintf(stderr,"\nv2 in DAQ units:\n");
	descalemat(3,1,v2,(float)pow(2,15));
	printmat(3,1,v2);

	return 0;
}
