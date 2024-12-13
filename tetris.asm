INCLUDE Irvine32.inc
;TitleWidth=26
;TitleHeight=7
;Buttonwidth=12
;ButtonHeight=5
main          EQU start@0
Drawplayer PROTO,player:PTR BYTE, block_type:BYTE, xpos:byte, ypos:byte, direction:byte,paint:byte
Rotate_block PROTO,player:PTR BYTE,block_type:BYTE,xpos:byte,ypos:byte,direction:byte,lr:byte 
Rotate_I PROTO,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
Rotate_S PROTO,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
Rotate_T PROTO,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
Rotate_J PROTO,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
Rotate_Z PROTO,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
Rotate_L PROTO,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
Collison_block PROTO,player:PTR BYTE, block_type:BYTE, xpos:byte, ypos:byte, direction:byte
Draw PROTO
;DrawTitle PROTO
;DrawButton1 PROTO
;DrawButton2 PROTO
;DrawButtonExit PROTO
;CheckState PROTO
.data
xpos_1 BYTE 4
ypos_1 BYTE 1
xpos_2 BYTE 4
ypos_2 BYTE 1
inputChar BYTE ?
isJumping BYTE ?
player_1type byte ?;indicate what kind of block player is controling I O J L S Z T
player_2type byte ? 
player_1direction byte ?
player_2direction byte ?
generate_1 byte 1
generate_2 byte 1
player_1 Byte 22 dup('..........',0);多出來的兩格是 給一開始方塊的位置
empty Byte '             ',0
player_2 Byte 22 dup('..........',0)
.code
main PROC
    ;mov eax,green+(blue*16) ;設定顏色 背景藍色 方塊可以隨便改
    call SetTextColor
    gameloop:
    .IF player_1==1
    .ENDIF
    invoke Drawplayer,OFFSET [player_1] ,'I' ,xpos_1 ,ypos_1,'1','X'
    invoke Draw
    call ReadChar
    jmp gameloop
    call ReadChar
    exit
main ENDP
;DrawTitle PROC
;   
;DrawTitle ENDP

;DrawButton1 PROC
;
;DrawButton1 ENDP

;DrawButton2 PROC
;
;DrawButton2 ENDP

;DrawButtonExit PROC
;
;DrawButtonExit ENDP

