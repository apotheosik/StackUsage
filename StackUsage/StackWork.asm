;Chris Sequeira
;lab9

;hardware specifications
.586
.model flat, stdcall
.stack 4096

;libraries
includelib libcmt.lib
;from stdio.h
includelib legacy_stdio_definitions.lib 

;extern: not our function, defined elsewhere
;NEAR: 
extern printf:NEAR
extern scanf:NEAR

ExitProcess PROTO, dwExitCode: DWORD

.data
	;define variables
	;int var = 15
	var dd 12345678h
	varscanf dd 0

	;specify newline (10)/(0Ah) and null (0)
	msg db "eax is %d", 10, 0
	msgscanf db "%db"
	msgprompt db "enter a number ", 0

.code
main PROC c

	;INTEGERS
	;eax = var
	;mov eax,var
	;eax +=1
	;add eax,1

	;ADDRESSES
	;offset = ampersand = address
	;mov ebx, offset var
	;[] = asterisk = pointer
	;mov eax, [ebx]

	;VARIABLE ExTRACTION
	mov eax, offset var		;now address stored in memory stack for segmentation
	mov ebx, 0					;performs cleanup of ebx
	mov bl, BYTE PTR [eax+2]		;move a but up in the stack where '34' of var is stored
									;only get one byte so it does not continue collecting up the stack into higher memory trays
									;todo wrong also what is bl

	;SCANF
	push offset varscanf
	call scanf
	push offset msgprompt
	call printf
	add esp, 8				;like the pop to a stack


	;STRINGS
	;stack grow downwards
	;push to stack in reverse order
	;can only push addresses, pointers
	push ebx
	push offset msg
	call printf

	;CLEANUP ASK ABOUT
	;changes stack ointer
	;what happens to the old memory
	add esp, 8

	INVOKE ExitProcess, 0
	main ENDP
END
