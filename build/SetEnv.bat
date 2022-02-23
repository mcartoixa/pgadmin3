@ECHO OFF

:: Reset ERRORLEVEL
VERIFY OTHER 2>nul



CALL :SetVersionsEnvHelper 2>nul



:: -------------------------------------------------------------------
:: Set environment variables
:: -------------------------------------------------------------------
CALL :SetGitHomeHelper > nul 2>&1
IF ERRORLEVEL 1 GOTO ERROR_GIT
ECHO SET GIT_HOME=%GIT_HOME%
SET PATH=%GIT_HOME%\bin;%GIT_HOME%\usr\bin;%PATH%

CALL :SetPythonHomeHelper > nul 2>&1
IF ERRORLEVEL 1 GOTO ERROR_PYTHON
ECHO SET PYTHON_HOME=%PYTHON_HOME%
SET PATH=%PYTHON_HOME%;%PYTHON_HOME%\Scripts;%PATH%

CALL "%VS120COMNTOOLS%vsvars32.bat" > nul

:: PostgreSQL
SET PGDIR=%CD%\.tmp\pgsql
IF NOT EXIST "%PGDIR%\bin\psql.exe" (
    IF NOT EXIST .tmp MKDIR .tmp
    IF NOT EXIST ".tmp\postgresql-%_PG_VERSION%-windows-binaries.zip" (
        powershell.exe -NoLogo -NonInteractive -ExecutionPolicy ByPass -Command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest https://get.enterprisedb.com/postgresql/postgresql-$Env:_PG_VERSION-windows-binaries.zip -OutFile .tmp\postgresql-$Env:_PG_VERSION-windows-binaries.zip; }"
        IF ERRORLEVEL 1 GOTO ERROR_PG
    )
    RMDIR /S /Q .tmp\pgsql
    powershell.exe  -NoLogo -NonInteractive -ExecutionPolicy ByPass -Command "Add-Type -Assembly 'System.IO.Compression.Filesystem'; [System.IO.Compression.ZipFile]::ExtractToDirectory(\".tmp\postgresql-$Env:_PG_VERSION-windows-binaries.zip\", \".tmp\");"
    IF ERRORLEVEL 1 GOTO ERROR_PG
)
ECHO SET PGDIR=%PGDIR% 

