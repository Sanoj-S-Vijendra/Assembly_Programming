#include "vector.h"
#include "heap.h"
#include <stdio.h>

void init_h(heap *h) {
    init_v(&(h->arr));
}

void delete_h(heap *h) {
    delete_v(&(h->arr));
}

uint64_t size_h(const heap *h) {
    return size_v(&(h->arr));
}

void insert_h(heap *h, uint64_t element) {
    push_v(&(h->arr), element);

    // Maintain the heap property
    uint64_t idx = size_h(h) - 1;
    while (idx > 0) {
        uint64_t parent_idx = (idx - 1) / 2;
        if (h->arr.ptr[idx] > h->arr.ptr[parent_idx]) {
            // Swap with the parent if the heap property is violated
            uint64_t temp = h->arr.ptr[idx];
            h->arr.ptr[idx] = h->arr.ptr[parent_idx];
            h->arr.ptr[parent_idx] = temp;

            // Move up the tree
            idx = parent_idx;
        } else {
            // The heap property is satisfied
            break;
        }
    }
}

uint64_t get_max(const heap *h) {
    if (size_h(h) > 0) {
        return h->arr.ptr[0];
    } else {
        // Heap is empty
        // You might want to handle this case differently
        return 0; // Assuming 0 as a default value
    }
}

uint64_t pop_max(heap *h) {
    if (size_h(h) == 0) {
        // Heap is empty
        // You might want to handle this case differently
        return 0; // Assuming 0 as a default value
    }

    // Swap the root with the last element
    uint64_t max_val = h->arr.ptr[0];
    h->arr.ptr[0] = h->arr.ptr[size_h(h) - 1];
    h->arr.size--;

    // Maintain the heap property
    uint64_t idx = 0;
    while (1) {
        uint64_t left_child_idx = 2 * idx + 1;
        uint64_t right_child_idx = 2 * idx + 2;
        uint64_t largest = idx;

        if (left_child_idx < size_h(h) && h->arr.ptr[left_child_idx] > h->arr.ptr[largest]) {
            largest = left_child_idx;
        }

        if (right_child_idx < size_h(h) && h->arr.ptr[right_child_idx] > h->arr.ptr[largest]) {
            largest = right_child_idx;
        }

        if (largest != idx) {
            // Swap with the larger child if the heap property is violated
            uint64_t temp = h->arr.ptr[idx];
            h->arr.ptr[idx] = h->arr.ptr[largest];
            h->arr.ptr[largest] = temp;

            // Move down the tree
            idx = largest;
        } else {
            // The heap property is satisfied
            break;
        }
    }

    return max_val;
}


int main() {
    // Example using vector
    vector v;
    init_v(&v);

    // Push elements into the vector
    for (uint64_t i = 1; i <= 5; i++) {
        push_v(&v, i * 10);
    }

    // Print the elements in the vector
    printf("Vector elements: ");
    for (uint64_t i = 0; i < size_v(&v); i++) {
        printf("%lu ", *get_element_v(&v, i));
    }
    printf("\n");

    // Example using heap
    heap h;
    init_h(&h);

    // Insert elements into the heap
    insert_h(&h, 30);
    insert_h(&h, 20);
    insert_h(&h, 40);
    insert_h(&h, 10);

    // Print the elements in the heap
    printf("Heap elements: ");
    while (size_h(&h) > 0) {
        printf("%lu ", pop_max(&h));
    }
    printf("\n");

    // Example of optional heapsort function
    vector v2;
    init_v(&v2);

    // Push elements into the vector
    for (uint64_t i = 5; i >= 1; i--) {
        push_v(&v2, i * 10);
    }

    // Use heapsort to sort the vector
    

    // Print the sorted elements
    printf("Sorted Vector elements: ");
    for (uint64_t i = 0; i < size_v(&v2); i++) {
        printf("%lu ", *get_element_v(&v2, i));
    }
    printf("\n");

    // Clean up
    delete_v(&v);
    delete_h(&h);
    delete_v(&v2);

    return 0;
}
