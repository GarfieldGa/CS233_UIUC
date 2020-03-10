#pragma once
#include <stdio.h>
#include "pet.h"

class cat : public pet {
    public:
        cat(const char * name, const char * id) : pet(name, id) {
            puts("Inside cat constructor");
        }

        virtual ~cat() {
            puts("Inside cat destructor");
        }

        virtual void speak() {
            puts("Meow");
        }

        virtual void express_happiness() {
            puts("Purr");
        }
};
