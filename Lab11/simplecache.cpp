#include "simplecache.h"
#include <iostream>

int SimpleCache::find(int index, int tag, int block_offset) {
  // read handout for implementation details
  std::vector< SimpleCacheBlock > curr_set = _cache[index];
  SimpleCacheBlock curr_block;
  for (auto itr = curr_set.begin(); itr != curr_set.end(); ++itr) {
    if ((*itr).tag() == tag) {
      curr_block = *itr;
      break;
    }
  }
  if (curr_block.valid()) {
    return curr_block.get_byte(block_offset);
  } else {
    return 0xdeadbeef;
  }
}

void SimpleCache::insert(int index, int tag, char data[]) {
  // read handout for implementation details
  // keep in mind what happens when you assign in C++ (hint: Rule of Three)
  std::vector< SimpleCacheBlock >* curr_set = &_cache[index];
  SimpleCacheBlock* curr_block = &(curr_set->at(0));
  for (auto itr = curr_set->begin(); itr != curr_set->end(); ++itr) {
    if (!(*itr).valid()) {
      curr_block = &(*itr);
      break;
    }
  }
  curr_block->replace(tag, data);
}
