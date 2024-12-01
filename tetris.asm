INCLUDE Irvine32.inc
main          EQU start@0
Drawplayer PROTO,,player:PTR BYTE, block_type:BYTE, xpos:byte, ypos:byte, direction:byte
Draw PROTO
.data
xpos_1 BYTE 5
ypos_1 BYTE 1
xpos_2 BYTE 5
ypos_2 BYTE 1
inputChar BYTE ?
isJumping BYTE ?
player_1 Byte 20 dup('..........',0)
empty Byte '             ',0
player_2 Byte 20 dup('..........',0)
.code
main PROC
    ;mov eax,green+(blue*16) ;設定顏色 背景藍色 方塊可以隨便改
    call SetTextColor
    gameloop:
    invoke Drawplayer,OFFSET [player_1] ,'f' ,xpos_1 ,ypos_1 ,1
    invoke Draw
    call ReadChar
    jmp gameloop
    exit
main ENDP
Drawplayer PROC,player:PTR BYTE, block_type:BYTE, xpos:byte, ypos:byte, direction:byte
    mov edx,player
    mov eax,0
    mov al,ypos
    mov bl,11
    mul bl
    add al,xpos
    add edx,eax
    mov BYTE PTR [edx],'X'
    ; .IF block_type=='I'
    ;     .IF direction==1  ;| center is at bottom 2

    ;     .ENDIF
    ;     .IF direction==2  ;___ center is at right 2

    ;     .ENDIF
    ; .ENDIF
    ; .IF block_type=='O'

    ; .ENDIF
    ; .IF block_type=='T'

    ; .ENDIF
    ; .IF block_type=='S'

    ; .ENDIF
    ; .IF block_type=='Z'

    ; .ENDIF
    ; .IF block_type=='J'

    ; .ENDIF
Drawplayer ENDP
Draw PROC
    mov ecx,20
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