EXTRN SUBPROG1:FAR
EXTRN BEEP:FAR
;=============================================
;����ֱ��
;=============================================
DRAW_VLINE MACRO startx,starty,lengt,color
	local inner1
	push ax
	push bx
	push cx
	push dx
	
	mov cx,startx
	mov dx,starty
	mov ax,dx
	add ax,lengt
	inner1:
		push ax
		mov bh,0
		mov ah,0ch
		mov al,color
		int 10h
		pop ax
		inc dx
		cmp dx,ax
		jnz inner1
		
	pop dx
	pop cx
	pop bx
	pop ax
ENDM


;============================================
;��ˮƽ��
;============================================
DRAW_HLINE MACRO startx,starty,lengt,color
	local inner1
	
	push ax
	push bx
	push cx
	push dx
	
	mov cx,startx
	mov dx,starty
	mov ax,cx
	add ax,lengt
	inner1:
		push ax
		mov bh,0
		mov ah,0ch
		mov al,color
		int 10h
		pop ax
		inc cx
		cmp cx,ax
		jnz inner1
	
	pop dx
	pop cx
	pop bx
	pop ax
ENDM


;========================================
;�õ������������ĵ�x
;========================================
GET_POSNEARX MACRO posx
	local loop1,loop2
	
	push ax
	push bx
	push cx
	push dx
	
	mov ax,posx
	cmp ax,30
	jb loop1
	cmp ax,460
	ja loop1
	
	sub ax,30
	sub dx,dx
	
	mov bx,50
	div bx
	
	cmp dx,30
	ja loop1
	
	sub dx,dx
	mov dx,50
	mul dx
	add ax,45
	mov pos_cenx,ax
	jmp loop2
loop1:
	mov pos_cenx,0
loop2:
	
	pop dx
	pop cx
	pop bx
	pop ax
ENDM


;======================================
;�õ������������ĵ�y
;======================================
GET_POSNEARY MACRO posy
	local loop1,loop2
	
	push ax
	push bx
	push cx
	push dx
	
	mov ax,posy
	cmp ax,30
	jb loop1
	cmp ax,460
	ja loop1
	
	sub ax,30
	sub dx,dx
	
	mov bx,50
	div bx
	
	cmp dx,30
	ja loop1
	
	sub dx,dx
	mov dx,50
	mul dx
	add ax,45
	mov pos_ceny,ax
	jmp loop2
loop1:
	mov pos_ceny,0
loop2:

	pop dx
	pop cx
	pop bx
	pop ax
	
ENDM

;=======================================================
;��Բ
;=======================================================
CIRCLE MACRO xc,yc,radius,color
       local next1,next2,next3,next4,next5,next6,exit1
    
       push ax
       push bx
       push cx
       push dx
       push si
       push di
       push bp
       
     ;  mov cx,RADIUS
      
;outter:
;	push cx
       mov ah,0ch
       mov al,color
       mov bh,0
       mov cx,xc
       mov dx,yc
       mov si,0         ;X
       mov di,radius    ;Y
       mov bp,1-radius
next1: 
	   cmp si,di
       jl next2
       lea bx,exit1
       jmp bx
next2:
	   inc si
	   
next3: 
       cmp bp,0
       jge next4
       add bp,si
       add bp,si
       add bp,1
       jmp next5
next4: 
	   dec di
       add bp,si
       add bp,si
       sub bp,di
       sub bp,di
       add bp,1
next5: 
	   mov bh,0
       mov cx,xc
       mov dx,yc
       add cx,si
       add dx,di
       int 10h
       mov cx,xc
       mov dx,yc
       sub cx,si
       add dx,di
       int 10h
       mov cx,xc
       mov dx,yc
       add cx,si
       sub dx,di
       int 10h
       mov cx,xc
       mov dx,yc
       sub cx,si
       sub dx,di
       int 10h
       mov cx,xc
       mov dx,yc
       add cx,di
       add dx,si
       int 10h
       mov cx,xc
       mov dx,yc
       sub cx,di
       add dx,si
       int 10h
       mov cx,xc
       mov dx,yc
       add cx,di
       sub dx,si
       int 10h
       mov cx,xc
       mov dx,yc
       sub cx,di
       sub dx,si
       int 10h
next6: 
	   lea bx,next1
       jmp bx
exit1:
       mov ah,0ch
       mov al,color
       mov bh,0
       mov cx,xc-radius
       mov dx,yc
       int 10h
       mov cx,xc+radius
       mov dx,yc
       int 10h
       mov cx,xc
       mov dx,yc-radius
       int 10h
       mov cx,xc
       mov dx,yc+radius
       int 10h
       
   		
