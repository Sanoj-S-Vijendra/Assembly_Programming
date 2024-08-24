#include "vector.h"
#include <stdio.h>

void init_v(vector *v) {
    v->buff_size = 0;
    v->size = 0;
    v->ptr = NULL;
}

void delete_v(vector *v) {
    free(v->ptr);
    v->buff_size = 0;
    v->size = 0;
    v->ptr = NULL;
}

void resize_v(vector *v, uint64_t new_size) {
    v->ptr = realloc(v->ptr, new_size * sizeof(uint64_t));
    v->buff_size = new_size;
}

uint64_t *get_element_v(const vector *v, uint64_t index) {
    return &(v->ptr[index]);
}

void push_v(vector *v, uint64_t element) {
    if (v->size == v->buff_size) {
        // Resize the vector
        resize_v(v, 2 * v->buff_size + 1);
    }

    v->ptr[v->size] = element;
    v->size++;
}

uint64_t pop_v(vector *v) {
    if (v->size > 0) {
        v->size--;
        return v->ptr[v->size];
    } else {
        // Vector is empty
        // You might want to handle this case differently
        return 0; // Assuming 0 as a default value
    }
}

uint64_t size_v(const vector *v) {
    return v->size;
}

// main.c
#include "vector.h"

int main() {
    vector myVector;
    init_v(&myVector);

    // Your vector operations go here
    for(int i=0; i<25; ++i)
    {
    push_v(&myVector, i+1);
    }
    for(int i=0; i<24; ++i)
    {
    uint64_t l = pop_v(&myVector);
    printf("%lu\n",l);
    }
    uint64_t l = size_v(&myVector);
    printf("%lu\n",l);
    delete_v(&myVector);
    return 0;
}
