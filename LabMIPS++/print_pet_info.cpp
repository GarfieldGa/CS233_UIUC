#include <stdio.h>
#include "pet.h"

void print_pet_info(pet * p) {
    const char * name = p->get_name();
    puts(name);
    const char * id = p->get_id();
    puts(id);
    p->speak();
    p->express_happiness();
}
