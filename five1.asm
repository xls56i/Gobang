EXTRN SUBPROG1:FAR
EXTRN BEEP:FAR
;=============================================
;画竖直线
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
;画水平线
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
;得到距离鼠标最近的点x
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
;得到距离鼠标最近的点y
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
;画圆
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
;判断当前位置有没有棋子
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
	mov colx,ax;第几列
	
	mov ax,y1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov rowy,ax;第几行
	
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
;棋盘落子
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
	mov colx,ax;第几列
	
	mov ax,y1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov rowy,ax;第几行
	
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
;画鼠标状态
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
;判断横向是否有5个棋子
;==================================================
JUDGEROW MACRO x1,y1,who
	local loop1,loop2,next,next1,success,fail,endd
	push ax
	push bx
	push cx
	push dx
	;mov qizinum,1
	;mov ax,x;行坐标
	;mov bx,y;纵坐标
	
	;计算偏移
	;mov di,offsite x1
	mov ax,x1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov jcolx,ax;第几列
	
	;mov di,offset y1
	mov ax,y1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov jrowy,ax;第几行
	
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
;判断纵向是否有5个棋子
;=================================================
JUDGECOL MACRO x1,y1,who
	local loop1,loop2,next,next1,success,fail,endd
	push ax
	push bx
	push cx
	push dx
	;mov qizinum,1
	;mov ax,x;行坐标
	;mov bx,y;纵坐标
	
	;计算偏移
	;mov di,offsite x1
	mov ax,x1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov jcolx,ax;第几列
	
	;mov di,offset y1
	mov ax,y1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov jrowy,ax;第几行
	
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
;判断左上右下是否有5个棋子
;=================================================
JUDGELUTORD MACRO x1,y1,who
	local loop1,loop2,next,next1,success,fail,endd
	push ax
	push bx
	push cx
	push dx
	;mov qizinum,1
	;mov ax,x;行坐标
	;mov bx,y;纵坐标
	
	;计算偏移
	;mov di,offsite x1
	mov ax,x1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov jcolx,ax;第几列
	
	;mov di,offset y1
	mov ax,y1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov jrowy,ax;第几行
	
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
;判断右上左下是否有5个棋子
;=================================================

JUDGERUTOLD MACRO x1,y1,who

	local loop1,loop2,next,next1,success,fail,endd
	push ax
	push bx
	push cx
	push dx
	;mov qizinum,1
	;mov ax,x;行坐标
	;mov bx,y;纵坐标
	
	;计算偏移
	;mov di,offsite x1
	mov ax,x1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov jcolx,ax;第几列
	
	;mov di,offset y1
	mov ax,y1
	sub ax,45
	sub dx,dx
	mov bx,50
	div bx
	add ax,4
	mov jrowy,ax;第几行
	
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
;计算黑棋得分（黑棋为电脑）	黑棋state为2
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
;计算白棋得分（白棋为人） 白棋state为1
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
;得到Score表并返回要下棋子的位置
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
    ;表示能不能落子
    jud1 db 1;0表示不能，1表示能
    ;表示相对于首地址的偏移
    pianyi dw ?
    ;判断游戏是否结束
    judg db 0
    
    org 130h
    ;记录当前棋手和颜色
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

    
    ;08黑
    ;15白
.CODE
MAIN PROC FAR
	MOV AX,@DATA
	MOV DS,AX
    ;此处输入代码段代码
   
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
;初始化
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
;鼠标操作
;==================================
mouse proc
	;初始化并显示鼠标
	mov ax,0
	int 33h
	mov ax,01
	int 33h
	
	
	
again:

	DRAWCIR 540,120,colo
	;获得鼠标坐标
	mov ax,03h
	int 33h
	mov ax,cx
	mov pos_x,ax
	mov ax,dx
	mov pos_y,ax	
	
	;得到离此鼠标最近的棋盘点
	GET_POSNEARX pos_x
	GET_POSNEARY pos_y
	
	;如果此鼠标位置不合法，则至少有一个为0
	cmp pos_cenx,0
	jz loop3
	cmp pos_ceny,0
	jz loop3
	
	;如果鼠标位置合法，并且当前鼠标坐标值发生改变
	mov ax,pos_cenx
	mov bx,pos_lastx
	cmp ax,bx
	jnz loop2
	mov ax,pos_ceny
	mov bx,pos_lasty
	cmp ax,bx
	jnz loop2
	
	;如果鼠标位置没有改变
	jmp loop1

loop2:
	
	;检查上次坐标位置有没有棋子
;	JUDGE1 pos_lastx,pos_lasty
;	cmp jud1,0
;	jz redrawcir

	;将上次鼠标位置隐藏
	DRAW_CURSOR pos_lastx,pos_lasty,14

