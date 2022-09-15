AVNAME = DarkHook
PROGNAME = DARKINST
AVSRC = darkHook.asm
PROGSRC = darkHookInstall.asm

all:
	fasmg $(AVSRC) $(AVNAME).8xv
	fasmg $(PROGSRC) $(PROGNAME).8xp
