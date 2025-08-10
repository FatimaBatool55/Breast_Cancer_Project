
# 🎗️ Breast Cancer Survival Trends Dashboard

## 🎯 Project Objective  
The primary goal of this project is to analyze breast cancer patient data across various regions in Pakistan, focusing on survival outcomes, tumor characteristics, treatment effectiveness, and demographic patterns. The dashboard provides actionable insights for healthcare professionals, researchers, and policymakers to improve treatment strategies and patient care.

---

## 🧰 Tools Used  
- **SQL**: Data cleaning, transformation, and aggregation
- **Power BI**: Interactive dashboard creation and visualization

---
## SQL Code
<a href="https://github.com/FatimaBatool55/Breast_Cancer_Project/blob/main/Breast_cancer.sql">Breast_cancer.sql</a>


## 📊 Dataset Used  
📂 [Pakistan_Tourism_Hotels.csv](https://github.com/FatimaBatool55/Pakistan_Hotel_Project/blob/main/Pakistan_Tourism_Hotels.csv)  
The dataset includes detailed records of breast cancer patients with attributes such as:

| Category               | Attributes |
|------------------------|------------|
| 🧍 Patient Info         | Patient ID, Age, Region, City, Marital Status, Education Level |
| 🧬 Medical History      | Family History, Genetic Mutation, Diabetes, Hypertension |
| ⚕️ Clinical Details     | BMI, Physical Activity, Diet, Smoking, Alcohol, Menarche Age, Menopause Status |
| 👶 Reproductive History | Pregnancies, Breastfeeding, Hormone Therapy, Contraceptive Use |
| ☢️ Exposure & Diagnosis | Radiation Exposure, Tumor Size, Location, Stage, Histology Type |
| 🧪 Biomarkers           | ER, PR, HER2 Status |
| 💊 Treatment & Outcome  | Treatment Type, Response, Survival Status, Follow-Up Years |

---

## ❓ Key Questions / KPIs Explored  

| KPI Area                     | Questions Answered |
|-----------------------------|--------------------|
| 🧍 Patient Demographics      | What is the age and regional distribution of patients? |
| 🎗️ Survival Analysis         | What percentage of patients survived vs. deceased? |
| 🧬 Tumor Characteristics     | How do tumor location and stage correlate? |
| 💊 Treatment Effectiveness   | Which treatments show the highest survival rates? |
| ☢️ Radiation Impact          | How does radiation exposure relate to survival status? |

---

## 📌 Primary KPIs  

| KPI                          | Description |
|-----------------------------|-------------|
| 👥 Total Patients            | 1,000 patients |
| 🎗️ Survival Status Breakdown | Alive vs. Deceased |
| 📏 Average Tumor Size        | 5.24 cm |
| 🧓 Age Distribution          | Age spread across cities |
| ☢️ Radiation Exposure        | Correlation with survival |
| 💊 Treatment Response        | Complete, Partial, None |

---

## ⚙️ Process  

### 🧹 SQL Data Preparation  
- Replaced `NULL` values using `COALESCE`  
- Removed invalid records (e.g., age < 0, BMI > 50)  
- Standardized tumor stage values  
- Trimmed whitespace from categorical fields  
- Removed duplicate patient IDs  
- Created age and tumor size bins for histogram analysis  
- Aggregated survival status, treatment type, tumor stage, and geographical distribution

### 📊 Power BI Visualization  
- Imported cleaned SQL data  
- Designed a single-page interactive dashboard  
- Used pie charts, bar graphs, stacked visuals, and slicers for filtering  
- Linked survival status with radiation exposure, treatment type, and tumor stage

---

## 📸 Dashboard Screenshot  
![Dashboard](https://github.com/user-attachments/assets/ba14752a-e81f-410f-9b43-051bac32824b)


---

## 🔍 Project Insights  

| Insight Area         | Key Findings |
|----------------------|--------------|
| 🧍 Demographics        | Most patients are from Islamabad and Karachi; average age is 49.6 years |
| 🎗️ Survival Trends     | 499 patients are deceased; survival rate is nearly 50% |
| 📏 Tumor Characteristics | Tumor size and stage are closely linked; larger tumors appear in later stages |
| 💊 Treatment Response   | Radiation and targeted therapy show higher complete response rates |
| ☢️ Radiation Impact     | Patients exposed to radiation show mixed survival outcomes, requiring deeper analysis |

---

## 🧠 Final Conclusion  
This dashboard provides a comprehensive view of breast cancer trends in Pakistan, highlighting survival outcomes, treatment effectiveness, and demographic disparities. It serves as a valuable tool for healthcare professionals to identify high-risk groups, evaluate treatment success, and improve patient care strategies.

---
