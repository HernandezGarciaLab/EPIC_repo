#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include "mat3x3.h"

int main(void) {

	float xi = M_PI/4;
	float psi = M_PI/4;
	float phi = M_PI;

	printf("Angles:\n\txi = %f\n\tpsi = %f\n\tphi = %f\n",xi,psi,phi);

	int axises[3] = {1,0,2};
	float angles[3] = {psi,xi,phi};
	float R[3][3];
	genrot3x3(axises,angles,R);

	printf("\nRotation matrix:\n");
	printmat3x3(R);
	
	return 0;
}
