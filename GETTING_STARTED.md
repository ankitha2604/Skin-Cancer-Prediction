# 🚀 Getting Started - Step by Step Guide

## ✅ Installation & Setup Checklist

Complete each step in order. Don't skip any steps!

---

## Step 1: Verify Python Installation ✓

### Windows:
Open Command Prompt and type:
```bash
python --version
```

Should show: `Python 3.8.0` or higher

**If not installed:** Go to https://www.python.org/ and install Python

### Linux/Mac:
```bash
python3 --version
```

Should show: `Python 3.8.0` or higher

---

## Step 2: Navigate to Project Directory

### Windows:
```bash
cd C:\Users\Hp\OneDrive\Documents\CIE-02\SkinCancerDetection
dir
```

You should see these folders:
- backend/
- frontend/

### Linux/Mac:
```bash
cd ~/OneDrive/Documents/CIE-02/SkinCancerDetection
ls -la
```

You should see:
- backend/
- frontend/

---

## Step 3: Install Python Dependencies

Navigate to backend directory:

### Windows:
```bash
cd backend
pip install -r requirements.txt
```

### Linux/Mac:
```bash
cd backend
pip3 install -r requirements.txt
```

**This will install:**
- Flask (web framework)
- TensorFlow (deep learning)
- Pillow (image processing)
- NumPy (numerical computing)

**⏱️ Time:** 5-10 minutes (depending on internet speed)

**Expected output:** Multiple lines of installation

---

## Step 4: Train the Model 🧠

**Important:** You MUST do this before making predictions!

### Windows:
```bash
python model.py
```

### Linux/Mac:
```bash
python3 model.py
```

**Expected output:**
```
==================================================
SKIN CANCER DETECTION MODEL TRAINING
==================================================

Creating synthetic training data...
Generating samples for class 0: Melanoma
...
Training started...
Epoch 1/20
...
TRAINING COMPLETED!
```

**⏱️ Time:** 2-5 minutes

**What's happening:**
1. Creating 350 synthetic training images (50 per cancer type)
2. Loading MobileNetV2 pre-trained model
3. Training neural network for 20 epochs
4. Saving model to `models/skin_cancer_model.h5`

**Files created:**
- `models/skin_cancer_model.h5` (~100MB)
- `models/training_history.json`

---

## Step 5: Start Backend Server

**Keep the same terminal window open!**

### Windows:
```bash
python app.py
```

### Linux/Mac:
```bash
python3 app.py
```

**Expected output:**
```
 * Running on http://127.0.0.1:5000
 * Press CTRL+C to quit
 * Restarting with reloader
```

**✓ Server is running:** Don't close this terminal!

---

## Step 6: Start Frontend Server

**Open a NEW terminal/command prompt window!**

Navigate to frontend directory:

### Windows:
```bash
cd C:\Users\Hp\OneDrive\Documents\CIE-02\SkinCancerDetection\frontend
python -m http.server 8000
```

### Linux/Mac:
```bash
cd ~/OneDrive/Documents/CIE-02/SkinCancerDetection/frontend
python3 -m http.server 8000
```

**Expected output:**
```
Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
```

**✓ Frontend is ready!**

---

## Step 7: Open Web Interface

Open your web browser and go to:

```
http://localhost:8000
```

You should see:
- Purple/gradient header: "🏥 Skin Cancer Detection System"
- "📤 Upload Image" section on the left
- "📊 Analysis Results" section on the right

---

## Step 8: Test the System

### Method 1: Using the Web Interface

1. Click **"📁 Choose Skin Image"** button
2. Select any image file from your computer (JPG, PNG, etc.)
3. When the image loads, click **"🔍 Analyze Image"**
4. Wait 2-5 seconds for analysis
5. See results with cancer type and confidence

### Method 2: Using the Test Script

In your backend terminal, open a NEW terminal window:

### Windows:
```bash
cd C:\Users\Hp\OneDrive\Documents\CIE-02\SkinCancerDetection\backend
pip install requests
python test_api.py
```

### Linux/Mac:
```bash
cd ~/OneDrive/Documents/CIE-02/SkinCancerDetection/backend
pip3 install requests
python3 test_api.py
```

This will run automated tests and create a test image.

---

## Typical Output Example

When you upload an image and click analyze:

```
PREDICTED CANCER TYPE:
Melanoma

CONFIDENCE:
88.45%

SEVERITY:
🔴 HIGH

DESCRIPTION:
Most dangerous type of skin cancer. Requires immediate medical attention.

RISK:
Can spread to other parts of body

TREATMENT:
Surgical removal, chemotherapy, immunotherapy

ALL PREDICTIONS:
1. Melanoma           - 88.45%
2. Basal Cell Carc.   - 7.23%
3. Actinic Keratosis  - 2.45%
4. Nevus              - 1.45%
5. Benign Keratosis   - 0.23%
6. Dermatofibroma     - 0.12%
7. Vascular Lesion    - 0.07%
```

---

## 🔧 Troubleshooting During Setup

### Issue: "python: command not found"
**Solution:** Use `python3` instead on Mac/Linux, or add Python to PATH on Windows

### Issue: "No module named 'flask'"
**Solution:** Run `pip install -r requirements.txt` again. Make sure you're in `backend/` directory

### Issue: "Address already in use" on port 5000
**Solution:** 
- Kill the process using port 5000
- Or change port in `backend/app.py` line 165

### Issue: "Address already in use" on port 8000
**Solution:** 
- Use `python -m http.server 9000` instead
- Update browser URL to `http://localhost:9000`

### Issue: Model training fails
**Solution:** Make sure you have internet (TensorFlow downloads weights), 2GB+ RAM free

### Issue: Frontend shows "Upload and analyze an image"
**Solution:** This is normal! Just upload an image

### Issue: "Cannot reach API" error
**Solution:** Make sure backend (`python app.py`) is running

### Issue: Predictions take 10+ seconds
**Solution:** 
- First prediction is slow (TensorFlow initialization)
- Subsequent predictions are faster
- Normal behavior

---

## ✅ Success Checklist

Verify you've completed everything:

- [ ] Python 3.8+ installed
- [ ] In SkinCancerDetection/backend directory
- [ ] Dependencies installed (`pip install -r requirements.txt`)
- [ ] Model trained (`python model.py` completed)
- [ ] Backend running (`python app.py` in terminal 1)
- [ ] Frontend running (`python -m http.server 8000` in terminal 2)
- [ ] Browser opened to http://localhost:8000
- [ ] Webpage loaded successfully
- [ ] Uploaded a test image
- [ ] Received prediction results

✓ All done! Your system is working!

---

## 📝 Next Steps

### To Train with Real Data:

1. Download ISIC dataset from https://www.isic-archive.com/
2. Follow instructions in `ISIC_DATASET_GUIDE.md`
3. This greatly improves accuracy

### To Customize:

1. Edit `backend/app.py` to add more cancer types
2. Edit `frontend/index.html` to change styling
3. Edit `backend/model.py` to change model architecture

### To Deploy Online:

1. Use Heroku, AWS, Google Cloud, or Azure
2. Update `API_BASE_URL` in frontend from `localhost:5000` to your server

---

## 🆘 Still Having Issues?

1. **Check the README.md** for detailed explanation
2. **Check QUICK_REFERENCE.md** for common commands
3. **Check PROJECT_INDEX.md** for file structure
4. **Run test_api.py** to diagnose API issues
5. **Check browser console** (F12) for JavaScript errors
6. **Check Flask terminal** for server errors

---

## 📞 Quick Help Commands

```bash
# Check if backend is running
curl http://localhost:5000/api/health

# See what's in uploads folder
ls backend/uploads/

# See trained models
ls backend/models/

# Check if frontend is accessible
curl http://localhost:8000/

# Kill a stuck process (if needed)
pkill -f "python app.py"  # Linux/Mac
taskkill /IM python.exe /F  # Windows (force all Python)
```

---

## 🎓 Learning Pathways

After getting the basics working, explore:

### Beginner Path:
- [ ] Run all tests in test_api.py
- [ ] Upload different image types
- [ ] Check predictions output
- [ ] Read README.md fully

### Intermediate Path:
- [ ] Train with real ISIC dataset
- [ ] Modify HTML/CSS styling
- [ ] Change model parameters
- [ ] Add more cancer types

### Advanced Path:
- [ ] Deploy to cloud (Heroku)
- [ ] Build React frontend
- [ ] Implement authentication
- [ ] Add database for results

---

## 📊 System Requirements

**Minimum:**
- 2GB RAM
- 500MB disk space (+ 100MB for model)
- Python 3.8+
- Modern web browser

**Recommended:**
- 8GB RAM
- 1GB SSD space
- Python 3.10+
- GPU (for faster training)

---

## 🎉 Congratulations!

You've successfully set up a professional-grade deep learning application!

**What you've accomplished:**
✓ Machine learning model training
✓ REST API backend
✓ Web frontend interface
✓ Full image processing pipeline
✓ Real-time predictions

---

**Ready to use your system?**

1. Make sure both terminals are running
2. Open http://localhost:8000
3. Upload an image
4. Get instant AI predictions!

---

**Need detailed help?**
- README.md → Full documentation
- QUICK_REFERENCE.md → Quick lookup
- ISIC_DATASET_GUIDE.md → Using real data
- PROJECT_INDEX.md → File structure

**Enjoy your AI Skin Cancer Detection System! 🏥**
