.pos 0x0
                 ld   $sb, r5               # r5 = &sb = address of bottom of stack  
                 inca r5                    # r5 = stack pointer 
                 gpc  $6, r6                # store 0x6 as return address 
                 j    0x300                 # jump to main
                 halt                     
.pos 0x100
                 .long 0x00001000         
.pos 0x200
                 ld   0x0(r5), r0         # r0 = c
                 ld   0x4(r5), r1         # r1 = d
                 ld   $0x100, r2          # r2 = &arr
                 ld   0x0(r2), r2         # r2 = head (ptr)
                 ld   (r2, r1, 4), r3     # r3 = head[d]
                 add  r3, r0              # c = c + head[d]
                 st   r0, (r2, r1, 4)     # head[d] = c 
                 j    0x0(r6)             # return 
.pos 0x300
                 ld   $0xfffffff4, r0     # r0 = -12
                 add  r0, r5              # 3 bytes allocated for function1
                 st   r6, 0x8(r5)         # store the return address 3 from sb
                 ld   $0x1, r0            # r0 = 1
                 st   r0, 0x0(r5)         # sb top of stack = 1
                 ld   $0x2, r0            # r0 = 2 
                 st   r0, 0x4(r5)         # store (value 2) 1 from sb
                 ld   $0xfffffff8, r0     # r0 = -8
                 add  r0, r5              # allocate more space 
                 ld   $0x3, r0            # r0 = 3
                 st   r0, 0x0(r5)         # store 3 at top of new r5 stack
                 ld   $0x4, r0            # r0=4
                 st   r0, 0x4(r5)         # store (value 4) 2 from r5
                 gpc  $6, r6              # get return address
                 j    0x200               # jump to function
                 ld   $0x8, r0            # r0 = 8
                 add  r0, r5              # deallocate 8 bytes from r5
                 ld   0x0(r5), r1         # r1 = a
                 ld   0x4(r5), r2         # r2 = b
                 ld   $0xfffffff8, r0     # r0 = -8
                 add  r0, r5              # allocate 8 bytes for r5
                 st   r1, 0x0(r5)         # c = a
                 st   r2, 0x4(r5)         # d = b
                 gpc  $6, r6              # get return address
                 j    0x200               # jump to function
                 ld   $0x8, r0            # r0 = 8
                 add  r0, r5              # deallocate 8 bytes from r5
                 ld   0x8(r5), r6         # r6 = value in return address 
                 ld   $0xc, r0            
                 add  r0, r5              # deallocate memory of main
                 j    0x0(r6)             # return
.pos 0x1000
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
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
