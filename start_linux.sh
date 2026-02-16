#!/bin/bash

# Skin Cancer Detection System - Quick Start Script

echo ""
echo "======================================================"
echo "  Skin Cancer Detection System - Quick Start"
echo "======================================================"
echo ""

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "ERROR: Python3 is not installed"
    echo "Please install Python from https://www.python.org/"
    exit 1
fi

echo "[1/4] Installing Python dependencies..."
cd backend
pip install -r requirements.txt
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to install dependencies"
    exit 1
fi

echo ""
echo "[2/4] Training the model (this may take 2-5 minutes)..."
python3 model.py
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to train model"
    exit 1
fi

echo ""
echo "[3/4] Starting Flask backend server..."
echo ""
echo "Backend is running at http://localhost:5000"
echo "Press Ctrl+C to stop the server"
echo ""
echo "[4/4] In a new terminal, run:"
echo "   cd SkinCancerDetection/frontend"
echo "   python3 -m http.server 8000"
echo ""
echo "Then open: http://localhost:8000"
echo ""

python3 app.py
