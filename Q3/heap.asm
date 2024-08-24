extern init_v
extern pop_v
extern push_v
extern size_v
extern get_element_v
extern resize_v
extern delete_v

section .text
global init_h
global delete_h
global size_h
global insert_h
global get_max
global pop_max
global heapify
global heapsort

init_h:
        push rbp
        mov rbp, rsp
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        mov rax, rdi ; loading rax with heap h
        mov rdi, rax  ; loading h->arr to rdi for calling init_v
        call init_v  ; calling init_v
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

delete_h:
        push rbp
        mov rbp, rsp
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        mov rax, rdi  ; loading rax with h
        mov rdi, rax  ; loading rdi with h->arr for calling delete_v
        call delete_v  ; calling delete_v
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret


size_h:
        push rbp
        mov rbp, rsp
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        mov rax, rdi ; loading h into rax
        mov rdi, rax  ; loading h->arr into rdi for calling size_v
        call size_v  ; calling size_v
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret


insert_h:
        push rbp
        mov rbp, rsp
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        mov qword [rbp - 0x8], rdi ; loaidng h into [rbp -8]
        mov rax, rdi
        mov rsi, rsi ; loading rsi with element
        mov rdi, rax ; loading rdi with h->arr
        call push_v ; calling push_v
        mov rdi, qword [rbp - 0x8]  ; loading rdi with h
        call size_h ; calling size_h
        sub rax, 0x1 ; rax = size_h(h); rax = rax - 1
        mov r15, rax ; r15 = size - 1
        while:
                cmp r15, 0x0 ; comparing size - 1 with 0 or variable idx with 0
                jne loop ; if r15 > 0 then jump to loop
                jmp pops_0 ; else jump to pops_0
                loop:
                        mov rax, r15 ; rax = r15
                        sub rax, 0x1
                        shr rax, 0x1
                        mov r14, rax ; r14 = parent index = (idx-1)/2
                        mov rax, qword [rbp - 0x8] ; loading rax with h->arr
                        mov rdx, r15
                        shl rdx, 0x3
                        mov rax, qword [rax + 0x10]
                        add rax, rdx ; getting address of h->arr.ptr[idx]
                        mov rax, qword [rax] ; storing element at h->arr.ptr[idx] in rax
                        mov rdx, qword [rbp - 0x8]
                        mov rcx, r14
                        shl rcx, 0x3
                        mov rdx, qword [rdx + 0x10]
                        add rdx, rcx ; getting address of h->arr.ptr[parent_idx]
                        mov rdx, qword [rdx] ;  storing element at h->arr.ptr[parent_idx] in rdx
                        cmp rax, rdx ; comparing parent with child
                        jle pops_0 ; if child <= parent jumpto pops_0
                        mov rax, qword [rbp - 0x8]
                        mov rax, qword [rax + 0x10]
                        mov rdx, r15
                        shl rdx, 0x3
                        add rax, rdx
                        mov rax, qword [rax]
                        mov r13, rax ; storing child in temporary register r13
                        mov rax, qword [rbp - 0x8]
                        mov rax, qword [rax + 0x10]
                        mov rdx, r14
                        shl rdx, 0x3
                        add rax, rdx
                        mov rcx, rax
                        mov rcx, qword [rcx]
                        mov rax, qword [rbp - 0x8]
                        mov rax, qword [rax + 0x10]
                        mov rdx, r15
                        shl rdx, 0x3
                        add rax, rdx
                        mov qword [rax], rcx ; child = parent
                        mov rax, qword [rbp - 0x8]
                        mov rax, qword [rax + 0x10]
                        mov rdx, r14
                        shl rdx, 0x3
                        add rax, rdx
                        mov qword [rax], r13 ; parent = child
                        mov r15, r14 ; idx = parent_idx
                        jmp while ; jump to while again
        pops_0:
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

get_max:
        push rbp
        mov rbp, rsp
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        mov [rbp - 0x8], rdi ; loading [rbp - 8] with h
        mov rdi, rdi ; rdi = rdi for calling size_h
        call size_h ; calling size_h
        cmp rax, 0x0 ; comparing size with 0
        je err ; if size = 0 the jump to err
        mov rax, qword [rbp - 0x8]
        mov rax, qword [rax + 0x10]
        mov rax, qword [rax] ; storing rax with value of h->arr.ptr[0] for returning
        jmp pops_1 ; jump to pops_1
        err:
                mov rax, 0x0 ; in case size = 0, return 0
        pops_1:
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

