/**
 * @file
 * Contains an implementation of the countOnes function.
 */
 #include "countOnes.h"

unsigned countOnes(unsigned input) {
	// TODO: write your code here
	unsigned a1 = input & 85;
	unsigned a2 = (input & (85 << 8)) >> 8;
	unsigned a3 = (input & (85 << 16)) >> 16;
	unsigned a4 = (input & (85 << 24)) >> 24;
	unsigned b1 = input & 170;
	unsigned b2 = (input & (170 << 8)) >> 8;
	unsigned b3 = (input & (170 << 16)) >> 16;
	unsigned b4 = (input & (170 << 24)) >> 24;
	unsigned count1 = a1 + (b1 >> 1);
	unsigned count2 = a2 + (b2 >> 1);
	unsigned count3 = a3 + (b3 >> 1);
	unsigned count4 = a4 + (b4 >> 1);
	a1 = count1 & 51;
	a2 = count2 & 51;
	a3 = count3 & 51;
	a4 = count4 & 51;
	b1 = count1 & 204;
	b2 = count2 & 204;
	b3 = count3 & 204;
	b4 = count4 & 204;
	count1 = a1 + (b1 >> 2);
  count2 = a2 + (b2 >> 2);
	count3 = a3 + (b3 >> 2);
  count4 = a4 + (b4 >> 2);
	a1 = count1 & 15;
	a2 = count2 & 15;
	a3 = count3 & 15;
	a4 = count4 & 15;
	b1 = count1 & 240;
	b2 = count2 & 240;
	b3 = count3 & 240;
	b4 = count4 & 240;
	count1 = a1 + (b1 >> 4);
  count2 = a2 + (b2 >> 4);
	count3 = a3 + (b3 >> 4);
  count4 = a4 + (b4 >> 4);
	input = count1 + count2 + count3 +count4;

	return input;
}
