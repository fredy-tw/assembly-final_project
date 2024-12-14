INCLUDE Irvine32.inc
main          EQU start@0
Drawplayer PROTO,paint:byte
Move_block PROTO,move_type:byte
Rotate_block PROTO,lr:byte
Rotate_I PROTO,lr:byte
Rotate_S PROTO,lr:byte
Rotate_T PROTO,lr:byte
Rotate_J PROTO,lr:byte
Rotate_Z PROTO,lr:byte
Rotate_L PROTO,lr:byte
Collision_block PROTO,dir:byte
Drop_block PROTO,dir:byte
Draw PROTO
Generate_block PROTO
;DrawTitle PROTO
DrawButton1 PROTO,State:byte
DrawButtonExit PROTO,State:byte
;CheckState PROTO
TitleWidth = 26
TitleHeight = 7
Buttonwidth = 13
ButtonHeight = 3
.data

Button1_State Byte 1
ButtonExit_State Byte 0
ButtonTop    BYTE 0DAh, (Buttonwidth - 2) DUP(0C4h), 0BFh 
ButtonBody1   BYTE 0B3h, (3) DUP(' '), 'S', 'T', 'A', 'R', 'T', (3) DUP(' '), 0B3h ;STARTButton
ButtonBody2   BYTE 0B3h, (4) DUP(' '), 'E', 'X', 'I', 'T', (3) DUP(' '), 0B3h ;EXITButton
ButtonBottom BYTE 0C0h, (Buttonwidth - 2) DUP(0C4h), 0D9h
outputHandle DWORD 0
bytesWritten DWORD 0
attributes1 WORD ButtonWidth DUP(0Ch)
attributes2 WORD ButtonWidth DUP(0Fh)
xyPosition COORD <10,5>
cellsWritten DWORD ?
xpos BYTE 4
ypos BYTE 1
inputChar BYTE ?
isJumping BYTE ?
block_type byte 'O';indicate what kind of block player is controling I O J L S Z T
direction byte 1
player Byte 22 dup('..........',0),2 dup('xxxxxxxxxx',0);多出來的兩格是 給一開始方塊的位置
collisioned Byte 1 ;to check if it is collision, 1 means not collision, 0 means collision
hConsoleInput HANDLE 0
temp BYTE 0
.code
    SetConsoleOutputCP PROTO STDCALL :DWORD
main PROC
    INVOKE SetConsoleOutputCP, 437
    INVOKE GetStdHandle, STD_INPUT_HANDLE
    mov hConsoleInput, eax
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov outputHandle, eax
    ;mov eax,red+(blue*16) ;設定顏色 背景藍色 方塊可以隨便改
    ;call SetTextColor
    ;invoke DrawTitle
Buttons:
    ;invoke DrawButton1, Button1_State
    ;invoke DrawButtonExit, ButtonExit_State
    ;invoke CheckState
  
    call Clrscr
gameloop_out:
    mov collisioned, 1
    invoke Generate_block
    invoke Drawplayer, 'X'
    invoke Draw
gameloop_in:
    mov ecx, 5
gameloop:
    mov eax, 200
    call Delay
    push eax
    call ReadKey
    jz no_input
    .IF al == 'a'
        mov temp, 1
    .ELSEIF al == 's'
        mov temp, 2
    .ELSEIF al == 'd'
        mov temp, 3
    .ENDIF
    invoke Move_block, temp
no_input:
    pop eax
    loop gameloop
    mov collisioned, 1
    invoke Drop_block, direction
    ;call ReadChar
    cmp collisioned, 1
    je gameloop_in
    jmp gameloop_out
    ;call ReadChar
    exit
main ENDP


;DrawTitle PROC
;  
;DrawTitle ENDP

