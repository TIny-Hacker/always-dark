#-----------------------------------------------
#
# Always Dark Source Code - makefile
# By RoccoLox Programs and TIny_Hacker
# Copyright 2022 - 2025
# License: GPL-3.0
# Last Built: March 16, 2024
#
#-----------------------------------------------

AVNAME = DarkHook
PROGNAME = DARKINST
AVSRC = src/darkHook.asm
PROGSRC = src/darkHookInstall.asm

all:
	fasmg $(AVSRC) $(AVNAME).8xv
	fasmg $(PROGSRC) $(PROGNAME).8xp
