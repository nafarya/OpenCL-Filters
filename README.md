# OpenCL-Filters
Implemented OpenCL-based convolution filter(used for blurring, sharpening, embossing, edge detection, and more).


# Profiler INFO

- **GPU:** AMD Radeon HD 8750M

- [CodeXL Profiler information](https://github.com/nafarya/OpenCL-Filters/blob/master/CodeXL_Profiler_Feb-24-2018_16-54-17.csv)

# Examples for blurring

**Source frame**, resolution: 1280x720

<img src="https://github.com/nafarya/OpenCL-Filters/blob/master/examples/frame0015.png">

1. **Boxblur filter(normalized)** 3x3, factor = 1.
```  
  BoxBlur filter 3x3:
       { 0.0, 0.2, 0.0 }
       { 0.2, 0.2, 0.2 }
       { 0.0, 0.2, 0.0 }
```    
    
result of applying filter 3x3 3 times:
<img src="https://github.com/nafarya/OpenCL-Filters/blob/master/examples/blured_3_times(3x3matrix).png">

2. **Boxblur filter(normalized)** 5x5, factor = 1/13.
```
  BoxBlur filter 5x5:
        { 0, 0, 1, 0, 0 }
        { 0, 1, 1, 1, 0 }
   1/13 { 1, 1, 1, 1, 1 }
        { 0, 1, 1, 1, 0 }
        { 0, 0, 1, 0, 0 }
```
result of applying filter 5x5 3 times:
<img src="https://github.com/nafarya/OpenCL-Filters/blob/master/examples/blured_3_times(5x5matrix).png">