DrawButton1 PROC, State:Byte
    .IF State==1
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes2,
            ButtonWidth, 
            xyPosition,
            ADDR cellsWritten
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonTop,	; pointer to the top box line
            ButtonWidth,	; size of box line
            xyPosition,	; coordinates of first char
            ADDR cellsWritten	; output count
            
        inc xyPosition.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes2,
            ButtonWidth, 
            xyPosition,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBody1,	; pointer to the box body
            ButtonWidth,	; size of box line
            xyPosition,	; coordinates of first char
            ADDR cellsWritten	; output count
        
        inc xyPosition.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes2,
            ButtonWidth, 
            xyPosition,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBottom,	; pointer to the bottom of the box
            ButtonWidth,	; size of box line
            xyPosition,	; coordinates of first char
            ADDR cellsWritten	; output count
    .ELSEIF State==0
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes1,
            ButtonWidth, 
            xyPosition,
            ADDR cellsWritten
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonTop,	; pointer to the top box line
            ButtonWidth,	; size of box line
            xyPosition,	; coordinates of first char
            ADDR cellsWritten	; output count
            
        inc xyPosition.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes1,
            ButtonWidth, 
            xyPosition,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBody1,	; pointer to the box body
            ButtonWidth,	; size of box line
            xyPosition,	; coordinates of first char
            ADDR cellsWritten	; output count
        
        inc xyPosition.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes1,
            ButtonWidth, 
            xyPosition,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBottom,	; pointer to the bottom of the box
            ButtonWidth,	; size of box line
            xyPosition,	; coordinates of first char
            ADDR cellsWritten	; output count
    .ENDIF
DrawButton1 ENDP

DrawButtonExit PROC, State:Byte
    .IF State==1
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes2,
            ButtonWidth, 
            xyPosition,
            ADDR cellsWritten
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonTop,	; pointer to the top box line
            ButtonWidth,	; size of box line
            xyPosition,	; coordinates of first char
            ADDR cellsWritten	; output count
            
        inc xyPosition.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes2,
            ButtonWidth, 
            xyPosition,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBody2,	; pointer to the box body
            ButtonWidth,	; size of box line
            xyPosition,	; coordinates of first char
            ADDR cellsWritten	; output count
        
        inc xyPosition.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes2,
            ButtonWidth, 
            xyPosition,
            ADDR cellsWritten
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBottom,	; pointer to the bottom of the box
            ButtonWidth,	; size of box line
            xyPosition,	; coordinates of first char
            ADDR cellsWritten	; output count
    .ELSEIF State==0
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes1,
            ButtonWidth, 
            xyPosition,
            ADDR cellsWritten
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonTop,	; pointer to the top box line
            ButtonWidth,	; size of box line
            xyPosition,	; coordinates of first char
            ADDR cellsWritten	; output count
            
        inc xyPosition.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes1,
            ButtonWidth, 
            xyPosition,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBody2,	; pointer to the box body
            ButtonWidth,	; size of box line
            xyPosition,	; coordinates of first char
            ADDR cellsWritten	; output count
        
        inc xyPosition.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes1,
            ButtonWidth, 
            xyPosition,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBottom,	; pointer to the bottom of the box
            ButtonWidth,	; size of box line
            xyPosition,	; coordinates of first char
            ADDR cellsWritten	; output count
    .ENDIF
DrawButtonExit ENDP

;CheckState PROC
;
;CheckState ENDP

Generate_block PROC
    mov xpos, 4
    mov ypos, 1
    mov direction, 1
    mov ebx, 7
    call Random32
    mul ebx
    cmp edx, 0
    je gen_I
    cmp edx, 1
    je gen_S
    cmp edx, 2
    je gen_Z
    cmp edx, 3
    je gen_T
    cmp edx, 4
    je gen_J
    cmp edx, 5
    je gen_L
    cmp edx, 6
    je gen_O
gen_I:
    mov block_type, 'I'
    ret
gen_S:
    mov block_type, 'S'
    ret
gen_Z:
    mov block_type, 'Z'
    ret
gen_T:
    mov block_type, 'T'
    ret
gen_J:
    mov block_type, 'J'
    ret
gen_L:
    mov block_type, 'L'
    ret
gen_O:
    mov block_type, 'O'
    ret
Generate_block ENDP
Drawplayer PROC,paint:byte;最後一個參數使我們可以決定畫什麼方塊
    mov edx,OFFSET player
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
    push ecx
    mov ecx,22
    mov dl,3;xpos
    mov dh,3;ypos
    mov ebx,0
    L:
        call Gotoxy
        mov al,dl
        mov ah,dh
        mov edx, OFFSET player
        add edx,ebx
        add ebx, 11
        call WriteString
        mov dl, al
        mov dh, ah
        call Crlf
        inc dh
        loop L
    ;call ReadChar
    pop ecx
    ret
