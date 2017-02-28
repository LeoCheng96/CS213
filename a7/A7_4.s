.pos 0x0 #main function
                 ld   $0x1028, r5      #r5 = top of stack  
                 ld   $0xfffffff4, r0  #r0 = -12
                 add  r0, r5           #r5 = 0x1016
                 ld   $0x200, r0       #r0 = &i
                 ld   0x0(r0), r0      #r0 = i
                 st   r0, 0x0(r5)      #0x1016 = i    
                 ld   $0x204, r0       #r0 = &j
                 ld   0x0(r0), r0      #r0 = j
                 st   r0, 0x4(r5)      #0x1020 = j 
                 ld   $0x208, r0       #r0 = &k
                 ld   0x0(r0), r0      #r0 = k
                 st   r0, 0x8(r5)      #0x1024 = k 
                 gpc  $6, r6           #r6 = pc + 6   
                 j    0x300            #jump to callee
                 ld   $0x20c, r1       #r1 = returnVal
                 st   r0, 0x0(r1)      #returnVal = foo(i,j,k)
                 halt                     
.pos 0x200 #foo's parameters
                 .long 0x00000012      #i      
                 .long 0x00000001      #j 
                 .long 0x00000002      #k 
                 .long 0x00000000      #val 
.pos 0x300 #foo function
                 ld   0x0(r5), r0      #r0 = i  
                 ld   0x4(r5), r1      #r1 = j   
                 ld   0x8(r5), r2      #r2 = k
                 ld   $0xfffffff6, r3  #r3 = -10
                 add  r3, r0           #r0 = i-10   
                 mov  r0, r3           #r3 = i-10   
                 not  r3                  
                 inc  r3               #r3 = -(i-10)   
                 bgt  r3, L6           #if i < 10, goto L6   
                 mov  r0, r3           #r3 = i-10   
                 ld   $0xfffffff8, r4  #r4 = -8
                 add  r4, r3           #r3 = i-10-8   
                 bgt  r3, L6           #if i > 18 goto L6
                 ld   $0x400, r3       #r3 = &jmpTable
                 j    *(r3, r0, 4)     #goto jmpTable[i-10]   
.pos 0x330
                 add  r1, r2           #case i=10: set tmp= j + k 
                 br   L7               #goto L7   
                 not  r2               #case i = 12 
                 inc  r2               #r2 = -k              
                 add  r1, r2           #r2 = j-k set tmp=j-k
                 br   L7               #goto L7
                 not  r2               #case i = 14
                 inc  r2               #r2 = -k
                 add  r1, r2           #r2 = j-k   
                 bgt  r2, L0           #if j>k goto L0   
                 ld   $0x0, r2         #else set tmp = 0
                 br   L1               #goto L1   
L0:              ld   $0x1, r2         #set tmp = 1   
L1:              br   L7               #goto L7   
                 not  r1               #case i = 16   
                 inc  r1               #r1 = -j   
                 add  r2, r1           #r1 = k-j   
                 bgt  r1, L2           #if k>j goto L2   
                 ld   $0x0, r2         #else set tmp = 0   
                 br   L3               #goto L3   
L2:              ld   $0x1, r2         #set tmp = 1   
L3:              br   L7               #goto L7   
                 not  r2               #case i =18   
                 inc  r2               #r2 = -k   
                 add  r1, r2           #r2 = j-k   
                 beq  r2, L4           #if j=k goto L4   
                 ld   $0x0, r2         #else set tmp = 0   
                 br   L5               #goto L5   
L4:              ld   $0x1, r2         #set tmp = 1   
L5:              br   L7               #goto L7  
L6:              ld   $0x0, r2         #default, set tmp=0    
                 br   L7               #goto L7   
L7:              mov  r2, r0           #r0 = tmp
                 j    0x0(r6)          #return tmp    
.pos 0x400 #jmpTable
                 .long 0x00000330  #case i = 10   
                 .long 0x00000384  #default    
                 .long 0x00000334  #case i = 12     
                 .long 0x00000384  #default       
                 .long 0x0000033c  #case i = 14        
                 .long 0x00000384  #default       
                 .long 0x00000354  #case i = 16       
                 .long 0x00000384  #default       
                 .long 0x0000036c  #case i = 18 
.pos 0x1000 #stack
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000  #i       
                 .long 0x00000000  #j       
                 .long 0x00000000  #k      
