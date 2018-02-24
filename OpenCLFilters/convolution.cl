__constant sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP_TO_EDGE | CLK_FILTER_NEAREST;


__kernel void convolution_local(__read_only image2d_t src, __write_only image2d_t output,  __constant float *convArr, int convSize, float factor) {
	
	
	const int WS = 8;

	const int X = get_group_id(0);
	const int Y = get_group_id(1);

	const int BLOCK_X = X * WS + WS;
	const int BLOCK_Y = Y * WS + WS;
	
	const int f  =  get_local_id(0);
	const int f1 =  get_local_id(1);

	const int HALFCONVSZ = (convSize / 2);
	

	__local float4 B[WS*3*WS*3];

	for (int i = -1; i <= 1; i++) {
		for (int j = -1; j <= 1; j++) {	
			B[((i+1)*WS+f) * (WS*3) +(j+1)*WS+f1] = read_imagef(src, sampler, (int2)(BLOCK_X+f1 + (j*WS), BLOCK_Y+f + (i*WS)));
		}
	}  
	barrier(CLK_LOCAL_MEM_FENCE);
	
	float4 convPix = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
	for (int conv_i = -HALFCONVSZ; conv_i <= HALFCONVSZ; conv_i++) {
			for (int conv_j = -HALFCONVSZ; conv_j <= HALFCONVSZ; conv_j++) {
				float4 px = B[(f+conv_i+WS) * (WS*3) + f1+conv_j+WS];
				convPix += px * convArr[(conv_i+1)*convSize+(conv_j+1)];
			}
		}
	barrier(CLK_LOCAL_MEM_FENCE);
	write_imagef(output, (int2)(BLOCK_X+f1, BLOCK_Y+f), convPix / factor);
	
}



__kernel void convolution_global(__read_only image2d_t src, __write_only image2d_t output,  __constant float *convArr, int convSize, float factor) {
	const int BLOCKSIZE = 8;
	const int X = get_global_id(0);
	const int Y = get_global_id(1);

	const int BLOCK_X = X * BLOCKSIZE + BLOCKSIZE;
	const int BLOCK_Y = Y * BLOCKSIZE + BLOCKSIZE;

	const int HALFCONVSZ = (convSize / 2);

	for (int i = 0; i < BLOCKSIZE; i++) {
		for (int j = 0; j < BLOCKSIZE; j++) {
				float4 convPix = (float4)(0.0f, 0.0f, 0.0f, 0.0f);
				for (int conv_i = -HALFCONVSZ; conv_i <= HALFCONVSZ; conv_i++) {
					for (int conv_j = -HALFCONVSZ; conv_j <= HALFCONVSZ; conv_j++) {
						float4 px = read_imagef(src, sampler, (int2)(BLOCK_X+i+conv_j, BLOCK_Y+j+conv_i));
						convPix += px * convArr[(conv_i+1)*convSize+(conv_j+1)];
					}
				}
				write_imagef(output, (int2)(BLOCK_X+i, BLOCK_Y+j), convPix / factor);		
		}
	}
}






