int genrotmat(char axis, float angle, float* R);
int multmat(int M, int N, int P, float* mat1, float* mat2, float* mat3);
int printmat(int M, int N, float* mat);

int genviews(float T_0[9], float T_all[][9],
		int N_slices, int N_leaves,
		char rotorder[3], int doCAIPI,
		float rotAnglex, float rotAngley, float rotAnglez,
		int readAngsFromFile)
{

	/* Get matrix of rotation angles from file */	
	float filerotAngles[1000][4];
	if (readAngsFromFile) {
		FILE* f_angles = fopen("./SERIOSrotangles.txt","r");
		int i = 0;
		float ax, ay, az, sz;
		while (fscanf(f_angles,"%f %f %f %f\t", &ax, &ay, &az, &sz) != EOF) {
			filerotAngles[i][1] = ax;
			filerotAngles[i][2] = ay;
			filerotAngles[i][3] = az;
			filerotAngles[i++][4] = sz;
		}
		fclose(f_angles);
	}

	/* Determine if trajectory is SOS */
	int isSOS = (rotAnglex > 0.0 || rotAngley > 0.0) ? (0) : (1);
	
	/* Loop through views */
	int leafn, slicen, an, k;
	float xi, psi, phi, kzf;
	float T[9], T_tmp[9];
	float Rx[9], Ry[9], Rz[9];
	float Tz[9] = {1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0};
	char axis;
	FILE* f_kviews = fopen("./kviews.txt","w");
	for (leafn = 0; leafn < N_leaves; leafn++) {
		for (slicen = 0; slicen < N_slices; slicen++) {

			/* Determine kz fraction for current view */
			if (isSOS)
				kzf = 2.0 / (float)N_slices * pow(-1, (float)slicen) * floor((float)(slicen + 1) / 2.0);
			else
				kzf = 1.0;

			/* Determine rotation angles */
			xi = rotAnglex * (float)slicen;
			psi = rotAngley * (float)slicen;
			phi = rotAnglez * (float)leafn;

			/* Add additional stepping/rotation for CAIPI case */
			if (doCAIPI) {
				if (isSOS)
					kzf += 2.0 / (float)N_slices * pow(-1, (float)leafn) * (float)leafn / (float)N_leaves;
				xi += rotAnglex * (float)leafn / (float)N_leaves;
				psi += rotAngley * (float)leafn / (float)N_leaves;
			}

			if (readAngsFromFile) {
				xi = filerotAngles[leafn * N_slices + slicen][1];
				psi = filerotAngles[leafn * N_slices + slicen][2];
				phi = filerotAngles[leafn * N_slices + slicen][3];
				kzf = filtrotAngles[leafn * N_slices + slicen][4];
			}

			/* Generate translation matrix for kz stepping and multiply it to translation matrix */
			Tz[8] = kzf;
			multmat(3,3,3,T_0,Tz,T_tmp);
			for (k = 0; k < 9; k++) T[k] = T_tmp[k];

			/* Generate rotation matrices for all three axises */
			genrotmat('x', xi, Rx);
			genrotmat('y', psi, Ry);
			genrotmat('z', phi, Rz);

			/* Loop through axises and multiply transformation matrix by rotation matrices */
			for (an = 0; an < 3; an++) {
				axis = rotorder[2-an];	
				switch (axis) {
					case 'x' :
						multmat(3,3,3,Rx,T,T_tmp);
						break;
					case 'y' :
						multmat(3,3,3,Ry,T,T_tmp);
						break;
					case 'z' :
						multmat(3,3,3,Rz,T,T_tmp);
						break;
					default :
						fprintf(stderr,"Error: Invalid axis\n");
						break;
				}
				for (k = 0; k < 9; k++) T[k] = T_tmp[k];
			}
			
			/* Print translation matrix to file and save to table*/
			fprintf(f_kviews, "%d \t%d \t%f \t%f \t%f \t%f \t", leafn, slicen, kzf, xi, psi, phi);
			for (k = 0; k < 9; k++) {
				T_all[leafn * N_slices + slicen][k] = T[k];
				fprintf(f_kviews, "%f \t", T[k]);
			}
			fprintf(f_kviews, "\n");

		}
	}
	fclose(f_kviews);

	return 0;
}

int genrotmat(char axis, float angle, float* R) {
	
	switch (axis) {
		case 'x' :
			R[0] = 1.0;
			R[1] = 0.0;
			R[2] = 0.0;
			R[3] = 0.0;
			R[4] = cos(angle);
			R[5] = -sin(angle);
			R[6] = 0.0;
			R[7] = sin(angle);
			R[8] = cos(angle);
			break;
		case 'y' :
			R[0] = cos(angle);
			R[1] = 0.0;
			R[2] = sin(angle);
			R[3] = 0.0;
			R[4] = 1.0;
			R[5] = 0.0;
			R[6] = -sin(angle);
			R[7] = 0.0;
			R[8] = cos(angle);
			break;
		case 'z' :
			R[0] = cos(angle);
			R[1] = -sin(angle);
			R[2] = 0.0;
			R[3] = sin(angle);
			R[4] = cos(angle);
			R[5] = 0.0;
			R[6] = 0.0;
			R[7] = 0.0;
			R[8] = 1.0;
			break;
		default :
			fprintf(stderr,"Error: Invalid axis\n");
			break;
	}

	return 0;
}

int multmat(int M, int N, int P, float* mat1, float* mat2, float* mat3) {
	
	int row, col, v;
	float sum;
	for (row = 0; row < M; row++) {
		for (col = 0; col < P; col++) {
			sum = 0;
			for (v = 0; v < N; v++)
				sum += mat1[row * N + v] * mat2[v * P + col];
			mat3[row * P + col] = sum;
		}
	}

	return 0;
}

int printmat(int M, int N, float* mat) {

	int row, col;
	for (row = 0; row < M; row++) {
		for (col = 0; col < N; col++)
			fprintf(stderr, "%f \t", mat[row * N + col]);
		fprintf(stderr, "\n");
	}

	return 0;
}
