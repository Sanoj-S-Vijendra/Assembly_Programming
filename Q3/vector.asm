extern realloc
extern free

section .text
global init_v
global delete_v
global resize_v
global get_element_v
global push_v
global pop_v
global size_v

init_v:
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
        mov rax, rdi   ; loading vector to rax
        mov qword [rax], 0x0  ; buff_size = 0
        mov rax ,rdi
        mov qword [rax + 0x8], 0x0 ; size = 0
        mov rax, rdi
        mov qword [rax + 0x10], 0x0  ; ptr = NULL
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

delete_v:
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
        mov qword [rbp - 0x8], rdi   ; loading vector to [rbp - 8]
        mov rax, rdi
        mov rax, qword [rax + 0x10]  ; rax =ptr
        mov rdi, rax    ; loading ptr to rdi for calling free
        call free
        mov rax, qword [rbp - 0x8]
        mov qword [rax], 0x0   ; buffsize = 0
        mov rax, qword [rbp - 0x8]
        mov qword [rax + 0x8], 0x0  ; size = 0
        mov rax, qword [rbp - 0x8]
        mov qword [rax + 0x10], 0x0  ; ptr = NULL
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

resize_v:
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
        mov qword [rbp - 0x8], rdi   ; loading vector in [rbp - 8]
        mov qword [rbp - 0x10], rsi  ; loading newsize in [rbp - 16]
        mov rax, rsi
        lea rdx, [rax*0x8]   ; calculating new buffsize space needed
        mov rax, rdi
        mov rax, [rax + 0x10] 
        mov rsi, rdx   ; loading new space to rsi for calling realloc
        mov rdi, rax   ; loading ptr to rdi to call realloc
        call realloc
        mov rdx, qword [rbp - 0x8]
        mov qword [rdx + 0x10], rax  ; assigning result of realloc to ptr
        mov rax, rdx  
        mov rdx, qword [rbp - 0x10]  
        mov qword [rax], rdx  ; assigning buffsize = newsize
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

get_element_v:
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
        mov rax, rdi  ; loadinf rax with vector
        mov rax, qword [rax + 0x10]  ; rax is ptr
        mov rdx, rsi  ; loading rdx with index
        shl rdx, 0x3 
        add rax, rdx  ; going to that index number ;and storing that in rax for output 
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

push_v:
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
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL COD
        mov qword [rbp - 0x8], rdi 
        mov qword [rbp - 0x10], rsi
        mov rax, rdi
        mov rdx, qword [rax + 0x8]  ; rdx is size
        mov rax, rdi
        mov rax, qword [rax] ; rax is buffsize
        cmp rax, rdx ; comparing buffsize with size
        jne insert ; if not equal jump to insert
        mov rax, rdi 
        mov rax, qword [rax]
        add rax, rax
        add rax, 0x1  ; new buffsize = 2*buffsize+1
        mov rsi, rax   ; rsi = new buffsize
        mov rdi, rdi  ; rdi = vector
        call resize_v  ; calling resize
        insert:
                mov rax, qword [rbp - 0x8]  
                mov rdx, qword [rax + 0x10] ; rdx has ptr
                mov rax, qword [rbp - 0x8]
                mov rax, qword [rax + 0x8]  ; rax has size
                shl rax, 0x3
                add rdx, rax  ; going to last element
                mov rax, qword [rbp - 0x10] ;rax is new element
                mov qword [rdx], rax ; storing new element in v[size]
                mov rax, qword [rbp - 0x8]
                mov rdx, qword [rax + 0x8]  ; rdx = size
                add rdx, 0x1  ; rdx = size+1
                mov qword [rax + 0x8], rdx  ; size = size + 1
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

pop_v:
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
        mov rax, rdi   ; rax has vector
        mov rax, qword [rax + 0x8]  ; rax = size
        cmp rax, 0x0  ; comparing size with 0
        je error  ; if size = 0, jump to error
        mov rax, rdi   
        mov rax, qword [rax + 0x8]
        sub rax, 0x1  ; rax had size, now rax = size - 1
        mov rdx, rdi
        mov qword [rdx + 0x8], rax ; size = size - 1
        mov rdx, qword [rdx + 0x10]
        shl rax, 0x3
        add rdx, rax ; getting the last element
        mov rax, qword [rdx] ; storing last element in rax for returning
        jmp pops ; jump to pops
        error:
                mov rax, 0x0  ; in case size = 0 return 0
        pops:
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

size_v:
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
        mov rax, rdi
        mov rax, qword [rax + 0x8]  ; rax = size, for returning
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
