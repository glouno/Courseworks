; Paul Beglin
; k1889054
;
; write_DB : constantly swaps the upper and lower 4 bits of r16 displayed on 8 LEDs
; with a 0.5 sec delay

; specify equivalent symbols
.equ SREG, 0x3f 	; Status register. See data sheet , p.11
.equ PORTB, 0x05 	; define PORTB
.equ PORTD, 0x0B	; define PORTD
.equ DDRB, 0x04 	; define Data direction Register for PORTB
.equ DDRD, 0x0A		; define Data direction register for PORTD

; specify the start address
.org 0
;reset system status
main:   ldi r16, 0	; set register r16 to zero
	out SREG, r16	; copy contents of r16 to SREG, i.e. clear SREG
	
	ldi r16, 0x0F	; set register r16 to 0x0F in hex, making bits 0 through 3 output
	out DDRB, r16	; copy contents of r16 in DDRB

	ldi r16, 0xF0	; set register r16 to , making bits 4 through 7 output
	out DDRD, r16	; copy contents of r16 in DDRD
	
mainloop: 
	ldi r16, 0xA5	; new value
	out PORTD, r16	; copy contents of r16 in PORTD
	out PORTB, r16	; copy contents of r16 in PORTB

	call delay

; bit mask lower 4 bits means keep lower 4 bits
	ldi r20, 0x0F	; keep lower 4 bits
	and r20, r16	; bit mask
	lsl r20
	lsl r20
	lsl r20
	lsl r20

	ldi r21, 0xF0	; keep upper 4 bits
	and r21, r16	; bit mask
	lsr r21
	lsr r21
	lsr r21
	lsr r21

	or r20, r21
	out PORTD, r20	; copy contents of r20 in PORTD
	out PORTB, r20	; copy contents of r20 in PORTB

	call delay

	rjmp  mainloop

delay: 	; initiate 3 variables for nested loop 
	ldi r17, 255
	ldi r18, 126
	ldi r19, 40	;this is the 10ms parameter

; 0.5 seconds delay loop
loop:	nop
	dec r17
	cpi r17, 0
	brne loop
	ldi r17, 255
	dec r18
	cpi r18, 0
	brne loop
	ldi r18, 126
	dec r19
	cpi r19, 0
	brne loop
	ret	;return from subroutine, this says the subroutine halfsec ends here


