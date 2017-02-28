#br A
br:
		br 0x104 #goto +1
		br br3
br2:	br end
br3:	br br2
end:	halt


#beq rc ,A
beq: 
		ld $0x5, r0
		beq r0, fail #if r0==0, goto fail
fail:	ld $0x0, r0
		beq r0, success #if r0==0, goto success
success:halt

#bgt rc, A
bgt: 
		ld $0x0, r0
		bgt r0, fail
try:	ld $0x1, r0
		bgt r0, success
fail:	br try
success:halt

#j A
j:
		j j3
j2:		j end
j3:		j j2
end:	halt

#j o(rt)
j o(rt):
		ld $0x1000, r0
		j 0x4(r0)
.pos 0x1004
		halt

#gpc $o, rd
gpc: 
		gpc $6, r6
		j (r6)
		halt


