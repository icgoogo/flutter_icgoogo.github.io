# Pipeline Highlights

- **Data Cleaning:** Removed 110 contaminated images using HSV space filtering, leaving 581 clean training images.

- **Dense Tiling:** Extracted tissue regions into a $5 \times 5$ grid of $32 \times 32$ tiles to remove uninformative background.

### Performance Overview

**Test Accuracy:**

1.  **Custom CNN**: 23.72%
2.  **EfficientNet-B3**: 34.69%
3.  **ResNet-50**: 36.40%
4.  **ResNet-18**:**39.26%**

---

📄 For the complete detailed groups, detailed methodology, mathematical equations, diagnostic plots, failed experiment logs, and full hyperparameter setups, refer directly to `ANN2DL_Convoggle_Challenge2_Report.pdf` on Repo: [Github Repo](https://github.com/icgoogo/image_classifier_with_mask).
