.pos 0x100
main:            ld   $sb, r5       
                 inca r5                  

                 gpc  $0x6, r6            
                 j    copy                

                 halt                     

.pos 0x150
copy:            ld   $0xfffffff4, r0     
                 add  r0, r5              
                 st   r6, 0x8(r5)         
                 ld   $0, r2              

loop:            ld   $src, r0            
                 ld   (r0, r2, 4), r0     
                 beq  r0, end_loop        

                 st   r0, (r5, r2, 4)     
                 inc  r2                  

                 br   loop                

end_loop:        ld   $0, r0              
                 st   r0, (r5, r2, 4)     

                 ld   8(r5), r6           
                 ld   $12, r0             
                 add  r0, r5              
                 j    0x0(r6)             

.pos 0x200
src:             .long 0x1                # src[0]
                 .long 0x2                # src[1]
                 .long 0x25C              
                 .long 0x0000FFFF         
                 .long 0xFFFF6001         
                 .long 0x60026003         
                 .long 0x60046005         
                 .long 0x60066007         
                 .long 0xF0000000         
                 .long 0                  

.pos 0x250
                 .long 0x0
                 .long 0x0
sb:              .long 0x0
