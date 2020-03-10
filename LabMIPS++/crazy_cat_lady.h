#pragma once
#include <stdio.h>
#include "cat.h"

class crazy_cat_lady {
    public:
        crazy_cat_lady(const char * cat_name, const char * cat_id, const char * name) :
                favorite_cat(cat_name, cat_id), name(name) {
            puts("Inside crazy_cat_lady constructor");
        }

        ~crazy_cat_lady() {
            puts("Inside crazy_cat_lady destructor");
        }

        const char * get_name() {
            return name;
        }

        void pet_cat() {
            // since favorite_cat is a cat object and not a pointer or reference,
            // the express_happiness method can be called normally (i.e. a non-virtual dispatch)
            favorite_cat.express_happiness();
        }

    private:
        cat favorite_cat;
        const char * name;
};
