:: build Zen Rush.love
7z a -tzip _build\"Zen Rush.love" .\src\*

:: Safe check if LOVE2D_PATH is defined
if [%LOVE2D_PATH%]==[] echo LOVE2D_PATH is NOT defined & goto :eof

:: build Zen Rush executable for win64
set WIN64_FOLDER=_build\"Zen Rush win64"
mkdir %WIN64_FOLDER%
copy /b %LOVE2D_PATH%\love.exe+_build\"Zen Rush.love" %WIN64_FOLDER%\"Zen Rush.exe"
copy %LOVE2D_PATH%\license.txt %WIN64_FOLDER%\
copy %LOVE2D_PATH%\*.dll %WIN64_FOLDER%\

:: zip it out
7z a -tzip %WIN64_FOLDER%.zip .\%WIN64_FOLDER%\*
