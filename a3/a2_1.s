# int b;
# int c;
# int a[10];

# c = 5;
# b = c + 10; 
# a[8] = 8;
# a[4] = a[4] + 4;
# a[c] = a[8] + b + a[b & 0x7];

ld $0x5, r0 							  # r0 = 5
ld $c, r1								  # r1 = &c
st r0, 0x0(r1)							  # c = 5

ld $0xA, r2 							  # r2 = 10
add r0,r2 								  # r2 = 10 + 5
ld $b, r1								  # r1 = &b
st r2,0x0(r1)							  # b = 15

ld $0x8, r0            				      # r0 = 8
ld $a, r1                                 # r1 = &a
st r0, (r1, r0, 4)                        # a[8] = 8

ld $0x4, r0							      # r0 = 4
ld 0x10(r1), r2	                          # r2 = a[4]
add r0, r2								  # r2 = r2 + 4
st  r2,(r1,r0,4)						  # a[4] = r2

ld 0x20(r1),r0 							  # r0 = a[8]
ld $b,r2                                  # r2 = &b
ld 0x0(r2),r3                             # r3 = b
add r3,r0                                 # r0 = r0 + r3
ld $0x7, r4                               # r4 = 0x7
and r3,r4                                 # r4 = 0x7 & b
ld $a, r5							      # r5 = $a
ld (r5,r4,4),r6                           # r6 = a[0x7 & b]
add r6, r0                                # r0 = r0 + r6

ld $c, r5							      # r5 = &c
ld 0x0(r5), r6							  # r6 = c

st r0, (r1,r6,4)                          # a[c] = r0

halt



.pos 0x1000
b:               .long 0x00000000         # b

.pos 0x2000 
c:			     .long 0x00000000         # c
.pos 0x3000
a:               .long 0x00000000         # a[0]
                 .long 0x00000000         # a[1]
                 .long 0x00000000         # a[2]
                 .long 0x00000000         # a[3]
                 .long 0x00000000         # a[4]
                 .long 0x00000000         # a[5]
                 .long 0x00000000         # a[6]
                 .long 0x00000000         # a[7]
                 .long 0x00000000         # a[8]
                 .long 0x00000000         # a[9] 
