	org 32768
__START_PROGRAM:
	di
	push ix
	push iy
	exx
	push hl
	exx
	ld hl, 0
	add hl, sp
	ld (__CALL_BACK__), hl
	ei
	jp __MAIN_PROGRAM__
ZXBASIC_USER_DATA:
	; Defines USER DATA Length in bytes
ZXBASIC_USER_DATA_LEN EQU ZXBASIC_USER_DATA_END - ZXBASIC_USER_DATA
	.__LABEL__.ZXBASIC_USER_DATA_LEN EQU ZXBASIC_USER_DATA_LEN
	.__LABEL__.ZXBASIC_USER_DATA EQU ZXBASIC_USER_DATA
ZXBASIC_USER_DATA_END:
__MAIN_PROGRAM__:
	ld hl, 0
	ld b, h
	ld c, l
__END_PROGRAM:
	di
	ld hl, (__CALL_BACK__)
	ld sp, hl
	exx
	pop hl
	exx
	pop iy
	pop ix
	ei
	ret
__CALL_BACK__:
	DEFW 0
_test:
	push ix
	ld ix, 0
	add ix, sp
	ld a, 089h
	ld de, 00000h
	ld bc, 00000h
	push bc
	push de
	push af
	call _test
_test__leave:
	ld sp, ix
	pop ix
	exx
	pop hl
	pop bc
	pop bc
	ex (sp), hl
	exx
	ret
	END
