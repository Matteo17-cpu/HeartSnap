# 💓 HeartSnap – Smart μPAD-Based Cardiac Biomarker Detection App From SMAN 81 Jakarta

HeartSnap is an integrated mobile application and biosensor system designed to enable **early detection of cardiac biomarkers** — particularly **Heart-type Fatty Acid Binding Protein (h-FABP)** — using **microfluidic paper-based analytical devices (μPADs)** combined with **gold nanoparticles (AuNPs)** and **machine learning (YOLOv8)**.  
This project merges nanotechnology, colorimetric analysis, and artificial intelligence into an accessible **point-of-care diagnostic platform** for rapid and affordable cardiac health screening.

---

## 🧠 Background

Early diagnosis of **acute myocardial infarction (AMI)** is crucial to prevent irreversible cardiac damage. Traditional lab-based assays such as troponin tests and ELISA are accurate but require complex instrumentation and time-consuming procedures.

HeartSnap proposes a **portable, smartphone-integrated diagnostic system** that detects biomarker-induced color changes on μPADs via camera input and processes them using trained machine learning models. The goal is to create an accessible diagnostic tool for all communities.

---

## ⚙️ System Architecture

HeartSnap consists of two main components:

1. **μPAD Toolkit (Offline Component)**
   - Fabricated using Whatman filter paper with hydrophobic wax barriers.
   - Coated with AuNPs synthesized from pomegranate peel extract.
   - Reacts with blood samples containing h-FABP, generating visible color change through surface plasmon resonance (SPR).

2. **HeartSnap Mobile App (Online Component)**
   - Developed with **Flutter (Dart)**.
   - Processes μPAD images captured via smartphone.
   - Integrated **YOLOv8 model** for automatic color classification.
   - Displays diagnostic interpretation, health trends, and emergency recommendations.

---

## 🧩 Features

### 🔬 Detection
- Real-time colorimetric analysis from μPAD scans.
- Integrated YOLOv8 image classification.
- Supports dataset-based calibration (HSV and RGB processing).

### 📱 Dashboard
- Displays personal health summary.
- Includes “Measure Now” button for direct μPAD scan or heart rate measurement.

### 🩺 Community
- Connects users with doctors and other patients.
- Allows posting health updates, educational content, and discussions.

### 📰 Bulletin
- Provides verified medical articles about heart disease, prevention, and lifestyle.
- Articles categorized by age and condition.

### 📊 Data Logging
- Stores scan results and health trends.
- Supports export of analysis reports for medical consultation.

---

## 🧪 Machine Learning

HeartSnap’s analytical engine uses **YOLOv8** trained with 110 annotated μPAD colorimetric images.

| Parameter | Value |
|------------|--------|
| Model | YOLOv8n |
| Dataset | 110 μPAD images (albumin–AuNPs reaction) |
| Epochs | 25 |
| Batch Size | 32 |
| Learning Rate | 0.001 |
| Accuracy | 97% |
| Precision | 98% |
| Recall | 97% |
| F1-Score | 97% |
| Framework | Ultralytics YOLOv8 (Python, Google Colab) |

---

## 📊 Experimental Validation

- **UV-Vis spectroscopy** confirmed AuNP formation with λmax = 521.5 nm (SPR band).  
- **Contact angle analysis** indicated increased hydrophobicity with higher albumin concentration.  
- **Colorimetric sensitivity test** (HSV model) showed significant hue and saturation shifts proportional to albumin levels.  
- **Expert validation** (doctor, developer, user) confirmed usability, accuracy, and social feasibility.

---

## 🧱 Tech Stack

| Layer | Tools / Framework |
|--------|-------------------|
| Mobile Frontend | Flutter (Dart) |
| ML Model | YOLOv8 (Ultralytics, Python) |
| Data Analysis | Python (Pandas, NumPy, Matplotlib, OpenCV) |
| Image Quantification | ImageJ |
| Visualization | OriginPro |
| Backend (optional) | Firebase or REST API (future development) |

---

## 🧬 Workflow Overview

1. User performs sample test on μPAD coated with AuNPs.  
2. Color change occurs due to interaction between AuNPs and h-FABP.  
3. Smartphone camera captures μPAD image.  
4. HeartSnap processes the image → converts RGB to HSV → runs YOLOv8 inference.  
5. Machine learning model classifies the result → returns status: **Normal / Abnormal / Risk**.  
6. Application logs result and recommends follow-up actions or nearby hospitals.

---

## 🧾 Results Summary

| Parameter | Result |
|------------|---------|
| λmax (AuNPs) | 521.50 nm |
| Absorbance (Amax) | 1.8140 |
| Particle Size (Est.) | 15–25 nm |
| Contact Angle Range | 59.9° – 70.4° |
| ML Accuracy | 97% |
| LOD Range | 0.1–10 mM (albumin model) |

---

## 🧩 Installation Guide

### 🔹 Clone Repository
```bash
git clone https://github.com/your-username/HeartSnap.git
cd HeartSnap
