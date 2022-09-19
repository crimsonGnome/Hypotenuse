;****************************************************************************************************************************
; Program name: "Hypotenuse". This program takes in two float numbers as inputs to determine the hypotenuse in which the two
; lines forms. It will then return the hypotenuse of the new triangele.
; use Copyright (C) 2022 Joseph Eggers.
;                                                                                                                           *
;This file is part of the software program "Hypotenuse".                                                              *
; Hypotenuse is free software: you can redistribute it and/or modify it under the terms of the GNU General Public      *
;License version 3 as published by the Free Software Foundation.                                                            *
; Hypotenuse is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied     *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
;****************************************************************************************************************************

;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Joseph Eggers
;  Author email: joseph.eggers@csu.fullerton.edu
;  Author CWID: 885939488
;
;Contributors 
;  Consutlation was provided by the programmer sapphireGnome (Destiny Bonillas) for terminology, and Flow Control
;
;Status
;  This software is not an application program, but rather it is a single function licensed for use by other applications.
;  This function can be embedded within both FOSS programs and in proprietary programs as permitted by the LGPL.

;Function information
;  Function name: Hypotenuse
;  Programming language: X86 assembly in Intel syntax.
;  Date development began:  2022-Oct-17
;  Date version 1.0 finished: 2022-Oct-17
;  System requirements: an X86 platform with nasm installed o other compatible assembler.
;  Know issues: <now in testing phase>
;  Assembler used for testing: Nasm version 2.14.02
;
;Purpose
;  This function wil accept two floats and return the hypotenuse
;
;Translation information
;  Assemble: nasm -f elf64 -l Hypotenuse.lis -o Hypotenuse.o hypotenuse.asm
;
;========= Begin source code ====================================================================================
extern printf
extern scanf
extern fgets
extern stdin
extern strlen
INPUT_LEN equ 256 ; Max bytes of name, title, response
LARGE_BOUNDARY equ 64
SMALL_BOUNDARY equ 16

global pythagoras

segment .data
align SMALL_BOUNDARY
; Output messages used for the program. 
nameInput db "Please enter your last name: ",0
titleInput db "Please enter your title (Mr, Ms, Nurse, Engineer, etc): ",0
initiate db "Please enter the sides of your triangle seperated by ws: ", 0
calculation db `The length of the hypotenuse is %1.16f units`, 10, 0 
confirmationNumbers db `These are the numbers were entered \n %1.16lf \n %1.16lf`,10,0
endingMSG db `Please enjoy your triangle %s %s`, 10, 0
; Inut messages received by the user
floatFormat db "%lf %lf", 0
format: db "%s", 0 ;
align LARGE_BOUNDARY
segment .bss
; Reserve 256 bytes for each
  title: resb INPUT_LEN
  name: resb INPUT_LEN
  response: resb INPUT_LEN

segment .text

pythagoras:
;Prolog ===== Insurance for any caller of this assembly module ========================================================
;Any future program calling this module that the data in the caller's GPRs will not be modified.
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

;Registers rax, rip, and rsp are usually not backed up.
push qword 0
;====== Intiate progam ======================================================================
;============================================================================================
;
;====== ***** Name Section *****  =====================================
;====== Print the last name Enter Message ================
;

mov rax, 0				      ; 0 floats being passed into funcion
mov rdi, format			    ; the format the we are expexcting, which is a string
mov rsi, nameInput			; output message - Please enter your name 
call printf				      ; call printf function 


;====== Enter the last name ================

mov rax, 0				      ; 0 floats being passed into funcion
mov rdi, name			      ; moving name 
mov rsi, INPUT_LEN 		  ; 256 bytes limit (2nd arg)
mov rdx, [stdin]		    ; dereferenced file strem
call fgets              ; call to fegets function

; Remove newline char from fgets input
mov rax, 0              ; 0 floats being passed into funcion
mov rdi, name           
call strlen           ; Call external function strlen, there will be an enter at the end
sub rax, 1            ; gets location of '\n' since string is stored in rax
mov byte [name + rax], 0 ; Replace enter

;
;====== ***** Title Section *****  ===================================
;====== Enter you tilte Section ================
;
mov rax, 0                ; 0 floats being passed into funcion
mov rdi, format   
mov rsi, titleInput       ; Move titleInput 
call printf               ; Call function printf

;===== Enter Title Input ==================

mov rax, 0                ; 0 floats being passed into funcion
mov rdi, title            ; first arg
mov rsi, INPUT_LEN        ; 256 bytes limit (2nd arg)
mov rdx, [stdin]          ; dereferenced file strem
call fgets                ; call to fegets function

mov rax, 0                ; 0 floats being passed into funcion
mov rdi, title  
call strlen               ; Call external function strlen, there will be an enter at the end
sub rax, 1                ; gets location of '\n' since string is stored in rax
mov byte [title + rax], 0 ; Replace the byte where '\n' exits with '\0'\

;====== ***** Traingle Section *****  ===================================
;====== Print Traingle Enter Message ================
;
push qword 0
mov rax, 0			        ; 0 floats being passed into funcion
mov rdi, initiate			  ; load function
call printf				      ; call printf function 
pop rax
;==== Scanf Traingle Section ===== 

push qword 0
push qword 0
push qword 0
mov rax, 0 
mov rdi, floatFormat        ; 2 seperate floats 
mov rsi, rsp                ; prepare the 2 floats
mov rdx, rsp
add rdx, 8                  ; leave space for one qword
call scanf                  ; call scanf function
; move float to register
movsd xmm15, [rsp]          ; move outpt to xmm float register
movsd xmm14, [rsp+8]        ; move 2nd outpt to xmm float register

pop rax                     ; pop 3x for each push
pop rax
pop rax
;==== Calculation Section ===== 

mulsd xmm15, xmm15          ; mutliply input 1, by input 1 
mulsd xmm14, xmm14          ; mutliply input 2, by input 2 
addsd xmm15, xmm14          ; add the squared parts togeter 
sqrtsd xmm13, xmm15         ; take the squareroot of the sum
;==== OutPut Section ===== 
;==== OutPut Hypotenuse ===== 
push qword 0
mov rax, 1                  ; printf uses one floats for the xmm registers
mov rdi, calculation		    ; output hypotenuse 
movsd xmm0, xmm13
call printf
pop rax
;==== OutPut Title Name ===== 
push qword 0
mov rax, 1                  	; printf uses one floats for the xmm registers
mov rdi, endingMSG		        ;"Please enjoy your triangle %s %s"
mov rsi, title                ; title comes first 
mov rdx, name                 ; 2nd input string is Last Name 
call printf
pop rax
;==== Return Hypotenuse  ===== 
movsd xmm0, xmm13             ; make sure to return hypotenuse
pop rax

;===== Restore original values to integer registers ===================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret