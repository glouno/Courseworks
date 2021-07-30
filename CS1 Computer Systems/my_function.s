; Paul Beglin
; K1889054
;
; my_function.s - reads value from PORTC and writes to PORTB with my piece-wise function

; specify equivalent symbols
.equ SREG, 0x3f		; Status register. See data sheet, p.11
.equ DDRB, 0x04		; Data Direction Register for PORTB
.equ PORTB, 0x05	; Address of PORTB
.equ DDRC, 0x07		; Data Direction Register for PORTC
.equ PINC, 0x06		; Address of input register for PORTC

; specify the start address
.org 0
; reset system status
main:	ldi r16, 0		; set register r16 to 0
	out SREG, r16		; copy contents of r16 to SREG, clear SREG

	; configure PORTB for output 
	ldi r16, 0x0F		; hexadecimal value of 0F copied to r16
	out DDRB, r16		; writes r16 to DDRB, setting up bits 0 to 3 in output mode

	; configure PORTC for input
	ldi r16, 0xF0		; set register r16 to F0 hexadecimal
	out DDRC, r16		; writes r16 to DDRC setting up for bit 0 to 3 in input mode

	; reads from external pins of PORTC to r16
	in r16, PINC		; gets value from PORTC through PINC writes into r16
	cpi r16, 6		; compare r16 with 6
	brlo fsub		; if r16 < 6 is true, jump to fsub
	
	ldi r17, 17		; if not true, set the value of 17 to r17
	sub r17, r16		; sub register r16 (the input value) to r17 and store in r17
	rjmp continue		; jump to continue and avoid fsub

fsub:	ldi r17, 8		; set the value of 8 to r17
	sub r17, r16		; sub r16 (the input value) to r17, stored in r17

	
continue:
	out PORTB, r17		; writes content r17 to PORTB

mainloop: rjmp mainloop		; jump back to mainloop address
