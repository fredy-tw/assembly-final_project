INCLUDE Irvine32.inc
.data
xpos BYTE 10
ypos BYTE 10
inputChar BYTE ?
ground BYTE "-----------------------------------------------------------------------------------------------------------", 0
main          EQU start@0
.code
main PROC
    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx, OFFSET ground
    call WriteString

    call DrawPlayer

    gameLoop: 
        ;get user input
        call ReadChar
        ;mov ax,al
        .IF ax == 2d58h ;input x 
        je exitGame
	    .ENDIF
	    .IF ax== 4800h ;UP ARROW
		    jmp moveUp
	    .ENDIF
        .IF ax== 5000h ;DOWN ARROW
            jmp moveDown
	    .ENDIF
	    .IF ax== 4B00h ;LEFT ARROW
            jmp moveLeft
    	.ENDIF
	    .IF ax== 4D00h ;RIGHT ARROW
            jmp moveRight
	    .ENDIF
        ;cmp ax,'X'
        ;je exitGame
        ;cmp ax,'w'
        ;je moveUp
        moveUp:
            dec xpos    
        moveDown:
            inc xpos
        moveLeft:
            dec ypos
        moveRight:
            inc ypos
    jmp gameLoop

    exitGame:
    call ReadChar

    exit
main ENDP
DrawPlayer PROC
    ;draw player at (x,y)
    mov al,'X'
    mov dl,xpos
    mov dh,ypos
    call Gotoxy
    call WriteChar
    ret
DrawPlayer ENDP
END main