# API Usage Guide

Complete reference for using the Skin Cancer Detection API.

---

## 📡 Base URL

```
http://localhost:5000
```

---

## 🔌 Endpoints Overview

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/` | Home/Info |
| POST | `/api/predict` | Predict cancer type from image |
| POST | `/api/train` | Train/retrain the model |
| GET | `/api/cancer-types` | Get all cancer type information |
| GET | `/api/health` | Check API status |

---

## Endpoint 1: Home (GET `/`)

Get basic API information.

### Request
```bash
curl http://localhost:5000/
```

### Response
```json
{
  "message": "Skin Cancer Detection API",
  "version": "1.0"
}
```

### Python
```python
import requests

response = requests.get('http://localhost:5000/')
print(response.json())
```

---

## Endpoint 2: Health Check (GET `/api/health`)

Check if API and model are operational.

### Request
```bash
curl http://localhost:5000/api/health
```

### Response
```json
{
  "status": "healthy",
  "model_loaded": true,
  "uploads_folder_exists": true
}
```

### Response Fields
- `status` (string): API status ("healthy" or other)
- `model_loaded` (boolean): Whether model file is loaded
- `uploads_folder_exists` (boolean): Whether uploads directory exists

### Python
```python
import requests

response = requests.get('http://localhost:5000/api/health')
data = response.json()

if response.status_code == 200 and data['model_loaded']:
    print("✓ API is ready for predictions")
else:
    print("✗ API is not ready. Model may not be trained.")
```

### JavaScript
```javascript
fetch('http://localhost:5000/api/health')
  .then(res => res.json())
  .then(data => {
    if (data.model_loaded) {
      console.log('Model is loaded and ready');
    } else {
      console.log('Model needs to be trained');
    }
  });
```

---

## Endpoint 3: Get Cancer Types (GET `/api/cancer-types`)

Retrieve information about all 7 cancer types.

### Request
```bash
curl http://localhost:5000/api/cancer-types
```

### Response
```json
{
  "success": true,
  "cancer_types": {
    "Melanoma": {
      "severity": "HIGH",
      "description": "Most dangerous type of skin cancer...",
      "risk": "Can spread to other parts of body",
      "treatment": "Surgical removal, chemotherapy, immunotherapy"
    },
    "Nevus": {
      "severity": "LOW",
      "description": "Common mole. Usually benign.",
      "risk": "Minimal risk",
      "treatment": "Monitoring or removal if desired"
    },
    "Basal Cell Carcinoma": {
      "severity": "MEDIUM",
      "description": "Most common type of skin cancer...",
      "risk": "Rarely spreads",
      "treatment": "Surgical removal, topical therapy, cryotherapy"
    },
    "Actinic Keratosis": {
      "severity": "MEDIUM",
      "description": "Pre-cancerous lesion caused by sun exposure.",
      "risk": "Can develop into squamous cell carcinoma",
      "treatment": "Topical creams, cryotherapy, chemical peels"
    },
    "Benign Keratosis": {
      "severity": "LOW",
      "description": "Non-cancerous growth. Harmless.",
      "risk": "No cancer risk",
      "treatment": "Removal for cosmetic reasons if needed"
    },
    "Dermatofibroma": {
      "severity": "LOW",
      "description": "Benign skin nodule. Very common.",
      "risk": "No cancer risk",
      "treatment": "Removal if bothersome"
    },
    "Vascular Lesion": {
      "severity": "LOW",
      "description": "Blood vessel abnormality. Usually benign.",
      "risk": "Low risk",
      "treatment": "Monitoring or laser treatment if desired"
    }
  }
}
```

### Python
```python
import requests

response = requests.get('http://localhost:5000/api/cancer-types')
data = response.json()

if data['success']:
    for cancer_type, info in data['cancer_types'].items():
        print(f"\n{cancer_type}:")
        print(f"  Severity: {info['severity']}")
        print(f"  Description: {info['description']}")
        print(f"  Risk: {info['risk']}")
        print(f"  Treatment: {info['treatment']}")
