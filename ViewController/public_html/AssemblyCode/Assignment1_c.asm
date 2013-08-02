INCLUDE Irvine32.inc

;Name: Colin Christie
;Student ID: 101746234
:Assignment 1
:Submitted: Oct 23, 2011

;this program displays randomly generated numbers in binary, decimal, and hex in the top right corner, centre, and 
;bottom left of the screen respectively

.code
main PROC

	call Randomize				;seed random number generator

	mov dh, 0 
	mov dl, 70					;top right corner 
	call Gotoxy					;Move cursor there 
	mov eax, 101				;range of numbers is 1-100
	call RandomRange			;generate random number
	mov ebx, 1					;only show the least significant byte
	call WriteBinB				;display number in binary on screen

	mov dh, 12 
	mov dl, 35					;middle of screen 
	call Gotoxy					;Move cursor there 
	mov eax, 101				;range of numbers is 1-100
	call RandomRange			;generate random number
	call WriteInt				;display the number in decimal on the screen


	mov dh, 24 
	mov dl, 0					;bottom-right corner 
	call Gotoxy					;Move cursor there 
	mov eax, 101				;range of numbers is 1-100
	call RandomRange			;generate random number	
	call WriteHex				;display the number in hex on the screen

	mov eax, 5000
	call Delay					;wait 5 secs
	call ClrScr					;clear the screen	
	
	exit

main ENDP

END main