Draw ENDP
Collision_block PROC,dir:byte ; 0 collide 1 safe to place
    mov edx,OFFSET player
    mov eax,0
    mov al,ypos
    mov bl,11
    mul bl
    add al,xpos
    add edx,eax
    .IF block_type=='I' ;not good
        .IF dir==1
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
            mov collisioned,1
            ret
        .ENDIF
        .IF dir==2
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
            mov collisioned,1
            ret
        .ENDIF
        .IF dir==3
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
            mov collisioned,1
            ret
        .ENDIF
        .IF dir==4
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
            mov collisioned,1
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
        mov collisioned,1
        ret
    .ENDIF
    .IF block_type=='T' ;good
        .IF dir==1 ;face up
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
            mov collisioned,1
            ret
        .ENDIF
        .IF dir==2  ;face right
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
            mov collisioned,1
            ret
        .ENDIF
        .IF dir==3 ;face down
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
            mov collisioned,1
            ret
        .ENDIF
        .IF dir==4 ;face left
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
            mov collisioned,1
            ret
        .ENDIF
    .ENDIF
    .IF block_type=='S' ;good
        .IF dir==1
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
            mov collisioned,1
            ret
        .ENDIF
        .IF dir==2  
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
            mov collisioned,1
            ret
        .ENDIF
        .IF dir==3
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
            mov collisioned,1
            ret
        .ENDIF
        .IF dir==4
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
            mov collisioned,1
            ret
        .ENDIF
    .ENDIF
    .IF block_type=='Z' ;good
        .IF dir==1
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
            mov collisioned,1
            ret
        .ENDIF
        .IF dir==2  
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
            mov collisioned,1
            ret
        .ENDIF
        .IF dir==3
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
            mov collisioned,1
            ret
        .ENDIF
        .IF dir==4
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
            mov collisioned,1
            ret
        .ENDIF
    .ENDIF
    .IF block_type=='L' ;good
        .IF dir==1
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
            mov collisioned,1
            ret
        .ENDIF
        .IF dir==2  
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
            mov collisioned,1
            ret
        .ENDIF
        .IF dir==3
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
            mov collisioned,1
            ret
        .ENDIF
        .IF dir==4
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
            mov collisioned,1
            ret
        .ENDIF
    .ENDIF
    .IF block_type=='J' ;good
        .IF dir==1
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
            mov collisioned,1
            ret
        .ENDIF
        .IF dir==2  
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
            mov collisioned,1
            ret
        .ENDIF
        .IF dir==3
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
            mov collisioned,1
            ret
        .ENDIF
        .IF dir==4
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
            mov collisioned,1
            ret
        .ENDIF
    .ENDIF
collison:
    ; mov ypos, 10
    mov collisioned, 0
    ret
Collision_block ENDP
Drop_block PROC,dir:byte
    invoke Drawplayer,'.'
    inc ypos
    invoke Collision_block,dir
    dec ypos
    cmp collisioned, 0
    je L1
    inc ypos
L1:
    invoke Drawplayer,'X'
    invoke Draw
    ret
Drop_block ENDP
Move_block PROC, move_type: BYTE
    invoke Drawplayer, '.'
    .IF move_type == 1
        dec xpos
        invoke Collision_block, direction
        .IF collisioned == 0
            inc xpos
        .ENDIF
    .ENDIF
    .IF move_type == 3
        inc xpos
        invoke Collision_block, direction
        .IF collisioned == 0
            dec xpos
        .ENDIF
    .ENDIF
    .IF move_type == 2
        inc ypos
        invoke Collision_block, direction
        .IF collisioned == 0
            dec ypos
        .ENDIF
    .ENDIF
    invoke Drawplayer, 'X'
    invoke Draw
    ret
Move_block ENDP

Rotate_block PROC,lr:byte
    .IF block_type=='I'
        invoke Rotate_I,lr
    .ENDIF
    .IF block_type=='S'
        invoke Rotate_S,lr
    .ENDIF
    .IF block_type=='Z'
        invoke Rotate_Z,lr
    .ENDIF
    .IF block_type=='T'
        invoke Rotate_T,lr
    .ENDIF
    .IF block_type=='J'
        invoke Rotate_J,lr
    .ENDIF
    .IF block_type=='L'
        invoke Rotate_L,lr
    .ENDIF
    ret
