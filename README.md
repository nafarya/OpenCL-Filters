# OpenCL-Filters
Implemented OpenCL-based blur filter for images/frames


# Examples

**Source frame**

<img src="https://github.com/nafarya/OpenCL-Filters/blob/master/examples/frame0015.png">

1. **Gaussian blur filter** 3x3, factor = 1.
```  
  Blur filter 3x3:
    { 0.0, 0.2, 0.0 }
    { 0.2, 0.2, 0.2 }
    { 0.0, 0.2, 0.0 }
```    
    
result of applying filter 3x3 3 times:
<img src="https://github.com/nafarya/OpenCL-Filters/blob/master/examples/blured_3_times(3x3matrix).png">

2. **Gaussian blur filter** 5x5, factor = 13.
```
  Blur filter 5x5:
    { 0, 0, 1, 0, 0 }
    { 0, 1, 1, 1, 0 }
    { 1, 1, 1, 1, 1 }
    { 0, 1, 1, 1, 0 }
    { 0, 0, 1, 0, 0 }
```
result of applying filter 5x5 3 times:
<img src="https://github.com/nafarya/OpenCL-Filters/blob/master/examples/blured_3_times(5x5matrix).png">
