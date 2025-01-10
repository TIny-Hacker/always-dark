;-----------------------------------------------
;
; Always Dark Source Code - darkHook.asm
; By RoccoLox Programs and TIny_Hacker
; Copyright 2022 - 2025
; License: GPL-3.0
; Last Built: March 16, 2024
;
;-----------------------------------------------

include 'include/ez80.inc'
include 'include/tiformat.inc'
format ti archived appvar 'DarkHook'
include 'include/ti84pceg.inc'

hookOffset := darkHookStart - checkLCDOff
hookBackUp := ti.appData + 250

checkLCDOff:
    db $83
    push af
    push hl
    ld hl, ti.mpLcdCtrl + 1
    bit 3, (hl)
    jr nz, return
    ld hl, (ti.appChangeHookPtr)
    ld de, hookOffset
    add hl, de
    ex de, hl
    bit ti.getCSCHookActive, (iy + ti.hookflags2)
    jr z, clearChain
    ld hl, (ti.getKeyHookPtr)
    push hl
    or a, a
    sbc hl, de
    pop hl
    jr z, return
    ld (hookBackUp), hl
    jr installHook

clearChain:
    or a, a
    sbc hl, hl
    ld (hookBackUp), hl

installHook:
    ex de, hl
    call ti.SetGetCSCHook

return:
    pop hl
    pop af
    ret

darkHookStart:
    db $83
    push af
    ld hl, $2000B
    ld (ti.mpSpiRange + ti.spiCtrl1), hl
    ld hl, $1828
    ld (ti.mpSpiRange), hl
    ld hl, $0C
    ld (ti.mpSpiRange + ti.spiCtrl2), hl
    nop
    ld hl, $40
    ld (ti.mpSpiRange + ti.spiCtrl2), hl
    call ti.Delay10ms
    ld hl, $182B
    ld (ti.mpSpiRange), hl
    ld hl, $0C
    ld (ti.mpSpiRange + ti.spiCtrl2), hl
    nop
    ld hl, $40
    ld (ti.mpSpiRange + ti.spiCtrl2), hl
    call ti.Delay10ms
    ld hl, $21
    ld (ti.mpSpiRange + ti.spiIntCtrl), hl
    ld hl, $100
    ld (ti.mpSpiRange + ti.spiCtrl2), hl
    ld hl, $F80818
    ld (hl), h
    ld (hl), $44
    ld (hl), $21
    ld l, h
    ld (hl), $01
    call ti.ClrGetKeyHook
    ld hl, (hookBackUp)
    call ti.ChkHLIs0
    call nz, ti.SetGetCSCHook
    pop af
    ret