Rotate_block ENDP
Rotate_I PROC,lr:byte
    .IF lr=='r'
        .IF direction==1
            _1rtest1:


            _1rtest2:
           
            _1rtest3:


            _1rtest4:


            _1rtest5:


        .ENDIF
        .IF direction==2
            _2rtest1:


            _2rtest2:


            _2rtest3:


            _2rtest4:


            _2rtest5:
        .ENDIF
        .IF direction==3
            _3rtest1:


            _3rtest2:


            _3rtest3:


            _3rtest4:


            _3rtest5:
        .ENDIF
        .IF direction==3
            _4rtest1:


            _4rtest2:


            _4rtest3:


            _4rtest4:


            _4rtest5:
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction==1
            _1ltest1:


            _1ltest2:
           
            _1ltest3:


            _1ltest4:


            _1ltest5:


        .ENDIF
        .IF direction==2
            _2ltest1:


            _2ltest2:


            _2ltest3:


            _2ltest4:


            _2ltest5:
        .ENDIF
        .IF direction==3
            _3ltest1:


            _3ltest2:


            _3ltest3:


            _3ltest4:


            _3ltest5:
        .ENDIF
        .IF direction==3
            _4ltest1:


            _4ltest2:


            _4ltest3:


            _4ltest4:


            _4ltest5:
        .ENDIF
    .ENDIF
Rotate_I ENDP
Rotate_S PROC,lr:byte
    .IF lr=='r'
        .IF direction==1
            _1rtest1:


            _1rtest2:
           
            _1rtest3:


            _1rtest4:


            _1rtest5:


        .ENDIF
        .IF direction==2
            _2rtest1:


            _2rtest2:


            _2rtest3:


            _2rtest4:


            _2rtest5:
        .ENDIF
        .IF direction==3
            _3rtest1:


            _3rtest2:


            _3rtest3:


            _3rtest4:


            _3rtest5:
        .ENDIF
        .IF direction==3
            _4rtest1:


            _4rtest2:


            _4rtest3:


            _4rtest4:


            _4rtest5:
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction==1
            _1ltest1:


            _1ltest2:
           
            _1ltest3:


            _1ltest4:


            _1ltest5:


        .ENDIF
        .IF direction==2
            _2ltest1:


            _2ltest2:


            _2ltest3:


            _2ltest4:


            _2ltest5:
        .ENDIF
        .IF direction==3
            _3ltest1:


            _3ltest2:


            _3ltest3:


            _3ltest4:


            _3ltest5:
        .ENDIF
        .IF direction==3
            _4ltest1:


            _4ltest2:


            _4ltest3:


            _4ltest4:


            _4ltest5:
        .ENDIF
    .ENDIF
    ret
