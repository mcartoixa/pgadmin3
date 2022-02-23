@ECHO OFF

:: Reset ERRORLEVEL
VERIFY OTHER 2>nul
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
IF ERRORLEVEL 1 GOTO ERROR_EXT



SET NO_PAUSE=0
GOTO ARGS



:: -------------------------------------------------------------------
:: Builds the project
:: -------------------------------------------------------------------
:BUILD
msbuild.exe /nologo pgAdmin3.sln /p:Configuration="Release"
GOTO END



:: -------------------------------------------------------------------
:: Parse command line argument values
:: Note: Currently, last one on the command line wins (ex: rebuild clean == clean)
:: -------------------------------------------------------------------
:ARGS
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (
    "C:\Windows\Sysnative\cmd.exe" /C "%0 %*"

    IF ERRORLEVEL 1 EXIT /B 1
    EXIT /B 0
)
::IF NOT "x%~5"=="x" GOTO ERROR_USAGE

:ARGS_PARSE
IF /I "%~1"=="/NoPause"             SET NO_PAUSE=1& SHIFT & GOTO ARGS_PARSE
IF    "%~1" EQU ""  GOTO ARGS_DONE
ECHO [31mUnknown command-line switch[0m %~1 1>&2
GOTO END_ERROR

:ARGS_DONE



:: -------------------------------------------------------------------
:: Set environment variables
:: -------------------------------------------------------------------
:SETENV
CALL build\SetEnv.bat
IF ERRORLEVEL 1 GOTO END_ERROR
ECHO.
GOTO BUILD



:: -------------------------------------------------------------------
:: Errors
:: -------------------------------------------------------------------
:ERROR_EXT
ECHO [31mCould not activate command extensions[0m 1>&2
GOTO END_ERROR

:ERROR_USAGE
SET _ERROR=1
GOTO SHOW_USAGE



:: -------------------------------------------------------------------
:: End
:: -------------------------------------------------------------------
:END_ERROR
ECHO.
ECHO [41m                                                                                [0m
ECHO [41;1mThe build failed                                                                [0m
ECHO [41m                                                                                [0m

:END
@IF NOT "%NO_PAUSE%"=="1" PAUSE
ENDLOCAL