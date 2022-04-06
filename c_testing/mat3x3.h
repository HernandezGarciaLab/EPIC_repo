//========== Inclusions ==========//

#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>

//========== End of inclusions ==========//



//========== Function declarations ==========//

int geneye3x3(float result[3][3]);
int genrot3x3(int axises[], float angles[], float result[3][3]);
int assignmat3x3(float mat1[3][3], float mat2[3][3]);
int printmat3x3(float mat[3][3]);
int addmat3x3(float mat1[3][3], float mat2[3][3], float result[3][3]);
int elmultmat3x3(float mat1[3][3], float mat2[3][3], float result[3][3]);
int multmat3x3(float mat1[3][3], float mat2[3][3], float result[3][3]);

//========== End of function declarations =========//



//========== Function definitions ==========//

int geneye3x3(float result[3][3]) {
// Function geneye3x3 by David Frey
// 
// 	Creates a 3x3 Identity matrix
//
// Inputs:
// 	result: 3x3 array of type float (function will write to the array)
//

	// Loop through each element and assign 1 if the entrant is diagonal, 0 otherwise:
	int row, col;
	for (row = 0; row < 3; row++) {
		for (col = 0; col < 3; col++) {
			if (row == col)
				result[row][col] = 1;
			else
				result[row][col] = 0;
		}
	}  

	return 0;
}

int genrot3x3(int axises[], float angles[], float result[3][3]) {
// Function genrot3x3 by David Frey
// 
// 	Creates a 3x3 rotation matrix given axis and angles in specified order
//
// Inputs:
// 	axises: char array of axises to rotate about in order of multiplication (i.e. 'zxy' for Rz*Rx*Ry)
// 	angles: float array of rotation angles corresponding to axises of rotation
// 	result: 3x3 array of type float (function will write to the array)
//

	// Get number of angles from length of axises array:
	int N_angles = (int)sizeof(axises)/(int)sizeof(axises[0]);

	// Initialize variables:
	int axis;
	float angle;
	float Rax[3][3];
	float Rtotal[3][3];
	float Rprod[3][3];
	geneye3x3(Rtotal); // Initialize Rtotal to be an identity matrix

	int k;
	for (k = 0; k < 3; k++) { // Loop through rotation angles
		axis = axises[N_angles-1-k];
		angle = angles[N_angles-1-k];
		memset(Rax, 0, sizeof Rax); // Reset Rax to all zeros
		switch (axis) {
			case 0 :
				/* For rotation about x-axis:
				 R = | 1     0        0    |
				     | 0  cos(xi) -sin(xi) |
				     | 0  sin(xi)  cos(xi) |
				*/
				  	
				Rax[0][0] = 1;
				Rax[1][1] = cos(angle);
				Rax[1][2] = -sin(angle);
				Rax[2][1] = sin(angle);
				Rax[2][2] = cos(angle);
				break;
			case 1 :
				/* For rotation about y-axis:
                                 R = | cos(psi)  0  sin(psi) |
                                     |    0      1     0     |
                                     | -sin(psi) 0  cos(psi) |
                                */

				Rax[0][0] = cos(angle);
				Rax[0][2] = sin(angle);
				Rax[1][1] = 1;
				Rax[2][0] = -sin(angle);
				Rax[2][2] = cos(angle);
				break;
			case 2 :
				/* For rotation about z-axis:
				 R = | cos(phi) -sin(phi) 0 |
				     | sin(phi) cos(phi)  0 |
				     |    0        0      1 |
				*/

				Rax[0][0] = cos(angle);
				Rax[0][1] = -sin(angle);
				Rax[1][0] = sin(angle);
				Rax[1][1] = cos(angle);
				Rax[2][2] = 1;
				break;
			default :
				// Error if invalid axis name
				printf("\nError: Invalid axis name\n");
				exit(EXIT_FAILURE);
		}
		// Multiply rotation matrices and assign to Rtotal:
		multmat3x3(Rax,Rtotal,Rprod);
		assignmat3x3(Rtotal,Rprod);
	}
	// Assign result:
	assignmat3x3(result,Rtotal);

	return 0;
}

int assignmat3x3(float mat1[3][3], float mat2[3][3]) {
// Function assignmat3x3 by David Frey
//
// 	Assigns a 3x3 array with the same elements as another array, since C does not allow
// 		multi-element assignments of arrays after initialization
//
// Inputs:
// 	mat1: Matrix to be assigned
// 	mat2: Matrix to copy
//

	// Loop through each element and copy it over:
	int row, col;
	for (row = 0; row < 3; row++) {
		for (col = 0; col < 3; col++)
			mat1[row][col] = mat2[row][col];
	}

	return 0;
}

int printmat3x3(float mat[3][3]) {
// Function printmat3x3 by David Frey
//
// 	Prints 3x3 matrix to terminal for readability and debugging
//
// Inputs:
// 	mat: matrix to print
//

	// Loop through each entrant
	int row, col;
	for (row = 0; row < 3; row++) {
		for (col = 0; col < 3; col++)
			printf("%f\t",mat[row][col]); // Seperate cols by tab
		printf("\n"); // Seperate rows by newline
	}

	return 0;
}

int addmat3x3(float mat1[3][3], float mat2[3][3], float result[3][3]) {
// Function addmat3x3 by David Frey
//
// 	Adds two 3x3 matrices
//
// Inputs:
// 	mat1: first matrix to sum
// 	mat2: second matrix to sum
// 	result: sum of first and second matrices (function will write to the array)
//

	// Loop through each entrant and add them together:
	int row, col;
	for (row = 0; row < 3; row++) {
		for (col = 0; col < 3; col++)
			result[row][col] = mat1[row][col] + mat2[row][col];
	}

	return 0;
}

int elmultmat3x3(float mat1[3][3], float mat2[3][3], float result[3][3]) {
// Function elmultmat3x3 by David Frey
//
// 	Performs element-wise multiplication of two 3x3 matrices (like .* operation in matlab)
//
// Inputs:
// 	mat1: first matrix to multiply
// 	mat2: second matrix to multiply
// 	result: element-wise product of first and second matrices (function will write to the array)
//

	// Loop through each element and multiply them together:
	int row, col;
	for (row = 0; row < 3; row++) {
		for (col = 0; col < 3; col++)
			result[row][col] = mat1[row][col] * mat2[row][col];		
	}

	return 0;
}

int multmat3x3(float mat1[3][3], float mat2[3][3], float result[3][3]) {
// Function multmat3x3 by David Frey
//
// 	Performs true matrix multiplication of two 3x3 matrices
//
// Inputs:
// 	mat1: first matrix to multiply
// 	mat2: second matrix to multiply
// 	result: matrix product of first and secon matrix (function will write to the array)
//

	// Initialize variable:
	float sum;

	// Loop through rows and columns
	int row, col, k;
	for (row = 0; row < 3; row++) {
		for (col = 0; col < 3; col++) {
			// Perform dot prouct of corresponding row and column vectors
			sum = 0;
			for (k = 0; k < 3; k++)
				sum += mat1[row][k] * mat2[k][col];
			// Assign dot product to the result
			result[row][col] = sum;
		}
	}

	return 0;
}

//========== End of function definitions ==========//
