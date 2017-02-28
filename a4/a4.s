.pos 0x1000
code:
			ld $s, r0		    #r0 = &s
			ld $i, r1           #r1 = &i
			ld 0x0(r1),r1       #r1 = i
			ld (r0,r1,4),r1     #r1 = s.x[i]
			ld $v, r2           #r2 = &v
			st r1,0x0(r2)       # v = s.x[i]

			ld $s, r0           #r0 = &s
			ld 0x8(r0),r0       #r0 = &heap0
			ld $i, r1           #r1 = &i
			ld 0x0(r1),r1       #r1 = i       
			ld (r0,r1,4),r1		#r1 = s.y[i]
			ld $v, r2           #r2 = &v
			st r1,0x0(r2)       #v = s.y[i]

			ld $s, r0 			#r0 = &s
			ld 0xc(r0),r0		#r0 = &heap1
			ld $i, r1           #r1 = &i
			ld 0x0(r1),r1       #r1 = i       
			ld (r0,r1,4),r1		#r1 = s.z->x[i]
			ld $v, r2           #r2 = &v
			st r1,0x0(r2)       #v = s.z->x[i]

			

			


.pos 0x2000
static:
i:	.long 1
v:	.long 0
s:	.long 0 #s.x[0]
	.long 6 #s.x[1]
	.long heap0 #s.y
	.long heap1 #s.z
	


.pos 0x3000
heap0:	.long 0 #s.y[0]
		.long 3 #s.y[1]

heap1:
		.long 0 #s.z->x[0]
		.long 5 #s.z->x[1]
		.long 0 #s.z->y
		.long 0 #s.z->z
		
