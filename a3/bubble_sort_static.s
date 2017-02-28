ld $0x100, r0        # r0 = &i
ld 0x0(r0), r0   # r0 = i
ld $0x1000, r1   # r1 = &val
ld (r1,r0,4),r1  # r1 = val[i]

mov r1, r3       #r3 = r1

ld $0x200, r0        # r0 = &j
ld 0x0(r0), r0   # r0 = j
ld $0x1000, r2      # r2 = &val
ld (r2,r0,4),r2  # r2 = val[j]

ld $0x100, r0        # r0 = &i
ld 0x0(r0), r0   # r0 = i
ld $0x1000, r1   # r1 = &val
st r2, (r1,r0,4) # val[i] = r2

ld $0x200, r0        # r0 = &j
ld 0x0(r0), r0   # r0 = j
ld $0x1000, r2   # r2 = &val
st r3, (r2,r0,4) # val[j] = r3

halt

.pos 0x100
i: .long 1
.pos 0x200
j: .long 2
.pos 0x1000
val: 
.long 0
.long 12
.long 32
