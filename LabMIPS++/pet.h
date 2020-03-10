#pragma once
#include <stdio.h>
#include "animal.h"

class pet : public animal {
    public:
        pet(const char * name, const char * id) : animal(name), id(id) {
            puts("Inside pet constructor");
        }

        virtual ~pet() {
            puts("Inside pet destructor");
        }

        const char * get_id() {
            return id;
        }

        virtual void express_happiness() = 0;

    private:
        const char * id;
};
