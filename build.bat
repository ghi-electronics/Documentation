@ECHO OFF

SETLOCAL

SET ScriptRoot=%~dp0

PUSHD "%ScriptRoot%"

RMDIR /s /q docs
RMDIR /s /q obj

MKDIR docs

SET Target=%1

IF "%Target%" == "" SET Target=build
IF "%Target%" == "all" SET Target=

REM SET to supress newline at end of file
ECHO | SET /p="docs-test.ghielectronics.com" > docs/CNAME

docfx %Target%

POPD

ENDLOCAL
