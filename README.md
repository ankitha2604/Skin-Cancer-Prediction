# 🏥 Skin Cancer Detection System

An AI-powered system for detecting and classifying different types of skin cancer from images using deep learning. This project includes both frontend and backend components.

## 📋 Project Overview

This application uses a deep learning model (MobileNetV2 with transfer learning) to classify skin lesions into 7 categories:

1. **Melanoma** - Most dangerous type, requires immediate medical attention
2. **Nevus** - Common mole, usually benign
3. **Basal Cell Carcinoma** - Most common type, grows slowly
4. **Actinic Keratosis** - Pre-cancerous lesion from sun exposure
5. **Benign Keratosis** - Non-cancerous, harmless growth
6. **Dermatofibroma** - Benign skin nodule
7. **Vascular Lesion** - Blood vessel abnormality

## ⚠️ Important Disclaimer

**This system is for educational and research purposes only.** It should NOT be used for self-diagnosis or as a replacement for professional medical advice. Always consult with a qualified dermatologist for accurate diagnosis and treatment recommendations.

## 🏗️ Project Structure

```
SkinCancerDetection/
│
├── backend/
│   ├── app.py                 # Flask API server
│   ├── model.py              # Model training script
│   ├── requirements.txt       # Python dependencies
│   ├── models/               # Trained models directory
│   │   ├── skin_cancer_model.h5
│   │   └── training_history.json
│   └── uploads/              # Uploaded images directory
│
├── frontend/
│   └── index.html            # Web interface (HTML/CSS/JS)
│
└── README.md                 # This file
```

## 🔧 Installation & Setup

### Prerequisites

- Python 3.8 or higher
- pip (Python package manager)
- A modern web browser
- 2GB+ RAM (for TensorFlow)

### Step 1: Clone or Download

Make sure you have the project files in your workspace.

### Step 2: Install Python Dependencies

Open a terminal/command prompt and navigate to the backend directory:

```bash
cd SkinCancerDetection/backend
pip install -r requirements.txt
```

**Note:** TensorFlow might take a few minutes to install depending on your internet connection.

### Step 3: Train the Model

Before making predictions, you need to train the model:

```bash
python model.py
```

This will:
- Create synthetic training data for demonstration
- Build a model using MobileNetV2 with transfer learning
- Train for 20 epochs
- Save the model to `models/skin_cancer_model.h5`

**Training time:** 2-5 minutes (depending on your machine)

Expected output:
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

### Step 4: Run the Backend Server

Keep the terminal open and start the Flask server:

```bash
python app.py
```

You should see:
```
 * Running on http://127.0.0.1:5000
 * Press CTRL+C to quit
```

**Leave this server running** while you use the application.

### Step 5: Open the Frontend

Open a new terminal/command prompt and navigate to the frontend directory:

```bash
cd SkinCancerDetection/frontend
```

**Option A: Using Python's built-in server (Recommended)**
```bash
python -m http.server 8000
```

Then open your browser and go to: `http://localhost:8000`

**Option B: Directly open the file**
- Simply double-click `index.html` to open it in your default browser

## 🚀 Usage

### Using the Web Interface

1. **Access the Application:**
   - Go to `http://localhost:8000` (if using http.server)
   - Or open `frontend/index.html` directly

2. **(Optional) Train the Model:**
   - Click the "🤖 Train Model" button to train the model
   - This trains using synthetic data for demonstration
   - Progress will be shown in the Flask terminal

3. **Upload a Skin Image:**
   - Click "📁 Choose Skin Image"
   - Select a JPG, PNG, or other image file
   - The image preview will display

4. **Analyze the Image:**
   - Click "🔍 Analyze Image"
   - The system will process the image and show results

5. **View Results:**
   - **Cancer Type:** The predicted skin condition
   - **Confidence:** How confident the model is (0-100%)
   - **Severity:** HIGH, MEDIUM, or LOW risk level
   - **Description:** What the condition is
   - **Risk:** Potential complications
   - **Treatment:** Suggested treatment approaches
   - **All Predictions:** Confidence scores for all 7 types

### API Endpoints

If you want to integrate with other applications:

**1. Predict (POST)**
```
POST http://localhost:5000/api/predict
Content-Type: multipart/form-data

Body:
- image: <image file>

Response:
{
  "success": true,
  "predicted_cancer_type": "Melanoma",
  "confidence": 82.45,
  "severity": "HIGH",
  "description": "...",
  "risk": "...",
  "treatment": "...",
  "all_predictions": [...]
}
```

**2. Train Model (POST)**
```
POST http://localhost:5000/api/train

Response:
{
  "success": true,
  "message": "Model trained successfully",
  "model_path": "models/skin_cancer_model.h5"
}
```

**3. Get Cancer Types (GET)**
```
GET http://localhost:5000/api/cancer-types

Response:
{
  "success": true,
  "cancer_types": {...}
}
```

