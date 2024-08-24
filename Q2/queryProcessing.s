.data
numbers:    .space 40000    # Assuming a maximum of 100 integers in array1 (4 bytes each)
newline: .asciiz "\n"
.text
input_array:
    beq $t2, $t0, exit_input
    li $v0, 5 # take input elements
    syscall
    sw $v0, 0($t1) # store number in array
    add $t1, $t1, 4
    addi $t2, $t2, 1
    j input_array

binary_search: 
    lw $a0, 0($sp) # load array to a0 using stack pointer
    li $t3, 0  # initialising low = 0
    move $t4, $a1 # initialising high = n      #change
    move $t5, $a0  # initializing t5 = array
    move $t2, $a2 # t2 = query                 #change
    add $t6, $t3, $t4 # mid = high+low
    div $t6, $t6, 2 # mid = mid/2
    while_binary:
        bge $t3, $t4, end # if low >= high jump to exit
        sll $t7, $t6, 2 # t7 = 4*t6
        add $t7, $t7, $t5 # going to middle element 
        lw $t7, 0($t7)
        beq $t2, $t7, exit # if query = middle element jump to exit
        blt $t2, $t7, if # if query < middle element jump to if
        addi $t3, $t6, 1 # else low = mid + 1
        j ex_if
        if:
            move $t4, $t6 # high = mid
        ex_if:
            add $t6, $t3, $t4 # mid = high + low
            div $t6, $t6, 2   # mid = mid/2
        j while_binary # jump back in while loop
    end:
        li $t6, -1  # if element not in array t6 = -1
        j exit # jump to exit

while_loop:
    addi $sp, $sp, -8 # initialising stack
    sw $a0, 0($sp) # storing array to sp0
    sw $ra, 4($sp) # storing return address of jal while_loop
    j while_loop2

while_loop2:
    beq $t9, $t8, exit_loop_while # exit loop if t9 == q
    addi $t9, $t9, 1 # incrementing counter
    li $v0, 5 # taking query number
    syscall
    move $a2, $v0 # storing queried number in t3
    jal binary_search
  
exit:
    li $v0, 1  # printing t6
    move $a0, $t6
    syscall
    li $v0, 4
    la $a0, newline  # printing newlinw
    syscall
    j while_loop2  # jumping back to while_loop2

exit_loop_while:
    lw $ra, 4($sp)
    j exit_input

heapsort: # a0 = numbers, a1 = size(number)
  addi $sp, $sp, -12
  sw $a1, 0($sp)  # save size
  sw $a2, 4($sp)  # save a2
  sw $ra, 8($sp)  # save return address
  move $a2, $a1  # n will be stored in a2
  addi $a2, $a2, -1    # n = size - 1
  ble $a2,$zero, end_heapsort  # if (n <= 0 ) return;
  jal make_heap  # a0 = arr, a1 = size
  add $a1, $zero, $zero # clear $a1

heapsort_loop:
  # swap(numbers[0],array[n])
  lw $t0, 0($a0)
  sll $t1, $a2, 2  #t1 = bytes(n)
  add $t1, $t1, $a0
  lw $t2, 0($t1)
  sw $t0, 0($t1)
  sw $t2, 0($a0)
  addi $a2, $a2, -1 # n--
  jal bubble_down  # a0 = numbers, a1 = 0, a2 = n
  bnez $a2, heapsort_loop

end_heapsort:
  lw $ra, 8($sp)
  lw $a2, 4($sp)
  lw $a1, 0($sp)
  addi $sp, $sp, 12
  j exit_input
  
make_heap: # a0 = numbers, a1 = size
  addi $sp, $sp, -12
  sw $a1, 0($sp)
  sw $a2, 4($sp)
  sw $ra, 8($sp)
  addi $a2, $a1, -1  # a2 = size - 1
  addi $a1, $a1, -1  # start_index = size - 1
  srl $a1, $a1, 1  # start_index /= 2
  blt $a1, $zero, end_make_heap  # if(start_index < 0) return
  
make_heap_loop:
  jal bubble_down # a0 = numbers, a1 = start_index, a2 = size-1
  addi $a1, $a1, -1
  ble $zero, $a1, make_heap_loop
  
end_make_heap:
  lw $ra, 8($sp)
  lw $a2, 4($sp)
  lw $a1, 0($sp)
  addi $sp, $sp, 12
  j exit_input

#bubble_down is a leaf in the call graph
bubble_down: # a0 = numbers, a1 = s_idx, a2 = end
  move $t0, $a1  # index = s_idx
  sll $t1, $t0, 1  # child = index*2+1
  addi $t1, $t1, 1
  bgt $t1, $a2, exit_input
  
bubble_down_loop:
  #if ( child < end && arr[child] < arr[child+1] )
  ble $a2, $t1, skipinc
  sll $t3, $t1, 2  # get bytes(child)
  add $t3, $t3, $a0
  lw $t3, 0($t3)  # t3 = arr[child]
  sll $t4, $t1, 2 #get bytes(child)
  addi $t4, $t4, 4 #t4 = bytes(child+1)
  add $t4, $t4, $a0
  lw $t4, 0($t4)  #t4 = arr[child+1]
  ble $t4, $t3, skipinc
  addi $t1, $t1, 1  # child++
  
skipinc:
  sll $t3, $t0, 2  # get bytes(index)
  add $t3, $t3, $a0
  lw $t4, 0($t3)  #t4 = arr[index], t3 = &arr[index]
  sll $t5, $t1, 2  # get bytes(child)
  add $t5, $t5, $a0
  lw $t6, 0($t5)  #t6 = arr[child], t5 = &arr[child]
  ble $t6, $t4, exit_input
  # swap(arr[index],arr[child])
  # note: t4 = arr[index], t6 = arr[child], t3 = &arr[index], t5 = &arr[child]
  sw $t4, 0($t5)
  sw $t6, 0($t3)
  move $t0, $t1  # index = child
  sll $t1, $t0, 1  # child = index*2+1
  addi $t1, $t1, 1
  ble $t1, $a2, bubble_down_loop

exit_input:
    jr $ra

main:
    li $v0, 5  # take input n
    syscall

    move $t0, $v0 # storing n in t0
    li $t2, 0  # initializing counter t2 to 0
    la $t1, numbers  # initializing numbers(array) to t1
    jal input_array  # function for taking input array

    la $a0, numbers # loading array into register a0 to pass it into a sort function
    move $a1, $t0  # loading n to a1
    jal heapsort # calling heapsort

    li $v0, 5 # take input q
    syscall

    move $t8, $v0 # storing q in t8 
    li $t9, 0 # initializing counter t9
    jal while_loop # calling while loop 
    addi $sp, $sp, 8 # popinf off stack

    li $v0, 10 #closing the program
    syscall