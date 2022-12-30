@ECHO OFF

CD /D %~dp0

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::����ϵͳ����

SET "PATH=.\node_modules\.bin;%PATH%"
SET "PATH=%PATH%;D:\Software\PortableGit\bin"

::����Node����

IF EXIST D:\RunTime\node\runtime.bat (
    CALL D:\RunTime\node\runtime set "%~n0"
)

::����Python����

IF EXIST D:\RunTime\python3\runtime.bat (
    CALL D:\RunTime\python3\runtime set "%~n0"
)

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::ÿ���Զ�����

CD /D %~dp0

SET dateline=%date:~0,4%%date:~5,2%%date:~8,2%

IF EXIST node_modules\update.txt (
    FOR /F %%a IN (node_modules\update.txt) DO (
        IF %%a LSS %dateline% CMD /C "npm install"
    )
) else (
    IF NOT EXIST node_modules MKDIR node_modules
    CMD /C "npm install"
)

ECHO %dateline% >node_modules\update.txt

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

CD /D %~dp0

IF "%1" == "" CMD /K
IF NOT "%1" == "" CMD /C "npm run %1"
