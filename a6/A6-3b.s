.pos 0x100
start:
    ld $sb, r5 					# r5 = stack pointer 
    inca    r5                  # r5 = allocate space for return address
    gpc $6, r6                  # save return address 0x6
    j main                      # jump to main
    halt                        # stop program

f:
    deca r5						# allocate 4 byte for stack
    ld $0, r0                   # r0 = 0;
    ld 4(r5), r1                # r1 = x[i]
    ld $0x80000000, r2          # r2 = 0x80000000
f_loop:
    beq r1, f_end				# if x[i]==0 go to f_end
    mov r1, r3                  # r3 = x[i]
    and r2, r3					# r3 = x[i] & $0x80000000
    beq r3, f_if1			    # if r3 == 0 go to f_if1
    inc r0                      # r0++
f_if1:
    shl $1, r1                  # r1 = x[i]*2
    br f_loop                   # go to f_loop
f_end:
    inca r5						# deallocate space on stack
    j(r6)                       # return 

main:
    deca r5                   # allocate space 
    deca r5                   # allocate space, total of 8 bytes
    st r6, 4(r5)              # save return address 
    ld $8, r4				  # r4 = 8 = i
main_loop:
    beq r4, main_end		  # if i==0 go to main_end
    dec r4 					  # i--
    ld $x, r0				  # r0 = &x
    ld (r0,r4,4), r0          # r0 = x[i]
    deca r5 			      # allocate 4 bytes at stack
    st r0, (r5)				  # store x[i] at top of stack
    gpc $6, r6			      # save return address
    j f                       # jump to f
    inca r5					  # deallocate 4 bytes on stack
    ld $y, r1				  # r1 = &y
    st r0, (r1,r4,4)          # y[i]=x[i]
    br main_loop			  # go to main_loop
main_end:
    ld 4(r5), r6			  # r6 = 
    inca r5                   # deallocate 
    inca r5					  # deallocate total of 8 bytes
    j (r6)					  # returen

.pos 0x2000
x:
    .long 1
    .long 2
    .long 3
    .long 0xffffffff
    .long 0xfffffffe
    .long 0
    .long 184
    .long 340057058

y:
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0

.pos 0x8000
# These are here so you can see (some of) the stack contents.
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
sb: .long 0

