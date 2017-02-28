ldi: 
	ld $a, r0 #r0 = a
	ld $b, r1 #r1 = b

ldbo:	
	ld 0x0(r0), r2 #r2 = a
 	ld 0x4(r1), r3 #r3 = b[1]

ldind:
	ld $0x1, r4 
	ld (r1,r4,4), r5 #r4 = b[1] 
	ld $0x0, r7
	ld (r0,r4,4), r5 #r5 = a[0]

stbo:
	ld $a, r2
	ld $b, r3
	ld $0x12345678, r6
	st r6, 0x0(r2) #r6 = 0x12345678
	st r6, 0x8(r3) #r6 = 0x87654329

stin:
	ld $0, r4
	st r6, (r1, r4, 4) #b[0] = r6
	ld $1, r4
	st r6, (r1, r4, 4) #b[1] = r6

mov:
	mov r0, r2 #r2 = a
	mov r1, r2 #r2 = b

add:
	ld $0x1, r2
	ld $0x3, r3
	add r2, r3 #r3=4
	ld $0xFFFFFFFF, r2
	ld $0x1, r3
	add r2, r3 #r3=0

and:
	ld $0xAA, r2
	ld $0x55, r3
	and r2, r3 #r3 = 0x0
	ld $0x11, r2
	ld $0x01, r3
	and r3, r2 #r3 = 0x01

inc:
	ld $1, r1
	inc r1 #r1 = 2
	inc r1 #r1 = 3
	inc r1 #r1 = 4

inca:
	inca r1 #r1 = 8
	inca r1 #r1 = 12
	inca r1 #r1 = 16

dec:
	dec r1 #r1 = 15
	dec r1 #r1 = 14
	dec r1 #r1 = 13

deca: 
	ld $1, r1
	deca r1 #r1 = 9
	deca r1 #r1 = 5
	deca r1 #r1 = 1

not:
	ld $0x0, r1
	not r1 #r1 = 0xFFFFFFFF
	not r1 #r1 = 0x0

shift:
	ld $0x1, r1
	shl $0x1,r1 #r1 = 0x10
	shl $0x5, r1 #r1 = 0x1000000
	shr $0x2, r1 #r1 = 0x10000
	shr $0x4, r1 #r1 = 0x1

.pos 0x1000
a:
.long 0x11223344
.long 0x00223344

.pos 0x2000
b:
.long 0x44332211
.long 0x00332211
.long 0x00002211

halt