;    jnz outter
       
       pop bp
       pop di
       pop si
       pop dx
       pop cx
       pop bx
       pop ax
ENDM

DRAWCIR MACRO x,y,color
	CIRCLE x,y,20,color
	CIRCLE x,y,19,color
	CIRCLE x,y,18,color
	CIRCLE x,y,17,color
	CIRCLE x,y,16,color
	CIRCLE x,y,15,color
	CIRCLE x,y,14,color
	CIRCLE x,y,13,color
	CIRCLE x,y,12,color
	CIRCLE x,y,11,color
	CIRCLE x,y,10,color
	CIRCLE x,y,09,color
	CIRCLE x,y,08,color
	CIRCLE x,y,07,color
	CIRCLE x,y,06,color
	CIRCLE x,y,05,color
	CIRCLE x,y,04,color
	CIRCLE x,y,03,color
	CIRCLE x,y,02,color
	CIRCLE x,y,01,color
	
ENDM


;=====================================
;�жϵ�ǰλ����û������
;=====================================

JUDGE1 MACRO x1,y1
	local loop1,loop2
	
	push ax
	push bx
	push cx
	push dx
	
	mov ax,x1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov colx,ax;�ڼ���
	
	mov ax,y1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov rowy,ax;�ڼ���
	
	;rowy*17+colx
	
	mov ax,rowy
	mov bx,17
	mul bx
	add ax,colx
	mov pianyi,ax
	
	
	
	sub cx,cx
	mov bx,offset map0
	add bx,pianyi
	;mov dx,pianyi
	mov cl,[bx]

	
	cmp cl,0
	jz loop1
	mov jud1,0
	jmp loop2
loop1:
	mov jud1,1
loop2:
	
	pop dx
	pop cx
	pop bx
	pop ax
	
ENDM


;=====================================
;��������
;=====================================
DROP MACRO x1,y1,num
	
	push ax
	push bx
	push cx
	push dx
	
	mov ax,x1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov colx,ax;�ڼ���
	
	mov ax,y1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov rowy,ax;�ڼ���
	
	mov ax,rowy
	mov bx,17
	mul bx
	add ax,colx
	mov pianyi,ax
	mov bx,offset map0
	add bx,pianyi
	;mov si,offset num
	mov al,num
	mov [bx],al
	
	pop dx
	pop cx
	pop bx
	pop ax
	
ENDM


;=====================================
;�����״̬
;=====================================
DRAW_CURSOR MACRO cenx,ceny,color
	
	push ax
	push bx
	push cx
	push dx
	
	mov ax,cenx
	mov bx,ceny
	
	push ax
	push bx
	
	sub ax,20
	sub bx,5
	DRAW_HLINE ax,bx,15,color
	
	pop bx
	pop ax
	
	push ax
	push bx
	
	sub ax,5
	sub bx,20
	DRAW_VLINE ax,bx,15,color
	
	pop bx
	pop ax
	
	push ax
	push bx
	
	sub ax,20
	add bx,5
	DRAW_HLINE ax,bx,15,color
	
	pop bx
	pop ax
	
	push ax
	push bx
	
	sub ax,5
	add bx,5
	DRAW_VLINE ax,bx,15,color
	
	pop bx
	pop ax
	
	push ax
	push bx
	
	add ax,5
	sub bx,20
	DRAW_VLINE ax,bx,15,color
	
	pop bx
	pop ax
	
	push ax
	push bx
	
	add ax,5
	sub bx,5
	DRAW_HLINE ax,bx,15,color
	
	pop bx
	pop ax
	
	push ax
	push bx
	
	add ax,5
	add bx,5
	DRAW_VLINE ax,bx,15,color
	
	pop bx
	pop ax
	
	push ax
	push bx
	
	add ax,5
	add bx,5
	DRAW_HLINE ax,bx,15,color
	
	pop bx
	pop ax

	pop dx
	pop cx
	pop bx
	pop ax
	
ENDM

;==================================================
;�жϺ����Ƿ���5������
;==================================================
JUDGEROW MACRO x1,y1,who
	local loop1,loop2,next,next1,success,fail,endd
	push ax
	push bx
	push cx
	push dx
	;mov qizinum,1
	;mov ax,x;������
	;mov bx,y;������
	
	;����ƫ��
	;mov di,offsite x1
	mov ax,x1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov jcolx,ax;�ڼ���
	
	;mov di,offset y1
	mov ax,y1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov jrowy,ax;�ڼ���
	
	;rowy*17+colx
	
	mov ax,jrowy
	mov bx,17
	mul bx
	add ax,jcolx
	mov pianyi,ax
	
	mov bx,offset map0
	mov ax,pianyi
	add bx,ax
	
	mov qizinum,1
	mov dl,qizinum
	
	;mov ax,pianyi
	;mov ah,who
	mov dh,who
	push bx
	
	mov cl,1
