INCLUDE Irvine32.inc

;Name: Colin Christie
;Student ID: 101746234
:Assignment 1
:Submitted: Oct 23, 2011

;this program reads 10 numbers typed in at the keyboard and stores them in myArray.
;The sum of every other element starting from myArray[1] is calculated and displayed on the screen

.data
myArray DWORD 10 DUP(?)

prompt BYTE "Enter a number:", 0
sum DWORD 0

.code
main PROC

	mov esi, OFFSET myArray			;move esi to the start of myArray
	mov ecx, LENGTHOF myArray		;move the size of myArray into counter register for loop

	L1:
		mov edx, OFFSET prompt		
		call WriteString		;prompt user for input
		call ReadInt			;read the input
		mov [esi], eax			;store the value entered in myArray
		add esi, TYPE myArray		;move esi to the next element
	Loop L1

	mov esi, OFFSET myArray			;move esi to start of myArray
	add esi, TYPE myArray			;move esi to myArray[1]
	mov ecx, LENGTHOF myArray/2	
	
	L2:
		mov ebx, [esi]			;copy the value of myArray[i] into ebx
		add sum, ebx			;add the value of myArray[i] to sum
		add esi, 8			;move esi ahead by 2 indices
	Loop L2

	mov eax, sum				;move the sum into eax
	call WriteInt				;display value in eax on the screen

	mov eax, 5000
	call Delay				;wait 5 secs
	call ClrScr				;clear the screen
	
	exit

main ENDP

END main