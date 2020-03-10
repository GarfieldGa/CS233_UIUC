#include <stdio.h>

int array[] = { 9, 1, 2, 6, 5, 3, 25, -4, -55, 71, 8 };
int array_length = sizeof(array) / sizeof(*array);

typedef int (*compare_fn)(int, int);

void isort(int * array, int length, compare_fn compare) {
    for (int i = 1; i < length; ++i) {
        int curr = array[i];
        int j;
        for (j = i; j > 0 && compare(curr, array[j - 1]) < 0; --j) {
            array[j] = array[j - 1];
        }
        array[j] = curr;
    }
}

int ascending(int x, int y) {
    return -(x < y) | (x > y);
}

int descending(int x, int y) {
    return -(x > y) | (x < y);
}

int even_odd(int x, int y) {
    int x_odd = x & 1;
    int y_odd = y & 1;
    if (x_odd == y_odd) {
        return ascending(x, y);
    } else {
        return x_odd * 2 - 1;
    }
}

void print_array(int * array, int length) {
    int i;
    for (i = 0; i < length - 1; ++i) {
        printf("%d ", array[i]);
    }
    printf("%d\n", array[i]);
}

int main() {
    isort(array, array_length, ascending);
    print_array(array, array_length);

    isort(array, array_length, descending);
    print_array(array, array_length);

    isort(array, array_length, even_odd);
    print_array(array, array_length);
}
