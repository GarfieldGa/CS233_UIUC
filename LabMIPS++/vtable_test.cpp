#include "vtable_classes.h"

void vtable_modify();

int main() {
    foo f; // used for its vtable
    bar b1, b2;
    foo * fp = &b1;
    fp->say_hello();

    void ** f_vtable_ptr_ptr = (void **) &f;
    void ** b1_vtable_ptr_ptr = (void **) &b1;
    *b1_vtable_ptr_ptr = *f_vtable_ptr_ptr;
    fp->say_hello();

    fp = &b2;
    fp->say_hello();
    vtable_modify();
    fp->say_hello();
}