loop1:
	add bx,1
	mov ch,[bx]
	cmp ch,dh
	jnz next
	add dl,1
	add cl,1
	cmp cl,5
	jnz loop1
	
next:
	pop bx
	mov cl,1
loop2:
	sub bx,1
	mov ch,[bx]
	cmp ch,dh
	jnz next1
	add dl,1
	add cl,1
	cmp cl,5
	jnz loop2

next1:
	mov lianzigeshu,dl
	cmp dl,5
	jae success
	jmp fail
success:
	mov judg,1
	jmp endd
fail:
	mov judg,0

endd:

	pop dx
	pop cx
	pop bx
	pop ax
ENDM

;=================================================
;�ж������Ƿ���5������
;=================================================
JUDGECOL MACRO x1,y1,who
	local loop1,loop2,next,next1,success,fail,endd
	push ax
	push bx
	push cx
	push dx
	;mov qizinum,1
	;mov ax,x;������
	;mov bx,y;������
	
	;����ƫ��
	;mov di,offsite x1
	mov ax,x1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov jcolx,ax;�ڼ���
	
	;mov di,offset y1
	mov ax,y1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov jrowy,ax;�ڼ���
	
	;rowy*17+colx
	
	mov ax,jrowy
	mov bx,17
	mul bx
	add ax,jcolx
	mov pianyi,ax
	
	mov bx,offset map0
	mov ax,pianyi
	add bx,ax
	
	mov qizinum,1
	mov dl,qizinum
	
	;mov ax,pianyi
	;mov ah,who
	mov dh,who
	push bx
	
	mov cl,1
loop1:
	add bx,17
	mov ch,[bx]
	cmp ch,dh
	jnz next
	add dl,1
	add cl,1
	cmp cl,5
	jnz loop1
	
next:
	pop bx
	mov cl,1
loop2:
	sub bx,17
	mov ch,[bx]
	cmp ch,dh
	jnz next1
	add dl,1
	add cl,1
	cmp cl,5
	jnz loop2

next1:
	mov lianzigeshu,dl
	cmp dl,5
	jae success
	jmp fail
success:
	mov judg,1
	jmp endd
fail:
	mov judg,0

endd:
	pop dx
	pop cx
	pop bx
	pop ax
ENDM

;=================================================
;�ж����������Ƿ���5������
;=================================================
JUDGELUTORD MACRO x1,y1,who
	local loop1,loop2,next,next1,success,fail,endd
	push ax
	push bx
	push cx
	push dx
	;mov qizinum,1
	;mov ax,x;������
	;mov bx,y;������
	
	;����ƫ��
	;mov di,offsite x1
	mov ax,x1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov jcolx,ax;�ڼ���
	
	;mov di,offset y1
	mov ax,y1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov jrowy,ax;�ڼ���
	
	;rowy*17+colx
	
	mov ax,jrowy
	mov bx,17
	mul bx
	add ax,jcolx
	mov pianyi,ax
	
	mov bx,offset map0
	mov ax,pianyi
	add bx,ax
	
	mov qizinum,1
	mov dl,qizinum
	
	;mov ax,pianyi
	;mov ah,who
	mov dh,who
	push bx
	
	mov cl,1
loop1:
	add bx,18
	mov ch,[bx]
	cmp ch,dh
	jnz next
	add dl,1
	add cl,1
	cmp cl,5
	jnz loop1
	
next:
	pop bx
	mov cl,1
loop2:
	sub bx,18
	mov ch,[bx]
	cmp ch,dh
	jnz next1
	add dl,1
	add cl,1
	cmp cl,5
	jnz loop2

next1:
	mov lianzigeshu,dl
	cmp dl,5
	jae success
	jmp fail
success:
	mov judg,1
	jmp endd
fail:
	mov judg,0

endd:
	pop dx
	pop cx
	pop bx
	pop ax

ENDM


;=================================================
;�ж����������Ƿ���5������
;=================================================

