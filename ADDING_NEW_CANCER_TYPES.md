# Adding New Skin Cancer Types to the Detection System

## Overview
This project currently supports **9 skin cancer types**. This guide explains how to add more types.

## Current Cancer Types (Index 0-8)
1. **Melanoma** - Most dangerous skin cancer
2. **Nevus** - Common mole
3. **Basal Cell Carcinoma** - Most common skin cancer
4. **Actinic Keratosis** - Pre-cancerous lesion
5. **Benign Keratosis** - Non-cancerous growth
6. **Dermatofibroma** - Benign skin nodule
7. **Vascular Lesion** - Blood vessel abnormality
8. **Squamous Cell Carcinoma** - Second most common cancer *(newly added)*
9. **Melanosis** - Hyperpigmentation lesion *(newly added)*

## Files That Need to be Modified

### 1. **config.json**
Update two fields:
```json
{
  "backend": {
    "model": {
      "output_classes": 9  // Change this number to total cancer types
    }
  },
  "cancer_types": [
    "Type1",
    "Type2",
    ...
    "TypeN"  // Add new types here in chronological order
  ]
}
```

### 2. **backend/model.py**
Update these two locations:

**a) CANCER_TYPES list** (Line ~10)
```python
CANCER_TYPES = ['Melanoma', 'Nevus', ..., 'YourNewType1', 'YourNewType2']
```

**b) create_synthetic_data() function** (Line ~50-85)
Add elif clauses for new types with distinctive visual patterns:
```python
elif class_idx == 8:  # Your New Type - description
    img = img * 0.7 + 0.25
    # Add pattern-specific modifications
    # Example: Add texture, color adjustments, shapes, etc.
    pass
```

**c) Dense output layer** (Line ~113)
```python
outputs = Dense(9, activation='softmax')(x)  # Update number here
```

### 3. **backend/app.py**
Update two dictionaries:

**a) CANCER_TYPES dictionary** (Line ~31)
```python
CANCER_TYPES = {
    0: 'Melanoma',
    1: 'Nevus',
    ...
    8: 'YourNewType1',
    9: 'YourNewType2'
}
```

**b) CANCER_INFO dictionary** (Line ~44)
```python
CANCER_INFO = {
    'YourNewType': {
        'severity': 'LOW/MEDIUM/HIGH',
        'description': 'Medical description of the condition',
        'risk': 'Potential risks if untreated',
        'treatment': 'Available treatment options'
    }
}
```

## Step-by-Step Instructions

### Example: Adding "Seborrheic Keratosis"

1. **config.json**:
   - Change `output_classes` from 9 to 10
   - Add `"Seborrheic Keratosis"` to the `cancer_types` array

2. **model.py**:
   - Add to CANCER_TYPES: `'Seborrheic Keratosis'`
   - Add new elif block in create_synthetic_data():
   ```python
   elif class_idx == 9:  # Seborrheic Keratosis - waxy, scaly
       img = img * 0.65 + 0.32
       # Add waxy appearance
       img[:, :, 1] = np.clip(img[:, :, 1] * 0.8, 0, 1)
   ```
   - Change Dense output to `Dense(10, activation='softmax')(x)`

3. **app.py**:
   - Add to CANCER_TYPES: `10: 'Seborrheic Keratosis'`
   - Add to CANCER_INFO:
   ```python
   'Seborrheic Keratosis': {
       'severity': 'LOW',
       'description': 'Common benign skin growth',
       'risk': 'No cancer risk',
       'treatment': 'Removal for cosmetic reasons'
   }
```

## Important Notes

### Training Strategy
After adding new types:
1. Obtain real training data from ISIC dataset or medical sources
2. Update the `create_synthetic_data()` function with realistic patterns
3. **Retrain the model** with all data (old + new types)
4. Save the new model as `skin_cancer_model.h5`

### Medical Data Requirements
For each new cancer type, include:
- **Severity level**: LOW, MEDIUM, HIGH
- **Accurate description**: Medical characteristics
- **Risk factors**: Potential serious outcomes
- **Treatment options**: Available medical treatments

### Model Architecture Constraints
- Input: Always 224×224×3 RGB images
- Hidden layers: 256 → 128 neurons
- Output: Dense layer with N nodes (where N = number of cancer types)
- Activation: softmax (for multi-class classification)

## Quick Reference: Cancer Type Mapping

| Index | Type | Severity |
|-------|------|----------|
| 0 | Melanoma | HIGH |
| 1 | Nevus | LOW |
| 2 | Basal Cell Carcinoma | MEDIUM |
| 3 | Actinic Keratosis | MEDIUM |
| 4 | Benign Keratosis | LOW |
| 5 | Dermatofibroma | LOW |
| 6 | Vascular Lesion | LOW |
| 7 | Squamous Cell Carcinoma | HIGH |
| 8 | Melanosis | MEDIUM |

## Files to Update Checklist

- [ ] config.json (output_classes, cancer_types array)
- [ ] backend/model.py (CANCER_TYPES, synthetic data, Dense layer)
- [ ] backend/app.py (CANCER_TYPES dict, CANCER_INFO dict)
- [ ] Retrain model with new data
- [ ] Test predictions with new types
