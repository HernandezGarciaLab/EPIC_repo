#include<stdio.h>
#include<stdlib.h>
#include<math.h>

int eye3x3mat(float **A[3][3])
{
	int i,j;
	for (i=0;i<3;i++) {
		for (j=0;j<3;j++) {
			if (i==j)
				&*A[i][j] = 1;
			else
				&*A[i][j] = 0;
		}
	}
}

/*
int mult3x3mat(float *A[3][3], float *B[3][3], float *C[3][3])
{
	int i,j,k;
	for (i=0;i<3;i++) {
		for (j=0;j<3;j++) {
			C[i][j] = 0;
			for (k=0;k<3;k++) {
				float aik = A[i][k];
				float bkj = B[k][j];
				C[i][j] = C[i][j] + (aik * bkj);
			}
		}
	}

	return 1;
}
*/

int print3x3mat(float M[3][3])
{
	int row, col;
	for (row=0;row<3;row++) {
		for (col=0;col<3;col++) {
			printf("%f ", M[row][col]);
		}
		printf("\n");
	}
	return 1;
}

int genrotmat(float ax, float ay, float az)
{
	double a[3] = {(double)ax,(double)ay,(double)az};
	float cosa[3], sina[3];
	int axis;
	for (axis=0;axis<3;axis++) {
		cosa[axis] = (float)cos(a[axis]);
		sina[axis] = (float)sin(a[axis]);
	}

	float Ryxz[3][3] = {0};
	eye3x3mat(&&Ryxz);

	float Rx[3][3] = {
		{1,0,0},
		{0,cosa[0],-sina[0]},
		{0,sina[0],cosa[0]}
	};

	float Ry[3][3] = {
		{cosa[1],0,sina[1]},
		{0,1,0},
		{-sina[1],0,cosa[1]},
	};

	float Rz[3][3] = {
		{cosa[2],-sina[2],0},
		{sina[2],cosa[2],0},
		{0,0,1}
	};

	print3x3mat(Ryxz);

	return 1;
}

int main()
{	
	float R[3][3];
	float rotAngle[3] = {3.145};
	
	genrotmat(3.145,0,3.145);

	return 1;
}
