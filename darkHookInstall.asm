; Copyright 2015-2021 Matt "MateoConLechuga" Waltz
;
; Redistribution and use in source and binary forms, with or without
; modification, are permitted provided that the following conditions are met:
;
; 1. Redistributions of source code must retain the above copyright notice,
;    this list of conditions and the following disclaimer.
;
; 2. Redistributions in binary form must reproduce the above copyright notice,
;    this list of conditions and the following disclaimer in the documentation
;    and/or other materials provided with the distribution.
;
; 3. Neither the name of the copyright holder nor the names of its contributors
;    may be used to endorse or promote products derived from this software
;    without specific prior written permission.
;
; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
; ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
; CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
; POSSIBILITY OF SUCH DAMAGE.

include 'include/ez80.inc'
include 'include/tiformat.inc'
format ti archived executable protected program 'DARKINST'
include 'include/ti84pceg.inc'

_main:
    bit 4, (iy + 34h) ; check if the hook is installed
    jr z, _installHook
    call ti.ClrHomescreenHook ; if the hook is installed, we clear it, otherwise we install it
    call ti.boot.InitializeHardware
    ld hl, $F80818
    ld (hl), h
    ld (hl), $44
    ld (hl), $20
    ld l, h
    ld (hl), $01
    ret

_installHook:
    ld hl, appvarName
    call ti.Mov9ToOP1
    call ti.ChkFindSym
    ret c
    call ti.ChkInRam
    call z, _notInRAM
    ld hl, 10
    add hl, de
    ld a, c
    ld bc, 0
    ld c, a
    add hl, bc
    inc hl
    inc hl
    call ti.SetGetCSCHook
    call ti.boot.InitializeHardware ; cesium code
    ld hl, $F80818
    ld (hl), h
    ld (hl), $44
    ld (hl), $21
    ld l, h
    ld (hl), $01
    ret

_notInRAM:
    call ti.ArchiveVar
    ld hl, appvarName
    call ti.Mov9ToOP1
    call ti.ChkFindSym
    ret

appvarName:
    db ti.AppVarObj, "DarkHook", 0
