#-----------------------------------------------
#
# Always Dark Source Code - makefile
# By RoccoLox Programs and TIny_Hacker
# Copyright 2022 - 2023
# License: GPL-3.0
# Last Built: August 3, 2023
#
#-----------------------------------------------

AVNAME = DarkHook
PROGNAME = DARKINST
AVSRC = src/darkHook.asm
PROGSRC = src/darkHookInstall.asm

all:
	fasmg $(AVSRC) $(AVNAME).8xv
	fasmg $(PROGSRC) $(PROGNAME).8xp
