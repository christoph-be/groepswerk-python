@echo off
echo ==========================================
echo   KOOKCOMPAS DJANGO UI STARTER
echo ==========================================
echo.

:: Ga naar de map van dit script
cd /d "%~dp0"

:: Controleer of venv bestaat via het relatieve pad (..)
if not exist "..\.venv\Scripts\python.exe" (
    echo FOUT: Kan de virtual environment niet vinden op ..\.venv
    echo Zorg dat je dit script uitvoert vanuit de UI_Django_false map.
    pause
    exit /b
)

echo Start server via ..\.venv\Scripts\python.exe...
"..\.venv\Scripts\python.exe" manage.py runserver

echo.
echo Server is gestopt.
pause
