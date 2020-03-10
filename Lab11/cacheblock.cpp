#include "cacheblock.h"

uint32_t Cache::Block::get_address() const {
  // TODO
  uint32_t shift = _cache_config.get_num_block_offset_bits() + _cache_config.get_num_index_bits();
  uint32_t tag = _tag << shift;
  uint32_t index = _index << _cache_config.get_num_block_offset_bits();
  return tag ^ index;
}