pop_max:
        push rbp
        mov rbp, rsp
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        mov [rbp - 0x8], rdi ; loading [rbp - 8] with h
        mov rdi, rdi
        call size_h ; calling size_h
        cmp rax, 0x0 ; comparing size with 0
        je errr ; if size = 0 then jump to errr
        mov rdx, [rbp - 0x8] ; rdx = h
        mov rdx, [rdx + 0x10]
        mov rdx, [rdx] ; rdx = element at h->arr.ptr[0] or max element
        mov r15, rdx ; r15 = max element
        mov rdx, [rbp - 0x8]
        mov rdx, [rdx + 0x10]
        sub rax, 1 ; rax = size - 1
        shl rax, 0x3
        add rdx, rax ; getting address of last element
        mov rdx, [rdx] ; rdx = last element
        mov rcx, [rbp - 0x8]
        mov rcx, [rdx + 0x10] ; rcx = address of h->arr.ptr[0]
        mov [rcx], rdx ; h->arr.ptr[0] = last element
        mov rdx, [rbp - 0x8]
        mov [rdx + 0x8], rax ; size = size - 1
        mov r14, 0x0 ; initialising a variable register at 0 say variable i
        loop_1:
                mov rax, r14
                add rax, rax
                add rax, 0x1 ; rax = 2*i+1 or left child
                mov r13, rax ; r13 = left child
                mov rax, r14
                add rax, 0x1
                add rax, rax ; rax = 2*i+2 or right child
                mov r12, rax ; r12 = right child
                mov r11, r14 ; r11 = i lets say it largest
                mov rdi, [rbp - 0x8] ; loading h into rdi
                call size_h ; calling size_h
                cmp r13, rax ; comparing size with left child
                jge next ; if left child >= size jump to next
                mov rax, [rbp - 0x8]
                mov rax, [rax + 0x10]
                mov rdx, r13
                shl rdx, 0x3
                add rax, rdx
                mov rax, [rax] ; rax = element in left child
                mov rdx, [rbp - 0x8]
                mov rdx, [rdx + 0x10]
                mov rcx, r11
                shl rcx, 0x3
                add rdx, rcx
                mov rdx, [rdx] ; rdx = element at index i
                cmp rdx, rax ; comparing element i with left child
                jge next ; if element i >= left child then jump to next
                mov r11, r13 ; r11 = left child index
                next:
                        mov rdi, [rbp - 0x8] ; loading h into rdi
                        call size_h ; calling size_h
                        cmp r12, rax ; comparing size with right child
                        jge end_if ; if right child >= size jump to end_if
                        mov rax, [rbp - 0x8]
                        mov rax, [rax + 0x10]
                        mov rdx, r12
                        shl rdx, 0x3
                        add rax, rdx
                        mov rax, [rax]  ; rax = element in right child
                        mov rdx, [rbp - 0x8]
                        mov rdx, [rdx + 0x10]
                        mov rcx, r11
                        shl rcx, 0x3
                        add rdx, rcx
                        mov rdx, [rdx] ; rdx = element at index i
                        cmp rdx, rax ; comparing element i with right` child
                        jge end_if ; if element i >= right child then jump to end_if
                        mov r11, r12 ; r11 = right child index
                end_if:
                        cmp r11, r14 ; comparing r11 with r14
                        je return_value ; if equal jump to return_value
                        mov rax, [rbp - 0x8]
                        mov rax, [rax + 0x10]
                        mov rdx, r14
                        shl rdx, 0x3
                        add rax, rdx
                        mov rax, [rax] ; rax = value at h->arr.ptr[i]
                        mov r10, rax ; storing h->arr.ptr[i] in variable r10
                        mov rax, [rbp - 0x8] 
                        mov rax, [rax + 0x10]
                        mov rdx, r11
                        shl rdx, 0x3
                        add rax, rdx ; rax has address of h->arr.ptr[largest]
                        mov rcx, [rax]  ; rcx has value of h->arr.ptr[largest]
                        mov rax, [rbp - 0x8]
                        mov rax, [rax + 0x10]
                        mov rdx, r14
                        shl rdx, 0x3
                        add rax, rdx ; rax has address of h->arr.ptr[i]
                        mov [rax], rcx ; h->arr.ptr[i] = h->arr.ptr[largest]
                        mov rax, [rbp - 0x8]
                        mov rax, [rax + 0x10]
                        mov rdx, r11
                        shl rdx, 0x3
                        add rax, rdx
                        mov [rax], r10 ; h->arr.ptr[largest] = h->arr.ptr[i]
                        mov r14, r11 ; i = largest
                        jmp loop_1 ; jump back to loop_1
        return_value:
                mov rax, r15 ; returning maximum value
                jmp pops_2 ; jump to pops_2
        errr:
                mov rax, 0x0 ; if size = 0, return 0
        pops_2:
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

heapify:
        push rbp
        mov rbp, rsp
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

heapsort:
        push rbp
        mov rbp, rsp
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret
