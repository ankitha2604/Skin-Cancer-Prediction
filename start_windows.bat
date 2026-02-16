@echo off
REM Skin Cancer Detection System - Quick Start Script for Windows

echo.
echo ======================================================
echo  Skin Cancer Detection System - Quick Start
echo ======================================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python from https://www.python.org/
    pause
    exit /b 1
)

echo [1/4] Installing Python dependencies...
cd backend
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)

echo.
echo [2/4] Training the model (this may take 2-5 minutes)...
python model.py
if %errorlevel% neq 0 (
    echo ERROR: Failed to train model
    pause
    exit /b 1
)

echo.
echo [3/4] Starting Flask backend server...
echo.
echo Backend is running at http://localhost:5000
echo Press Ctrl+C in the terminal to stop the server
echo.
echo.
echo [4/4] In a new command prompt, run:
echo   cd SkinCancerDetection\frontend
echo   python -m http.server 8000
echo.
echo Then open: http://localhost:8000
echo.

python app.py
