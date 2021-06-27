@echo off
rem env [%1=EnvName] [%2=--python] [%3==Version]

if "%~1" == "" (
echo env [EnvName] [--python] [Version]
goto :EOF
)


set this=%~dp0
rem set WORKON_HOME=%this%.venvs
set PIPENV_VENV_IN_PROJECT=1
set JUPYTER_CONFIG_DIR=%WORKON_HOME%\Lib\.jupyter

setlocal
set dirname=%~1
set py=%~2
set pyv=%~3

if "%py%"=="" (set py=--python)
if "%pyv%"=="" (set pyv=3.9)


rem make dir

if not exist .venvs (
 echo [env] Not Find Folder ".venvs".
 echo [env] Made it.
 mkdir .venvs
)

if not exist %1 (
 echo [env] Not Find Environment "%1".
 echo [env] Made it and Installing Python%3...
 mkdir %1
 cd %1
 pipenv install %2 %3
 echo [env] Successly Installed!
) else (
 echo [env] There is this Environment "%1".
 echo [env] Running %1 ...
 cd %1
)

cd ../
whoami /priv | find "SeDebugPrivilege" > nul
if %errorlevel% neq 0 (
 powershell start-process "%~0" -verb runas
 echo [env] Get Administrator privileges.
)
cd %1

start pipenv shell
echo [env] Building environment is finished!
