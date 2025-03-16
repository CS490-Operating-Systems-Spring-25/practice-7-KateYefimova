.section .data
    buffer: .space 256
    filename: .asciz "example.txt"   
    message: .asciz "Hello, World!\n"
    newline: .asciz "\n"

.section .text
    .global _start

_start:
    ldr x0, =buffer
    mov x1, #256
    mov x8, #17
    svc #0

    mov x0, #1
    ldr x1, =buffer
    mov x2, #256
    mov x8, #64
    svc #0

    mov x8, #56
    mov x0, #-100
    ldr x1, =filename
    mov x2, #577
    mov x3, #0644
    svc #0

    mov x19, x0

    mov x8, #64
    mov x0, x19
    ldr x1, =message
    mov x2, #14
    svc #0

    mov x0, x19
    mov x8, #57
    svc #0

    ldr x0, =filename
    mov x1, #2
    mov x8, #56
    svc #0

    cmp x0, #0

    mov x0, x19
    mov x1, #0755
    mov x8, #52
    svc #0

    mov x0, x19
    mov x1, #1000
    mov x2, #1000
    mov x8, #55
    svc #0

    mov x0, x19
    mov x8, #57
    svc #0

    mov x0, #0
    mov x8, #93
    svc #0