;CheckState PROC
;
;CheckState ENDP
Generate_block PROC
Generate_block ENDP
Drawplayer PROC,player:PTR BYTE, block_type:BYTE, xpos:byte, ypos:byte, direction:byte,paint:byte;最後一個參數使我們可以決定畫什麼方塊
    mov edx,player
    mov eax,0
    mov al,ypos
    mov bl,11
    mul bl
    add al,xpos
    add edx,eax
    mov al,paint
    .IF block_type=='I' ;not good 
        .IF direction==1 
            dec edx
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al 
            inc edx
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
        .ENDIF
        .IF direction==2 
            sub edx,11
            mov BYTE PTR [edx],al 
            add edx,11
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al
        .ENDIF
        .IF direction==3 
            sub edx,2
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
        .ENDIF
        .IF direction==4
            sub edx,22
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al
        .ENDIF
    .ENDIF
    .IF block_type=='O' ; good
        mov BYTE PTR [edx],al
        inc edx
        mov BYTE PTR [edx],al
        sub edx,11
        mov BYTE PTR [edx],al
        dec edx
        mov BYTE PTR [edx],al
    .ENDIF
    .IF block_type=='T' ;good
        .IF direction==1 ;face up
            sub edx,11
            mov BYTE PTR [edx],al
            add edx,10
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
        .ENDIF
        .IF direction==2  ;face right
            sub edx,11
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
            add edx,10
            mov BYTE PTR [edx],al
        .ENDIF
        .IF direction==3 ;face down
            dec edx
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al 
            inc edx
            mov BYTE PTR [edx],al
            add edx,10
            mov BYTE PTR [edx],al
        .ENDIF
        .IF direction==4 ;face left
            sub edx,11
            mov BYTE PTR [edx],al
            add edx,10
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al
        .ENDIF
    .ENDIF
    .IF block_type=='S' ;good
        .IF direction==1 
            sub edx,11
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
            add edx,9
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
        .ENDIF
        .IF direction==2  
            sub edx,11
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al 
            inc edx
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al
        .ENDIF
        .IF direction==3
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
            add edx,9
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
        .ENDIF
        .IF direction==4
            sub edx,12
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al
        .ENDIF
    .ENDIF
    .IF block_type=='Z' ;good
        .IF direction==1 
            sub edx,12
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
        .ENDIF
        .IF direction==2  
            sub edx,10
            mov BYTE PTR [edx],al
            add edx,10
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
            add edx,10
            mov BYTE PTR [edx],al
        .ENDIF
        .IF direction==3
            dec edx
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
        .ENDIF
        .IF direction==4
            sub edx,11
            mov BYTE PTR [edx],al
            add edx,10
            mov BYTE PTR [edx],al 
            inc edx
            mov BYTE PTR [edx],al
            add edx,10
            mov BYTE PTR [edx],al
        .ENDIF
    .ENDIF
    .IF block_type=='L' ;good
        .IF direction==1
            sub edx,12
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
        .ENDIF
        .IF direction==2  
            sub edx,11
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
            add edx,10
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al
        .ENDIF
        .IF direction==3
            dec edx
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al 
            add edx,11
            mov BYTE PTR [edx],al
        .ENDIF
        .IF direction==4
            sub edx,11
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al
            add edx,10
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
        .ENDIF
    .ENDIF
    .IF block_type=='J' ;good
        .IF direction==1
            sub edx,10
            mov BYTE PTR [edx],al
            add edx,9
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al 
            inc edx
            mov BYTE PTR [edx],al
        .ENDIF
        .IF direction==2  
            sub edx,11
            mov BYTE PTR [edx],al 
            add edx,11
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al 
            inc edx
            mov BYTE PTR [edx],al
        .ENDIF
        .IF direction==3
            dec edx
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
            add edx,9
            mov BYTE PTR [edx],al
        .ENDIF
        .IF direction==4
            sub edx,12
            mov BYTE PTR [edx],al
            inc edx
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al
            add edx,11
            mov BYTE PTR [edx],al
        .ENDIF
    .ENDIF
    ret
Drawplayer ENDP
Draw PROC
    mov ecx,22
    mov dl,3;xpos
    mov dh,3;ypos
    mov ebx,0
    L:
        call Gotoxy
        mov al,dl
        mov ah,dh
        mov edx, OFFSET player_1
        add edx,ebx
        call WriteString
        mov dh,ah
        mov dl,al
        add dl,22
        call Gotoxy
        mov edx, OFFSET player_2
        add edx,ebx
        call WriteString
        add ebx,11
        mov dh,ah
        mov dl,al
        call Crlf
        inc dh
        loop L
    call ReadChar
Draw ENDP
Collison_block PROC,player:PTR BYTE, block_type:BYTE, xpos:byte, ypos:byte, direction:byte ; 0 collide 1 safe to place
    mov edx,player
    mov eax,0
    mov al,ypos
    mov bl,11
    mul bl
    add al,xpos
    add edx,eax
    mov bl,1
    .IF block_type=='I' ;not good 
        .IF direction==1 
            dec edx
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
        .IF direction==2 
            sub edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
        .IF direction==3 
            sub edx,2
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
        .IF direction==4
            sub edx,22
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
    .ENDIF
    .IF block_type=='O' ; good
        cmp BYTE PTR [edx],'.'
        jne collison
        inc edx
        cmp BYTE PTR [edx],'.'
        jne collison
        sub edx,11
        cmp BYTE PTR [edx],'.'
        jne collison
        dec edx
        cmp BYTE PTR [edx],'.'
        jne collison
        mov bl,1
        ret
    .ENDIF
    .IF block_type=='T' ;good
        .IF direction==1 ;face up
            sub edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,10
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
        .IF direction==2  ;face right
            sub edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,10
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
        .IF direction==3 ;face down
            dec edx
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,10
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
        .IF direction==4 ;face left
            sub edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,10
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
    .ENDIF
    .IF block_type=='S' ;good
        .IF direction==1 
            sub edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,9
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
        .IF direction==2  
            sub edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
        .IF direction==3
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,9
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
        .IF direction==4
            sub edx,12
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
    .ENDIF
    .IF block_type=='Z' ;good
        .IF direction==1 
            sub edx,12
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
        .IF direction==2  
            sub edx,10
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,10
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,10
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
        .IF direction==3
            dec edx
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
        .IF direction==4
            sub edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,10
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,10
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
    .ENDIF
    .IF block_type=='L' ;good
        .IF direction==1
            sub edx,12
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
        .IF direction==2  
            sub edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,10
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
        .IF direction==3
            dec edx
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
        .IF direction==4
            sub edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,10
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
    .ENDIF
    .IF block_type=='J' ;good
        .IF direction==1
            sub edx,10
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,9
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.' 
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
        .IF direction==2  
            sub edx,11
            cmp BYTE PTR [edx],'.' 
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.' 
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
        .IF direction==3
            dec edx
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,9
            cmp BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
        .IF direction==4
            sub edx,12
            cmp BYTE PTR [edx],'.'
            jne collison
            inc edx
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            cmp BYTE PTR [edx],'.'
            jne collison
            add edx,11
            mov BYTE PTR [edx],'.'
            jne collison
            mov bl,1
            ret
        .ENDIF
    .ENDIF
    collison:
    mov bl,0
    ret
