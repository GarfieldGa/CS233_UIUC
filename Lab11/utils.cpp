#include "utils.h"

uint32_t extract_tag(uint32_t address, const CacheConfig& cache_config) {
  // TODO
  uint32_t shift = cache_config.get_num_block_offset_bits() + cache_config.get_num_index_bits();
  return address >> shift;
}

uint32_t extract_index(uint32_t address, const CacheConfig& cache_config) {
  // TODO
  uint32_t curr = address >> cache_config.get_num_block_offset_bits();
  std::size_t mask = (1 << cache_config.get_num_index_bits()) - 1;
  uint32_t final = curr & mask;
  return final;
}

uint32_t extract_block_offset(uint32_t address, const CacheConfig& cache_config) {
  // TODO
  std::size_t mask = (1 << cache_config.get_num_block_offset_bits()) - 1;
  uint32_t final = address & mask;
  return final;
}
