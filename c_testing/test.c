#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include "vsaslmats.h"

int main(void) {

	float mat1[9];
	int rax[3] = {1,0,2};
	float rang[3] = {M_PI/2,M_PI/2,M_PI};
	genrotmatR3(3,rax,rang,mat1);
	int size1[2] = {3,3};

	float mat2[15] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
	int size2[2] = {3,5};

	float mat3[15];
	int size3[2] = {3,5};

	matrixmult(size1,size2,mat1,mat2,mat3);
	printmat(size1,mat1);
	fprintf(stderr,"*\n");
	printmat(size2,mat2);
	fprintf(stderr,"=\n");
	printmat(size3,mat3);

	return 0;
}
