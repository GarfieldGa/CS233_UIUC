#pragma once
#include <stdio.h>

class foo {
    public:
        virtual void say_hello() {
            puts("foo says hello");
        }
};

class bar : public foo {
    public:
        virtual void say_hello() {
            puts("bar says hello");
        }
};
