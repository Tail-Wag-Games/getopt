@echo off
setlocal

cl /DDEBUG /c /Zi /Fo%~dp0 /Fd%~dp0getoptd.pdb /I%~dp0include %~dp0getoptimpl.c %~dp0src/getopt.c
lib /out:%~dp0getoptd.lib %~dp0getoptimpl.obj %~dp0getopt.obj

cl /DNDEBUG /O2 /c /Fo%~dp0 /I%~dp0include %~dp0getoptimpl.c %~dp0src/getopt.c 
lib /out:%~dp0getopt.lib %~dp0getoptimpl.obj %~dp0getopt.obj

@REM del %~dp0*.obj