```

---

## Endpoint 4: Make Prediction (POST `/api/predict`)

Analyze an image and predict the skin cancer type.

### Request
```bash
curl -X POST -F "image=@path/to/image.jpg" http://localhost:5000/api/predict
```

### Headers
```
Content-Type: multipart/form-data
```

### Body Parameters
- `image` (file, required): Image file (JPG, PNG, BMP, GIF, etc.)

### Response
```json
{
  "success": true,
  "predicted_cancer_type": "Melanoma",
  "confidence": 94.82,
  "severity": "HIGH",
  "description": "Most dangerous type of skin cancer. Requires immediate medical attention.",
  "risk": "Can spread to other parts of body",
  "treatment": "Surgical removal, chemotherapy, immunotherapy",
  "all_predictions": [
    {
      "type": "Melanoma",
      "confidence": 94.82
    },
    {
      "type": "Nevus",
      "confidence": 3.45
    },
    {
      "type": "Basal Cell Carcinoma",
      "confidence": 1.23
    },
    {
      "type": "Actinic Keratosis",
      "confidence": 0.25
    },
    {
      "type": "Benign Keratosis",
      "confidence": 0.15
    },
    {
      "type": "Dermatofibroma",
      "confidence": 0.07
    },
    {
      "type": "Vascular Lesion",
      "confidence": 0.03
    }
  ],
  "image_path": "/uploads/20260213_143022_test.jpg",
  "timestamp": "2026-02-13T14:30:22.123456"
}
```

### Response Fields

| Field | Type | Description |
|-------|------|-------------|
| `success` | boolean | Whether prediction was successful |
| `predicted_cancer_type` | string | Main predicted cancer type |
| `confidence` | float | Confidence percentage (0-100) |
| `severity` | string | Severity level (HIGH, MEDIUM, LOW) |
| `description` | string | Description of the condition |
| `risk` | string | Risk information |
| `treatment` | string | Treatment options |
| `all_predictions` | array | All predictions with confidence scores |
| `image_path` | string | Path to stored image |
| `timestamp` | string | ISO 8601 timestamp |

### Error Response
```json
{
  "success": false,
  "error": "No image provided",
  "message": "Error details"
}
```

### Status Codes
- `200`: Success
- `400`: Bad request (no image)
- `500`: Server error (model not loaded)

---

### Python Examples

#### Basic Prediction
```python
import requests

# Single image prediction
with open('skin_image.jpg', 'rb') as f:
    files = {'image': f}
    response = requests.post('http://localhost:5000/api/predict', files=files)

data = response.json()

if data['success']:
    print(f"Predicted: {data['predicted_cancer_type']}")
    print(f"Confidence: {data['confidence']:.2f}%")
    print(f"Severity: {data['severity']}")
else:
    print(f"Error: {data['error']}")
```

#### Batch Predictions
```python
import requests
import os

image_folder = 'path/to/images'
results = []

for filename in os.listdir(image_folder):
    if filename.endswith(('.jpg', '.png')):
        filepath = os.path.join(image_folder, filename)
        
        with open(filepath, 'rb') as f:
            files = {'image': f}
            response = requests.post('http://localhost:5000/api/predict', files=files)
            
        if response.status_code == 200:
            data = response.json()
            results.append({
                'filename': filename,
                'cancer_type': data['predicted_cancer_type'],
                'confidence': data['confidence']
            })

# Save results
import json
with open('predictions.json', 'w') as f:
    json.dump(results, f, indent=2)
```

#### High Confidence Filter
```python
import requests

def predict_if_confident(image_path, min_confidence=80):
    with open(image_path, 'rb') as f:
        files = {'image': f}
        response = requests.post('http://localhost:5000/api/predict', files=files)
    
    data = response.json()
    
    if data['confidence'] >= min_confidence:
        return data
    else:
        return None  # Confidence too low

result = predict_if_confident('image.jpg', min_confidence=85)
if result:
    print(f"High confidence prediction: {result['predicted_cancer_type']}")
else:
    print("No high confidence prediction")
```

---

### JavaScript Examples

#### Basic Prediction
```javascript
const imageFile = document.getElementById('imageInput').files[0];

const formData = new FormData();
formData.append('image', imageFile);

