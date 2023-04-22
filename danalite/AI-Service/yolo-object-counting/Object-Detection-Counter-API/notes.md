## Open Cv 4.7 Error:

## Downgrade to Opencv 4.6.0.66

cv2.error: OpenCV(4.7.0) /io/opencv/modules/dnn/src/layers/fast_convolution/winograd_3x3s1_f63.cpp:147: error: (-215:Assertion failed) _FX_WINO_IBLOCK == 3 && _FX_WINO_KBLOCK == 4 in function '_fx_winograd_accum_f32'


## Because

This error message indicates that an assertion has failed in the function _fx_winograd_accum_f32 in the OpenCV module winograd_3x3s1_f63.cpp. The assertion checks that the values of the constants _FX_WINO_IBLOCK and _FX_WINO_KBLOCK are equal to 3 and 4, respectively.

This error can occur for a few reasons:

You are using an incorrect version of the OpenCV library: This error has been reported to occur when using an older version of the OpenCV library with newer hardware. Make sure that you are using the latest version of OpenCV.

You are using an incorrect version of the Winograd convolution kernel: The Winograd convolution kernel has different versions for different architectures. Make sure that you are using the correct version for your hardware.

There is a bug in the OpenCV library: If you are using the latest version of OpenCV and the correct version of the Winograd convolution kernel and you are still experiencing this error, it is possible that there is a bug in the library. You can try reporting the issue to the OpenCV developers or searching for a workaround.

I hope this helps! Let me know if you have any further questions or if you need more assistance.