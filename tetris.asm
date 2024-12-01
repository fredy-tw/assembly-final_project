INCLUDE Irvine32.inc
.data
xpos BYTE 10
ypos BYTE 10
inputChar BYTE ?
isJumping BYTE ?
player_1 Byte 20 dup('..........',0)
empty Byte '             ',0
player_2 Byte 20 dup('..........',0)
main          EQU start@0
.code
main PROC
    ;mov eax,green+(blue*16) ;設定顏色 背景藍色 方塊可以隨便改
    call SetTextColor
    call Draw
    call ReadChar
    exit
main ENDP

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