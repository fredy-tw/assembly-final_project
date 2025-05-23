INCLUDE Irvine32.inc
main          EQU start@0
Drawplayer PROTO,paint:byte
Resetplayer PROTO
ShowGhostBlock PROTO
RemoveGhostBlock PROTO
Move_block PROTO,move_type:byte
Find_movetype PROTO
Rotate_block PROTO,lr:byte
Rotate_I PROTO,lr:byte
Rotate_S PROTO,lr:byte
Rotate_T PROTO,lr:byte
Rotate_J PROTO,lr:byte
Rotate_Z PROTO,lr:byte
Rotate_L PROTO,lr:byte
Collision_block PROTO,dir:byte
Drop_block PROTO,dir:byte
Score_counting PROTO
Draw PROTO
DrawScoreHold PROTO
DrawHoldblock PROTO
DrawNextblock PROTO
DrawNext PROTO
Holdfunction PROTO
Generate_block PROTO
DrawTitle PROTO
DrawButton1 PROTO,State:byte
DrawButtonExit PROTO,State:byte
SwitchButtonState1 PROTO
SwitchButtonState2 PROTO
DrawHintWord1 PROTO ;titleHintWord
DrawHintWord2 PROTO ;titleHintWord
DrawHintWord3 PROTO ;a move left
DrawHintWord4 PROTO ;s move down
DrawHintWord5 PROTO ;d move right
DrawHintWord6 PROTO ;j rotate left
DrawHintWord7 PROTO ;k rotate right
DrawHintWord8 PROTO ;space move bottom
DrawHintWord9 PROTO ;press a to continue
DrawHintWord10 PROTO ;h to hold block
DrawEndTitle PROTO
DrawReplayButton PROTO,State:byte
DrawExitButton PROTO,State:byte
TitleWidth = 26
TitleHeight = 7
Buttonwidth = 13
ButtonHeight = 3
.data
Button1_State Byte 1  ;StartTitle's StartButton
ButtonExit1_State Byte 0  ;StartTitle's ExitButton
ButtonReplay_State Byte 1  ;EndTitle's ReplayButton 
ButtonExit2_State Byte 0 ;EndTitle's ExitButton
TitleTop    BYTE 0DAh, (TitleWidth - 2) DUP(0C4h), 0BFh 
TitleBody1   BYTE 0B3h, (9) DUP(' '), 'T', 'E', 'T', 'R', 'I', 'S', (9) DUP(' '), 0B3h ;TETRIS_TITLE
TitleBody2   BYTE 0B3h, (TitleWidth-2) DUP(' '), 0B3h ;STARTButton
TitleBody3   BYTE 0B3h, (8) DUP(' '), 'G', 'A', 'M', 'E', 'O', 'V', 'E', 'R', (8) DUP(' '), 0B3h ;TETRIS_TITLE
TitleBottom BYTE 0C0h, (TitleWidth - 2) DUP(0C4h), 0D9h
ButtonTop    BYTE 0DAh, (Buttonwidth - 2) DUP(0C4h), 0BFh 
ButtonBody1   BYTE 0B3h, (3) DUP(' '), 'S', 'T', 'A', 'R', 'T', (3) DUP(' '), 0B3h ;STARTButton
ButtonBody2   BYTE 0B3h, (4) DUP(' '), 'E', 'X', 'I', 'T', (3) DUP(' '), 0B3h ;EXITButton
ButtonBody3   BYTE 0B3h, (2) DUP(' '), 'R', 'E', 'P', 'L', 'A', 'Y', (3) DUP(' '), 0B3h ;ReplayButton
HintText1   BYTE 'w', ' ', 'o', 'r', ' ', 's', ' ', 't', 'o', ' ', 's', 'w', 'i', 't', 'c', 'h', ' ', 'b', 'u', 't', 't', 'o', 'n', 's' ;w or s to switch buttons 24
HintText2   BYTE 's', 'p', 'a', 'c', 'e', ' ', 't', 'o', ' ', 'c', 'o', 'n', 'f', 'i', 'r', 'm' ;HintText2 16
HintText3   BYTE 'a', ' ', 'm', 'o', 'v', 'e', ' ', 'l', 'e', 'f', 't' ;HintText3 11
HintText4   BYTE 's', ' ', 'm', 'o', 'v', 'e', ' ', 'd', 'o', 'w', 'n' ;HintText4 11
HintText5   BYTE 'd', ' ', 'm', 'o', 'v', 'e', ' ', 'r', 'i', 'g', 'h', 't' ;HintText5 12
HintText6   BYTE 'j', ' ', 'r', 'o', 't', 'a', 't', 'e', ' ', 'l', 'e', 'f', 't' ;HintText6 13
HintText7   BYTE 'k', ' ', 'r', 'o', 't', 'a', 't', 'e', ' ', 'r', 'i', 'g', 'h', 't' ;HintText7 14
HintText8   BYTE 's', 'p', 'a', 'c', 'e', ' ', 'm', 'o', 'v', 'e', ' ', 'b', 'o', 't', 't', 'o', 'm' ;HintText8 17
HintText9   BYTE 'p', 'r', 'e', 's', 's', ' ', 'a', ' ', 't', 'o', ' ', 'c', 'o', 'n', 't', 'i', 'n', 'u', 'e' ;HintText9 19  
HintText10   BYTE 'h', ' ', 't', 'o', ' ', 'h', 'o', 'l', 'd', ' ', 'b', 'l', 'o', 'c', 'k' ;HintText7 15
ButtonBottom BYTE 0C0h, (Buttonwidth - 2) DUP(0C4h), 0D9h
outputHandle DWORD 0
bytesWritten DWORD 0
attributes0  WORD TitleWidth DUP(0Ch);title
attributes1  WORD ButtonWidth DUP(0Ch);titleStart
attributes2  WORD ButtonWidth DUP(0Fh);titleExit
attributes3  WORD 24 DUP(0Fh);titleHintWord
attributes4  WORD 16 DUP(0Fh)
attributes5  WORD 11 DUP(0Fh);totorielStart
attributes6  WORD 11 DUP(0Fh)
attributes7  WORD 12 DUP(0Fh)
attributes8  WORD 13 DUP(0Fh)
attributes9  WORD 14 DUP(0Fh)
attributes10 WORD 17 DUP(0Fh)
attributes11 WORD 19 DUP(0Fh);totorielEnd
attributes12 WORD 15 DUP(0Fh)
xyPosition0  COORD <3,4>;title
xyPosition1  COORD <10,12>;titleStart
xyPosition2  COORD <10,17>;titleExit
xyPosition3  COORD <4,20>;titleHintWord
xyPosition4  COORD <9,21>
xyPosition5  COORD <9,10>;totorielStart
xyPosition6  COORD <9,11>
xyPosition7  COORD <9,12>
xyPosition8  COORD <9,13>
xyPosition9  COORD <9,14>
xyPosition10 COORD <9,15>
xyPosition11 COORD <4,19>;totorielEnd
xyPosition12 COORD <9,16>
cellsWritten DWORD ?
xpos BYTE 4
ypos BYTE 1
ghost_xpos BYTE ?
ghost_ypos BYTE ?
buffer BYTE ?
inputChar BYTE ?
isJumping BYTE ?
block_type byte 'O';indicate what kind of block player is controling I O J L S Z T
next_type byte 'O'
direction byte 1
player Byte 22 dup('..........',0),2 dup(10 dup(0feh),0);?h?X??????O ???@?}?l???????m
collided Byte 1  ;to check if it is collision, 1 means not collision, 0 means collision
score DWORD 0
row_num Byte 0
score_msg db 'Score:', 0
hold_msg db 'Hold:', 0
next_msg db 'Next: ', 0
level_msg db 'Level: ', 0
boxTop BYTE 0DAh, 6 dup(0C4h), 0BFh, 0
boxBody BYTE 0B3h, 6 dup(' '), 0B3h, 0
boxBottom BYTE 0C0h, 6 dup(0C4h), 0D9h, 0
holdbox BYTE 6 dup('      ', 0), 0
hold_type byte '0'
holded byte 1 ;to check if this round had holded, 1 means had holded, 0 means not holded yet
nextbox BYTE 6 dup('      ', 0), 0
level byte 1
hConsoleInput HANDLE 0
temp BYTE 0
ButtonExit11_State Byte 1
.code
    SetConsoleOutputCP PROTO STDCALL :DWORD
main PROC
start:
    invoke Resetplayer
    INVOKE SetConsoleOutputCP, 437
    INVOKE GetStdHandle, STD_INPUT_HANDLE
    mov hConsoleInput, eax
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov outputHandle, eax
    ; mov eax,red+(black*16)
    ; call SetTextColor
    invoke DrawTitle
    invoke DrawHintWord1
    invoke DrawHintWord2
Buttons:
    invoke DrawButton1, Button1_State
    invoke DrawButtonExit, ButtonExit1_State
    mov eax, 200
    call Delay
    push eax
    call ReadKey
    .IF al == 'w'
        invoke SwitchButtonState1
        pop eax
        loop Buttons
    .ELSEIF al == 's'
        invoke SwitchButtonState1
        pop eax
        loop Buttons
    .ELSEIF al == ' '
        .IF Button1_State == 1
            pop eax
            jmp TotorielDraw
        .ELSEIF ButtonExit1_State == 1
            exit
        .ENDIF
    .ENDIF
    loop Buttons
TotorielDraw:
    call Clrscr
    invoke DrawHintWord3
    invoke DrawHintWord4
    invoke DrawHintWord5
    invoke DrawHintWord6
    invoke DrawHintWord7
    invoke DrawHintWord8
    invoke DrawHintWord9
    invoke DrawHintWord10