JUDGERUTOLD MACRO x1,y1,who

	local loop1,loop2,next,next1,success,fail,endd
	push ax
	push bx
	push cx
	push dx
	;mov qizinum,1
	;mov ax,x;������
	;mov bx,y;������
	
	;����ƫ��
	;mov di,offsite x1
	mov ax,x1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov jcolx,ax;�ڼ���
	
	;mov di,offset y1
	mov ax,y1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov jrowy,ax;�ڼ���
	
	;rowy*17+colx
	
	mov ax,jrowy
	mov bx,17
	mul bx
	add ax,jcolx
	mov pianyi,ax
	
	mov bx,offset map0
	mov ax,pianyi
	add bx,ax
	
	mov qizinum,1
	mov dl,qizinum
	
	;mov ax,pianyi
	;mov ah,who
	mov dh,who
	push bx
	
	mov cl,1
loop1:
	add bx,16
	mov ch,[bx]
	cmp ch,dh
	jnz next
	add dl,1
	add cl,1
	cmp cl,5
	jnz loop1
	
next:
	pop bx
	mov cl,1
loop2:
	sub bx,16
	mov ch,[bx]
	cmp ch,dh
	jnz next1
	add dl,1
	add cl,1
	cmp cl,5
	jnz loop2

next1:
	mov lianzigeshu,dl
	cmp dl,5
	jae success
	jmp fail
success:
	mov judg,1
	jmp endd
fail:
	mov judg,0

endd:
	pop dx
	pop cx
	pop bx
	pop ax

ENDM

;===========================================
;�������÷֣�����Ϊ���ԣ�	����stateΪ2
;===========================================
GETSCOREBLACK MACRO	x,y
	local next1,next2,next3,next4,four1,four2,four3,four4,three1,three2
	local three3,three4,two1,two2,two3,two4,one1,one2,one3,one4,five1,five2
	local five3,five4,next5,next6,next7
	push ax
	push bx
	push cx
	push dx
	sub ax,ax
	JUDGEROW x,y,2
	mov bl,lianzigeshu
	JUDGECOL x,y,2
	cmp lianzigeshu,bl
	ja next1
	jmp next2
next1:
	mov bl,lianzigeshu
next2:
	JUDGELUTORD x,y,2
	cmp lianzigeshu,bl
	ja next3
	jmp next4
next3:
	mov bl,lianzigeshu
next4:
	JUDGERUTOLD x,y,2
	cmp lianzigeshu,bl
	jb next5
	jmp next6
next5:
	mov lianzigeshu,bl
next6:	
	cmp lianzigeshu,5
	jae five1
	cmp lianzigeshu,4
	jz four1
	cmp lianzigeshu,3
	jz three1
	cmp lianzigeshu,2
	jz two1
	cmp lianzigeshu,1
	jz one1
five1:
	add ax,500
	jmp next7
four1:
	add ax,100
	jmp next7
three1:
	add ax,16
	jmp next7
two1:
	add ax,4
	jmp next7
one1:
	add ax,1
	
next7:
	add ax,1
	mov tempscore,ax
	
	pop dx
	pop cx
	pop bx
	pop ax
ENDM
	
	
;==========================================	
;�������÷֣�����Ϊ�ˣ� ����stateΪ1
;==========================================
GETSCOREWHITE MACRO	x,y
	local next1,next2,next3,next4,four1,four2,four3,four4,three1,three2
	local three3,three4,two1,two2,two3,two4,one1,one2,one3,one4,next5,next6
	local five1,five2,five3,five4,next5,next6,next7,next8,next9
	push ax
	push bx
	push cx
	push dx
	sub ax,ax
	JUDGEROW x,y,1
	mov bl,lianzigeshu
	JUDGECOL x,y,1
	cmp lianzigeshu,bl
	ja next1
	jmp next2
next1:
	mov bl,lianzigeshu
next2:
	JUDGELUTORD x,y,1
	cmp lianzigeshu,bl
	ja next3
	jmp next4
next3:
	mov bl,lianzigeshu
next4:
	JUDGERUTOLD x,y,1
	cmp lianzigeshu,bl
	jb next5
	jmp next6
next5:
	mov lianzigeshu,bl
next6:	
	cmp lianzigeshu,5
	jae five1
	cmp lianzigeshu,4
	jz four1
	cmp lianzigeshu,3
	jz three1
	cmp lianzigeshu,2
	jz two1
	cmp lianzigeshu,1
	jz one1
five1:
	add ax,500
	jmp next7
four1:
	add ax,100
	jmp next7
three1:
	add ax,16
	jmp next7
two1:
	add ax,4
	jmp next7
one1:
	add ax,1
	
