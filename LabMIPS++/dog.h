#pragma once
#include <stdio.h>
#include "pet.h"

class dog : public pet {
    public:
        dog(const char * name, const char * id) : pet(name, id) {
            puts("Inside dog constructor");
        }

        virtual ~dog() {
            puts("Inside dog destructor");
        }

        virtual void speak() {
            puts("Woof");
        }

        virtual void express_happiness() {
            puts("Wag");
        }
};
