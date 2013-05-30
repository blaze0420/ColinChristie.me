Include Irvine32.inc

;Name: Colin Christie
;Student ID: 101746234
;Assignment 2
;Submitted: Nov 25, 2011

CheckPrime PROTO

.data

str1 BYTE "number is not Prime", 0
str2 BYTE "number is Prime", 0
prompt BYTE "Enter an integer between 1-9999:", 0

.code
main PROC

	mov edx, OFFSET prompt		;prompt the user for input
	call WriteString

	call ReadInt				;read the input into eax
	call Crlf

	cmp	eax, 0					;make sure the number is above 0
	jna done					;if it is below zero exit main
	cmp eax, 9999				;make sure the number is 9999 or below
	ja done						;if it is above 9999 exit main

	call CheckPrime				;if the number is within the valid range call check prime on the number in eax

	done: exit

main ENDP

;------------------------------------------------------------------------------------------
;CheckPrime will check an integer value to see if it is prime or not
;The value to check is passed in eax
;The procedure will divide the number in eax starting at 2 until n-1
;If the any division results in a remainder of 0 the procedure will print a message 
;saying that the number is not prime and exit
;If no integer from 2 to n-1 divides evenly into the number passed then it is prime and
;message will be displayed on the screen and the procedure will exit
;------------------------------------------------------------------------------------------
CheckPrime PROC

	LOCAL dividend:DWORD
	LOCAL divisor:WORD

	cmp eax, 1		;if the user entered 1 don't perform any division
	je prime		;jump to prime output message and exit procedure
	cmp eax, 2		;if the user entered 2 don't perform any division
	je prime		;jump to prime output message and exit procedure

	mov dividend, eax		;save the value of the number passed in dividend
	mov divisor, 2			;the divisor starts from 2
	mov eax, dividend

	mov ecx, eax		
	sub ecx, 2					;counter goes till n-1

	L1:	mov dx, WORD PTR dividend + 2	;move higher 2 bytes of dividend into dx
		mov ax, WORD PTR dividend		;move lower 2 bytes of dividend into ax
		div divisor		;perform the division
		cmp dx, 0		;check to see if remainder is 0
		jz not_prime	;if it is 0 the number is not prime
		inc divisor		;increment the divisor
		loop L1			;keep dividing until divisor is n-1 or an even division occurs

	prime: test ax, 0				;set the 0 flag if the number is prime
	mov edx, OFFSET str2	;if the loop exits and no number divided evenly then it is prime
	call WriteString		;dispay the message that the number is prime

	mov eax, 3000
	call Delay					;wait 3 secs
	call ClrScr					;clear the screen

	jmp done					;exit procedure

	not_prime: or ax, 1			;clear the 0 flag if the number is not prime
	mov edx, OFFSET str1		;if the number passed did have even division it is not prime
	call WriteString			;display the message that the number is not prime and exit procedure

	mov eax, 3000
	call Delay					;wait 3 secs
	call ClrScr					;clear the screen


	done:	ret

CheckPrime ENDP

END main