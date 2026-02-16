# Business Problem

Hotel cancellations directly impact revenue forecasting, occupancy planning, and staffing allocation.

This project analyzes booking data to identify key drivers of cancellation risk and improve demand predictability.

## Dataset Overview

The dataset contains hotel booking records including:

- Hotel type (Resort vs City)
- Lead time before arrival
- Market segment
- Deposit type
- Previous cancellations
- Booking changes
- Special requests
- Cancellation status (target variable)

  
## Analytical Approach

- Data preprocessing and factor encoding
- 80/20 train-test split
- Logistic regression modeling
- Model comparison using AIC
- Accuracy and misclassification evaluation
- ROC curve analysis

## Key Findings

- Bookings made further in advance were significantly more likely to cancel, suggesting early reservations carry higher revenue volatility.
- City hotels exhibited higher variability in lead time among canceled bookings.
- Deposit type and market segment significantly influenced cancellation probability.
- Final model achieved ~80% classification accuracy.

<img width="672" height="494" alt="Screenshot 2026-02-15 at 10 55 05 PM" src="https://github.com/user-attachments/assets/765a9bec-ff6b-418f-b457-12dc5d82e8b2" />

## Business Impact

Insights from this model can help:

- Improve revenue forecasting accuracy
- Identify high-risk bookings earlier
- Optimize overbooking strategies
- Adjust deposit policies by segment

# Model Performance
- Model achieved ~80% accuracy on test data.

- AUC indicated strong classification ability.

- Lead time and deposit type were the strongest predictors of cancellation.