fetch('http://localhost:5000/api/predict', {
  method: 'POST',
  body: formData
})
.then(response => response.json())
.then(data => {
  if (data.success) {
    console.log('Predicted:', data.predicted_cancer_type);
    console.log('Confidence:', data.confidence + '%');
  } else {
    console.error('Error:', data.error);
  }
});
```

#### With Progress Tracking
```javascript
function predictImage(imageFile) {
  return new Promise((resolve, reject) => {
    const formData = new FormData();
    formData.append('image', imageFile);

    const xhr = new XMLHttpRequest();

    xhr.upload.addEventListener('progress', (e) => {
      const percentComplete = (e.loaded / e.total) * 100;
      console.log('Upload progress:', percentComplete + '%');
    });

    xhr.addEventListener('load', () => {
      if (xhr.status === 200) {
        resolve(JSON.parse(xhr.responseText));
      } else {
        reject(new Error('Prediction failed'));
      }
    });

    xhr.addEventListener('error', () => {
      reject(new Error('Network error'));
    });

    xhr.open('POST', 'http://localhost:5000/api/predict');
    xhr.send(formData);
  });
}
```

---

## Endpoint 5: Train Model (POST `/api/train`)

Train or retrain the model. This takes 2-5 minutes.

### Request
```bash
curl -X POST http://localhost:5000/api/train
```

### Response (Success)
```json
{
  "success": true,
  "message": "Model trained successfully",
  "model_path": "models/skin_cancer_model.h5"
}
```

### Response (Error)
```json
{
  "success": false,
  "error": "Error details",
  "message": "Error training model"
}
```

### Status Codes
- `200`: Success
- `500`: Training failed

---

### Important Notes

1. **Long Operation:** Training takes 2-5 minutes
   - Use timeout of 10+ minutes in requests
   - Don't close the connection

2. **Large Model File:** Creates ~100MB file
   - Ensure disk space available
   - May use significant RAM during training

3. **Blocks Predictions:** While training, predictions may be slow
   - Train during off-hours
   - Or use separate machine for inference

### Python
```python
import requests
import time

print("Starting model training...")
start = time.time()

try:
    # 10 minute timeout
    response = requests.post(
        'http://localhost:5000/api/train',
        timeout=600
    )
    
    data = response.json()
    
    if data['success']:
        elapsed = time.time() - start
        print(f"✓ Training completed in {elapsed:.1f} seconds")
        print(f"Model saved to: {data['model_path']}")
    else:
        print(f"✗ Training failed: {data['error']}")

except requests.exceptions.Timeout:
    print("✗ Training timed out")
except Exception as e:
    print(f"✗ Error: {str(e)}")
```

### JavaScript
```javascript
async function trainModel() {
  try {
    const response = await fetch('http://localhost:5000/api/train', {
      method: 'POST'
    });
    
    const data = await response.json();
    
    if (data.success) {
      console.log('Model trained successfully');
      console.log('Model path:', data.model_path);
    } else {
      console.error('Training failed:', data.error);
    }
  } catch (error) {
    console.error('Error:', error);
  }
}

// Call with timeout handling
const trainingPromise = trainModel();
const timeoutPromise = new Promise((_, reject) =>
  setTimeout(() => reject(new Error('Training timeout')), 600000)
);

Promise.race([trainingPromise, timeoutPromise])
  .catch(error => console.error('Timeout or error:', error));
```

---

## Error Handling Examples

### Python
```python
import requests

def safe_prediction(image_path):
    try:
        with open(image_path, 'rb') as f:
            files = {'image': f}
            response = requests.post(
                'http://localhost:5000/api/predict',
                files=files,
                timeout=30
            )
        
        # Check HTTP status
        if response.status_code != 200:
            return {'error': f'HTTP {response.status_code}'}
        
        data = response.json()
        
        # Check API response
        if not data.get('success'):
            return {'error': data.get('error', 'Unknown error')}
        
        return data
        
    except FileNotFoundError:
        return {'error': 'Image file not found'}
    except requests.exceptions.ConnectionError:
        return {'error': 'Cannot connect to API. Is it running?'}
    except requests.exceptions.Timeout:
        return {'error': 'Request timed out'}
    except Exception as e:
        return {'error': str(e)}

# Usage
result = safe_prediction('image.jpg')
if 'error' in result:
    print(f"Error: {result['error']}")
else:
    print(f"Prediction: {result['predicted_cancer_type']}")