TotorielCheck:
    mov eax, 500
    call Delay
    push eax
    call ReadKey
    .IF al == 'a'
        pop eax
        invoke Generate_block
        jmp gameloop_out
    .ENDIF
    jmp TotorielCheck
gameloop_out:
    call Clrscr
    mov collided, 1
    mov holded, 0
    push eax
    mov al, next_type
    mov block_type, al
    pop eax
    invoke Generate_block
    .IF score >= 0
        mov level, 1
        .IF score >= 1000
            mov level, 2
            .IF score >= 2000
                mov level, 3
                .IF score >= 3000
                    mov level, 4
                    .IF score >= 4000
                        mov level, 5
                    .ENDIF
                .ENDIF
            .ENDIF
        .ENDIF
    .ENDIF
    ; mov block_type,'L'
L_hold:
    invoke Collision_block, direction
    cmp collided, 0
    je gameover
    invoke ShowGhostBlock
    ; mov eax,blue+(black*16)
    ; call SetTextColor
    invoke Drawplayer, 0feh
    invoke Draw
gameloop_in:
    push eax
    mov ecx, 6
    movzx eax, level
    sub ecx, eax
    pop eax
gameloop:
    mov temp, 0
    mov eax, 200
    call Delay
    push eax
    call ReadKey
    jz no_input
    invoke Find_movetype
    .IF al == 'h'
        .IF holded == 0
            invoke RemoveGhostBlock
            invoke Drawplayer, '.'
            .IF hold_type == '0'
                invoke Holdfunction
                jmp gameloop_out
            .ELSE
                mov xpos, 4
                mov ypos, 1
                invoke Holdfunction
                jmp L_hold
            .ENDIF
        .ENDIF
    .ENDIF
    invoke Move_block, temp
no_input:
    pop eax
    loop gameloop
    mov collided, 1
    invoke Drop_block, direction
    cmp collided, 1
    je gameloop_in
    call RemoveBlock
    jmp gameloop_out
gameover:
    invoke DrawEndTitle
Buttons2:
    invoke DrawReplayButton, ButtonReplay_State
    invoke DrawExitButton, ButtonExit2_State
    mov eax, 200
    call Delay
    push eax
    call ReadKey
    .IF al == 'w'
        invoke SwitchButtonState2
        pop eax
        loop Buttons2
    .ELSEIF al == 's'
        invoke SwitchButtonState2
        pop eax
        loop Buttons2
    .ELSEIF al == ' '
        .IF ButtonReplay_State == 1
            pop eax
            jmp start
        .ELSEIF ButtonExit2_State == 1
            exit
        .ENDIF
    .ENDIF
    loop buttons2
    exit
main ENDP

ShowGhostBlock PROC
    push eax
    push ebx
    mov al, ypos
    mov buffer, al
drop_loop:
    inc ypos
    invoke Collision_block, direction
    cmp collided, 1
    je drop_loop
    dec ypos
    invoke Drawplayer, 'O'
    mov bh, xpos
    mov bl, ypos
    mov ghost_xpos, bh
    mov ghost_ypos, bl
    mov al, buffer
    mov ypos, al
    pop ebx
    pop eax
    ret
ShowGhostBlock ENDP

RemoveGhostBlock PROC
    push eax
    push ebx
    mov ah, xpos
    mov al, ypos
    mov bh, ghost_xpos
    mov bl, ghost_ypos
    mov xpos, bh
    mov ypos, bl
    invoke Drawplayer, '.'
    mov xpos, ah
    mov ypos, al
    pop ebx
    pop eax
    ret
RemoveGhostBlock ENDP

RemoveBlock PROC
    mov row_num, 0
    mov eax, 0
    mov esi, 0
check_row:
    cmp esi, 242
    jae end_remove
    .IF player[esi] == '.'
        add eax, 11
        mov esi, eax
        jmp check_row
    .ELSEIF player[esi] == 0
        push esi
        add eax, 11
        mov edx, esi
        sub edx, 11
remove_row:
        mov bl, player[edx]
        mov player[esi], bl
        .IF edx > 0
            sub esi, 1
            sub edx, 1
            jmp remove_row
        .ENDIF
        mov ecx, 10
add_empty_row:
        inc row_num
        mov player[edx], '.'
        add edx, 1
        loop add_empty_row
        pop esi
    .ENDIF
    add esi, 1
    jmp check_row
end_remove:
    invoke Score_counting
    ret
RemoveBlock ENDP

Score_counting PROC
    .IF row_num == 10
        add score, 40
    .ELSEIF row_num == 20
        add score, 100
    .ELSEIF row_num == 30
        add score, 300
    .ELSEIF row_num == 40
        add score, 1200
    .ENDIF
    mov row_num, 0
    ret
Score_counting ENDP
DrawTitle PROC
    sub xyPosition0.y, 4 
    INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes0,
            TitleWidth, 
            xyPosition0,
            ADDR cellsWritten
    INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR TitleTop,	; pointer to the top box line
            TitleWidth,	; size of box line
            xyPosition0,	; coordinates of first char
            ADDR cellsWritten	; output count
            
    inc xyPosition0.y	; next line
    INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes0,
            TitleWidth, 
            xyPosition0,
            ADDR cellsWritten
        
    INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR TitleBody2,	; pointer to the box body
            TitleWidth,	; size of box line
            xyPosition0,	; coordinates of first char
            ADDR cellsWritten	; output count
        
    inc xyPosition0.y	; next line
    INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes0,
            TitleWidth, 
            xyPosition0,
            ADDR cellsWritten
        
    INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR TitleBody1,	; pointer to the box body
            TitleWidth,	; size of box line
            xyPosition0,	; coordinates of first char
            ADDR cellsWritten	; output count
        
    inc xyPosition0.y	; next line
    INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes0,
            TitleWidth, 
            xyPosition0,
            ADDR cellsWritten
        
    INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR TitleBody2,	; pointer to the box body
            TitleWidth,	; size of box line
            xyPosition0,	; coordinates of first char
            ADDR cellsWritten	; output count
        
    inc xyPosition0.y	; next line
    INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes0,
            TitleWidth, 
            xyPosition0,
            ADDR cellsWritten
        
    INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR TitleBottom,	; pointer to the bottom of the box
            TitleWidth,	; size of box line
            xyPosition0,	; coordinates of first char
            ADDR cellsWritten	; output count
    ret
DrawTitle ENDP

DrawButton1 PROC, State:Byte
    sub xyPosition1.y, 2
    .IF State==1
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes2,
            ButtonWidth, 
            xyPosition1,
            ADDR cellsWritten
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonTop,	; pointer to the top box line
            ButtonWidth,	; size of box line
            xyPosition1,	; coordinates of first char
            ADDR cellsWritten	; output count
            
        inc xyPosition1.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes2,
            ButtonWidth, 
            xyPosition1,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBody1,	; pointer to the box body
            ButtonWidth,	; size of box line
            xyPosition1,	; coordinates of first char
            ADDR cellsWritten	; output count
        
        inc xyPosition1.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes2,
            ButtonWidth, 
            xyPosition1,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBottom,	; pointer to the bottom of the box
            ButtonWidth,	; size of box line
            xyPosition1,	; coordinates of first char
            ADDR cellsWritten	; output count
        ret
    .ELSEIF State==0
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes1,
            ButtonWidth, 
            xyPosition1,
            ADDR cellsWritten
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonTop,	; pointer to the top box line
            ButtonWidth,	; size of box line
            xyPosition1,	; coordinates of first char
            ADDR cellsWritten	; output count
            
        inc xyPosition1.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes1,
            ButtonWidth, 
            xyPosition1,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBody1,	; pointer to the box body
            ButtonWidth,	; size of box line
            xyPosition1,	; coordinates of first char
            ADDR cellsWritten	; output count
        
        inc xyPosition1.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes1,
            ButtonWidth, 
            xyPosition1,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBottom,	; pointer to the bottom of the box
            ButtonWidth,	; size of box line
            xyPosition1,	; coordinates of first char
            ADDR cellsWritten	; output count
        ret
    .ENDIF
    ret
DrawButton1 ENDP

DrawButtonExit PROC, State:Byte
    sub xyPosition2.y, 2
    .IF State==1
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes2,
            ButtonWidth, 
            xyPosition2,
            ADDR cellsWritten
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonTop,	; pointer to the top box line
            ButtonWidth,	; size of box line
            xyPosition2,	; coordinates of first char
            ADDR cellsWritten	; output count
            
        inc xyPosition2.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes2,
            ButtonWidth, 
            xyPosition2,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBody2,	; pointer to the box body
            ButtonWidth,	; size of box line
            xyPosition2,	; coordinates of first char
            ADDR cellsWritten	; output count
        
        inc xyPosition2.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes2,
            ButtonWidth, 
            xyPosition2,
            ADDR cellsWritten
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBottom,	; pointer to the bottom of the box
            ButtonWidth,	; size of box line
            xyPosition2,	; coordinates of first char
            ADDR cellsWritten	; output count
        ret
    .ELSEIF State==0
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes1,
            ButtonWidth, 
            xyPosition2,
            ADDR cellsWritten
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonTop,	; pointer to the top box line
            ButtonWidth,	; size of box line
            xyPosition2,	; coordinates of first char
            ADDR cellsWritten	; output count
            
        inc xyPosition2.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes1,
            ButtonWidth, 
            xyPosition2,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBody2,	; pointer to the box body
            ButtonWidth,	; size of box line
            xyPosition2,	; coordinates of first char
            ADDR cellsWritten	; output count
        
        inc xyPosition2.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes1,
            ButtonWidth, 
            xyPosition2,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBottom,	; pointer to the bottom of the box
            ButtonWidth,	; size of box line
            xyPosition2,	; coordinates of first char
            ADDR cellsWritten	; output count
        ret
    .ENDIF
    ret