next7:
	mov bx,tempscore
	cmp ax,bx
	jae next8
	jmp next9
next8:
	mov tempscore,ax
next9:

	pop dx
	pop cx
	pop bx
	pop ax
ENDM


;=============================================
;�õ�Score������Ҫ�����ӵ�λ��
;=============================================
GETNEXTPOINT MACRO
	local outter,inner,next1,next2,next3
	push ax
	push bx
	push cx
	push dx
	mov maxscore,0
	mov tmpaicenx,45
	mov tmpaiceny,45

outter:
	mov tmpaicenx,45
inner:
	JUDGE1 tmpaicenx,tmpaiceny
	cmp jud1,1
	jnz next2
	GETSCOREBLACK tmpaicenx,tmpaiceny
	GETSCOREWHITE tmpaicenx,tmpaiceny
	mov ax,tempscore
	cmp ax,maxscore
	ja next1
	jmp next2	
next1:
	mov maxscore,ax
	mov ax,tmpaicenx
	mov aicenx,ax
	mov ax,tmpaiceny
	mov aiceny,ax
next2:
	add tmpaicenx,50
	cmp tmpaicenx,495
	jz next3
	jmp inner
next3:
	add tmpaiceny,50
	cmp tmpaiceny,495
	jnz outter	

	pop dx
	pop cx
	pop bx
	pop ax
ENDM	
.MODEL SMALL
.STACK 64
.DATA
 line dw 45,95,145,195,245,295,345,395,445
    ;pointcen dw 30,60,80,110,130,160,180,210,230,260,280,310,330,360,380,410,430,460
    org 20h
    pos_x dw 0
    pos_y dw 0
    pos_cenx dw 0
    pos_ceny dw 0
    pos_lastx dw 95
    pos_lasty dw 95
    
    org 30h
    map0 db 289 dup(0) 
    
    rowy dw ?
    colx dw ?
    
    jrowy dw ?
    jcolx dw ?
    
    org 120h
    ;��ʾ�ܲ�������
    jud1 db 1;0��ʾ���ܣ�1��ʾ��
    ;��ʾ������׵�ַ��ƫ��
    pianyi dw ?
    ;�ж���Ϸ�Ƿ����
    judg db 0
    
    org 130h
    ;��¼��ǰ���ֺ���ɫ
    state db 1
    colo db 15
    
    qizinum db 0
    
    
    org 140h
    
    ;score dw 289 dup(0)
    
    lianzigeshu db 0
	maxscore dw 0
    tempscore dw 0
    aicenx dw 0
    aiceny dw 0
    tmpaicenx dw 0
    tmpaiceny dw 0

    
    ;08��
    ;15��
.CODE
MAIN PROC FAR
	MOV AX,@DATA
	MOV DS,AX
    ;�˴��������δ���
   
restart:	
	CALL SUBPROG1
	CMP AL,'q'
	JE EXIT1
	CMP AL,'Q'
	JE EXIT1
	CMP AH,3BH
	JE ptp
	CMP AH,3CH
	JE ptc
ptp:
	call initdata
	call init
	call mouse
	
AGAIN11:	
	MOV AH,01
	INT 16H
	MOV AH,0
	INT 16H
	CMP AL,'q'
	JE EXIT1	
	CMP AL,'Q'
	JE EXIT1
	CMP AL,'r'
	JE restart
	CMP AL,'R'
	JE restart
	JMP AGAIN11
	
	;jmp EXIT1
	
ptc:
	call initdata
	call init
	call computer
	
AGAIN12:	
	MOV AH,01
	INT 16H
	MOV AH,0
	INT 16H
	CMP AL,'q'
	JE EXIT1	
	CMP AL,'Q'
	JE EXIT1
	CMP AL,'r'
	JE restart
	CMP AL,'R'
	JE restart
	
	JMP AGAIN12
	;jmp EXIT1
		
EXIT1:
    MOV AH,4CH
    INT 21H
    
    
;==================================================
;��ʼ��
;==================================================
init proc
	mov ah,00
	mov al,12h
	int 10h
	mov ah,0bh
	mov bh,00
	mov bl,7
	int 10h
	;cx_col,dx_row
	mov cx,20
	mov dx,20
outter:
	inner:
		mov bh,0
		mov ah,0ch
		mov al,14
		int 10h
		inc cx
		cmp cx,470
		jnz inner
	mov cx,20
	inc dx
	cmp dx,470
	jnz outter
	
	mov cx,8
	mov di,offset line