Collison_block ENDP
Rotate_block PROC,player:PTR BYTE,block_type:BYTE,xpos:byte,ypos:byte,direction:byte,lr:byte
    .IF block_type=='I'
        invoke Rotate_I,player,xpos,ypos,direction,lr
    .ENDIF
    .IF block_type=='S'
        invoke Rotate_S,player,xpos,ypos,direction,lr
    .ENDIF
    .IF block_type=='Z'
        invoke Rotate_Z,player,xpos,ypos,direction,lr
    .ENDIF
    .IF block_type=='T'
        invoke Rotate_T,player,xpos,ypos,direction,lr
    .ENDIF
    .IF block_type=='J'
        invoke Rotate_J,player,xpos,ypos,direction,lr
    .ENDIF
    .IF block_type=='L'
        invoke Rotate_L,player,xpos,ypos,direction,lr
    .ENDIF
Rotate_block ENDP
Rotate_I PROC,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
    .IF lr=='r'
        .IF direction=='1'
            _1rtest1:

            _1rtest2:
            
            _1rtest3:

            _1rtest4:

            _1rtest5:

        .ENDIF
        .IF direction=='2'
            _2rtest1:

            _2rtest2:

            _2rtest3:

            _2rtest4:

            _2rtest5:
        .ENDIF
        .IF direction=='3'
            _3rtest1:

            _3rtest2:

            _3rtest3:

            _3rtest4:

            _3rtest5:
        .ENDIF
        .IF direction=='4'
            _4rtest1:

            _4rtest2:

            _4rtest3:

            _4rtest4:

            _4rtest5:
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction=='1'
            _1ltest1:

            _1ltest2:
            
            _1ltest3:

            _1ltest4:

            _1ltest5:

        .ENDIF
        .IF direction=='2'
            _2ltest1:

            _2ltest2:

            _2ltest3:

            _2ltest4:

            _2ltest5:
        .ENDIF
        .IF direction=='3'
            _3ltest1:

            _3ltest2:

            _3ltest3:

            _3ltest4:

            _3ltest5:
        .ENDIF
        .IF direction=='4'
            _4ltest1:

            _4ltest2:

            _4ltest3:

            _4ltest4:

            _4ltest5:
        .ENDIF
    .ENDIF
Rotate_I ENDP
Rotate_S PROC,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
    .IF lr=='r'
        .IF direction=='1'
            _1rtest1:

            _1rtest2:
            
            _1rtest3:

            _1rtest4:

            _1rtest5:

        .ENDIF
        .IF direction=='2'
            _2rtest1:

            _2rtest2:

            _2rtest3:

            _2rtest4:

            _2rtest5:
        .ENDIF
        .IF direction=='3'
            _3rtest1:

            _3rtest2:

            _3rtest3:

            _3rtest4:

            _3rtest5:
        .ENDIF
        .IF direction=='4'
            _4rtest1:

            _4rtest2:

            _4rtest3:

            _4rtest4:

            _4rtest5:
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction=='1'
            _1ltest1:

            _1ltest2:
            
            _1ltest3:

            _1ltest4:

            _1ltest5:

        .ENDIF
        .IF direction=='2'
            _2ltest1:

            _2ltest2:

            _2ltest3:

            _2ltest4:

            _2ltest5:
        .ENDIF
        .IF direction=='3'
            _3ltest1:

            _3ltest2:

            _3ltest3:

            _3ltest4:

            _3ltest5:
        .ENDIF
        .IF direction=='4'
            _4ltest1:

            _4ltest2:

            _4ltest3:

            _4ltest4:

            _4ltest5:
        .ENDIF
    .ENDIF
Rotate_S ENDP
Rotate_Z PROC,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:Byte
    .IF lr=='r'
        .IF direction=='1'
            _1rtest1:
                invoke Collison_block,player,'Z',xpos,ypos,'2'
                cmp bl,1
                jne _1rtest2
                invoke Drawplayer,player,'Z',xpos,ypos,'1','.' 
                mov direction,'2'
                invoke Drawplayer,player,'Z',xpos,ypos,direction,'X' 
                ret
            _1rtest2:
                invoke Collison_block,player,'Z',xpos-1,ypos,'2'
                cmp bl,1
                jne _1rtest3
                invoke Drawplayer,player,'Z',xpos,ypos,'1','.' 
                dec xpos
                mov direction,'2'
                invoke Drawplayer,player,'Z',xpos,ypos,direction,'X' 
                ret
            _1rtest3:
                invoke Collison_block,player,'Z',xpos-1,ypos-1,'2'
                cmp bl,1
                jne _1rtest4
                invoke Drawplayer,player,'Z',xpos,ypos,'1','.' 
                mov direction,'2'
                dec xpos
                dec ypos
                invoke Drawplayer,player,'Z',xpos,ypos,direction,'X' 
                ret
            _1rtest4:                
                cmp ypos,19
                jg _dontmove
                invoke Collison_block,player,'Z',xpos,ypos+2,'2'
                cmp bl,1
                jne _1rtest5
                invoke Drawplayer,player,'Z',xpos,ypos,'1','.' 
                mov direction,'2'
                add ypos,2
                invoke Drawplayer,player,'Z',xpos,ypos,'1','X' 
                ret
            _1rtest5:
                invoke Collison_block,player,'Z',xpos-1,ypos+2,'2'
                cmp bl,1
                jne _dontmove
                invoke Drawplayer,player,'Z',xpos,ypos,'1','.' 
                mov direction,'2'
                invoke Drawplayer,player,'Z',xpos,ypos,'1','X' 
                ret
            _dontmove:
                ret
        .ENDIF
        .IF direction=='2'
            _2rtest1:
                invoke Collison_block,player,'Z',xpos,ypos,'3'
                cmp bl,1
                jne _2rtest2
                invoke Drawplayer,player,'Z',xpos,ypos,direction,'.'
                mov direction,'3'
                invoke Drawplayer,player,'Z',xpos,ypos,direction,'X'
                ret
            _2rtest2:
                cmp xpos,9
                jg _2rtest3
                invoke Collison_block,player,'Z',xpos+1,ypos,'3'
            _2rtest3:

            _2rtest4:

            _2rtest5:
        .ENDIF
        .IF direction=='3'
            _3rtest1:

            _3rtest2:

            _3rtest3:

            _3rtest4:

            _3rtest5:
        .ENDIF
        .IF direction=='4'
            _4rtest1:

            _4rtest2:

            _4rtest3:

            _4rtest4:

            _4rtest5:
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction=='1'
            _1ltest1:

            _1ltest2:
            
            _1ltest3:

            _1ltest4:

            _1ltest5:

        .ENDIF
        .IF direction=='2'
            _2ltest1:

            _2ltest2:

            _2ltest3:

            _2ltest4:

            _2ltest5:
        .ENDIF
        .IF direction=='3'
            _3ltest1:

            _3ltest2:

            _3ltest3:

            _3ltest4:

            _3ltest5:
        .ENDIF
        .IF direction=='4'
            _4ltest1:

            _4ltest2:

            _4ltest3:

            _4ltest4:

            _4ltest5:
        .ENDIF
    .ENDIF