DrawButtonExit ENDP

SwitchButtonState1 PROC
    .IF Button1_State == 1
        dec Button1_State
        inc ButtonExit1_State
    .ELSEIF Button1_State == 0
        inc Button1_State
        dec ButtonExit1_State
    .ENDIF
    ret
SwitchButtonState1 ENDP

SwitchButtonState2 PROC
    .IF ButtonReplay_State == 1
        dec ButtonReplay_State
        inc ButtonExit2_State
    .ELSEIF ButtonReplay_State == 0
        inc ButtonReplay_State
        dec ButtonExit2_State
    .ENDIF
    ret
SwitchButtonState2 ENDP

DrawHintWord1 PROC
    INVOKE WriteConsoleOutputAttribute,
        outputHandle, 
        ADDR attributes3,
        24, 
        xyPosition3,
        ADDR cellsWritten
        
    INVOKE WriteConsoleOutputCharacter,
        outputHandle,	; console output handle
        ADDR HintText1,	; pointer to the bottom of the box
        24,	; size of box line
        xyPosition3,	; coordinates of first char
        ADDR cellsWritten	; output count
    ret
DrawHintWord1 ENDP

DrawHintWord2 PROC
    INVOKE WriteConsoleOutputAttribute,
        outputHandle, 
        ADDR attributes4,
        16, 
        xyPosition4,
        ADDR cellsWritten
        
    INVOKE WriteConsoleOutputCharacter,
        outputHandle,	; console output handle
        ADDR HintText2,	; pointer to the bottom of the box
        16,	; size of box line
        xyPosition4,	; coordinates of first char
        ADDR cellsWritten	; output count
    ret
DrawHintWord2 ENDP

DrawHintWord3 PROC
    INVOKE WriteConsoleOutputAttribute,
        outputHandle, 
        ADDR attributes5,
        11, 
        xyPosition5,
        ADDR cellsWritten
        
    INVOKE WriteConsoleOutputCharacter,
        outputHandle,	; console output handle
        ADDR HintText3,	; pointer to the bottom of the box
        11,	; size of box line
        xyPosition5,	; coordinates of first char
        ADDR cellsWritten	; output count
    ret
DrawHintWord3 ENDP

DrawHintWord4 PROC
    INVOKE WriteConsoleOutputAttribute,
        outputHandle, 
        ADDR attributes6,
        11, 
        xyPosition6,
        ADDR cellsWritten
        
    INVOKE WriteConsoleOutputCharacter,
        outputHandle,	; console output handle
        ADDR HintText4,	; pointer to the bottom of the box
        11,	; size of box line
        xyPosition6,	; coordinates of first char
        ADDR cellsWritten	; output count
    ret
DrawHintWord4 ENDP

DrawHintWord5 PROC
    INVOKE WriteConsoleOutputAttribute,
        outputHandle, 
        ADDR attributes7,
        12, 
        xyPosition7,
        ADDR cellsWritten
        
    INVOKE WriteConsoleOutputCharacter,
        outputHandle,	; console output handle
        ADDR HintText5,	; pointer to the bottom of the box
        12,	; size of box line
        xyPosition7,	; coordinates of first char
        ADDR cellsWritten	; output count
    ret
DrawHintWord5 ENDP

DrawHintWord6 PROC
    INVOKE WriteConsoleOutputAttribute,
        outputHandle, 
        ADDR attributes8,
        13, 
        xyPosition8,
        ADDR cellsWritten
        
    INVOKE WriteConsoleOutputCharacter,
        outputHandle,	; console output handle
        ADDR HintText6,	; pointer to the bottom of the box
        13,	; size of box line
        xyPosition8,	; coordinates of first char
        ADDR cellsWritten	; output count
    ret
DrawHintWord6 ENDP

DrawHintWord7 PROC
    INVOKE WriteConsoleOutputAttribute,
        outputHandle, 
        ADDR attributes9,
        14, 
        xyPosition9,
        ADDR cellsWritten
        
    INVOKE WriteConsoleOutputCharacter,
        outputHandle,	; console output handle
        ADDR HintText7,	; pointer to the bottom of the box
        14,	; size of box line
        xyPosition9,	; coordinates of first char
        ADDR cellsWritten	; output count
    ret
DrawHintWord7 ENDP

DrawHintWord8 PROC
    INVOKE WriteConsoleOutputAttribute,
        outputHandle, 
        ADDR attributes10,
        17, 
        xyPosition10,
        ADDR cellsWritten
        
    INVOKE WriteConsoleOutputCharacter,
        outputHandle,	; console output handle
        ADDR HintText8,	; pointer to the bottom of the box
        17,	; size of box line
        xyPosition10,	; coordinates of first char
        ADDR cellsWritten	; output count
    ret
DrawHintWord8 ENDP

DrawHintWord9 PROC
    INVOKE WriteConsoleOutputAttribute,
        outputHandle, 
        ADDR attributes11,
        19, 
        xyPosition11,
        ADDR cellsWritten
        
    INVOKE WriteConsoleOutputCharacter,
        outputHandle,	; console output handle
        ADDR HintText9,	; pointer to the bottom of the box
        19,	; size of box line
        xyPosition11,	; coordinates of first char
        ADDR cellsWritten	; output count
    ret
DrawHintWord9 ENDP

DrawHintWord10 PROC
    INVOKE WriteConsoleOutputAttribute,
        outputHandle, 
        ADDR attributes12,
        15, 
        xyPosition12,
        ADDR cellsWritten
        
    INVOKE WriteConsoleOutputCharacter,
        outputHandle,	; console output handle
        ADDR HintText10,	; pointer to the bottom of the box
        15,	; size of box line
        xyPosition12,	; coordinates of first char
        ADDR cellsWritten	; output count
    ret
DrawHintWord10 ENDP

DrawReplayButton PROC, State:Byte
    sub xyPosition1.y, 2
    .IF State==1
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes2,
            ButtonWidth, 
            xyPosition1,
            ADDR cellsWritten
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonTop,	; pointer to the top box line
            ButtonWidth,	; size of box line
            xyPosition1,	; coordinates of first char
            ADDR cellsWritten	; output count
            
        inc xyPosition1.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes2,
            ButtonWidth, 
            xyPosition1,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBody3,	; pointer to the box body
            ButtonWidth,	; size of box line
            xyPosition1,	; coordinates of first char
            ADDR cellsWritten	; output count
        
        inc xyPosition1.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes2,
            ButtonWidth, 
            xyPosition1,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBottom,	; pointer to the bottom of the box
            ButtonWidth,	; size of box line
            xyPosition1,	; coordinates of first char
            ADDR cellsWritten	; output count
        ret
    .ELSEIF State==0
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes1,
            ButtonWidth, 
            xyPosition1,
            ADDR cellsWritten
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonTop,	; pointer to the top box line
            ButtonWidth,	; size of box line
            xyPosition1,	; coordinates of first char
            ADDR cellsWritten	; output count
            
        inc xyPosition1.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes1,
            ButtonWidth, 
            xyPosition1,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBody3,	; pointer to the box body
            ButtonWidth,	; size of box line
            xyPosition1,	; coordinates of first char
            ADDR cellsWritten	; output count
        
        inc xyPosition1.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes1,
            ButtonWidth, 
            xyPosition1,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBottom,	; pointer to the bottom of the box
            ButtonWidth,	; size of box line
            xyPosition1,	; coordinates of first char
            ADDR cellsWritten	; output count
        ret
    .ENDIF
    ret
DrawReplayButton ENDP

DrawExitButton PROC, State:Byte
    sub xyPosition2.y, 2
    .IF State==1
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes2,
            ButtonWidth, 
            xyPosition2,
            ADDR cellsWritten
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonTop,	; pointer to the top box line
            ButtonWidth,	; size of box line
            xyPosition2,	; coordinates of first char
            ADDR cellsWritten	; output count
            
        inc xyPosition2.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes2,
            ButtonWidth, 
            xyPosition2,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBody2,	; pointer to the box body
            ButtonWidth,	; size of box line
            xyPosition2,	; coordinates of first char
            ADDR cellsWritten	; output count
        
        inc xyPosition2.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes2,
            ButtonWidth, 
            xyPosition2,
            ADDR cellsWritten
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBottom,	; pointer to the bottom of the box
            ButtonWidth,	; size of box line
            xyPosition2,	; coordinates of first char
            ADDR cellsWritten	; output count
        ret
    .ELSEIF State==0
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes1,
            ButtonWidth, 
            xyPosition2,
            ADDR cellsWritten
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonTop,	; pointer to the top box line
            ButtonWidth,	; size of box line
            xyPosition2,	; coordinates of first char
            ADDR cellsWritten	; output count
            
        inc xyPosition2.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes1,
            ButtonWidth, 
            xyPosition2,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBody2,	; pointer to the box body
            ButtonWidth,	; size of box line
            xyPosition2,	; coordinates of first char
            ADDR cellsWritten	; output count
        
        inc xyPosition2.y	; next line
        INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes1,
            ButtonWidth, 
            xyPosition2,
            ADDR cellsWritten
        
        INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR ButtonBottom,	; pointer to the bottom of the box
            ButtonWidth,	; size of box line
            xyPosition2,	; coordinates of first char
            ADDR cellsWritten	; output count
        ret
    .ENDIF
    ret
DrawExitButton ENDP

