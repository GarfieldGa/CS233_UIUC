#include <stdint.h>
#include <sys/mman.h>
#include <unistd.h>
#include "vtable_classes.h"

void vtable_modify() {
    // these will come in handy
    foo f;
    bar b;

    // page_size will be useful, as will uintptr_t, which allows you to perform arithmetic on pointers
    uintptr_t page_size = sysconf(_SC_PAGESIZE);
}