SET PGBUILD=%CD%\.tmp\pgbuild
IF NOT EXIST "%PGBUILD%\iconv\bin\iconv.exe" (
    IF NOT EXIST .tmp MKDIR .tmp
    IF NOT EXIST ".tmp\iconv-%_ICONV_VERSION%.win32.zip" (
        powershell.exe -NoLogo -NonInteractive -ExecutionPolicy ByPass -Command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest https://www.zlatkovic.com/pub/libxml/iconv-$Env:_ICONV_VERSION.win32.zip -OutFile .tmp\iconv-$Env:_ICONV_VERSION.win32.zip; }"
        IF ERRORLEVEL 1 GOTO ERROR_ICONV
    )
    IF NOT EXIST .tmp\pgbuild MKDIR .tmp\pgbuild
    RMDIR /S /Q .tmp\pgbuild\iconv
    powershell.exe  -NoLogo -NonInteractive -ExecutionPolicy ByPass -Command "Add-Type -Assembly 'System.IO.Compression.Filesystem'; [System.IO.Compression.ZipFile]::ExtractToDirectory(\".tmp\iconv-$Env:_ICONV_VERSION.win32.zip\", \".tmp\pgbuild\"); Rename-Item .tmp\pgbuild\iconv-$Env:_ICONV_VERSION.win32 iconv;"
    IF ERRORLEVEL 1 GOTO ERROR_ICONV
)
IF NOT EXIST "%PGBUILD%\libxml2\bin\libxml2.dll" (
    IF NOT EXIST .tmp MKDIR .tmp
    IF NOT EXIST ".tmp\libxml2-%_LIBXML2_VERSION%.win32.zip" (
        powershell.exe -NoLogo -NonInteractive -ExecutionPolicy ByPass -Command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest https://www.zlatkovic.com/pub/libxml/libxml2-$Env:_LIBXML2_VERSION.win32.zip -OutFile .tmp\libxml2-$Env:_LIBXML2_VERSION.win32.zip; }"
        IF ERRORLEVEL 1 GOTO ERROR_LIBXML2
    )
    IF NOT EXIST .tmp\pgbuild MKDIR .tmp\pgbuild
    RMDIR /S /Q .tmp\pgbuild\libxml2
    powershell.exe  -NoLogo -NonInteractive -ExecutionPolicy ByPass -Command "Add-Type -Assembly 'System.IO.Compression.Filesystem'; [System.IO.Compression.ZipFile]::ExtractToDirectory(\".tmp\libxml2-$Env:_LIBXML2_VERSION.win32.zip\", \".tmp\pgbuild\"); Rename-Item .tmp\pgbuild\libxml2-$Env:_LIBXML2_VERSION.win32 libxml2;"
    IF ERRORLEVEL 1 GOTO ERROR_LIBXML2
)
IF NOT EXIST "%PGBUILD%\libxslt\bin\libxslt.dll" (
    IF NOT EXIST .tmp MKDIR .tmp
    IF NOT EXIST ".tmp\libxslt-%_LIBXSLT_VERSION%.win32.zip" (
        powershell.exe -NoLogo -NonInteractive -ExecutionPolicy ByPass -Command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest https://www.zlatkovic.com/pub/libxml/libxslt-$Env:_LIBXSLT_VERSION.win32.zip -OutFile .tmp\libxslt-$Env:_LIBXSLT_VERSION.win32.zip; }"
        IF ERRORLEVEL 1 GOTO ERROR_LIBXSLT
    )
    IF NOT EXIST .tmp\pgbuild MKDIR .tmp\pgbuild
    RMDIR /S /Q .tmp\pgbuild\libxslt
    powershell.exe  -NoLogo -NonInteractive -ExecutionPolicy ByPass -Command "Add-Type -Assembly 'System.IO.Compression.Filesystem'; [System.IO.Compression.ZipFile]::ExtractToDirectory(\".tmp\libxslt-$Env:_LIBXSLT_VERSION.win32.zip\", \".tmp\pgbuild\"); Rename-Item .tmp\pgbuild\libxslt-$Env:_LIBXSLT_VERSION.win32 libxslt;"
    IF ERRORLEVEL 1 GOTO ERROR_LIBXSLT
)
ECHO SET PGBUILD=%PGBUILD% 

:: wxWidgets
SET WXWIN=%CD%\.tmp\wxMSW-%_WXWIDGETS_VERSION%
IF NOT EXIST "%WXWIN%\INSTALL-MSW.txt" (
    IF NOT EXIST .tmp MKDIR .tmp
    IF NOT EXIST ".tmp\wxMSW-%_WXWIDGETS_VERSION%.zip" (
        powershell.exe -NoLogo -NonInteractive -ExecutionPolicy ByPass -Command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest https://github.com/wxWidgets/wxWidgets/releases/download/v$Env:_WXWIDGETS_VERSION/wxMSW-$Env:_WXWIDGETS_VERSION.zip -OutFile .tmp\wxMSW-$Env:_WXWIDGETS_VERSION.zip; }"
        IF ERRORLEVEL 1 GOTO ERROR_WXWIDGETS
    )
    powershell.exe  -NoLogo -NonInteractive -ExecutionPolicy ByPass -Command "Add-Type -Assembly 'System.IO.Compression.Filesystem'; [System.IO.Compression.ZipFile]::ExtractToDirectory(\".tmp\wxMSW-$Env:_WXWIDGETS_VERSION.zip\", \".tmp\");"
    IF ERRORLEVEL 1 GOTO ERROR_WXWIDGETS
)
ECHO SET WXWIN=%WXWIN%

CALL :SetLocalEnvHelper 2>nul

ECHO.
PUSHD xtra\wx-build
CALL build-wxmsw.bat
POPD

SET PATH=%WXWIN%\lib\vc_dll;%PGDIR%\bin;%PATH%

IF "%1" == "/clean" (
    DEL .tmp\*.zip
    IF ERRORLEVEL 1 GOTO ERROR
)

GOTO END



:SetLocalEnvHelper
IF EXIST .env (
    FOR /F "eol=# tokens=1* delims==" %%i IN (.env) DO (
        SET "%%i=%%j"
        ECHO SET %%i=%%j
    )
    ECHO.
)
EXIT /B 0



:SetVersionsEnvHelper
IF EXIST build\versions.env (
    FOR /F "eol=# tokens=1* delims==" %%i IN (build\versions.env) DO (
        SET "%%i=%%j"
        ECHO SET %%i=%%j
    )
    ECHO.
)
EXIT /B 0



:SetGitHomeHelper
SET GIT_HOME=
FOR /F "tokens=1,2*" %%i in ('REG QUERY HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Git_is1 /V InstallLocation') DO (
    IF "%%i"=="InstallLocation" (
        SET "GIT_HOME=%%k"
    )
)
IF "%GIT_HOME%"=="" (
    FOR /F "tokens=1,2*" %%i in ('REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Git_is1 /V InstallLocation') DO (
        IF "%%i"=="InstallLocation" (
            SET "GIT_HOME=%%k"
        )
    )
)
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    IF "%GIT_HOME%"=="" (
        FOR /F "tokens=1,2*" %%i in ('REG QUERY HKEY_CURRENT_USER\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Git_is1 /V InstallLocation') DO (
            IF "%%i"=="InstallLocation" (
                SET "GIT_HOME=%%k"
            )
        )
    )
    IF "%GIT_HOME%"=="" (
        FOR /F "tokens=1,2*" %%i in ('REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Git_is1 /V InstallLocation') DO (
            IF "%%i"=="InstallLocation" (
                SET "GIT_HOME=%%k"
            )
        )
    )
)
IF "%GIT_HOME%"=="" EXIT /B 1
EXIT /B 0



:SetPythonHomeHelper
:: Interpreting a default value from the registry is cumbersome...
SET PYTHON_HOME=
SET _PYTHON_HOME=
FOR /F "tokens=1* delims=Z" %%i in ('REG QUERY HKEY_CURRENT_USER\SOFTWARE\Python\PythonCore\2.7\InstallPath /VE') DO (
    IF "%%j" NEQ "" (
        SET "_PYTHON_HOME=%%j"
    )
)
IF "%_PYTHON_HOME%"=="" (
    FOR /F "tokens=1* delims=Z" %%i in ('REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Python\PythonCore\2.7\InstallPath /VE') DO (
        IF "%%j" NEQ "" (
            SET "_PYTHON_HOME=%%j"
        )
    )
)
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    IF "%_PYTHON_HOME%"=="" (
        FOR /F "tokens=1* delims=Z" %%i in ('REG QUERY HKEY_CURRENT_USER\SOFTWARE\Wow6432Node\Python\PythonCore\2.7\InstallPath /VE') DO (
            IF "%%j" NEQ "" (
                SET "_PYTHON_HOME=%%j"
            )
        )
    )
    IF "%_PYTHON_HOME%"=="" (
        FOR /F "tokens=1* delims=Z" %%i in ('REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Python\PythonCore\2.7\InstallPath /VE') DO (
            IF "%%j" NEQ "" (
                SET "_PYTHON_HOME=%%j"
            )
        )
    )
)
IF "%_PYTHON_HOME%"=="" EXIT /B 1
SET PYTHON_HOME=%_PYTHON_HOME:~4%
SET _PYTHON_HOME=
EXIT /B 0



:ERROR_GIT
ECHO [31mCould not find Git[0m
GOTO END

:ERROR_ICONV
ECHO [31mCould not install iconv v%_ICONV_VERSION%[0m 1>&2
GOTO END_ERROR

:ERROR_LIBXML2
ECHO [31mCould not install libxml2 v%_LIBXML2_VERSION%[0m 1>&2
GOTO END_ERROR

:ERROR_LIBXSLT
ECHO [31mCould not install libxslt v%_LIBXSLT_VERSION%[0m 1>&2
GOTO END_ERROR

:ERROR_PG
ECHO [31mCould not install PostgreSQL v%_PG_VERSION%[0m 1>&2
GOTO END_ERROR

:ERROR_WXWIDGETS
ECHO [31mCould not install wxWidgets v%_WXWIDGETS_VERSION%[0m 1>&2
GOTO END_ERROR

:END_ERROR
EXIT /B 1

:END