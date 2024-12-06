INCLUDE Irvine32.inc
main          EQU start@0
Drawplayer PROTO,player:PTR BYTE, block_type:BYTE, xpos:byte, ypos:byte, direction:byte,paint:byte
Rotate_block PROTO,player:PTR BYTE,block_type:BYTE,xpos:byte,ypos:byte,direction:byte
Rotate_I PROTO,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
Rotate_S PROTO,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
Rotate_T PROTO,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
Rotate_J PROTO,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
Rotate_Z PROTO,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
Rotate_L PROTO,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
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
    invoke Drawplayer,OFFSET [player_1] ,'I' ,xpos_1 ,ypos_1,1,'X'
    invoke Draw
    call ReadChar
    jmp gameloop
    call ReadChar
    exit
main ENDP
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
Rotate_block PROC,player:PTR BYTE,block_type:BYTE,xpos:byte,ypos:byte,direction:byte,,lr:byte
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
            1rtest1:

            1rtest2:
            
            1rtest3:

            1rtest4:

            1rtest5:

        .ENDIF
        .IF direction=='2'
            2rtest1:

            2rtest2:

            2rtest3:

            2rtest4:

            2rtest5:
        .ENDIF
        .IF direction=='3'
            3rtest1:

            3rtest2:

            3rtest3:

            3rtest4:

            3rtest5:
        .ENDIF
        .IF direction=='4'
            4rtest1:

            4rtest2:

            4rtest3:

            4rtest4:

            4rtest5
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction=='1'
            1ltest1:

            1ltest2:
            
            1ltest3:

            1ltest4:

            1ltest5:

        .ENDIF
        .IF direction=='2'
            2ltest1:

            2ltest2:

            2ltest3:

            2ltest4:

            2ltest5:
        .ENDIF
        .IF direction=='3'
            3ltest1:

            3ltest2:

            3ltest3:

            3ltest4:

            3ltest5:
        .ENDIF
        .IF direction=='4'
            4ltest1:

            4ltest2:

            4ltest3:

            4ltest4:

            4ltest5
        .ENDIF
    .ENDIF
Rotate_I ENDP
Rotate_S PROC,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
    .IF lr=='r'
        .IF direction=='1'
            1rtest1:

            1rtest2:
            
            1rtest3:

            1rtest4:

            1rtest5:

        .ENDIF
        .IF direction=='2'
            2rtest1:

            2rtest2:

            2rtest3:

            2rtest4:

            2rtest5:
        .ENDIF
        .IF direction=='3'
            3rtest1:

            3rtest2:

            3rtest3:

            3rtest4:

            3rtest5:
        .ENDIF
        .IF direction=='4'
            4rtest1:

            4rtest2:

            4rtest3:

            4rtest4:

            4rtest5
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction=='1'
            1ltest1:

            1ltest2:
            
            1ltest3:

            1ltest4:

            1ltest5:

        .ENDIF
        .IF direction=='2'
            2ltest1:

            2ltest2:

            2ltest3:

            2ltest4:

            2ltest5:
        .ENDIF
        .IF direction=='3'
            3ltest1:

            3ltest2:

            3ltest3:

            3ltest4:

            3ltest5:
        .ENDIF
        .IF direction=='4'
            4ltest1:

            4ltest2:

            4ltest3:

            4ltest4:

            4ltest5
        .ENDIF
    .ENDIF
Rotate_S ENDP
Rotate_Z PROC,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:Byte
    mov edx,player
    mov eax,0
    mov al,ypos
    mov bl,11
    mul bl
    add al,xpos
    add edx,eax
    mov eax,edx; to preserve the center we got now
    .IF lr=='r'
        .IF direction=='1'
            1rtest1:
                sub edx,10
                cmp [edx],'.'
                jne 1rtest2                
                add edx,10
                cmp [edx],'.'
                jne 1rtest2     
                inc edx
                cmp [edx],'.'
                jne 1rtest2     
                add edx,10
                cmp [edx],'.'
                jne 1rtest2     
                invoke Drawplayer,player,'Z',xpos,ypos,1,'.' 
                mov direction,'2'
                invoke Drawplayer,player,'Z',xpos,ypos,1,'X' 
                ret
            1rtest2:
                sub edx,11
                cmp [edx],'.'
                jne 1rtest3
                add edx,10
                cmp [edx],'.'
                jne 1rtest2   
                inc edx
                cmp [edx],'.'
                jne 1rtest2   
                add edx,10
                cmp [edx],'.'
                jne 1rtest2      
                invoke Drawplayer,player,'Z',xpos,ypos,1,'.' 
                sub xpos
                mov direction,'2'
                invoke Drawplayer,player,'Z',xpos,ypos,1,'X' 
            1rtest3:
                
                invoke Drawplayer,player,'Z',xpos,ypos,1,'.' 
                mov direction,'2'
                invoke Drawplayer,player,'Z',xpos,ypos,1,'X' 
            1rtest4:

                invoke Drawplayer,player,'Z',xpos,ypos,1,'.' 
                mov direction,'2'
                invoke Drawplayer,player,'Z',xpos,ypos,1,'X' 
            1rtest5:

                invoke Drawplayer,player,'Z',xpos,ypos,1,'.' 
                mov direction,'2'
                invoke Drawplayer,player,'Z',xpos,ypos,1,'X' 
        .ENDIF
        .IF direction=='2'
            2rtest1:

            2rtest2:

            2rtest3:

            2rtest4:

            2rtest5:
        .ENDIF
        .IF direction=='3'
            3rtest1:

            3rtest2:

            3rtest3:

            3rtest4:

            3rtest5:
        .ENDIF
        .IF direction=='4'
            4rtest1:

            4rtest2:

            4rtest3:

            4rtest4:

            4rtest5
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction=='1'
            1ltest1:

            1ltest2:
            
            1ltest3:

            1ltest4:

            1ltest5:

        .ENDIF
        .IF direction=='2'
            2ltest1:

            2ltest2:

            2ltest3:

            2ltest4:

            2ltest5:
        .ENDIF
        .IF direction=='3'
            3ltest1:

            3ltest2:

            3ltest3:

            3ltest4:

            3ltest5:
        .ENDIF
        .IF direction=='4'
            4ltest1:

            4ltest2:

            4ltest3:

            4ltest4:

            4ltest5
        .ENDIF
    .ENDIF
