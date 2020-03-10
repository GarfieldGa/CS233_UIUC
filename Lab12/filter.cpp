#include <stdio.h>
#include <stdlib.h>
#include "filter.h"

// modify this code by fusing loops together
void
filter_fusion(pixel_t **image1, pixel_t **image2) {
    for (int i = 1; i < SIZE - 1; i ++) {
        filter1(image1, image2, i);
        if (i < SIZE-3) {
          filter2(image1, image2, i+1);
        }
        if (i >= 6 && i < SIZE) {
          filter3(image2, i-5);
        }
    }
    /*
        for (int i = 2; i < SIZE - 2; i ++) {

        }
    for (int i = 2; i < SIZE - 2; i ++) {

    }

    for (int i = 1; i < SIZE - 5; i ++) {

    }

        for (int i = 1; i < SIZE - 5; i ++) {

        }
        */
}

// modify this code by adding software prefetching
void
filter_prefetch(pixel_t **image1, pixel_t **image2) {
    int tile_size = 30;
    int temporal = 1;
    for (int i = 1; i < SIZE - 1; i ++) {
        __builtin_prefetch(image1[i+tile_size], 0, temporal);
        __builtin_prefetch(image2[i+tile_size], 0, temporal);
        filter1(image1, image2, i);
    }

    for (int i = 2; i < SIZE - 2; i ++) {
      __builtin_prefetch(image1[i+tile_size], 0, temporal);
      __builtin_prefetch(image2[i+tile_size], 0, temporal);
        filter2(image1, image2, i);
    }

    for (int i = 1; i < SIZE - 5; i ++) {
      __builtin_prefetch(image2[i+tile_size], 0, temporal);
        filter3(image2, i);
    }
}

// modify this code by adding software prefetching and fusing loops together
void
filter_all(pixel_t **image1, pixel_t **image2) {
  int tile_size = 30;
  int temporal = 1;
  for (int i = 1; i < SIZE - 1; i ++) {
    __builtin_prefetch(image1[i+tile_size], 0, temporal);
    __builtin_prefetch(image2[i+tile_size], 0, temporal);
      filter1(image1, image2, i);
      if (i < SIZE-3) {
        filter2(image1, image2, i+1);
      }
      if (i >= 6 && i < SIZE) {
        filter3(image2, i-5);
      }
  }
}