**4. Health Check (GET)**
```
GET http://localhost:5000/api/health

Response:
{
  "status": "healthy",
  "model_loaded": true,
  "uploads_folder_exists": true
}
```

## 🧠 Model Details

### Architecture
- **Base Model:** MobileNetV2 (pre-trained on ImageNet)
- **Custom Layers:** 
  - Global Average Pooling
  - Dense (256 units, ReLU activation)
  - Dropout (0.5)
  - Dense (128 units, ReLU activation)
  - Dropout (0.3)
  - Output (7 units, Softmax activation)

### Training
- **Data:** Synthetic training data (350 samples, 50 per class)
- **Optimizer:** Adam (lr=0.001)
- **Loss Function:** Sparse Categorical Crossentropy
- **Epochs:** 20
- **Batch Size:** 16
- **Validation Split:** 20%

### Input/Output
- **Input Size:** 224×224 RGB images
- **Output:** 7-class probability distribution

## 📊 Expected Output Example

```
PREDICTED CANCER TYPE:
Melanoma

CONFIDENCE:
94.23%

SEVERITY:
🔴 HIGH

DESCRIPTION:
Most dangerous type of skin cancer. Requires immediate medical attention.

RISK:
Can spread to other parts of body

TREATMENT:
Surgical removal, chemotherapy, immunotherapy

ALL PREDICTIONS:
1. Melanoma           - 94.23%
2. Nevus              - 3.45%
3. Actinic Keratosis  - 1.23%
4. Basal Cell Carc.   - 0.87%
...
```

## 🔍 Troubleshooting

### Issue: "Model not found" or "Model not loaded"
- **Solution:** Run `python model.py` in the backend directory first

### Issue: "Connection refused" or "Cannot reach API"
- **Solution:** Make sure the Flask server is running with `python app.py`
- Check that port 5000 is not blocked by firewall
- Use `http://localhost:5000` not `https://`

### Issue: Frontend won't load
- **Solution:** 
  - Make sure you're accessing the correct URL (http://localhost:8000 or file:// path)
  - Check browser console for errors (F12)
  - Try a different browser

### Issue: Images take too long to analyze
- **Solution:** This is normal on first load. Subsequent predictions are faster
- TensorFlow needs to initialize on first use

### Issue: "Out of memory" error
- **Solution:** 
  - Close other applications
  - Reduce image size before uploading
  - Restart the Flask server

## 📈 Performance Metrics

With synthetic training data:
- **Training Accuracy:** ~85-90%
- **Validation Accuracy:** ~75-85%
- **Inference Time:** 2-5 seconds per image

**Note:** For production use, train with real ISIC dataset for better accuracy.

## 🎓 Using with Real Dataset

To improve accuracy, use the ISIC (International Skin Imaging Collaboration) dataset:

1. Download from: https://www.isic-archive.com/
2. Modify `model.py` to use real data:
```python
# Replace create_synthetic_data() with actual dataset loading
from tensorflow.keras.preprocessing.image import ImageDataGenerator

train_datagen = ImageDataGenerator(rescale=1./255)
train_generator = train_datagen.flow_from_directory(
    'path/to/isic/dataset',
    target_size=(224, 224),
    batch_size=32,
    class_mode='categorical'
)
```

## 🛠️ Advanced Configuration

### Change Model Architecture
Edit `backend/model.py`:
```python
def create_model():
    # Modify layers, loss function, etc.
    pass
```

### Change API Port
Edit `backend/app.py`:
```python
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)  # Change 5000
```

Update frontend `index.html`:
```javascript
const API_BASE_URL = 'http://localhost:5000';  // Update port
```

### Enable HTTPS
Use a reverse proxy like Nginx or Gunicorn with SSL certificates.

## 📚 Technologies Used

- **Backend:** Flask, TensorFlow/Keras, NumPy, Pillow
- **Frontend:** HTML5, CSS3, JavaScript (Vanilla)
- **Deep Learning:** MobileNetV2, Transfer Learning
- **Image Processing:** PIL/Pillow

## 🤝 Contributing

Feel free to improve this project:
- Train with real ISIC dataset for better accuracy
- Add more cancer types
- Improve UI/UX
- Add mobile app version
- Implement batch processing

## 📝 License

This project is for educational purposes.

## ⚖️ Legal Notice

This software is provided "as-is" for educational purposes only. The developers are not liable for:
- Inaccurate predictions
- Medical decisions based on this system
- Any harm resulting from use of this application

**Always consult with qualified medical professionals for health decisions.**

## 🔗 References

- ISIC Archive: https://www.isic-archive.com/
- TensorFlow: https://www.tensorflow.org/
- MobileNetV2: https://arxiv.org/abs/1801.04381
- Skin Cancer Statistics: https://www.skincancer.org/

## 📞 Support

For issues or questions:
1. Check the Troubleshooting section
2. Review the console errors (F12 in browser)
3. Check the Flask terminal for more details
4. Consult the code comments

---

**Remember:** This is an AI model, not a doctor. Always seek professional medical advice! 🏥
