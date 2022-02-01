@ECHO OFF

msgfmt .\Locale\de\LC_MESSAGES\default.po -o .\Locale\de\LC_MESSAGES\default.mo
msgfmt .\Locale\en\LC_MESSAGES\default.po -o .\Locale\en\LC_MESSAGES\default.mo
msgfmt .\Locale\fr\LC_MESSAGES\default.po -o .\Locale\fr\LC_MESSAGES\default.mo

assemble WorkNCGetTaskId.exe --dxgettext

PAUSE