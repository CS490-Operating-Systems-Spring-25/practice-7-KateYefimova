.section .data
color_prompt:    .asciz "Enter colors (up to 16): "
input_buffer:    .fill 17, 1, 0  
color_reset:     .asciz "\033[0m\n" 
color_black:     .asciz "\033[40m  "  
color_red:       .asciz "\033[41m  "  
color_green:     .asciz "\033[42m  "  
color_blue:      .asciz "\033[44m  "  
color_yellow:    .asciz "\033[43m  "  
color_white:     .asciz "\033[47m  "  
color_cyan:      .asciz "\033[46m  "  
color_magenta:   .asciz "\033[45m  "  

.section .bss
color_output:    .skip 128 

.section .text
.global _start

_start:
    // Display prompt to user
    mov x0, #1
    ldr x1, =color_prompt
    mov x2, #28
    mov x8, #64
    svc #0

    // Read user input
    mov x0, #0
    ldr x1, =input_buffer
    mov x2, #16
    mov x8, #63
    svc #0

    // Initialize pointers
    ldr x1, =input_buffer
    ldr x2, =color_output
    mov x3, x2

process_colors:
    ldrb w4, [x1], #1
    cmp w4, #10
    beq display_result
    cbz w4, display_result

    // Check color codes
    cmp w4, 'B'
    beq select_black
    cmp w4, 'r'
    beq select_red
    cmp w4, 'g'
    beq select_green
    cmp w4, 'b'
    beq select_blue
    cmp w4, 'y'
    beq select_yellow
    cmp w4, 'w'
    beq select_white
    cmp w4, 'c'
    beq select_cyan
    cmp w4, 'm'
    beq select_magenta
    b process_colors  

select_black:
    adr x5, color_black
    b append_color_code
select_red:
    adr x5, color_red
    b append_color_code
select_green:
    adr x5, color_green
    b append_color_code
select_blue:
    adr x5, color_blue
    b append_color_code
select_yellow:
    adr x5, color_yellow
    b append_color_code
select_white:
    adr x5, color_white
    b append_color_code
select_cyan:
    adr x5, color_cyan
    b append_color_code
select_magenta:
    adr x5, color_magenta
    b append_color_code

append_color_code:
    ldrb w6, [x5], #1
    cbz w6, process_colors
    strb w6, [x3], #1
    b append_color_code

display_result:
    ldr x5, =color_reset
append_reset_code:
    ldrb w6, [x5], #1
    cbz w6, output_result
    strb w6, [x3], #1
    b append_reset_code

output_result:
    mov x0, #1
    ldr x1, =color_output
    sub x2, x3, x1
    mov x8, #64
    svc #0

    mov x0, #0
    mov x8, #93
    svc #0
