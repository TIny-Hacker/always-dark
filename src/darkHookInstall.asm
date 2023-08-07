;-----------------------------------------------
;
; Always Dark Source Code - darkHookInstall.asm
; By RoccoLox Programs and TIny_Hacker
; Copyright 2022 - 2023
; License: GPL-3.0
; Last Built: August 4, 2023
;
;-----------------------------------------------

include 'include/ez80.inc'
include 'include/tiformat.inc'
format ti archived executable protected program 'DARKINST'
include 'include/ti84pceg.inc'

    jp main
    db $02, "Long-lasting dark mode for the CE", 0

main:
    bit ti.appChangeHookActive, (iy + ti.hookflags4)
    jr z, installHook
    call findAppVar
    jr c, removeHook
    ex de, hl
    ld hl, (ti.appChangeHookPtr)
    or a, a
    sbc hl, de
    jr nz, installHook

removeHook:
    call ti.ClrAppChangeHook
    ld a, $20
    jr setLCD

installHook:
    call findAppVar
    jr c, appvarNotFound
    jr nz, inArchive
    call ti.Arc_Unarc
    call findAppVar

inArchive:
    call ti.SetAppChangeHook
    ld a, $21

setLCD:
    push af
    call ti.boot.InitializeHardware
    pop af
    ld hl, $F80818
    ld (hl), h
    ld (hl), $44
    ld (hl), a
    ld l, h
    ld (hl), $01
    ret

appvarNotFound:
    call ti.ClrScrn
    call ti.HomeUp
    ld hl, needsAppvarStr
    call ti.PutS
    call ti.GetKey
    call ti.ClrScrn
    jp ti.HomeUp

findAppVar:
    ld hl, appvarName
    call ti.Mov9ToOP1
    call ti.ChkFindSym
    ret c
    call ti.ChkInRam
    ret z
    ld hl, 12
    add hl, de
    ld a, c
    ld bc, 0
    ld c, a
    add hl, bc
    ret

needsAppvarStr:
    db "Requires DarkHook AppVar.", 0

appvarName:
    db ti.AppVarObj, "DarkHook", 0
