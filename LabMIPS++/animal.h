#pragma once // because header guards are too mainstream
#include <stdio.h>

class animal {
    public:
        animal(const char * name) : name(name) {
            puts("Inside animal constructor");
        }

        virtual ~animal() {
            puts("Inside animal destructor");
        }

        const char * get_name() {
            return name;
        }

        virtual void speak() = 0;

    private:
        const char * name;
};