Rotate_S ENDP
Rotate_Z PROC,lr:Byte
    .IF lr=='r'
        .IF direction==1
            _1rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,2
                .IF collisioned == 0
                    jmp _1rtest2
                .ENDIF
                mov direction,2
                invoke Drawplayer,'x'
                ret
            _1rtest2:
                dec xpos
                invoke Collision_block,2
                .IF collisioned ==0
                    jmp _1rtest3
                .ENDIF
                mov direction,2
                invoke Drawplayer,'x'
                ret
            _1rtest3:
                dec ypos
                invoke Collision_block,2
                .IF collisioned == 0
                    jmp _1rtest4
                .ENDIF
                mov direction,2
                invoke Drawplayer,'x'
                ret
            _1rtest4:                
                inc xpos
                add ypos,3
                invoke Collision_block,2
                .IF collisioned == 0
                    jmp _1rtest5
                .ENDIF
                mov direction,2
                invoke Drawplayer,'x'
                ret
            _1rtest5:
                dec xpos
                invoke Collision_block,2
                .IF collisioned == 0
                    jmp _1rdontmove
                .ENDIF
                mov direction,2
                invoke Drawplayer,'x'
                ret
            _1rdontmove:
                mov direction,1
                inc xpos
                sub ypos,2
                invoke Drawplayer,'x'
                ret
        .ENDIF
        .IF direction==2
            _2rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,3
                .IF collisioned == 0
                jmp _2rtest2
                .ENDIF
                mov direction,3
                invoke Drawplayer,'x'
                ret
            _2rtest2:
                inc xpos
                invoke Collision_block,3
                .IF collisioned == 0
                jmp _2rtest3
                .ENDIF
                mov direction,3
                invoke Drawplayer,'x'
                ret
            _2rtest3:
                inc ypos
                invoke Collision_block,3
                .IF collisioned == 0
                jmp _2rtest4
                .ENDIF
                mov direction,3
                invoke Drawplayer,'x'
                ret
            _2rtest4:
                dec xpos
                sub ypos,3
                invoke Collision_block,3
                .IF collisioned == 0
                jmp _2rtest5
                .ENDIF
                mov direction,3
                invoke Drawplayer,'x'
                ret
            _2rtest5:
                inc xpos
                invoke Collision_block,3
                .IF collisioned == 0
                jmp _2rdontmove
                .ENDIF
                mov direction,3
                invoke Drawplayer,'x'
                ret
            _2rdontmove:
                add ypos,3
                dec xpos
                invoke Drawplayer,'x'
                ret
        .ENDIF
        .IF direction==3
            _3rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,3
                .IF collisioned == 0
                    jmp _3rtest2
                .ENDIF
                mov direction,3
                invoke Drawplayer,'x'
                ret
            _3rtest2:
                inc xpos
                invoke Collision_block,3
                .IF collisioned == 0
                    jmp _3rtest3
                .ENDIF
                mov direction,3
                invoke Drawplayer,'x'
                ret
            _3rtest3:
                dec ypos
                invoke Collision_block,3
                .IF collisioned == 0
                    jmp _3rtest4
                .ENDIF
                mov direction,3
                invoke Drawplayer,'x'
                ret
            _3rtest4:
                dec xpos
                add ypos,3
                invoke Collision_block,3
                .IF collisioned == 0
                    jmp _3rtest5
                .ENDIF
                mov direction,3
                invoke Drawplayer,'x'
                ret
            _3rtest5:
                inc xpos
                invoke Collision_block,3
                .IF collisioned == 0
                    jmp _3rdontmove
                .ENDIF
                mov direction,3
                invoke Drawplayer,'x'
                ret
            _3rdontmove:
                dec xpos
                sub ypos,2
                invoke Drawplayer,'x'
                ret
        .ENDIF
        .IF direction==3
            _4rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,1
                .IF collisioned == 0
                    jmp _4rtest2
                .ENDIF
                mov direction,1
                invoke Drawplayer,'x'
                ret
            _4rtest2:
                dec xpos
                invoke Collision_block,1
                .IF collisioned == 0
                    jmp _4rtest3
                .ENDIF
                mov direction,1
                invoke Drawplayer,'x'
                ret
            _4rtest3:
                inc ypos
                invoke Collision_block,1
                .IF collisioned == 0
                    jmp _4rtest4
                .ENDIF
                mov direction,1
                invoke Drawplayer,'x'
                ret
            _4rtest4:
                inc xpos
                sub ypos,3
                invoke Collision_block,1
                .IF collisioned == 0
                    jmp _4rtest5
                .ENDIF
                mov direction,1
                invoke Drawplayer,'x'
                ret
            _4rtest5:
                dec xpos
                invoke Collision_block,1
                .IF collisioned == 0
                    jmp _4rdontmove
                .ENDIF
                mov direction,1
                invoke Drawplayer,'x'
                ret
            _4rdontmove:
                inc xpos
                add ypos,2
                invoke Drawplayer,'x'
                ret
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction==1
            _1ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,3
                .IF collisioned == 0
                    jmp _1ltest2
                .ENDIF
                mov direction,3
                invoke Drawplayer,'x'
                ret
            _1ltest2:
                inc xpos
                invoke Collision_block,3
                .IF collisioned == 0
                    jmp _1ltest3
                .ENDIF
                mov direction,3
                invoke Drawplayer,'x'
                ret
            _1ltest3:   
                dec ypos
                invoke Collision_block,3  
                .IF collisioned == 0
                    jmp _1ltest4
                .ENDIF
                mov direction,3
                invoke Drawplayer,'x'
                ret
            _1ltest4:
                dec xpos
                add ypos,3
                invoke Collision_block,3
                .IF collisioned == 0
                    jmp _1ltest5
                .ENDIF
                mov direction,3
                invoke Drawplayer,'x'
                ret
            _1ltest5:
                inc xpos
                invoke Collision_block,3
                .IF collisioned == 0
                    jmp _1ldontmove
                .ENDIF
                mov direction,3
                invoke Drawplayer,'x'
                ret
            _1ldontmove:
                dec xpos
                sub ypos,3
                invoke Drawplayer,'x'
                ret
        .ENDIF
        .IF direction==2
            _2ltest1:


            _2ltest2:


            _2ltest3:


            _2ltest4:


            _2ltest5:
        .ENDIF
        .IF direction==3
            _3ltest1:


            _3ltest2:


            _3ltest3:


            _3ltest4:


            _3ltest5:
        .ENDIF
        .IF direction==3
            _4ltest1:


            _4ltest2:


            _4ltest3:


            _4ltest4:


            _4ltest5:
        .ENDIF
    .ENDIF
