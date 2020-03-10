#include "crazy_cat_lady.h"
#include "dog.h"
#include "print_pet_info.h"

// because naming things is too hard
void do_stuff_with_things() {
    dog d("Sam", "A256");
    print_pet_info(&d);

    crazy_cat_lady l("Tom", "C65536", "Eleanor");
    l.pet_cat();

    // since d is an actual object and not a pointer or reference,
    // its destructor can be called regularly (i.e. a non-virtual dispatch)
}
