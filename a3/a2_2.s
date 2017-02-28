# #include <stdio.h>
# int a[8] = {0,11,2,0,1,2,0,1};
# int b[8] = {2,12,0,2,1,0,2,1};
# int c[8] = {99,6,2,1,0,2,1,0};
# int i = 5;
# int *d = c;

# int main () {
#   a[i] = a[i+1] + b[i+2];
#   d[i] = a[i] + b[i];
#   d[i] = a[b[i]] + b[a[i]];
#   d[b[i]] = b[a[i & 3] & 3] - a[b[i & 3] & 3] + d[i];
#   for (int i=0; i<8; i++)
#     printf ("a[%d]==%d\n", i, a[i]);
#   for (int i=0; i<8; i++)
#     printf ("b[%d]==%d\n", i, b[i]);
#   for (int i=0; i<8; i++)
#     printf ("c[%d]==%d\n", i, c[i]);
# }

ld $a, r0       # r0 = &a
ld $b, r1       # r1 = &b
ld $i, r2       # r2 = &i
ld 0x0(r2), r3  # r3 = i
ld $0x1, r4     # r4 = 1
add r3, r4      # r4 = r4 + i
ld $0x2, r5     # r5 = 2
add r3, r5      # r5 = 2 + i
ld (r0,r4,4),r3 # r3 = a[i+1]
ld (r1,r5,4),r5 # r5 = b[i+2]
ld 0x0(r2),r2   # r2 = i
add r3,r5       # r5 = r5 + r3
st r5,(r0,r2,4) # a[i]=r5

ld (r0,r2,4),r3  # r3 = a[i]  
ld (r1,r2,4),r4  # r4 = b[i]
add r3, r4       # r4 = r4 + r3
ld $d, r5        # r5 = d
ld 0x0(r5),r5    # r5 = &c
st r4,(r5,r2,4)  # d[i] = r4


ld $i, r0        # r0 = &i
ld 0x0(r0), r0   # r0 = i
ld $b, r1        # r1 = &b
ld (r1,r0,4),r1  # r1 = b[i]
ld $a, r2        # r2 = &a
ld (r2,r1,4),r2  # r2 = a[b[i]]
ld $a, r3        # r3 = &a
ld (r3,r0,4),r3  # r3 = a[i]
ld $b, r4        # r4 = &b
ld (r4,r3,4),r4  # r4 = b[a[i]]
add r2,r4        # r4 = r2 + r4
st r4,(r5,r0,4)  # d[i] = r3

#   d[b[i]] = b[a[i & 3] & 3] - a[b[i & 3] & 3] + d[i];

ld $i, r0        # r0 = &i
ld 0x0(r0), r0   # r0 = i
ld $0x3, r1      # r1 = 3
and r1, r0       # r0 = r0 & r1
ld $a, r1        # r1 = &a
ld (r1,r0,4), r0 # r0 = a[r0]
ld $0x3, r1      # r1 = 3
and r1, r0       # r0 = r1 & r0 
ld $b, r1        # r1 = &b
ld (r1,r0,4), r0 # r0 = b[r0]

ld $i, r1        # r1 = &i
ld $0x3, r2      # r2 = 3
ld 0x0(r1), r1   # r1 = i
and r2, r1       # r1 = r1 & r2 
ld $b, r2        # r2 = &b
ld (r2,r1,4),r1  # r1 = b[r1]
ld $0x3, r2      # r2 = 3
and r2, r1       # r1 = r2 & r1
ld $a, r2        # r2 = &a
ld (r2,r1,4), r1 # r1 = a[r1]

ld $d,r2         # r2 = $d
ld 0x0(r2),r2    # r2 = &c
ld $i, r3        # r3 = &i
ld 0x0(r3),r3    # r3 = i
ld (r2,r3,4),r2  # r2 = d[i]
not r1           # r1 = ~r1
inc r1
add r1, r0       # r0 = r0 + r1
add r2, r0       # r0 = r0 + r2
ld $i, r1        # r1 = &i
ld 0x0(r1),r1    # r1 = i
ld $b, r2        # r2 = &b
ld (r2,r1,4),r1  # r1 = b[i]
ld $d, r2        # r2 = &d
ld 0x0(r2),r2    # r2 = d
st r0, (r2,r1,4) # d[r1]=r0



halt





.pos 0x1000
a:               .long 0x00000000         # a[0]
                 .long 0x0000000B         # a[1]
                 .long 0x00000002         # a[2]
                 .long 0x00000000         # a[3]
                 .long 0x00000001         # a[4]
                 .long 0x00000002         # a[5]
                 .long 0x00000000         # a[6]
                 .long 0x00000001         # a[7]

.pos 0x2000
b:               .long 0x00000002         # b[0]
                 .long 0x0000000C         # b[1]
                 .long 0x00000000         # b[2]
                 .long 0x00000002         # b[3]
                 .long 0x00000001         # b[4]
                 .long 0x00000000         # b[5]
                 .long 0x00000002         # b[6]
                 .long 0x00000001         # b[7]

.pos 0x3000
c:               .long 0x00000063         # c[0]
                 .long 0x00000006         # c[1]
                 .long 0x00000002         # c[2]
                 .long 0x00000001         # c[3]
                 .long 0x00000000         # c[4]
                 .long 0x00000002         # c[5]
                 .long 0x00000001         # c[6]
                 .long 0x00000000         # c[7]

.pos 0x4000
i:               .long 0x00000005         # int i = 5

.pos 0x5000      
d:               .long c             # d* = c