Rotate_Z ENDP
Rotate_T PROC,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
    .IF lr=='r'
        .IF direction=='1'
            1rtest1:

            1rtest2:
            
            1rtest3:

            1rtest4:

            1rtest5:

        .ENDIF
        .IF direction=='2'
            2rtest1:

            2rtest2:

            2rtest3:

            2rtest4:

            2rtest5:
        .ENDIF
        .IF direction=='3'
            3rtest1:

            3rtest2:

            3rtest3:

            3rtest4:

            3rtest5:
        .ENDIF
        .IF direction=='4'
            4rtest1:

            4rtest2:

            4rtest3:

            4rtest4:

            4rtest5
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction=='1'
            1ltest1:

            1ltest2:
            
            1ltest3:

            1ltest4:

            1ltest5:

        .ENDIF
        .IF direction=='2'
            2ltest1:

            2ltest2:

            2ltest3:

            2ltest4:

            2ltest5:
        .ENDIF
        .IF direction=='3'
            3ltest1:

            3ltest2:

            3ltest3:

            3ltest4:

            3ltest5:
        .ENDIF
        .IF direction=='4'
            4ltest1:

            4ltest2:

            4ltest3:

            4ltest4:

            4ltest5
        .ENDIF
    .ENDIF
Rotate_T ENDP
Rotate_J PROC,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
    .IF lr=='r'
        .IF direction=='1'
            1rtest1:

            1rtest2:
            
            1rtest3:

            1rtest4:

            1rtest5:

        .ENDIF
        .IF direction=='2'
            2rtest1:

            2rtest2:

            2rtest3:

            2rtest4:

            2rtest5:
        .ENDIF
        .IF direction=='3'
            3rtest1:

            3rtest2:

            3rtest3:

            3rtest4:

            3rtest5:
        .ENDIF
        .IF direction=='4'
            4rtest1:

            4rtest2:

            4rtest3:

            4rtest4:

            4rtest5
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction=='1'
            1ltest1:

            1ltest2:
            
            1ltest3:

            1ltest4:

            1ltest5:

        .ENDIF
        .IF direction=='2'
            2ltest1:

            2ltest2:

            2ltest3:

            2ltest4:

            2ltest5:
        .ENDIF
        .IF direction=='3'
            3ltest1:

            3ltest2:

            3ltest3:

            3ltest4:

            3ltest5:
        .ENDIF
        .IF direction=='4'
            4ltest1:

            4ltest2:

            4ltest3:

            4ltest4:

            4ltest5
        .ENDIF
    .ENDIF
Rotate_J ENDP
Rotate_L PROC,player:PTR byte,xpos:byte,ypos:byte,direction:byte,lr:byte
    .IF lr=='r'
        .IF direction=='1'
            1rtest1:

            1rtest2:
            
            1rtest3:

            1rtest4:

            1rtest5:

        .ENDIF
        .IF direction=='2'
            2rtest1:

            2rtest2:

            2rtest3:

            2rtest4:

            2rtest5:
        .ENDIF
        .IF direction=='3'
            3rtest1:

            3rtest2:

            3rtest3:

            3rtest4:

            3rtest5:
        .ENDIF
        .IF direction=='4'
            4rtest1:

            4rtest2:

            4rtest3:

            4rtest4:

            4rtest5
        .ENDIF
    .ENDIF
    .IF lr=='l'
        .IF direction=='1'
            1ltest1:

            1ltest2:
            
            1ltest3:

            1ltest4:

            1ltest5:

        .ENDIF
        .IF direction=='2'
            2ltest1:

            2ltest2:

            2ltest3:

            2ltest4:

            2ltest5:
        .ENDIF
        .IF direction=='3'
            3ltest1:

            3ltest2:

            3ltest3:

            3ltest4:

            3ltest5:
        .ENDIF
        .IF direction=='4'
            4ltest1:

            4ltest2:

            4ltest3:

            4ltest4:

            4ltest5
        .ENDIF
    .ENDIF
Rotate_L ENDP
END main