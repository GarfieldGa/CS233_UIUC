/**
 * @file
 * Contains an implementation of the extractMessage function.
 */

#include <iostream> // might be useful for debugging
#include <assert.h>
#include "extractMessage.h"

using namespace std;

char *extractMessage(const char *message_in, int length) {
   // Length must be a multiple of 8
   assert((length % 8) == 0);

   // allocates an array for the output
   char *message_out = new char[length];
   for (int i=0; i<length; i++) {
   		message_out[i] = 0;    // Initialize all elements to zero.
	}

	// TODO: write your code here
  for (int i = 0; i < length/8; i++) {
    for (int j = 0; j < 8; j++) {
      int out = 0;
      for (int k = 0; k < 8; k++) {
        if ((7 - k - j) > 0) {
          out += ((message_in[i * 8 + k] & (128 >> j)) >> (7 - k - j));
        } else {
          out += ((message_in[i * 8 + k] & (128 >> j)) << (k + j - 7));
        }
      }
      message_out[(7 - j) + (8 * i)] = out;
    }
  }

	return message_out;
}