DrawEndTitle PROC
    sub xyPosition0.y, 4 
    INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes0,
            TitleWidth, 
            xyPosition0,
            ADDR cellsWritten
    INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR TitleTop,	; pointer to the top box line
            TitleWidth,	; size of box line
            xyPosition0,	; coordinates of first char
            ADDR cellsWritten	; output count
            
    inc xyPosition0.y	; next line
    INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes0,
            TitleWidth, 
            xyPosition0,
            ADDR cellsWritten
        
    INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR TitleBody2,	; pointer to the box body
            TitleWidth,	; size of box line
            xyPosition0,	; coordinates of first char
            ADDR cellsWritten	; output count
        
    inc xyPosition0.y	; next line
    INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes0,
            TitleWidth, 
            xyPosition0,
            ADDR cellsWritten
        
    INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR TitleBody3,	; pointer to the box body
            TitleWidth,	; size of box line
            xyPosition0,	; coordinates of first char
            ADDR cellsWritten	; output count
        
    inc xyPosition0.y	; next line
    INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes0,
            TitleWidth, 
            xyPosition0,
            ADDR cellsWritten
        
    INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR TitleBody2,	; pointer to the box body
            TitleWidth,	; size of box line
            xyPosition0,	; coordinates of first char
            ADDR cellsWritten	; output count
        
    inc xyPosition0.y	; next line
    INVOKE WriteConsoleOutputAttribute,
            outputHandle, 
            ADDR attributes0,
            TitleWidth, 
            xyPosition0,
            ADDR cellsWritten
        
    INVOKE WriteConsoleOutputCharacter,
            outputHandle,	; console output handle
            ADDR TitleBottom,	; pointer to the bottom of the box
            TitleWidth,	; size of box line
            xyPosition0,	; coordinates of first char
            ADDR cellsWritten	; output count
    ret
DrawEndTitle ENDP

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
    mov next_type, 'I'
    ret
gen_S:
    mov next_type, 'S'
    ret
gen_Z:
    mov next_type, 'Z'
    ret
gen_T:
    mov next_type, 'T'
    ret
gen_J:
    mov next_type, 'J'
    ret
gen_L:
    mov next_type, 'L'
    ret
gen_O:
    mov next_type, 'O'
    ret
Generate_block ENDP
Drawplayer PROC,paint:byte;???@???????i?H?M?w?e??????
    push eax
    push ebx
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
    .IF block_type=='J' ;good
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
    .IF block_type=='L' ;good
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
    pop ebx
    pop eax
    ret
Drawplayer ENDP

Draw PROC
    push ecx
    mov ecx,22
    mov dl,6;xpos
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
    invoke DrawScoreHold
    invoke DrawNextblock
    ret
Draw ENDP
DrawScoreHold PROC
    invoke DrawHoldblock
    push dx
    push eax
    ;output the level
    mov dl, 19
    mov dh, 2
    call Gotoxy
    lea dx, level_msg
    call writestring
    movzx eax, level
    call writedec
    ;output the score
    mov dl, 19
    mov dh, 3
    call Gotoxy
    lea dx, score_msg
    call writestring
    mov eax, score
    call writedec
    ;output the hold box
    mov dl, 19
    mov dh, 4
    call Gotoxy
    lea dx, hold_msg
    call writestring
    mov dl, 19
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET boxTop
    call WriteString
    mov dl, 19
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET boxBottom
    call WriteString
    push ecx
    mov ecx, 6
    mov al, 6
L:
    mov dl, 19
    mov dh, al
    call Gotoxy
    mov edx, OFFSET boxBody
    call WriteString
    inc al
    loop L
    mov ecx, 6
    mov ebx, 0
    mov al, 6
    Lh:
        mov dl, 20
        mov dh, al
        call Gotoxy
        mov edx, OFFSET holdbox
        add edx, ebx
        add ebx, 7
        call WriteString
        call Crlf
        inc al
        loop Lh
    pop ecx
    pop eax
    pop dx
    ret
DrawScoreHold ENDP
DrawHoldblock PROC
    ;clear holdbox
    mov edx, OFFSET holdbox
    push ecx
    mov ecx, 6
L:
    mov BYTE PTR [edx], ' '
    inc edx
    mov BYTE PTR [edx], ' '
    inc edx
    mov BYTE PTR [edx], ' '
    inc edx
    mov BYTE PTR [edx], ' '
    inc edx
    mov BYTE PTR [edx], ' '
    inc edx
    mov BYTE PTR [edx], ' '
    inc edx
    mov BYTE PTR [edx], 0
    inc edx
    loop L
    pop ecx
    ;draw hold block I O J L S Z T
    mov edx, OFFSET holdbox
    .IF hold_type == 'I'
        add edx, 9
        mov BYTE PTR [edx], 0feh
        add edx, 7
        mov BYTE PTR [edx], 0feh
        add edx, 7
        mov BYTE PTR [edx], 0feh
        add edx, 7
        mov BYTE PTR [edx], 0feh
    .ELSEIF hold_type == 'O'
        add edx, 16
        mov BYTE PTR [edx], 0feh
        inc edx
        mov BYTE PTR [edx], 0feh
        add edx, 7
        mov BYTE PTR [edx], 0feh
        dec edx
        mov BYTE PTR [edx], 0feh
    .ELSEIF hold_type == 'J'
        add edx, 10
        mov BYTE PTR [edx], 0feh
        add edx, 7
        mov BYTE PTR [edx], 0feh
        add edx, 7
        mov BYTE PTR [edx], 0feh
        dec edx
        mov BYTE PTR [edx], 0feh
    .ELSEIF hold_type == 'L'
        add edx, 9
        mov BYTE PTR [edx], 0feh
        add edx, 7
        mov BYTE PTR [edx], 0feh
        add edx, 7
        mov BYTE PTR [edx], 0feh
        inc edx
        mov BYTE PTR [edx], 0feh
    .ELSEIF hold_type == 'S'
        add edx, 17
        mov BYTE PTR [edx], 0feh
        inc edx
        mov BYTE PTR [edx], 0feh
        add edx, 6
        mov BYTE PTR [edx], 0feh
        dec edx
        mov BYTE PTR [edx], 0feh
    .ELSEIF hold_type == 'Z'
        add edx, 16
        mov BYTE PTR [edx], 0feh
        dec edx
        mov BYTE PTR [edx], 0feh
        add edx, 8
        mov BYTE PTR [edx], 0feh
        inc edx
        mov BYTE PTR [edx], 0feh
    .ELSEIF hold_type == 'T'
        add edx, 15
        mov BYTE PTR [edx], 0feh
        inc edx
        mov BYTE PTR [edx], 0feh
        inc edx
        mov BYTE PTR [edx], 0feh
        add edx, 6
        mov BYTE PTR [edx], 0feh
    .ENDIF
    ret
DrawHoldblock ENDP
Holdfunction PROC
    mov holded, 1
    push eax
    .IF hold_type == '0'
        mov al, block_type
        mov hold_type, al
    .ELSE
        mov al, hold_type
        mov ah, block_type
        mov hold_type, ah
        mov block_type, al
    .ENDIF
    pop eax
    ret
Holdfunction ENDP
DrawNextblock PROC
    invoke DrawNext
    push dx
    push eax
    ;output the next box
    mov dl, 19
    mov dh, 14
    call Gotoxy
    lea dx, next_msg
    call writestring
    mov dl, 19
    mov dh, 15
    call Gotoxy
    mov edx, OFFSET boxTop
    call WriteString
    mov dl, 19
    mov dh, 22
    call Gotoxy
    mov edx, OFFSET boxBottom
    call WriteString
    push ecx
    mov ecx, 6
    mov al, 16
L:
    mov dl, 19
    mov dh, al
    call Gotoxy
    mov edx, OFFSET boxBody
    call WriteString
    inc al
    loop L
    mov ecx, 6
    mov ebx, 0
    mov al, 16
    Lh:
        mov dl, 20
        mov dh, al
        call Gotoxy
        mov edx, OFFSET nextbox
        add edx, ebx
        add ebx, 7
        call WriteString
        call Crlf
        inc al
        loop Lh
    pop ecx
    pop eax
    pop dx
    ret
DrawNextblock ENDP
DrawNext PROC
    ;clear nextbox
    mov edx, OFFSET nextbox
    push ecx
    mov ecx, 6
L:
    mov BYTE PTR [edx], ' '
    inc edx
    mov BYTE PTR [edx], ' '
    inc edx
    mov BYTE PTR [edx], ' '
    inc edx
    mov BYTE PTR [edx], ' '
    inc edx
    mov BYTE PTR [edx], ' '
    inc edx
    mov BYTE PTR [edx], ' '
    inc edx
    mov BYTE PTR [edx], 0
    inc edx
    loop L
    pop ecx
    ;draw hold block I O J L S Z T
    mov edx, OFFSET nextbox
    .IF next_type == 'I'
        add edx, 9
        mov BYTE PTR [edx], 0feh
        add edx, 7
        mov BYTE PTR [edx], 0feh
        add edx, 7
        mov BYTE PTR [edx], 0feh
        add edx, 7
        mov BYTE PTR [edx], 0feh
    .ELSEIF next_type == 'O'
        add edx, 16
        mov BYTE PTR [edx], 0feh
        inc edx
        mov BYTE PTR [edx], 0feh
        add edx, 7
        mov BYTE PTR [edx], 0feh
        dec edx
        mov BYTE PTR [edx], 0feh
    .ELSEIF next_type == 'J'
        add edx, 10
        mov BYTE PTR [edx], 0feh
        add edx, 7
        mov BYTE PTR [edx], 0feh
        add edx, 7
        mov BYTE PTR [edx], 0feh
        dec edx
        mov BYTE PTR [edx], 0feh
    .ELSEIF next_type == 'L'
        add edx, 9
        mov BYTE PTR [edx], 0feh
        add edx, 7
        mov BYTE PTR [edx], 0feh
        add edx, 7
        mov BYTE PTR [edx], 0feh
        inc edx
        mov BYTE PTR [edx], 0feh
    .ELSEIF next_type == 'S'
        add edx, 17
        mov BYTE PTR [edx], 0feh
        inc edx
        mov BYTE PTR [edx], 0feh
        add edx, 6
        mov BYTE PTR [edx], 0feh
        dec edx
        mov BYTE PTR [edx], 0feh
    .ELSEIF next_type == 'Z'
        add edx, 16
        mov BYTE PTR [edx], 0feh
        dec edx
        mov BYTE PTR [edx], 0feh
        add edx, 8
        mov BYTE PTR [edx], 0feh
        inc edx
        mov BYTE PTR [edx], 0feh
    .ELSEIF next_type == 'T'
        add edx, 15
        mov BYTE PTR [edx], 0feh
        inc edx
        mov BYTE PTR [edx], 0feh
        inc edx
        mov BYTE PTR [edx], 0feh
        add edx, 6
        mov BYTE PTR [edx], 0feh
    .ENDIF
    ret
