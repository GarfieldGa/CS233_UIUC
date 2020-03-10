#include "cachesimulator.h"

Cache::Block* CacheSimulator::find_block(uint32_t address) const {
  /**
   * TODO
   *
   * 1. Use `_cache->get_blocks_in_set` to get all the blocks that could
   *    possibly have `address` cached.
   * 2. Loop through all these blocks to see if any one of them actually has
   *    `address` cached (i.e. the block is valid and the tags match).
   * 3. If you find the block, increment `_hits` and return a pointer to the
   *    block. Otherwise, return NULL.
   */
  uint32_t tag = extract_tag(address, _cache->get_config());
  uint32_t index = extract_index(address, _cache->get_config());
  std::vector<Cache::Block*> blocks = _cache->get_blocks_in_set(index);
  for (auto itr = blocks.begin(); itr != blocks.end(); ++itr) {
    if ((*itr)->get_tag() == tag && (*itr)->is_valid()) {
      _hits++;
      return *itr;
    }
  }
  return NULL;
}

Cache::Block* CacheSimulator::bring_block_into_cache(uint32_t address) const {
  /**
   * TODO
   *
   * 1. Use `_cache->get_blocks_in_set` to get all the blocks that could
   *    cache `address`.
   * 2. Loop through all these blocks to find an invalid `block`. If found,
   *    skip to step 4.
   * 3. Loop through all these blocks to find the least recently used `block`.
   *    If the block is dirty, write it back to memory.
   * 4. Update the `block`'s tag. Read data into it from memory. Mark it as
   *    valid. Mark it as clean. Return a pointer to the `block`.
   */
  uint32_t tag = extract_tag(address, _cache->get_config());
  uint32_t index = extract_index(address, _cache->get_config());
  std::vector<Cache::Block*> blocks = _cache->get_blocks_in_set(index);
  for (auto itr = blocks.begin(); itr != blocks.end(); ++itr) {
    if (!(*itr)->is_valid()) {
      (*itr)->set_tag(tag);
      (*itr)->read_data_from_memory(_memory);
      (*itr)->mark_as_valid();
      (*itr)->mark_as_clean();
      return *itr;
    }
  }
  uint32_t LRU = blocks[0]->get_last_used_time();
  Cache::Block* least_used = blocks[0];
  for (auto itr = blocks.begin(); itr != blocks.end(); ++itr) {
    if ((*itr)->get_last_used_time() < LRU) {
      LRU = (*itr)->get_last_used_time();
      least_used = *itr;
    }
  }
  if (least_used->is_dirty()) {
    least_used->write_data_to_memory(_memory);
  }
  least_used->set_tag(tag);
  least_used->read_data_from_memory(_memory);
  least_used->mark_as_valid();
  least_used->mark_as_clean();
  return least_used;
}

uint32_t CacheSimulator::read_access(uint32_t address) const {
  /**
   * TODO
   *
   * 1. Use `find_block` to find the `block` caching `address`.
   * 2. If not found, use `bring_block_into_cache` cache `address` in `block`.
   * 3. Update the `last_used_time` for the `block`.
   * 4. Use `read_word_at_offset` to return the data at `address`.
   */
  uint32_t block_offset = extract_block_offset(address, _cache->get_config());
  Cache::Block* block = find_block(address);
  if (block == NULL) {
    block = bring_block_into_cache(address);
  }
  _use_clock++;
  block->set_last_used_time(_use_clock.get_count());
  return block->read_word_at_offset(block_offset);
}

void CacheSimulator::write_access(uint32_t address, uint32_t word) const {
  /**
   * TODO
   *
   * 1. Use `find_block` to find the `block` caching `address`.
   * 2. If not found
   *    a. If the policy is write allocate, use `bring_block_into_cache`.
   *    a. Otherwise, directly write the `word` to `address` in the memory
   *       using `_memory->write_word` and return.
   * 3. Update the `last_used_time` for the `block`.
   * 4. Use `write_word_at_offset` to to write `word` to `address`.
   * 5. a. If the policy is write back, mark `block` as dirty.
   *    b. Otherwise, write `word` to `address` in memory.
   */
  uint32_t block_offset = extract_block_offset(address, _cache->get_config());
  Cache::Block* block = find_block(address);
  if (block == NULL) {
    if (_policy.is_write_allocate()) {
      block = bring_block_into_cache(address);
    } else {
      _memory->write_word(address, word);
      return;
    }
  }
  _use_clock++;
  block->set_last_used_time(_use_clock.get_count());
  block->write_word_at_offset(word, block_offset);
  if (_policy.is_write_back()) {
    block->mark_as_dirty();
  } else {
    block->write_data_to_memory(_memory);
  }
}
