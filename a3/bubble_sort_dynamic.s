ld $i, r0        # r0 = &i
ld 0x0(r0), r0   # r0 = i
ld $val, r1      # r1 = &val
ld 0x0(r1), r1   # r1 = &a
ld (r1,r0,4),r1  # r1 = val[i]

mov r1, r3 #r3 = r1

ld $j, r0        # r0 = &j
ld 0x0(r0), r0   # r0 = j
ld $val, r2      # r2 = &val
ld 0x0(r2),r2    # r2 = &a
ld (r2,r0,4),r2  # r2 = val[j]

ld $i, r0        # r0 = &i
ld 0x0(r0), r0   # r0 = i
ld $val, r1      # r1 = &val
ld 0x0(r1),r1    # r2 = &a
st r2, (r1,r0,4) # val[i] = r2

ld $j, r0        # r0 = &j
ld 0x0(r0), r0   # r0 = j
ld $val, r2      # r2 = &val
ld 0x0(r2),r2    # r2 = &a
st r3, (r2,r0,4) # val[j] = r3

halt

.pos 0x100
i: .long 1

.pos 0x200
j: .long 2

.pos 0x1000
a: 
.long 0
.long 12
.long 32

.pos 0x2000
val:
.long a