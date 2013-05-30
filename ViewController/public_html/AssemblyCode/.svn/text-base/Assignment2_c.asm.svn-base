INCLUDE Irvine32.inc

Trim PROTO ptrStr:PTR BYTE, search_char:BYTE

;Name: Colin Christie
;Student ID: 101746234
;Assignment 2
;Submitted: Nov 25, 2011

.data

count = 100
prompt1 BYTE "Enter a string:", 0
prompt2 BYTE "Enter a char to trim:", 0
msg1 BYTE "The string entered was: ", 0
msg2 BYTE "The string after is: ", 0
str1 BYTE count DUP(0)

.code
main PROC

	mov edx, OFFSET prompt1		
	call WriteString			;ask user to input the string
	mov edx, OFFSET str1		;string read will be stored in str1
	mov ecx, count				;max chars to read is 100
	call ReadString		
			
	mov edx, OFFSET msg1		;display the string entered before the changes
	call WriteString
	mov edx, OFFSET str1
	call WriteString
	call Crlf

	mov edx, OFFSET prompt2		
	call WriteString			;prompt the user for the char to trim
	call ReadChar			
	call Crlf

	INVOKE Trim, ADDR str1, al

	mov edx, OFFSET msg2		;display the string after the deletion
	call WriteString
	mov edx, OFFSET str1
	call WriteString
	
	mov eax, 2000
	call Delay					;wait 2 secs
	call ClrScr					;clear the screen

	exit

main ENDP
;-----------------------------------------------------------------------------
;Trim finds leading chars in a string and deletes them
;The string is entered by the user stored in str1
;The rest of str1 after the leading chars is moved to the begining of str1
;-----------------------------------------------------------------------------
Trim PROC ptrStr:PTR BYTE, search_char:BYTE
	

	mov edi, ptrStr				;prepare to search str1
	cld							;set direction flag to forward
	mov al, search_char			;load the char to search for into al
	repne scasb					;search str1 for any leading chars
	jnz quit					;if no chars were found then exit main
	
	repe scasb					;find anymore leading chars
	
	mov esi, edi				
	dec esi						;esi points to the first char of the new string
	
	mov edi, ptrStr				;move the chars to the begining of the string
	cld							;set direction flag to forward
	rep movsb					;delete the leading chars

	quit: ret

Trim ENDP

END main