Rotate_Z ENDP
Rotate_T PROC,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
    .IF lr=='r'
        .IF direction=='1'
            _1rtest1:

            _1rtest2:
            
            _1rtest3:

            _1rtest4:

            _1rtest5:

        .ENDIF
        .IF direction=='2'
            _2rtest1:

            _2rtest2:

            _2rtest3:

            _2rtest4:

            _2rtest5:
        .ENDIF
        .IF direction=='3'
            _3rtest1:

            _3rtest2:

            _3rtest3:

            _3rtest4:

            _3rtest5:
        .ENDIF
        .IF direction=='4'
            _4rtest1:

            _4rtest2:

            _4rtest3:

            _4rtest4:

            _4rtest5:
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction=='1'
            _1ltest1:

            _1ltest2:
            
            _1ltest3:

            _1ltest4:

            _1ltest5:

        .ENDIF
        .IF direction=='2'
            _2ltest1:

            _2ltest2:

            _2ltest3:

            _2ltest4:

            _2ltest5:
        .ENDIF
        .IF direction=='3'
            _3ltest1:

            _3ltest2:

            _3ltest3:

            _3ltest4:

            _3ltest5:
        .ENDIF
        .IF direction=='4'
            _4ltest1:

            _4ltest2:

            _4ltest3:

            _4ltest4:

            _4ltest5:
        .ENDIF
    .ENDIF
Rotate_T ENDP
Rotate_J PROC,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
    .IF lr=='r'
        .IF direction=='1'
            _1rtest1:

            _1rtest2:
            
            _1rtest3:

            _1rtest4:

            _1rtest5:

        .ENDIF
        .IF direction=='2'
            _2rtest1:

            _2rtest2:

            _2rtest3:

            _2rtest4:

            _2rtest5:
        .ENDIF
        .IF direction=='3'
            _3rtest1:

            _3rtest2:

            _3rtest3:

            _3rtest4:

            _3rtest5:
        .ENDIF
        .IF direction=='4'
            _4rtest1:

            _4rtest2:

            _4rtest3:

            _4rtest4:

            _4rtest5:
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction=='1'
            _1ltest1:

            _1ltest2:
            
            _1ltest3:

            _1ltest4:

            _1ltest5:

        .ENDIF
        .IF direction=='2'
            _2ltest1:

            _2ltest2:

            _2ltest3:

            _2ltest4:

            _2ltest5:
        .ENDIF
        .IF direction=='3'
            _3ltest1:

            _3ltest2:

            _3ltest3:

            _3ltest4:

            _3ltest5:
        .ENDIF
        .IF direction=='4'
            _4ltest1:

            _4ltest2:

            _4ltest3:

            _4ltest4:

            _4ltest5:
        .ENDIF
    .ENDIF
Rotate_J ENDP
Rotate_L PROC,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
    .IF lr=='r'
        .IF direction=='1'
            _1rtest1:

            _1rtest2:
            
            _1rtest3:

            _1rtest4:

            _1rtest5:

        .ENDIF
        .IF direction=='2'
            _2rtest1:

            _2rtest2:

            _2rtest3:

            _2rtest4:

            _2rtest5:
        .ENDIF
        .IF direction=='3'
            _3rtest1:

            _3rtest2:

            _3rtest3:

            _3rtest4:

            _3rtest5:
        .ENDIF
        .IF direction=='4'
            _4rtest1:

            _4rtest2:

            _4rtest3:

            _4rtest4:

            _4rtest5:
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction=='1'
            _1ltest1:

            _1ltest2:
            
            _1ltest3:

            _1ltest4:

            _1ltest5:

        .ENDIF
        .IF direction=='2'
            _2ltest1:

            _2ltest2:

            _2ltest3:

            _2ltest4:

            _2ltest5:
        .ENDIF
        .IF direction=='3'
            _3ltest1:

            _3ltest2:

            _3ltest3:

            _3ltest4:

            _3ltest5:
        .ENDIF
        .IF direction=='4'
            _4ltest1:

            _4ltest2:

            _4ltest3:

            _4ltest4:

            _4ltest5:
        .ENDIF
    .ENDIF
Rotate_L ENDP
END main