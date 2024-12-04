INCLUDE Irvine32.inc
main          EQU start@0
Drawplayer PROTO,player:PTR BYTE, block_type:BYTE, xpos:byte, ypos:byte, direction:byte,paint:byte
Rotate_block PROTO,player:PTR BYTE,block_type:BYTE,xpos:byte,ypos:byte,direction:byte
Draw PROTO
.data
xpos_1 BYTE 4
ypos_1 BYTE 1
xpos_2 BYTE 4
ypos_2 BYTE 1
inputChar BYTE ?
isJumping BYTE ?
player_1type byte ?;indicate what kind of block player is controling I O J L S Z T
player_2type byte ? 
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
    invoke Drawplayer,OFFSET [player_1] ,'J' ,xpos_1 ,ypos_1,4,'X'
    ; invoke Drawplayer,OFFSET [player_1] ,'O' ,xpos_1 ,ypos_1,1,'x'
    invoke Draw
    call ReadChar
    jmp gameloop
    call ReadChar
    exit
main ENDP
Generate_block PROC
Generate_block ENDP
Rotate_block PROC,player:PTR BYTE,block_type:BYTE,xpos:byte,ypos:byte,direction:byte
    mov edx,player
    mov eax,0
    mov al,ypos
    mov bl,11
    mul bl
    add al,xpos
    add edx,eax
Rotate_block ENDP
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
        .IF direction==1 ;left center 2
        .ENDIF
        .IF direction==2  ;up 2
        .ENDIF
        .IF direction==3 ;right 2

        .ENDIF
        .IF direction==4 ;down 2

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

; DrawPlayer PROC
;     ;draw player at (x,y)
;     mov al,'X'
;     mov dl,xpos
;     mov dh,ypos
;     call Gotoxy
;     call WriteChar
    
;     mov eax,'XXX'
;     dec dl
;     inc dh
;     call Gotoxy
;     call WriteString
;     ; mov
;     ret
; DrawPlayer ENDP
; Updateplayer PROC
;     mov al,' '
;     mov dl,xpos
;     mov dh,ypos
;     call Gotoxy
;     call WriteChar
;     ret
; Updateplayer ENDP
END main