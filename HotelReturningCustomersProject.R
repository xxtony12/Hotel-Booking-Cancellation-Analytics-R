#This project analyzes hotel booking data to identify drivers of booking cancellations and assess cancellation risk by hotel type, customer behavior, and booking characteristics.
hotel <- read.csv("~/Downloads/bookings.csv")

str(hotel)
summary(hotel)
hotel$hotel = factor(hotel$hotel,
                     levels = c('Resort Hotel', 'City Hotel' ),
                     labels = c('Resort Hotel', 'City Hotel'))
hotel$market_segment = factor(hotel$market_segment,
                     levels = c('Direct', 'Corporate', 'Online TA', 'Offline TA/TO', 'Complementary',
                                'Groups', 'Undefined', 'Aviation' ),
                     labels = c('Direct', 'Corporate', 'Online TA', 'Offline TA/TO', 'Complementary',
                                'Groups', 'Undefined', 'Aviation'))
hotel$deposit_type = factor(hotel$deposit_type,
                     levels = c('No Deposit', 'Non Refund', 'Refundable' ),
                     labels = c('No Deposit', 'Non Refund', 'Refundable' ))
head(hotel)
hotel$is_canceled = as.factor(hotel$is_canceled)
names(hotel)
str(hotel)

set.seed(5623)
library(caTools)
split <- sample.split(hotel$is_canceled, SplitRatio = 0.80)
training <- subset(hotel, split == TRUE)
testing <- subset(hotel, split == FALSE)
str(training)


model1 <- glm(is_canceled~., training, family="binomial")
summary(model1)

#prediction
p1 <- predict(model1, training, type = 'response')
head(p1)

#classification
pred1 <- ifelse(p1>0.5,1, 0)
tab1 <- table(Predicted=pred1, Actual=training$is_canceled)
tab1
sum(diag(tab1))/sum(tab1)
1-sum(diag(tab1))/sum(tab1)
#80% accuracy rate and 20% misclassification error 

#Model 2 removing days in waiting list variable
model2 <- glm(
  is_canceled~ deposit_type+ market_segment+hotel+lead_time+previous_cancellations+previous_bookings_not_canceled+
    booking_changes+total_of_special_requests, data = training, family = 'binomial')
summary(model2)

#prediction for model 2
p2 <- predict(model2, testing, type = 'response')
head(p2)

#classification for model 2 
pred2 <- ifelse(p2>0.5,1, 0)
tab2 <- table(Predicted=pred2, Actual=testing$is_canceled)
tab2
sum(diag(tab2))/sum(tab2)
1-sum(diag(tab2))/sum(tab2)

#Model 1 AIC was 87125 and Model 2's was 87131, slightly higher after removing the days on the waiting list column/variable
install.packages("ROCR")
library(ROCR)

#Model 1 ROCR Plot
y_pred <- predict(model1, training, type = "response")
ROCRPred <- prediction(y_pred, training$is_canceled)
ROCRPref <- performance(ROCRPred, 'tpr', 'fpr')

plot(ROCRPref, colorize=TRUE, print.cutoffs.at=seq(0.1, by=0.1))
abline(h=0.99, col= 'purple', lty = 2) #Dashed line at tpr=99%
text(0.7, 0.99, "FPR=50%", pos=1, col = 'purple')
abline(v=0.27, col = 'blue', lty = 3) #Vertical line at FPR = 27%
text(0.5, 0.5, "FPR=50%", pos=1, col = 'blue')

#Model 2 ROCR Plot
y_pred <- predict(model2, training, type = "response")
ROCRPred <- prediction(y_pred, training$is_canceled)
ROCRPref <- performance(ROCRPred, 'tpr', 'fpr')

plot(ROCRPref, colorize=TRUE, print.cutoffs.at=seq(0.1, by=0.1))
abline(h=0.99, col= 'purple', lty = 2) #Dashed line at tpr=99%
text(0.7, 0.99, "FPR=50%", pos=1, col = 'purple')
abline(v=0.27, col = 'blue', lty = 3) #Vertical line at FPR = 27%
text(0.5, 0.5, "FPR=50%", pos=1, col = 'blue')

library(ElemStatLearn)

library(ggplot2)



#  Visualizing Model Insight: Lead Time vs. Cancellation by Hotel
ggplot(hotel, aes(x = hotel, y = lead_time, fill = is_canceled)) +
  geom_boxplot() +
  labs(title = "Booking Lead Time and Cancellation Risk",
       subtitle = "Analyzed by Hotel Type",
       x = "Hotel Type",
       y = "Days of Lead Time") +
  scale_fill_brewer(palette = "Set1", name = "Canceled", labels = c("No", "Yes")) +
  theme_light()
























































































