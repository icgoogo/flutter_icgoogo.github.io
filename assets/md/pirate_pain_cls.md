# **Pirate Pain Challenge – Time Series Classification Project Summary**

## Project Overview

This project focuses on time series classification for the AN2DL 2025–2026 challenge, analyzing temporal physiological metrics and multi-joint sensor data to classify pain levels into three categories: `no_pain`, `low_pain`, and `high_pain`.

Github Repo: [Pirate Pain Classifier](https://github.com/icgoogo/pirate_pain_classifier)

## Data Insights

- **Data Ingestion & Alignment Verification**: Successfully loaded and verified index alignment across training, testing, and ground-truth label files using `sample_index` key validation.
- **Dataset Scale & Zero-Null Data Hygiene**: Processed a training dataset of 105,760 time-series rows across 40 features and a test dataset of 211,840 rows, confirming 0 missing/null values across both sets.
- **Class Imbalance Analytics**: Quantified class distribution across the 661 sample series to guide loss weighting and model evaluation strategies:
  - `no_pain`: 77.31%
  - `low_pain`: 14.22%
  - `high_pain`: 8.47%

- **Exploratory Visualization**: Built Seaborn bar plots with relative frequency callouts to visualize class distribution and mapped feature schemas spanning survey scores (`pain_survey_1`–`4`), anatomical counters (`n_legs`, `n_hands`, `n_eyes`), and 31 joint movement channels (`joint_00`–`joint_30`).

## Tools

- PyTorch (torch, torch.nn, torch.optim).
- Pandas, NumPy, and SciPy.
- Scikit-Learn (sklearn) used for Stratified K-Fold cross-validation, feature scaling, label encoding, and classification performance metrics.
- Seaborn and Matplotlib used for custom Seaborn whitegrid themes, distribution bar plots, and figure formatting.