DrawNext ENDP
Resetplayer PROC
    mov edx, OFFSET player
    push ecx
    mov ecx, 22
L1:
    push ecx
    mov ecx, 10
L2:
    mov BYTE PTR [edx], '.'
    inc edx
    loop L2
    pop ecx
    inc edx
    loop L1
    pop ecx
    mov level, 1
    mov hold_type, '0'
    mov score, 0
    ret
Resetplayer ENDP
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
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
        .IF dir==2
            sub edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
        .IF dir==3
            sub edx,2
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
        .IF dir==4
            sub edx,22
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
    .ENDIF
    .IF block_type=='O' ; good
        cmp BYTE PTR [edx],0feh
        je collison
        cmp BYTE PTR [edx], 0
        je collison
        inc edx
        cmp BYTE PTR [edx],0feh
        je collison
        cmp BYTE PTR [edx], 0
        je collison
        sub edx,11
        cmp BYTE PTR [edx],0feh
        je collison
        cmp BYTE PTR [edx], 0
        je collison
        dec edx
        cmp BYTE PTR [edx],0feh
        je collison
        cmp BYTE PTR [edx], 0
        je collison
        mov collided,1
        ret
    .ENDIF
    .IF block_type=='T' ;good
        .IF dir==1 ;face up
            sub edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,10
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
        .IF dir==2  ;face right
            sub edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,10
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
        .IF dir==3 ;face down
            dec edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,10
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
        .IF dir==4 ;face left
            sub edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,10
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
    .ENDIF
    .IF block_type=='S' ;good
        .IF dir==1
            sub edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,9
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
        .IF dir==2  
            sub edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
        .IF dir==3
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,9
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
        .IF dir==4
            sub edx,12
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
    .ENDIF
    .IF block_type=='Z' ;good
        .IF dir==1
            sub edx,12
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
        .IF dir==2  
            sub edx,10
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,10
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,10
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
        .IF dir==3
            dec edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
        .IF dir==4
            sub edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,10
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,10
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
    .ENDIF
    .IF block_type=='J' ;good
        .IF dir==1
            sub edx,12
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
        .IF dir==2  
            sub edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,10
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
        .IF dir==3
            dec edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
        .IF dir==4
            sub edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,10
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
    .ENDIF
    .IF block_type=='L' ;good
        .IF dir==1
            sub edx,10
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,9
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
        .IF dir==2  
            sub edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
        .IF dir==3
            dec edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,9
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
        .IF dir==4
            sub edx,12
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            inc edx
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            add edx,11
            cmp BYTE PTR [edx],0feh
            je collison
            cmp BYTE PTR [edx], 0
            je collison
            mov collided,1
            ret
        .ENDIF
    .ENDIF
collison:
    mov collided, 0
    ret
Collision_block ENDP
Drop_block PROC,dir:byte
    invoke Drawplayer,'.'
    inc ypos
    invoke Collision_block,dir
    dec ypos
    cmp collided, 0
    je L1
    inc ypos
L1:
    invoke Drawplayer,0feh
    invoke Draw
    ret
Drop_block ENDP
Find_movetype PROC
    .IF al == 'a'
        mov temp, 1
    .ELSEIF al == 's'
        mov temp, 2
    .ELSEIF al == 'd'
        mov temp, 3
    .ELSEIF al == 'j'
        mov temp, 4
    .ELSEIF al == 'l'
        mov temp, 5
    .ELSEIF al == ' '
        mov temp, 6
    .ENDIF
    ret
Find_movetype ENDP

Move_block PROC, move_type: BYTE
    invoke RemoveGhostBlock
    invoke Drawplayer, '.'
    .IF move_type == 1
        dec xpos
        invoke Collision_block, direction
        .IF collided == 0
            inc xpos
        .ENDIF
    .ENDIF
    .IF move_type == 3
        inc xpos
        invoke Collision_block, direction
        .IF collided == 0
            dec xpos
        .ENDIF
    .ENDIF
    .IF move_type == 2
        inc ypos
        invoke Collision_block, direction
        .IF collided == 0
            dec ypos
        .ENDIF
    .ENDIF
    .IF move_type == 4
        invoke Rotate_block, 'l'
        invoke ShowGhostBlock
    .ENDIF
    .IF move_type == 5
        invoke Rotate_block, 'r'
        invoke ShowGhostBlock
    .ENDIF
    .IF move_type == 6
    L:
        invoke Drop_block, direction
        cmp collided, 1
        je L
    .ENDIF
    invoke ShowGhostBlock
    invoke Drawplayer, 0feh
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
                invoke Drawplayer,'.'
                inc xpos
                invoke Collision_block,2
                .IF collided == 0
                    jmp _1rtest2
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest2:
                sub xpos,2
                invoke Collision_block,2
                .IF collided == 0
                    jmp _1rtest3
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret           
            _1rtest3:
                add xpos,3
                invoke Collision_block,2
                .IF collided == 0
                    jmp _1rtest4
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest4:       
                sub xpos,3
                inc ypos
                cmp ypos,20
                jl _1rtest5
                invoke Collision_block,2
                .IF collided == 0
                    jmp _1rtest5
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest5:
                add xpos,3
                sub ypos,3
                cmp ypos,2
                jl _1rdontmove
                invoke Collision_block,2
                .IF collided == 0
                    jmp _1rdontmove
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rdontmove:
                sub xpos,2
                add ypos,2
                invoke Drawplayer,'x'
                ret
        .ENDIF
        .IF direction==2
            _2rtest1:
                inc ypos
                invoke Drawplayer,'.'
                invoke Collision_block,3
                .IF collided == 0
                    jmp _2rtest2
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest2:
                dec xpos
                cmp xpos,3
                jl _2rtest3
                invoke Collision_block,3
                .IF collided == 0
                    jmp _2rtest3
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest3:
                add xpos,3
                cmp xpos,9
                jg _2rtest4
                invoke Collision_block,3
                .IF collided == 0
                    jmp _2rtest4
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest4:
                sub ypos,2
                sub xpos,3
                cmp xpos,3
                jl _2rtest5
                invoke Collision_block,3
                .IF collided == 0
                    jmp _2rtest5
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest5:
                add xpos,3
                add ypos,3
                cmp xpos,9
                jg _2rdontmove
                invoke Collision_block,3
                .IF collided == 0
                    jmp _2rdontmove
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rdontmove:
                sub ypos,2
                sub xpos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==3
            _3rtest1:
                invoke Drawplayer,'.'
                dec xpos
                invoke Collision_block,4
                .IF collided == 0
                    jmp _3rtest2
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest2:
                add xpos,2
                invoke Collision_block,4
                .IF collided == 0
                    jmp _3rtest3
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest3:
                sub ypos,3
                invoke Collision_block,4
                .IF collided == 0
                    jmp _3rtest4
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest4:
                add xpos,3
                dec ypos
                invoke Collision_block,4
                .IF collided == 0
                    jmp _3rtest5
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest5:
                add ypos,3
                sub xpos,3
                cmp ypos,20
                jg _3rdontmove
                invoke Collision_block,4
                .IF collided == 0
                    jmp _3rdontmove
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rdontmove:
                add xpos,2
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==4
            _4rtest1:
                invoke Drawplayer,'.'
                dec ypos
                invoke Collision_block,1
                .IF collided == 0
                    jmp _4rtest2
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest2:
                inc xpos
                cmp xpos,8
                jg _4rtest3
                invoke Collision_block,1
                .IF collided == 0
                    jmp _4rtest3
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest3:
                sub xpos,3
                cmp xpos,3
                jl _4rtest4
                invoke Collision_block,1
                .IF collided == 0
                    jmp _4rtest4
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest4:
                add xpos,3
                add ypos,2
                cmp xpos,8
                jg _4rtest5
                invoke Collision_block,1
                .IF collided == 0
                    jmp _4rtest5
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest5:
                sub xpos,3
                sub ypos,3
                cmp xpos,2
                jl _4rdontmove
                invoke Collision_block,1
                .IF collided == 0
                    jmp _4rdontmove
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rdontmove:
                add xpos,2
                add ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction==1
            _1ltest1:
                invoke Drawplayer,'.'
                inc ypos
                invoke Collision_block,4
                .IF collided == 0
                    jmp _1ltest2
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest2:
                dec xpos
                invoke Collision_block,4
                .IF collided == 0
                    jmp _1ltest3
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest3:
                add xpos,3
                invoke Collision_block,4
                .IF collided == 0
                    jmp _1ltest4
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest4:
                sub xpos,3
                sub ypos,2
                cmp ypos,2
                jl _1ltest5
                invoke Collision_block,4
                .IF collided == 0
                    jmp _1ltest5
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret

            _1ltest5:
                add xpos,3
                add ypos,3
                cmp ypos,20
                jg _1ldontmove
                invoke Collision_block,4
                .IF collided == 0
                    jmp _1ldontmove
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ldontmove:
                sub xpos,2
                inc ypos
                invoke Drawplayer,'x'
                ret
        .ENDIF
        .IF direction==2
            _2ltest1:
                dec xpos

                invoke Collision_block,1
                .IF collided == 0
                    jmp _2ltest2
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest2:
                add xpos,2
                cmp xpos,8
                jg _2ltest3
                invoke Collision_block,1
                .IF collided == 0
                    jmp _2ltest3
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret

            _2ltest3:
                sub xpos,3
                cmp xpos,2
                jg _2ltest4
                invoke Collision_block,1
                .IF collided == 0
                    jmp _2ltest4
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest4:
                add xpos,3
                dec ypos
                cmp xpos,8
                jg _2ltest5
                invoke Collision_block,1
                .IF collided == 0
                    jmp _2ltest5
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest5:
                sub xpos,3
                add ypos,3
                cmp xpos,2
                jl _2ldontmove
                invoke Collision_block,1
                .IF collided == 0
                    jmp _2ldontmove
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ldontmove:
                add xpos,2
                sub ypos,2
                invoke Drawplayer,'x'
                ret
        .ENDIF
        .IF direction==3
            _3ltest1:
                invoke Drawplayer,'.'
                dec ypos
                invoke Collision_block,2
                .IF collided == 0
                    jmp _3ltest2
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest2:
                inc xpos
                invoke Collision_block,2
                .IF collided == 0
                    jmp _3ltest3
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest3:
                sub xpos,3
                invoke Collision_block,2
                .IF collided == 0
                    jmp _3ltest4
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest4:
                add xpos,3
                add ypos,2
                cmp ypos,20
                jg _3ltest5
                invoke Collision_block,2
                .IF collided == 0
                    jmp _3ltest5
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest5:
                sub xpos,3
                sub ypos,3
                cmp ypos,2
                jl _3ldontmove
                invoke Collision_block,2
                .IF collided == 0
                    jmp _3ldontmove
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ldontmove:
                add xpos,2
                add ypos,2
                invoke Drawplayer,'x'
                ret
        .ENDIF
        .IF direction==4
            _4ltest1:
                invoke Drawplayer,'.'
                inc xpos
                 invoke Collision_block,3
                .IF collided == 0
                    jmp _4ltest2
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest2:
                sub xpos,2
                cmp xpos,2
                jl _4ltest3
                dec xpos
                 invoke Collision_block,3
                .IF collided == 0
                    jmp _4ltest3
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest3:
                add xpos,3
                cmp xpos,8
                jg _4ltest4
                 invoke Collision_block,3
                .IF collided == 0
                    jmp _4ltest4
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest4:
                inc ypos
                sub xpos,3
                cmp xpos,2
                jl _4ltest5
                 invoke Collision_block,3
                .IF collided == 0
                    jmp _4ltest5
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest5:
                sub ypos,3
                add xpos,3
                cmp xpos,8
                jg _4ldontmove
                 invoke Collision_block,3
                .IF collided == 0
                    jmp _4ldontmove
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ldontmove:
                sub xpos,2
                add ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
    .ENDIF
