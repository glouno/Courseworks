; Paul Beglin
; k1889054
;
; send morse code for the first 3 letters of my name: pau

; specify equivalent symbols
.equ SREG , 0x3f ; Status register. See data sheet , p.11
.equ PORTB , 0x05 ; define PORTB
.equ DDRB , 0x04 ; define Data direction Register

; specify the start address
.org 0

;reset system status
main:   ldi r16,0	; set register r16 to zero
	out SREG ,r16	; copy contents of r16 to SREG, i.e. clear SREG
	
	ldi r16,0x0F	; set register r16 to 0x0F in hex, making bits 0 through 3 output
	out DDRB, r16	; copy contents of r16 in DDRB

	
mainloop: 		; Morse code for PAU
; code for P: dot	
	ldi r16, 0x01	
	out PORTB, r16	; turn on led PB0
	call d2
	ldi r16, 0x00
	out PORTB, r16	; turn off all leds
	call d2

; code for P: dash	
	ldi r16, 0x01	
	out PORTB, r16	; turn on led PB0
	call d6
	ldi r16, 0x00
	out PORTB, r16	; turn off all leds
	call d2

; code for P: dash	
	ldi r16, 0x01	
	out PORTB, r16	; turn on led PB0
	call d6
	ldi r16, 0x00
	out PORTB, r16	; turn off all leds
	call d2

; code for P: dot	
	ldi r16, 0x01	
	out PORTB, r16	; turn on led PB0
	call d2
	ldi r16, 0x00
	out PORTB, r16	; turn off all leds
	call d6		; space between letters

; code for A: dot	
	ldi r16, 0x01	
	out PORTB, r16	; turn on led PB0
	call d2
	ldi r16, 0x00
	out PORTB, r16	; turn off all leds
	call d2

; code for A: dash	
	ldi r16, 0x01	
	out PORTB, r16	; turn on led PB0
	call d6
	ldi r16, 0x00
	out PORTB, r16	; turn off all leds
	call d6		; space between letters

; code for U: dot	
	ldi r16, 0x01	
	out PORTB, r16	; turn on led PB0
	call d2
	ldi r16, 0x00
	out PORTB, r16	; turn off all leds
	call d2

; code for U: dot	
	ldi r16, 0x01	
	out PORTB, r16	; turn on led PB0
	call d2
	ldi r16, 0x00
	out PORTB, r16	; turn off all leds
	call d2

; code for U: dash	
	ldi r16, 0x01	
	out PORTB, r16	; turn on led PB0
	call d6
	ldi r16, 0x00
	out PORTB, r16	; turn off all leds
	call d6		; final space between letters
	
	rjmp mainloop

d2: 	; initiate 3 variables for nested loop 
	ldi r17, 255
	ldi r18, 126
	ldi r19, 20

; 200 milliseconds delay loop
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


d6: 	; initiate 3 variables for nested loop 
	ldi r17, 255
	ldi r18, 126
	ldi r19, 60

; 600 milliseconds delay loop
loop2:	nop
	dec r17
	cpi r17, 0
	brne loop2
	ldi r17, 255
	dec r18
	cpi r18, 0
	brne loop2
	ldi r18, 126
	dec r19
	cpi r19, 0
	brne loop2
	ret	;return from subroutine, this says the subroutine halfsec ends here