```

### JavaScript
```javascript
async function safePredict(imageFile) {
  try {
    if (!imageFile) {
      throw new Error('No image selected');
    }
    
    if (imageFile.size > 5 * 1024 * 1024) { // 5MB
      throw new Error('Image too large (max 5MB)');
    }
    
    const formData = new FormData();
    formData.append('image', imageFile);
    
    const response = await fetch('http://localhost:5000/api/predict', {
      method: 'POST',
      body: formData
    });
    
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}`);
    }
    
    const data = await response.json();
    
    if (!data.success) {
      throw new Error(data.error || 'Prediction failed');
    }
    
    return data;
    
  } catch (error) {
    return { error: error.message };
  }
}
```

---

## Rate Limiting & Best Practices

### Recommended Practices

1. **Caching:** Store results for same images
```python
cache = {}
image_hash = hash(image_data)
if image_hash in cache:
    return cache[image_hash]
```

2. **Batch Processing:** Process multiple with delays
```python
import time
for image in images:
    result = predict(image)
    time.sleep(1)  # Avoid overload
```

3. **Error Retry:** Implement exponential backoff
```python
import time

def predict_with_retry(image, max_retries=3):
    for attempt in range(max_retries):
        try:
            return predict(image)
        except Exception as e:
            if attempt < max_retries - 1:
                wait = 2 ** attempt
                time.sleep(wait)
    return None
```

4. **Timeouts:** Always set reasonable timeouts
```python
response = requests.post(url, timeout=30)  # 30 seconds
```

---

## Integration Examples

### Flask Integration
```python
from flask import Flask, request, jsonify
import requests

app = Flask(__name__)
CANCER_API = 'http://localhost:5000'

@app.route('/analyze', methods=['POST'])
def analyze():
    if 'image' not in request.files:
        return {'error': 'No image'}, 400
    
    image = request.files['image']
    files = {'image': image.read()}
    
    response = requests.post(f'{CANCER_API}/api/predict', files=files)
    return response.json()
```

### Django Integration
```python
# views.py
from django.http import JsonResponse
from django.views.decorators.http import require_http_methods
import requests

@require_http_methods(["POST"])
def predict_cancer(request):
    if 'image' not in request.FILES:
        return JsonResponse({'error': 'No image'}, status=400)
    
    image = request.FILES['image']
    files = {'image': image.read()}
    
    api_url = 'http://localhost:5000/api/predict'
    response = requests.post(api_url, files=files)
    
    return JsonResponse(response.json())
```

### FastAPI Integration
```python
from fastapi import FastAPI, File, UploadFile
import httpx

app = FastAPI()

@app.post("/predict")
async def predict(image: UploadFile = File(...)):
    contents = await image.read()
    
    async with httpx.AsyncClient() as client:
        files = {'image': contents}
        response = await client.post(
            'http://localhost:5000/api/predict',
            files=files
        )
    
    return response.json()
```

---

## Testing the API

### Using cURL

```bash
# Health check
curl http://localhost:5000/api/health

# Get cancer types
curl http://localhost:5000/api/cancer-types

# Predict
curl -X POST -F "image=@test.jpg" http://localhost:5000/api/predict

# Train model (long operation)
curl -X POST http://localhost:5000/api/train
```

### Using Python Requests

```bash
pip install requests
python -c "
import requests
r = requests.get('http://localhost:5000/api/health')
print(r.json())
"
```

### Using Postman

1. Open Postman
2. Create POST request
3. URL: `http://localhost:5000/api/predict`
4. Body → form-data → key: "image", value: (select image file)
5. Send

---

## API Limits & Specifications

| Aspect | Value |
|--------|-------|
| Max Image Size | 5 MB |
| Supported Formats | JPG, PNG, BMP, GIF, WEBP |
| Input Resolution | 224×224 (resized) |
| Processing Time | 2-5 seconds |
| Max Concurrent | 1 (single process) |
| Model File Size | ~100 MB |
| RAM Usage | ~500 MB |

---

## Version Information

- **API Version:** 1.0
- **Framework:** Flask 2.3.3
- **TensorFlow:** 2.13.0
- **Model:** MobileNetV2 Transfer Learning
- **Last Updated:** February 13, 2026

---

**For more information, refer to the main README.md**