Rotate_I ENDP
Rotate_S PROC,lr:byte
    .IF lr=='r'
        .IF direction==1
            _1rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,2
                .IF collided == 0
                    jmp _1rtest2
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest2:
                dec xpos
                invoke Collision_block,2
                .IF collided == 0
                    jmp _1rtest3
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest3:
                dec ypos
                cmp ypos,2
                jl _1rtest4
                invoke Collision_block,2
                .IF collided==0
                    jmp _1rtest4
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest4:
                inc xpos    
                add ypos,3
                cmp ypos,21
                jg _1rtest5
                invoke Collision_block,2
                .IF collided==0
                    jmp _1rtest5
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest5:
                dec xpos
                cmp ypos,21
                jg _1rdontmove
                invoke Collision_block,2
                .IF collided==0
                    jmp _1rdontmove
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rdontmove:
                inc xpos
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==2
            _2rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,3
                .IF collided==0
                    jmp _2rtest2
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest2:
                inc xpos
                cmp xpos,9
                jg _2rtest3
                invoke Collision_block,3
                .IF collided==0
                    jmp _2rtest3
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest3:
                dec ypos
                cmp xpos,9
                jg _2rtest4
                cmp ypos,21
                jg _2rtest4
                invoke Collision_block,3
                .IF collided==0
                    jmp _2rtest4
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest4:
                dec xpos
                sub ypos,3
                cmp ypos,1
                jl _2rtest5
                invoke Collision_block,3
                .IF collided==0
                    jmp _2rtest5
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest5:
                inc xpos
                cmp ypos,1
                jl _2rdontmove
                cmp xpos,9
                jg _2rdontmove
                invoke Collision_block,3
                .IF collided==0
                    jmp _2rdontmove
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rdontmove:
                dec xpos
                add ypos,2
                invoke Drawplayer,0feh
                ret
            .ENDIF
        .IF direction==3
            _3rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rtest2
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest2:
                inc xpos
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rtest3
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret

            _3rtest3:
                dec ypos
                cmp ypos,2
                jl _3rtest4
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rtest4
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest4:
                dec xpos
                add ypos,3
                cmp ypos,21
                jg _3rtest5
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rtest5
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest5:
                inc xpos
                cmp ypos,21
                jg _3rdontmove
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rdontmove
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rdontmove:
                dec xpos
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==4
            _4rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rtest2
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest2:
                dec xpos
                cmp xpos,2
                jl _4rtest3
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rtest3
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest3:
                inc ypos
                cmp xpos,2
                jl _4rtest4
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rtest4
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest4:
                inc xpos
                sub ypos,3
                cmp ypos,2
                jl _4rtest5
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rtest5
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest5:
                dec xpos
                cmp xpos,2
                jl _4rdontmove
                cmp ypos,2
                jl _4rdontmove
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rdontmove
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rdontmove:
                inc xpos
                add ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction==1
            _1ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ltest2
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest2:
                inc xpos
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ltest3
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest3:
                dec ypos
                cmp ypos,2
                jl _1ltest4
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ltest4
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest4:
                dec xpos
                add ypos,3
                cmp ypos,21
                jg _1ltest5
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ltest5
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest5:
                inc xpos
                cmp ypos,21
                jg _1ldontmove
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ldontmove
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ldontmove:
                dec xpos
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==2
            _2ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ltest2
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest2:
                inc xpos
                cmp xpos,9
                jg _2ltest3
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ltest3
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest3:
                inc ypos
                cmp xpos,9
                jg _2ltest4
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ltest4
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest4:
                dec xpos
                sub ypos,3
                cmp ypos,2
                jl _2ltest5
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ltest5
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest5:
                dec xpos
                cmp ypos,2
                jl _2ldontmove
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ldontmove
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ldontmove:
                dec xpos
                add ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==3
            _3ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest2
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest2:
                dec xpos
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest3
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest3:
                dec ypos
                cmp ypos,2
                jl _3ltest4
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest4
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest4:
                inc xpos
                add ypos,3
                cmp ypos,21
                jg _3ltest5
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest5
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest5:
                dec xpos
                cmp ypos,21
                jg _3ldontmove
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ldontmove
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ldontmove:
                inc xpos
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==4
            _4ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest2
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest2:
                dec xpos
                cmp xpos,2
                jl _4ltest3
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest3
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest3:
                inc ypos
                cmp xpos,2
                jl _4ltest4
                cmp ypos,21
                jg _4ltest4
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest4
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest4:
                inc xpos
                sub ypos,3
                cmp ypos,1
                jl _4ltest5
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest5
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest5:
                dec xpos
                cmp ypos,1
                jl _4ldontmove
                cmp xpos,2
                jl _4ldontmove
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ldontmove
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ldontmove:
                inc xpos
                add ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
    .ENDIF
    ret