outter1:
	push cx
	mov dx,45
	inner1:
		mov cx,[di]
		mov bh,0
		mov ah,0ch
		mov al,08
		int 10h
		inc dx
		cmp dx,445
		jnz inner1
	inc di
	pop cx
	loop outter1
	
	mov dx,45
	inner3:
		mov cx,245
		mov bh,0
		mov ah,0ch
		mov al,08
		int 10h
		inc dx
		cmp dx,445
		jnz inner3	
		
	mov dx,45
	inner4:
		mov cx,295
		mov bh,0
		mov ah,0ch
		mov al,08
		int 10h
		inc dx
		cmp dx,445
		jnz inner4	
		
	mov dx,45
	inner5:
		mov cx,345
		mov bh,0
		mov ah,0ch
		mov al,08
		int 10h
		inc dx
		cmp dx,445
		jnz inner5
		
	mov dx,45
	inner6:
		mov cx,395
		mov bh,0
		mov ah,0ch
		mov al,08
		int 10h
		inc dx
		cmp dx,445
		jnz inner6
	mov dx,45	
	inner7:
		mov cx,445
		mov bh,0
		mov ah,0ch
		mov al,08
		int 10h
		inc dx
		cmp dx,445
		jnz inner7
	
	mov cx,17
	mov di,offset line
outter2:
	push cx
	mov cx,45
	inner2:
		mov dx,[di]
		mov bh,0
		mov ah,0ch
		mov al,08
		int 10h
		inc cx
		cmp cx,445
		jnz inner2
	inc di
	pop cx
	loop outter2
	ret
init endp


;==================================
;������
;==================================
mouse proc
	;��ʼ������ʾ���
	mov ax,0
	int 33h
	mov ax,01
	int 33h
	
	
	
again:

	DRAWCIR 540,120,colo
	;����������
	mov ax,03h
	int 33h
	mov ax,cx
	mov pos_x,ax
	mov ax,dx
	mov pos_y,ax	
	
	;�õ���������������̵�
	GET_POSNEARX pos_x
	GET_POSNEARY pos_y
	
	;��������λ�ò��Ϸ�����������һ��Ϊ0
	cmp pos_cenx,0
	jz loop3
	cmp pos_ceny,0
	jz loop3
	
	;������λ�úϷ������ҵ�ǰ�������ֵ�����ı�
	mov ax,pos_cenx
	mov bx,pos_lastx
	cmp ax,bx
	jnz loop2
	mov ax,pos_ceny
	mov bx,pos_lasty
	cmp ax,bx
	jnz loop2
	
	;������λ��û�иı�
	jmp loop1

loop2:
	
	;����ϴ�����λ����û������
;	JUDGE1 pos_lastx,pos_lasty
;	cmp jud1,0
;	jz redrawcir

	;���ϴ����λ������
	DRAW_CURSOR pos_lastx,pos_lasty,14

;redrawcir:
;	DRAWCIR pos_lastx,pos_lasty,colo	
	
	JUDGE1 pos_cenx,pos_ceny
	cmp jud1,0
	jz cantdrop
		
	;��ʾ��ǰ���λ��
	DRAW_CURSOR pos_cenx,pos_ceny,08
	
cantdrop:
	
;	cmp recirx,0
;	jmp next1
;	cmp reciry,0
;	jmp next1
;	DRAWCIR recirx,reciry,recolo
	
;next1:
	
	;�����ϴ����λ��Ϊ��ǰ���λ��
	mov di,offset pos_lastx
	mov si,offset pos_cenx
	mov ax,[si]
	mov [di],ax
	
	mov di,offset pos_lasty
	mov si,offset pos_ceny
	mov ax,[si]
	mov [di],ax
	
loop1:
	;DRAW_CURSOR pos_lastx,pos_lasty,14
	
	;�ȴ���갴��
	mov ax,03h
	int 33h
	cmp bx,0001h
	jne again
	
	;�õ��밴����������̵�
	GET_POSNEARX cx
	GET_POSNEARY dx
	call delay
	
	;�жϷ�Χ�Բ���
	cmp pos_cenx,0
	jz again
	cmp pos_ceny,0
	jz again
	
	;�жϴ˴���û������
	JUDGE1 pos_cenx,pos_ceny
	cmp jud1,0
	jz again
	
	;���û�������ӣ�����map�б��
	DRAWCIR pos_cenx,pos_ceny,colo
	
	DROP pos_cenx,pos_ceny,state
	
	;mov ax,pos_cenx
	;mov recirx,ax
	;mov ax,pos_ceny
	;mov reciry,ax
	;mov al,colo
	;mov recolo,al
	
	;�鿴��Ϸ�Ƿ����
	JUDGEROW pos_cenx,pos_ceny,state
	cmp judg,1
	jz exitgame
	JUDGECOL pos_cenx,pos_ceny,state
	cmp judg,1
	jz exitgame
	JUDGELUTORD pos_cenx,pos_ceny,state
	cmp judg,1
	jz exitgame
	JUDGERUTOLD pos_cenx,pos_ceny,state
	cmp judg,1
	jz exitgame	
	
	;������λ��ֱ�������ı�
reget:	
	mov ax,03h
	int 33h
	mov ax,cx
	mov pos_x,ax
	mov ax,dx
	mov pos_y,ax
	GET_POSNEARX pos_x
	GET_POSNEARY pos_y

	cmp pos_cenx,0
	jz reget
	cmp pos_ceny,0
	jz reget
	;�����ǰ�������ֵ�����ı�
	mov ax,pos_cenx
	mov bx,pos_lastx
	cmp ax,bx
	jnz redrawcircle
	mov ax,pos_ceny
	mov bx,pos_lasty
	cmp ax,bx
	jnz redrawcircle
	jmp reget
	
redrawcircle:

	DRAWCIR pos_lastx,pos_lasty,colo
	;DRAW_CURSOR pos_cenx,pos_ceny,colo
	DRAW_CURSOR pos_lastx,pos_lasty,colo
	mov ax,pos_cenx
	mov pos_lastx,ax
	mov ax,pos_ceny
	mov pos_lasty,ax
	
	;��������
	mov al,state
	cmp al,1
	jz black
	cmp al,2
	jz white
black:
	mov colo,08
	mov state,2
	;DRAWCIR 540,120,colo
	jmp again
white:
	mov colo,15
	mov state,1
	;DRAWCIR 540,120,colo
	jmp again
;next:
;	cmp judg,0
;	jz again


exitgame:
	CALL BEEP
	ret
	;����һ�����λ�û�Ϊ����ɫ�������أ���Ȼ�����»�����λ��	
loop3:
	DRAW_CURSOR pos_lastx,pos_lasty,14
	jmp again
	
	ret
mouse endp

;===========================================================
;�ӳٺ�������������ı�������ɫʱ̫����������
;===========================================================
delay proc
	mov cx,65535
	push ax
wait1:
	in al,61h
	and al,10h
	cmp al,ah
	je wait1
	mov ah,al
	loop wait1
	pop ax
	ret
delay endp


initdata proc
	mov pos_x,0
    mov pos_y,0
    mov pos_cenx,0
    mov pos_ceny,0
    mov pos_lastx,95
    mov pos_lasty,95

    mov di,offset map0
    mov cx,289
inneloop:
	mov ax,0
	mov [di],ax
	inc di
	loop inneloop
    
    mov rowy,0
    mov colx,0
    
    mov jrowy,0
    mov jcolx,0
    
    ;��ʾ�ܲ�������
    mov jud1,1;0��ʾ���ܣ�1��ʾ��
    ;��ʾ������׵�ַ��ƫ��
    mov pianyi,0
    ;�ж���Ϸ�Ƿ����
    mov judg,0
    
    ;org 130h
    ;��¼��ǰ���ֺ���ɫ
    mov state,1
    mov colo,15
    
    mov qizinum,0
    
    mov lianzigeshu,0
	mov maxscore,0
    mov tempscore,0
    mov aicenx,0
    mov aiceny,0
    mov tmpaicenx,0
   	mov tmpaiceny,0
	
	ret
initdata endp


computer proc
	
	
	;��ʼ������ʾ���
	mov ax,0
	int 33h
	mov ax,01
	int 33h
	
again:

	DRAWCIR 540,120,colo
	cmp state,2
	jz comai
	jmp people

comai:
	
	GETNEXTPOINT
	
	cmp aicenx,0
	jz exitgame
	cmp aiceny,0
	jz exitgame
	
	DRAWCIR aicenx,aiceny,colo
	DROP aicenx,aiceny,state
	
	;mov ax,aicenx
	;mov pos_lastx,ax
	;mov ax,aiceny
	;mov pos_lasty,ax
	
	JUDGEROW aicenx,aiceny,state
	cmp judg,1
	jz exitgame
	JUDGECOL aicenx,aiceny,state
	cmp judg,1
	jz exitgame
	JUDGELUTORD aicenx,aiceny,state
	cmp judg,1
	jz exitgame
	JUDGERUTOLD aicenx,aiceny,state
	cmp judg,1
	jz exitgame	
	
	jmp change
	