;redrawcir:
;	DRAWCIR pos_lastx,pos_lasty,colo	
	
	JUDGE1 pos_cenx,pos_ceny
	cmp jud1,0
	jz cantdrop
		
	;显示当前鼠标位置
	DRAW_CURSOR pos_cenx,pos_ceny,08
	
cantdrop:
	
;	cmp recirx,0
;	jmp next1
;	cmp reciry,0
;	jmp next1
;	DRAWCIR recirx,reciry,recolo
	
;next1:
	
	;更新上次鼠标位置为当前鼠标位置
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
	
	;等待鼠标按键
	mov ax,03h
	int 33h
	cmp bx,0001h
	jne again
	
	;得到离按键最近的棋盘点
	GET_POSNEARX cx
	GET_POSNEARY dx
	call delay
	
	;判断范围对不对
	cmp pos_cenx,0
	jz again
	cmp pos_ceny,0
	jz again
	
	;判断此处有没有棋子
	JUDGE1 pos_cenx,pos_ceny
	cmp jud1,0
	jz again
	
	;如果没有则画棋子，并在map中标记
	DRAWCIR pos_cenx,pos_ceny,colo
	
	DROP pos_cenx,pos_ceny,state
	
	;mov ax,pos_cenx
	;mov recirx,ax
	;mov ax,pos_ceny
	;mov reciry,ax
	;mov al,colo
	;mov recolo,al
	
	;查看游戏是否结束
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
	
	;获得鼠标位置直到发生改变
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
	;如果当前鼠标坐标值发生改变
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
	
	;交换棋手
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
	;将上一次鼠标位置画为背景色（即隐藏），然后重新获得鼠标位置	
loop3:
	DRAW_CURSOR pos_lastx,pos_lasty,14
	jmp again
	
	ret
mouse endp

;===========================================================
;延迟函数，用来解决改变棋子颜色时太过灵敏问题
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
    
    ;表示能不能落子
    mov jud1,1;0表示不能，1表示能
    ;表示相对于首地址的偏移
    mov pianyi,0
    ;判断游戏是否结束
    mov judg,0
    
    ;org 130h
    ;记录当前棋手和颜色
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
	
	
	;初始化并显示鼠标
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
	;获得鼠标坐标
	mov ax,03h
	int 33h
	mov ax,cx
	mov pos_x,ax
	mov ax,dx
	mov pos_y,ax	
	
	;得到离此鼠标最近的棋盘点
	GET_POSNEARX pos_x
	GET_POSNEARY pos_y
	
	;如果此鼠标位置不合法，则至少有一个为0
	cmp pos_cenx,0
	jz loop3
	cmp pos_ceny,0
	jz loop3
	
	;如果鼠标位置合法，并且当前鼠标坐标值发生改变
	mov ax,pos_cenx
	mov bx,pos_lastx
	cmp ax,bx
	jnz loop2
	mov ax,pos_ceny
	mov bx,pos_lasty
	cmp ax,bx
	jnz loop2
	
	;如果鼠标位置没有改变
	jmp loop1

loop2:

	JUDGE1 pos_lastx,pos_lasty
	cmp jud1,0
	jz nodraw1 
		
	;将上次鼠标位置隐藏
	DRAW_CURSOR pos_lastx,pos_lasty,14
	
nodraw1:
	JUDGE1 pos_cenx,pos_ceny
	cmp jud1,0
	jz cantdrop
		
	;显示当前鼠标位置
	DRAW_CURSOR pos_cenx,pos_ceny,08
	
cantdrop:
	;更新上次鼠标位置为当前鼠标位置
	mov di,offset pos_lastx
	mov si,offset pos_cenx
	mov ax,[si]
	mov [di],ax
	
	mov di,offset pos_lasty
	mov si,offset pos_ceny
	mov ax,[si]
	mov [di],ax
	
loop1:
	
	;等待鼠标按键
	mov ax,03h
	int 33h
	cmp bx,0001h
	jne again
	
	;得到离按键最近的棋盘点
	GET_POSNEARX cx
	GET_POSNEARY dx
	call delay
	
	;判断范围对不对
	cmp pos_cenx,0
	jz again
	cmp pos_ceny,0
	jz again
	
	;判断此处有没有棋子
	JUDGE1 pos_cenx,pos_ceny
	cmp jud1,0
	jz again
	
	;如果没有则画棋子，并在map中标记
	DRAWCIR pos_cenx,pos_ceny,colo
	
	DROP pos_cenx,pos_ceny,state

	;查看游戏是否结束
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
	
	;获得鼠标位置直到发生改变
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
	;如果当前鼠标坐标值发生改变
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
	;交换棋手
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
	;将上一次鼠标位置画为背景色（即隐藏），然后重新获得鼠标位置	
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