Rotate_Z ENDP
Rotate_T PROC,lr:byte
    .IF lr=='r'
        .IF direction==1
            _1rtest1:


            _1rtest2:
           
            _1rtest3:


            _1rtest4:


            _1rtest5:


        .ENDIF
        .IF direction==2
            _2rtest1:


            _2rtest2:


            _2rtest3:


            _2rtest4:


            _2rtest5:
        .ENDIF
        .IF direction==3
            _3rtest1:


            _3rtest2:


            _3rtest3:


            _3rtest4:


            _3rtest5:
        .ENDIF
        .IF direction==3
            _4rtest1:


            _4rtest2:


            _4rtest3:


            _4rtest4:


            _4rtest5:
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction==1
            _1ltest1:


            _1ltest2:
           
            _1ltest3:


            _1ltest4:


            _1ltest5:


        .ENDIF
        .IF direction==2
            _2ltest1:


            _2ltest2:


            _2ltest3:


            _2ltest4:


            _2ltest5:
        .ENDIF
        .IF direction==3
            _3ltest1:


            _3ltest2:


            _3ltest3:


            _3ltest4:


            _3ltest5:
        .ENDIF
        .IF direction==3
            _4ltest1:


            _4ltest2:


            _4ltest3:


            _4ltest4:


            _4ltest5:
        .ENDIF
    .ENDIF
Rotate_T ENDP
Rotate_J PROC,lr:byte
    .IF lr=='r'
        .IF direction==1
            _1rtest1:


            _1rtest2:
           
            _1rtest3:


            _1rtest4:


            _1rtest5:


        .ENDIF
        .IF direction==2
            _2rtest1:


            _2rtest2:


            _2rtest3:


            _2rtest4:


            _2rtest5:
        .ENDIF
        .IF direction==3
            _3rtest1:


            _3rtest2:


            _3rtest3:


            _3rtest4:


            _3rtest5:
        .ENDIF
        .IF direction==3
            _4rtest1:


            _4rtest2:


            _4rtest3:


            _4rtest4:


            _4rtest5:
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction==1
            _1ltest1:


            _1ltest2:
           
            _1ltest3:


            _1ltest4:


            _1ltest5:


        .ENDIF
        .IF direction==2
            _2ltest1:


            _2ltest2:


            _2ltest3:


            _2ltest4:


            _2ltest5:
        .ENDIF
        .IF direction==3
            _3ltest1:


            _3ltest2:


            _3ltest3:


            _3ltest4:


            _3ltest5:
        .ENDIF
        .IF direction==3
            _4ltest1:


            _4ltest2:


            _4ltest3:


            _4ltest4:


            _4ltest5:
        .ENDIF
    .ENDIF
Rotate_J ENDP
Rotate_L PROC,lr:byte
    .IF lr=='r'
        .IF direction==1
            _1rtest1:


            _1rtest2:
           
            _1rtest3:


            _1rtest4:


            _1rtest5:


        .ENDIF
        .IF direction==2
            _2rtest1:


            _2rtest2:


            _2rtest3:


            _2rtest4:


            _2rtest5:
        .ENDIF
        .IF direction==3
            _3rtest1:


            _3rtest2:


            _3rtest3:


            _3rtest4:


            _3rtest5:
        .ENDIF
        .IF direction==3
            _4rtest1:


            _4rtest2:


            _4rtest3:


            _4rtest4:


            _4rtest5:
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction==1
            _1ltest1:


            _1ltest2:
           
            _1ltest3:


            _1ltest4:


            _1ltest5:


        .ENDIF
        .IF direction==2
            _2ltest1:


            _2ltest2:


            _2ltest3:


            _2ltest4:


            _2ltest5:
        .ENDIF
        .IF direction==3
            _3ltest1:


            _3ltest2:


            _3ltest3:


            _3ltest4:


            _3ltest5:
        .ENDIF
        .IF direction==3
            _4ltest1:


            _4ltest2:


            _4ltest3:


            _4ltest4:


            _4ltest5:
        .ENDIF
    .ENDIF
Rotate_L ENDP

END main
