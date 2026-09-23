### Optical Lightpath QoT Estimation & ML Pipeline

A 3-stage Python data processing and machine learning pipeline for predicting Quality of Transmission (**Signal-to-Noise Ratio in dB**) across optical network lightpaths.

#### Highlights

- **Task 1 (Data Ingestion & Feature Engineering)**: Built custom I/O logic to parse dynamic fiber span logs from 1,034 lightpath records into a structured feature matrix $X \in \mathbb{R}^{1034 \times 5}$ (span counts, total distance, max span length, interferer count, and spectral proximity $\Delta f$).
- **Task 2 (Statistical Analysis & EDA)**: Computed univariate statistics (NumPy) and multi-panel scatter visualizations (Matplotlib) to profile physical-layer degradation and non-linear cross-phase modulation trends.
- **Task 3 (ML Modeling & Evaluation)**: Preprocessed features using `StandardScaler` and trained Multi-Layer Perceptrons (`MLPRegressor`) alongside linear baselines to model target SNR, evaluating via learning curves, MSE, and max error metrics.

**Tech Stack:** Python 3, NumPy, scikit-learn, Matplotlib

👉 **[View Full Repository & Source Code](https://github.com/icgoogo/network_data_analysis_lab)**