people:
	;����������
	mov ax,03h
	int 33h
	mov ax,cx
	mov pos_x,ax
	mov ax,dx
	mov pos_y,ax	
	
	;�õ���������������̵�
	GET_POSNEARX pos_x
	GET_POSNEARY pos_y
	
	;��������λ�ò��Ϸ�����������һ��Ϊ0
	cmp pos_cenx,0
	jz loop3
	cmp pos_ceny,0
	jz loop3
	
	;������λ�úϷ������ҵ�ǰ�������ֵ�����ı�
	mov ax,pos_cenx
	mov bx,pos_lastx
	cmp ax,bx
	jnz loop2
	mov ax,pos_ceny
	mov bx,pos_lasty
	cmp ax,bx
	jnz loop2
	
	;������λ��û�иı�
	jmp loop1

loop2:

	JUDGE1 pos_lastx,pos_lasty
	cmp jud1,0
	jz nodraw1 
		
	;���ϴ����λ������
	DRAW_CURSOR pos_lastx,pos_lasty,14
	
nodraw1:
	JUDGE1 pos_cenx,pos_ceny
	cmp jud1,0
	jz cantdrop
		
	;��ʾ��ǰ���λ��
	DRAW_CURSOR pos_cenx,pos_ceny,08
	
cantdrop:
	;�����ϴ����λ��Ϊ��ǰ���λ��
	mov di,offset pos_lastx
	mov si,offset pos_cenx
	mov ax,[si]
	mov [di],ax
	
	mov di,offset pos_lasty
	mov si,offset pos_ceny
	mov ax,[si]
	mov [di],ax
	
loop1:
	
	;�ȴ���갴��
	mov ax,03h
	int 33h
	cmp bx,0001h
	jne again
	
	;�õ��밴����������̵�
	GET_POSNEARX cx
	GET_POSNEARY dx
	call delay
	
	;�жϷ�Χ�Բ���
	cmp pos_cenx,0
	jz again
	cmp pos_ceny,0
	jz again
	
	;�жϴ˴���û������
	JUDGE1 pos_cenx,pos_ceny
	cmp jud1,0
	jz again
	
	;���û�������ӣ�����map�б��
	DRAWCIR pos_cenx,pos_ceny,colo
	
	DROP pos_cenx,pos_ceny,state

	;�鿴��Ϸ�Ƿ����
	JUDGEROW pos_cenx,pos_ceny,state
	cmp judg,1
	jz exitgame
	JUDGECOL pos_cenx,pos_ceny,state
	cmp judg,1
	jz exitgame
	JUDGELUTORD pos_cenx,pos_ceny,state
	cmp judg,1
	jz exitgame
	JUDGERUTOLD pos_cenx,pos_ceny,state
	cmp judg,1
	jz exitgame	
	
	;������λ��ֱ�������ı�
reget:	
	mov ax,03h
	int 33h
	mov ax,cx
	mov pos_x,ax
	mov ax,dx
	mov pos_y,ax
	
	GET_POSNEARX pos_x
	GET_POSNEARY pos_y

	cmp pos_cenx,0
	jz reget
	cmp pos_ceny,0
	jz reget
	;�����ǰ�������ֵ�����ı�
	mov ax,pos_cenx
	mov bx,pos_lastx
	cmp ax,bx
	jnz redrawcircle
	mov ax,pos_ceny
	mov bx,pos_lasty
	cmp ax,bx
	jnz redrawcircle
	jmp reget
	
redrawcircle:

	DRAWCIR pos_lastx,pos_lasty,colo
	;DRAW_CURSOR pos_cenx,pos_ceny,colo
	DRAW_CURSOR pos_lastx,pos_lasty,colo
	mov ax,pos_cenx
	mov pos_lastx,ax
	mov ax,pos_ceny
	mov pos_lasty,ax

change:
	;��������
	mov al,state
	cmp al,1
	jz black
	cmp al,2
	jz white
black:
	mov colo,08
	mov state,2

	jmp again
white:
	mov colo,15
	mov state,1
	jmp again
exitgame:
	CALL BEEP

	ret
	;����һ�����λ�û�Ϊ����ɫ�������أ���Ȼ�����»�����λ��	
loop3:
	JUDGE1 pos_lastx,pos_lasty
	cmp jud1,0
	jz nodraw2
	DRAW_CURSOR pos_lastx,pos_lasty,14
nodraw2:
	jmp again	
	ret
computer endp
MAIN ENDP
	END MAIN












