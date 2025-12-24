@echo off
set PYTHONIOENCODING=utf-8
cd /d "%~dp0"
echo ============================================================
echo Gator OSINT Backend Server
echo ============================================================
echo.
echo Starting server with UTF-8 encoding...
echo Frontend will be available at: http://localhost:8000
echo API docs will be available at: http://localhost:8000/docs
echo.
python run_server.py

