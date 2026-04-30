        .section .data
prompt: .asciz "Enter Number: "
answer:  .asciz "Doubled number is "

        .section .bss
input_buffer:
        .skip 100
output_buffer:
        .skip 100

        .section .text
        .globl _start

_start:
        mov $4, %eax
        mov $1, %ebx
        mov $prompt, %ecx
        mov $14, %edx
        int $0x80

        mov $0, %rax
        mov $0, %rdi

        lea input_buffer(%rip), %rsi
        mov $100, %rdx
        syscall

        mov %rax, %rdx
        mov $1, %rax
        mov $1, %rdi
        lea input_buffer(%rip), %rsi
        syscall

        lea input_buffer(%rip), %rsi
        xor %rax, %rax

asciiParse:

        movzbl (%esi), %ecx        #grab from the ascii and set top 24 bits  to 0
        cmp $10, %cl               #see if its a new line
        je double                  #if new line jump to double
        sub $'0', %ecx             #ascii to integers
        imul $10, %eax             #multiply 10 by multiple and store in eax
        add %ecx, %eax             #add the next digit
        inc %esi         #increment to next in ascii
        jmp asciiParse

double:
        shl $1, %eax         #shift = doubling
        mov $output_buffer, %edi   #advance output positions
        add $31, %edi
        movb $10, (%edi)
        mov $1, %ebp
        mov $10, %ecx

convert:
        dec %edi #decrease buffer to input nmber
        inc %ebp
        xor %edx, %edx #go to zeroes
        div %ecx #undo our work by dividing by 10 from asciiParse section to convert back to ascii
        add $'0', %dl
        movb %dl, (%edi)
        test %eax, %eax
        jnz convert

        mov $4, %eax #display text showing doubled answer
        mov $1, %ebx
        mov $answer, %ecx
        mov $15, %edx
        int $0x80

-UU-:----F1  ass.s          Top L1     (Assembler) -----------------------------------------------------------------------------------------
(No changes need to be saved)File Edit Options Buffers Tools Asm Help
        .section .data
prompt: .asciz "Enter Number: "
answer:  .asciz "Doubled number is "

        .section .bss
input_buffer:
        .skip 100
output_buffer:
        .skip 100

        .section .text
        .globl _start

_start:
        mov $4, %eax
        mov $1, %ebx
        mov $prompt, %ecx
        mov $14, %edx
        int $0x80

        mov $0, %rax
        mov $0, %rdi

        lea input_buffer(%rip), %rsi
        mov $100, %rdx
        syscall

        mov %rax, %rdx
        mov $1, %rax
        mov $1, %rdi
        lea input_buffer(%rip), %rsi
        syscall

        lea input_buffer(%rip), %rsi
        xor %rax, %rax

asciiParse:

        movzbl (%esi), %ecx        #grab from the ascii and set top 24 bits  to 0
        cmp $10, %cl               #see if its a new line
        je double                  #if new line jump to double
        sub $'0', %ecx             #ascii to integers
        imul $10, %eax             #multiply 10 by multiple and store in eax
        add %ecx, %eax             #add the next digit
        inc %esi         #increment to next in ascii
        jmp asciiParse

double:
        shl $1, %eax         #shift = doubling
        mov $output_buffer, %edi   #advance output positions
        add $31, %edi
        movb $10, (%edi)
        mov $1, %ebp
        mov $10, %ecx

convert:
        dec %edi #decrease buffer to input nmber
        inc %ebp
        xor %edx, %edx #go to zeroes
        div %ecx #undo our work by dividing by 10 from asciiParse section to convert back to ascii
        add $'0', %dl
        movb %dl, (%edi)
        test %eax, %eax
        jnz convert

        mov $4, %eax #display text showing doubled answer
        mov $1, %ebx
        mov $answer, %ecx
        mov $15, %edx
        int $0x80
