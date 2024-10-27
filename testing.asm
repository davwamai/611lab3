    .data
    .text
    .globl _start

_start:
    # load the input number N into t0
    # li t0, 123456
    csrrw t0, 0xf00, zero

    li t1, 4321
    li t2, 1234
    li t3, 6789
    slt t4, t1, t2
    sltu t5, t3, t1
    or t6, t4, t5
    sll t5, t6, t3
    srl t4, t1, t1
    sra t3, t2, t1
    and t2, t3, t0
    srli t1, t4, 4
    srai t2, t1, 2
    andi t3, t2, 3
    ori t4, t3, 7
    xori t0, t4, 2
    mul t0, t0, t2
    mul t0, t0, t2
    mul t0, t0, t2

    # load multiplier M into t1
    li t1, 0x1999999A  # M = 0x1999999A

    # decimal digits D5 to D0 to zero
    li s0, 0   # D5
    li s1, 0   # D4
    li s2, 0   # D3
    li s3, 0   # D2
    li s4, 0   # D1
    li s5, 0   # D0

    # constant for 10
    li t4, 10  # t4 = 10

    ###############################################
    # extract D5
    ###############################################

    # multiply N by M and get upper 32 bits
    mulhu t3, t0, t1   # t3 = upper 32 bits of N * M

    # compute N = N - (Q * 10), where Q = t3
    mul t5, t3, t4
    sub t6, t0, t5

    # store the digit
    add s0, zero, t6   # D5 = t6
    add t0, zero, t3

    ###############################################
    # extract D4
    ###############################################

    mulhu t3, t0, t1
    mul t5, t3, t4
    sub t6, t0, t5
    add s1, zero, t6   # D4 = t6
    add t0, zero, t3

    ###############################################
    # extract D3
    ###############################################

    mulhu t3, t0, t1
    mul t5, t3, t4
    sub t6, t0, t5
    add s2, zero, t6   # D3 = t6
    add t0, zero, t3

    ###############################################
    # extract D2
    ###############################################

    mulhu t3, t0, t1
    mul t5, t3, t4
    sub t6, t0, t5
    add s3, zero, t6   # D2 = t6
    add t0, zero, t3

    ###############################################
    # extract D1
    ###############################################

    mulhu t3, t0, t1
    mul t5, t3, t4
    sub t6, t0, t5
    add s4, zero, t6   # D1 = t6
    add t0, zero, t3

    ###############################################
    # extract D0
    ###############################################

    # at this point, N is less than 10
    add s5, zero, t0   # D0 = N

    # make some room to shift in result
    add t0, zero, zero

    # pray
    xor t0, t0, s5
    slli t0, t0, 4

    xor t0, t0, s4
    slli t0, t0, 4

    xor t0, t0, s3
    slli t0, t0, 4

    xor t0, t0, s2
    slli t0, t0, 4

    xor t0, t0, s1
    slli t0, t0, 4

    xor t0, t0, s0

    # send to GPIO_out
    csrrw zero, 0xf02, t0 