Rotate_S ENDP
Rotate_T PROC,lr:byte

    .IF lr=='r'
        .IF direction==1
            _1rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,2
                .IF collided==0
                    jmp _1rtest2
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest2:
                dec xpos
                invoke Collision_block,2
                .IF collided==0
                    jmp _1rtest3
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest3:
                dec ypos
                cmp ypos,2
                jl _1rtest4
                invoke Collision_block,2
                .IF collided==0
                    jmp _1rtest4
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest4:   
                inc xpos
                add ypos,3
                cmp ypos,21
                jg _1rtest5
                invoke Collision_block,2
                .IF collided==0
                    jmp _1rtest5
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest5:
                dec xpos
                cmp ypos,21
                jmp _1rdontmove
                invoke Collision_block,2
                .IF collided==0
                    jmp _1rdontmove
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rdontmove:
                inc xpos
                sub ypos,2
                invoke Drawplayer,'x'
                ret
        .ENDIF
        .IF direction==2
            _2rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,3
                .IF collided==0
                    jmp _2rtest2
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest2:
                inc xpos
                cmp xpos,9
                jg _2rtest3
                invoke Collision_block,3
                .IF collided==0
                    jmp _2rtest3
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest3:
                inc ypos
                cmp xpos,9
                jg _2rtest4
                cmp ypos,21
                jg _2rtest4
                invoke Collision_block,3
                .IF collided==0
                    jmp _2rtest4
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest4:
                dec xpos
                sub ypos,3
                cmp ypos,1
                jl _2rtest5
                invoke Collision_block,3
                .IF collided==0
                    jmp _2rtest5
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest5:
                inc xpos
                cmp xpos,9
                jg _2rdontmove
                cmp ypos,1
                jl _2rdontmove
                invoke Collision_block,3
                .IF collided==0
                    jmp _2rdontmove
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rdontmove:
                dec xpos
                add ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==3
            _3rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rtest2
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest2:
                inc xpos
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rtest3
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest3:
                dec ypos
                cmp ypos,2
                jl _3rtest4
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rtest4
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest4:
                dec xpos
                add ypos,3
                cmp ypos,21
                jg _3rtest5
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rtest5
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest5:
                inc xpos
                cmp ypos,21
                jg _3rdontmove
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rtest2
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rdontmove:
                dec xpos
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==4
            _4rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rtest2
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest2:
                dec xpos
                cmp xpos,2
                jl _4rtest3
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rtest3
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest3:
                inc ypos
                cmp xpos,2
                jl _4rtest4
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rtest4
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest4:
                inc xpos
                sub ypos,3
                cmp ypos,2
                jl _4rtest5
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rtest5
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest5:
                dec xpos
                cmp xpos,2
                jl _4rdontmove
                cmp ypos,2
                jl _4rdontmove
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rdontmove
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rdontmove:
                inc xpos
                add ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction==1
            _1ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ltest2
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest2:
                inc xpos
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ltest3
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest3:
                dec ypos
                cmp ypos,2
                jl _1ltest4
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ltest4
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest4:
                dec xpos
                add ypos,3
                cmp ypos,21
                jg _1ltest5
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ltest5
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest5:
                inc xpos
                cmp ypos,21
                jg _1ldontmove
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ldontmove
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ldontmove:
                dec xpos
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==2
            _2ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ltest2
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest2:
                inc xpos
                cmp xpos,9
                jg _2ltest3
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ltest3
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest3:
                inc ypos
                cmp xpos,9
                jg _2ltest4
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ltest4
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest4:
                dec xpos
                sub ypos,3
                cmp ypos,2
                jl _2ltest5
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ltest5
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest5:
                inc xpos
                cmp xpos,9
                jg _2ldontmove
                cmp ypos,2
                jl _2ldontmove
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ldontmove
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ldontmove:
                dec xpos
                add ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==3
            _3ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest2
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest2:
                dec xpos
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest3
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest3:
                dec ypos
                cmp ypos,2
                jl _3ltest4
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest4
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest4:
                inc xpos
                add ypos,3
                cmp ypos,21
                jg _3ltest5
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest5
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest5:
                dec xpos
                cmp ypos,21
                jg _3ldontmove
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ldontmove
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ldontmove:
                inc xpos 
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==4
            _4ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest2
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest2:
                dec xpos
                cmp xpos,2
                jl _4ltest3
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest3
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret        
            _4ltest3:
                inc ypos
                cmp xpos,2
                jl _4ltest4
                cmp ypos,21
                jg _4ltest4
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest4
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest4:
                inc xpos
                sub ypos,3
                cmp ypos,1
                jl _4ltest5
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest2
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest5:
                dec xpos
                cmp ypos,1
                jl _4ldontmove
                cmp xpos,2
                jl _4ldontmove
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ldontmove
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ldontmove:
                inc xpos
                add ypos,2
                invoke Drawplayer,'x'
                ret
        .ENDIF
    .ENDIF
Rotate_T ENDP
Rotate_J PROC,lr:byte
    .IF lr=='r'
        .IF direction==1
            _1rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,2
                .IF collided==0
                    jmp _1rtest2
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest2:
                dec xpos
                invoke Collision_block,2
                .IF collided==0
                    jmp _1rtest3
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest3:
                dec ypos
                cmp ypos,2
                jl _1rtest4
                invoke Collision_block,2
                .IF collided==0
                    jmp _1rtest4
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest4:
                inc xpos
                add ypos,3
                cmp ypos,21
                jg _1rtest5
                invoke Collision_block,2
                .IF collided==0
                    jmp _1rtest5
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest5:
                dec xpos
                cmp ypos,21 
                jg _1rdontmove
                invoke Collision_block,2
                .IF collided==0
                    jmp _1rdontmove
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rdontmove:
                inc xpos
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==2
            _2rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,3
                .IF collided==0
                    jmp _2rtest2
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest2:
                inc xpos
                inc ypos
                cmp xpos,9
                jg _2rtest3
                cmp ypos,21 
                jg _2rtest3
                invoke Collision_block,3
                .IF collided==0
                    jmp _2rtest3
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest3:
                dec xpos
                sub ypos,3
                cmp ypos,1
                jl _2rtest4
                invoke Collision_block,3
                .IF collided==0
                    jmp _2rtest4
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest4:
                inc xpos
                cmp ypos,1
                jl _2rdontmove
                cmp xpos,9
                jg _2rdontmove
                invoke Collision_block,3
                .IF collided==0
                    jmp _2rdontmove
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rdontmove:
                dec xpos
                add ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==3
            _3rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rtest2
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest2:
                inc xpos
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rtest3
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest3:
                dec ypos
                cmp ypos,2
                jl _3rtest4
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rtest4
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest4:
                dec xpos
                add ypos,3
                cmp ypos,21
                jg _3rtest5
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rtest5
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest5:
                inc xpos
                cmp ypos,21
                jg _3rdontmove
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rdontmove
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rdontmove:
                dec xpos
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==4
            _4rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rtest2
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest2:
                dec xpos
                cmp xpos,2
                jl _4rtest3
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rtest3
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest3:
                inc ypos
                cmp xpos,2
                jl _4rtest4
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rtest4
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest4:
                inc xpos
                sub ypos,3
                cmp ypos,2
                jl _4rtest5
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rtest5
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest5:
                dec xpos
                cmp xpos,2
                jl _4rdontmove
                cmp ypos,2
                jl _4rdontmove
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rdontmove
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rdontmove:
                inc xpos
                add ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction==1
            _1ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ltest2
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest2:
                inc xpos
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ltest3
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest3:
                dec ypos
                cmp ypos,2
                jl _1ltest4
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ltest4
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest4:
                dec xpos
                add ypos,3
                cmp ypos,21
                jg _1ltest5
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ltest5
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest5:
                inc xpos
                cmp ypos,21
                jg _1ldontmove
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ldontmove
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ldontmove:
                dec xpos
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==2
            _2ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ltest2
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest2:
                inc xpos
                cmp xpos,9
                jg _2ltest3
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ltest3
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest3:
                inc ypos
                cmp xpos,9
                jg _2ltest4
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ltest4
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest4:
                dec xpos
                sub ypos,3
                cmp ypos,2
                jl _2ltest5
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ltest5
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest5:
                inc xpos
                cmp ypos,2
                jl _2ldontmove
                cmp xpos,9
                jg _2ldontmove
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ldontmove
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ldontmove:
                dec xpos
                add ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==3
            _3ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest2
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest2:
                dec xpos
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest3
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest3:
                dec ypos
                cmp ypos,2
                jl _3ltest4
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest4
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest4:
                inc xpos
                add ypos,2
                cmp ypos,21
                jg _3ltest5
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest5
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest5:
                dec xpos
                inc ypos
                cmp ypos,21
                jg _3ldontmove
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ldontmove
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ldontmove:
                inc xpos
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==4
            _4ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest2
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest2:
                dec xpos
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest3
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest3:
                dec ypos
                cmp ypos,2
                jl _4ltest4
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest4
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest4:
                inc xpos
                add ypos,2
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest5
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest5:
                dec xpos
                inc ypos
                cmp ypos,21
                jg _4ldontmove
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ldontmove
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret                
            _4ldontmove:
                inc xpos
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
    .ENDIF
