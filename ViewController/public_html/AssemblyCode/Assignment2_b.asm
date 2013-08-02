Include Irvine32.inc

;Name: Colin Christie
;Student ID: 101746234
;Assignment 2
;Submitted: Nov 25, 2011

mult PROTO multi:DWORD

.data

.code
main PROC

	mov eax, 1521
	mov ebx, 1115

	INVOKE mult, ebx
	
	WriteInt

	mov eax, 3000
	call Delay					;wait 3 secs
	call ClrScr					;clear the screen
	exit

main ENDP

;-----------------------------------------------------------------------------
;mult takes a number in ebx and multiplies it by the number in eax
;A loop is used to test each bit position in eax to check if the bit is set
;If the bit is set a copy of the number passed in ebx is shifted left by 
;the value of the bit position. For example if bit 3 is set in eax then the 
;number in ebx is copied and shifted left by 3.
;This number is then added to the findal product which is returned in eax
;-----------------------------------------------------------------------------
mult PROC multi:DWORD

	Local flag_set:DWORD
	Local product:DWORD
	Local count:BYTE

	mov count, 0		;initialize the number of bits to shift by to 0
	mov product, 0		;initialize product to 0
	mov flag_set, 0		;fill flag_set with 0
	mov flag_set, 1		;set the lowest bit to 1
	mov ecx, 32			;largest number to shift by is 32

	L1:	push ecx			;save the value of ecx
		mov ebx, multi		;restore the value of the multiplcand each time
		mov ecx, flag_set	;move the bit to check for into ecx

		and ecx, eax		;check to see if the current bit is set
		jz next				;if the bit was not set move to next bit position

		mov cl, count		;if the bit was set move the value of the bit position into cl				
		shl ebx, cl			;multiply the value by 2^count
				
		add product, ebx	;add the value to final product
		
		next: shl flag_set, 1	;move to the next bit position to check
		inc count				;increment the shift value
		pop ecx					;restore the value of ecx
		loop L1

		mov eax, product		;return the product in eax

		ret

mult ENDP

END main