Rotate_J ENDP
Rotate_L PROC,lr:byte
    .IF lr=='r'
        .IF direction==1
            _1rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,2
                .IF collided==0
                    jmp _1rtest2
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest2:
                dec xpos
                invoke Collision_block,2
                .IF collided==0
                    jmp _1rtest3
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest3:
                dec ypos
                cmp ypos,2
                jl _1rtest4
                invoke Collision_block,2
                .IF collided==0
                    jmp _1rtest4
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest4:
                inc xpos
                add ypos,3
                cmp ypos,21
                jg _1rtest5
                invoke Collision_block,2
                .IF collided==0
                    jmp _1rtest5
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest5:
                dec xpos
                cmp ypos,21 
                jg _1rdontmove
                invoke Collision_block,2
                .IF collided==0
                    jmp _1rdontmove
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rdontmove:
                inc xpos
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==2
            _2rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,3
                .IF collided==0
                    jmp _2rtest2
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest2:
                inc xpos
                inc ypos
                cmp xpos,9
                jg _2rtest3
                cmp ypos,21 
                jg _2rtest3
                invoke Collision_block,3
                .IF collided==0
                    jmp _2rtest3
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest3:
                dec xpos
                sub ypos,3
                cmp ypos,1
                jl _2rtest4
                invoke Collision_block,3
                .IF collided==0
                    jmp _2rtest4
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest4:
                inc xpos
                cmp ypos,1
                jl _2rdontmove
                cmp xpos,9
                jg _2rdontmove
                invoke Collision_block,3
                .IF collided==0
                    jmp _2rdontmove
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rdontmove:
                dec xpos
                add ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==3
            _3rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rtest2
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest2:
                inc xpos
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rtest3
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest3:
                dec ypos
                cmp ypos,2
                jl _3rtest4
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rtest4
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest4:
                dec xpos
                add ypos,3
                cmp ypos,21
                jg _3rtest5
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rtest5
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rtest5:
                inc xpos
                cmp ypos,21
                jg _3rdontmove
                invoke Collision_block,4
                .IF collided==0
                    jmp _3rdontmove
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _3rdontmove:
                dec xpos
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==4
            _4rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rtest2
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest2:
                dec xpos
                cmp xpos,2
                jl _4rtest3
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rtest3
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest3:
                inc ypos
                cmp xpos,2
                jl _4rtest4
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rtest4
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest4:
                inc xpos
                sub ypos,3
                cmp ypos,2
                jl _4rtest5
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rtest5
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest5:
                dec xpos
                cmp xpos,2
                jl _4rdontmove
                cmp ypos,2
                jl _4rdontmove
                invoke Collision_block,1
                .IF collided==0
                    jmp _4rdontmove
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rdontmove:
                inc xpos
                add ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction==1
            _1ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ltest2
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest2:
                inc xpos
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ltest3
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest3:
                dec ypos
                cmp ypos,2
                jl _1ltest4
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ltest4
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest4:
                dec xpos
                add ypos,3
                cmp ypos,21
                jg _1ltest5
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ltest5
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ltest5:
                inc xpos
                cmp ypos,21
                jg _1ldontmove
                invoke Collision_block,4
                .IF collided==0
                    jmp _1ldontmove
                .ENDIF
                mov direction,4
                invoke Drawplayer,0feh
                ret
            _1ldontmove:
                dec xpos
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==2
            _2ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ltest2
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest2:
                inc xpos
                cmp xpos,9
                jg _2ltest3
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ltest3
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest3:
                inc ypos
                cmp xpos,9
                jg _2ltest4
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ltest4
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest4:
                dec xpos
                sub ypos,3
                cmp ypos,2
                jl _2ltest5
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ltest5
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest5:
                inc xpos
                cmp ypos,2
                jl _2ldontmove
                cmp xpos,9
                jg _2ldontmove
                invoke Collision_block,1
                .IF collided==0
                    jmp _2ldontmove
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ldontmove:
                dec xpos
                add ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==3
            _3ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest2
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest2:
                dec xpos
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest3
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest3:
                dec ypos
                cmp ypos,2
                jl _3ltest4
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest4
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest4:
                inc xpos
                add ypos,2
                cmp ypos,21
                jg _3ltest5
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest5
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest5:
                dec xpos
                inc ypos
                cmp ypos,21
                jg _3ldontmove
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ldontmove
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ldontmove:
                inc xpos
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==4
            _4ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest2
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest2:
                dec xpos
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest3
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest3:
                dec ypos
                cmp ypos,2
                jl _4ltest4
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest4
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest4:
                inc xpos
                add ypos,2
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest5
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest5:
                dec xpos
                inc ypos
                cmp ypos,21
                jg _4ldontmove
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ldontmove
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret                
            _4ldontmove:
                inc xpos
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
    .ENDIF
Rotate_L ENDP
Rotate_Z PROC,lr:Byte                                
    .IF lr=='r'
        .IF direction==1
            _1rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,2
                .IF collided == 0
                    jmp _1rtest2
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest2:
                dec xpos
                invoke Collision_block,2
                .IF collided ==0
                    jmp _1rtest3
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest3:
                dec ypos
                cmp ypos,2
                jl _1rtest4
                invoke Collision_block,2
                .IF collided == 0
                    jmp _1rtest4
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest4:                
                inc xpos
                add ypos,3
                cmp ypos,21
                jg _1rtest5
                invoke Collision_block,2
                .IF collided == 0
                    jmp _1rtest5
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rtest5:
                dec xpos
                cmp ypos,21
                jg _1rdontmove
                invoke Collision_block,2
                .IF collided == 0
                    jmp _1rdontmove
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _1rdontmove:
                mov direction,1
                inc xpos
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==2
            _2rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,3
                .IF collided == 0
                jmp _2rtest2
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest2:
                inc xpos
                cmp xpos,9
                jg _2rtest3
                invoke Collision_block,3
                .IF collided == 0
                jmp _2rtest3
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest3:
                inc ypos
                cmp xpos,9
                jg _2rtest4
                cmp ypos,21
                jg _2rtest4
                invoke Collision_block,3
                .IF collided == 0
                jmp _2rtest4
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest4:
                dec xpos
                sub ypos,3
                cmp ypos,1
                jl _2rtest5
                invoke Collision_block,3
                .IF collided == 0
                jmp _2rtest5
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rtest5:
                inc xpos
                cmp xpos,9
                jg _2rdontmove
                cmp ypos,1
                jl _2rdontmove
                invoke Collision_block,3
                .IF collided == 0
                jmp _2rdontmove
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _2rdontmove:
                add ypos,3
                dec xpos
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==3
            _3rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,3
                .IF collided == 0
                    jmp _3rtest2
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _3rtest2:
                inc xpos
                invoke Collision_block,3
                .IF collided == 0
                    jmp _3rtest3
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _3rtest3:
                dec ypos
                cmp ypos,2
                jl _3rtest4
                invoke Collision_block,3
                .IF collided == 0
                    jmp _3rtest4
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _3rtest4:
                dec xpos
                add ypos,3
                cmp ypos,21
                jg _3rtest5
                invoke Collision_block,3
                .IF collided == 0
                    jmp _3rtest5
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _3rtest5:
                inc xpos
                cmp ypos,21
                jg _3rdontmove
                invoke Collision_block,3
                .IF collided == 0
                    jmp _3rdontmove
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _3rdontmove:
                dec xpos
                sub ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==4
            _4rtest1:
                invoke Drawplayer,'.'
                invoke Collision_block,1
                .IF collided == 0
                    jmp _4rtest2
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest2:
                dec xpos
                cmp xpos,1
                jl _4rtest3
                invoke Collision_block,1
                .IF collided == 0
                    jmp _4rtest3
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest3:
                inc ypos
                cmp xpos,1
                jl _4rtest4
                invoke Collision_block,1
                .IF collided == 0
                    jmp _4rtest4
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest4:
                inc xpos
                sub ypos,3
                cmp ypos,1
                jl _4rtest5
                invoke Collision_block,1
                .IF collided == 0
                    jmp _4rtest5
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rtest5:
                dec xpos
                cmp xpos,2
                jl _4rdontmove
                cmp ypos,1
                jl _4rdontmove
                invoke Collision_block,1
                .IF collided == 0
                    jmp _4rdontmove
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _4rdontmove:
                inc xpos
                add ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction==1
            _1ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,3
                .IF collided == 0
                    jmp _1ltest2
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _1ltest2:
                inc xpos
                invoke Collision_block,3
                .IF collided == 0
                    jmp _1ltest3
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _1ltest3:   
                dec ypos
                cmp ypos,2
                jl _1ltest4
                invoke Collision_block,3  
                .IF collided == 0
                    jmp _1ltest4
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _1ltest4:
                dec xpos
                add ypos,3
                cmp ypos,21
                jg _1ltest5
                invoke Collision_block,3
                .IF collided == 0
                    jmp _1ltest5
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _1ltest5:
                inc xpos
                cmp ypos,21
                jg _1ldontmove
                invoke Collision_block,3
                .IF collided == 0
                    jmp _1ldontmove
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _1ldontmove:
                dec xpos
                sub ypos,3
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==2
            _2ltest1:
                invoke Drawplayer,'.'
                invoke Collision_block,1
                .IF collided == 0
                    jmp _2ltest2
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ltest2:
                inc xpos
                cmp xpos,9
                jg _2ltest3
                invoke Collision_block,1
                .IF collided == 0
                    jmp _2ltest2
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret

            _2ltest3:
                inc ypos
                cmp xpos,9
                jg _2ltest4
                invoke Collision_block,1
                .IF collided == 0
                    jmp _2ltest2;=4
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret

            _2ltest4:
                dec xpos
                sub ypos,3
                cmp ypos,2
                jl _2ltest5
                invoke Collision_block,1
                .IF collided == 0
                    jmp _2ltest2;=5
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret

            _2ltest5:
                inc xpos
                cmp xpos,9
                jg _2ldontmove
                cmp ypos,2
                jl _2ldontmove
                invoke Collision_block,1
                .IF collided == 0
                    jmp _2ldontmove
                .ENDIF
                mov direction,1
                invoke Drawplayer,0feh
                ret
            _2ldontmove:
                dec xpos
                add ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
        .IF direction==3
            invoke Drawplayer,'.'
            _3ltest1:
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest2
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ltest2:
                dec xpos
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest3
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret

            _3ltest3:
                dec ypos
                cmp ypos,2
                jl _3ltest4
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest4
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret

            _3ltest4:
                inc xpos
                add ypos,3
                cmp ypos,21
                jg _3ltest5
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ltest5
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret

            _3ltest5:
                dec xpos
                cmp ypos,21
                jg _3ldontmove
                invoke Collision_block,2
                .IF collided==0
                    jmp _3ldontmove
                .ENDIF
                mov direction,2
                invoke Drawplayer,0feh
                ret
            _3ldontmove:
                inc xpos
                sub ypos,2
                ret
        .ENDIF
        .IF direction==3
            _4ltest1:
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest2
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest2:
                dec xpos
                cmp xpos,2
                jl _4ltest3
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest3
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest3:
                inc ypos
                cmp xpos,2
                jl _4ltest4
                cmp ypos,21
                jg _4ltest4
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest4
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest4:
                inc xpos
                sub ypos,3
                cmp ypos,1
                jl _4ltest5
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ltest5
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ltest5:
                dec xpos
                cmp ypos,1
                jl _4ldontmove
                cmp xpos,1
                jl _4ldontmove
                invoke Collision_block,3
                .IF collided==0
                    jmp _4ldontmove
                .ENDIF
                mov direction,3
                invoke Drawplayer,0feh
                ret
            _4ldontmove:
                inc xpos
                add ypos,2
                invoke Drawplayer,0feh
                ret
        .ENDIF
    .ENDIF
Rotate_Z ENDP
END main