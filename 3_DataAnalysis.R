# ===========================================
# Unit 8 Descriptive Analysis 
# ===========================================
set.seed(42) #  Set the same sampling result every time
test <- sample(1:10, 30, replace = T)

# arithmetic mean
mean(test)
sum(test)/length(test) # another algorithm

# weighted average
set.seed(42)
weight <- sample(1:5, 30, replace = T)
weighted.mean(test, weight)

# median
median(test)
sort(test)[15] # take the 15th place after sorting
sort(test)[16]# take the 16th place after sorting

# mode
mode(test)
sort(table(test), decreasing = T)

# quantile
quantile(test, 0.5)
quantile(test, c(0.25,0.75))

# min, max
min(test)
max(test)

# range
range(test)

# variance
var(test)
mean((test-mean(test))^2)
sum((test-mean(test))^2)/(length(test)-1)

# standard deviation
sd(test)
sqrt(var(test))
(var(test))^0.5

# summary
summary(test)

install.packages("fBasics")
library(fBasics)
basicStats(test)

install.packages("psych")
library(psych)
describe(test)


set.seed(42)
test.df <- data.frame(x=sample(1:20, 5),
                      y= rnorm(5,3,1))

apply(test.df, 1, mean) # 1 means row calculation, 2 means column calculation
apply(test.df, 2, mean)
apply(test.df, 2, summary)

basicStats(test.df)
describe(test.df)

# Covariance
cov(test.df)

# correlation coefficient
cor(test.df)

# ===========================================
# Unit 9 Hypothesis Testing 假设检验
# ===========================================
# create dataset
set.seed(42)
a <- rnorm(100, mean = 10, sd=1)
b <- rnorm(150, mean = 5, sd=1)
d <- rnorm(150, mean = 5, sd=3) # try not to name c in R, because c() is a function
e <- rpois(200, lambda = 5) # Poisson distribution

# Premise: The sample to be tested must obey the normal distribution

# Notes on using "Shapiro-Wilk normality test":
# Its null hypothesis is: the population is normally distributed
# (It is not the same as the general null hypothesis that is "no", p<= 0.05 needs to reject the null hypothesis, which is the same)

shapiro.test(a) # normality test: A simple function to test whether it obeys a normal distribution
# From the output, the p-value > 0.05 implying that the distribution of 
# the data are not significantly different from normal distribution. 
# In other words, we can assume the normality.

help(shapiro.test)
shapiro.test(rnorm(100, mean = 5, sd = 3))
shapiro.test(runif(100, min = 2, max = 4))


# Another way: ks.test
# Note that its null hypothesis is also "obey the normal distribution"
ks.test(b, "pnorm", 5, 1) # Tested object b, test distribution normality, mean 5, standard deviation 1
shapiro.test(b)
shapiro.test(d)
shapiro.test(e)

# Case 1: Single sample
t.test(a, mu=10) # Test whether the mean value of a is equal to 10

# Case 2: Double samples, even variance
var.test(a, b) # Test whether the variances are equal (whether the variance ratio is 1), the sample needs to obey the normal distribution
t.test(a, b) # Test whether the sample means are equal

# Case 3: Double samples, uneven variance
var.test(b, d)
t.test(b, d, var.equal = F)

# Nonparametric tests - no normal distribution required
wilcox.test(a, b)
# alternative hypothesis: true location shift is not equal to 0
# (no difference in means)

wilcox.test(b, d)
wilcox.test(a, e)


# t.test(b, e) # e sample is not normally distributed, error
wilcox.test(b, e)

# variance test
# parameter checking
var.test(a, b)
var.test(b, d)

#Nonparametric test - suitable for samples with non-normal distribution
ansari.test(a, e)

# ===========================================
# Unit 10 Analysis of variance ( ANOVA ) 方差分析
# ===========================================
# Analysis of variance (ANOVA) is a statistical formula used to compare the variation between means of different groups.
# The result of the ANOVA is the 'F-statistic'. The ratio shows the difference between the within-group variance and the between-group variance,
# Finally, a number is produced, so that a conclusion can be drawn to support or reject the null hypothesis.
# If there is a significant difference between the two groups, the null hypothesis is not supported and the F ratio will be larger.
# See https://www.tibco.com/zh-hans/reference-center/what-is-analysis-of-variance-anova#:~:text=%E6%96%B9%E5%B7%AE %E5%88%86%E6%9E%90(%20ANOVA%20)%20%E6%98%AF%E4%B8%80,%E6%A0%B7%E6%9C%AC%E6%80% BB%E4%BD%93%E6%98%AF%E4%B8%80%E7%BE%A4%E4%BA%BA%E3%80%82

install.packages("multcomp")
library(multcomp)
cholesterol # Use the public data table cholesterol, drug trial data
            # It can be seen that this is a categorical variable

#### ANOVA Terminology

# Dependent variables: This is the measurement item that is theorized to be affected by the independent variable.
# Independent Variables: These are measurements that may have an effect on the dependent variable.
# Null Hypothesis (H0): This is when there is no difference between groups or methods. Depending on the results of the ANOVA test, the null hypothesis will be accepted or rejected.
# Alternative Hypothesis (H1): When it is theoretically believed that there is a difference between groups and methods.
# Factors and levels: In ANOVA terminology, independent variables are called factors that affect the dependent variable. Levels represent different values ​​of independent variables used in the experiments.
# Fixed factor models: Some experiments use only a discrete set of levels for the factors. For example, a fixed factor test would test three different doses of a drug without looking at any other doses.
# Random Factor Model: This model draws a random level value from all possible values of the independent variable.
#set.seed(42)

f <- sample(letters[1:5], 10, replace = T) # Regarded as 5 different drugs

as.factor(f) # Factors need to be constructed in ANOVA
factor(f, ordered = T) # order=T specifies to sort by English alphabet
factor(f, levels = unique(f), ordered = T) # unique(f) returns the value level, plus ordered = T sorted by value level
factor(f, levels =c("b", "e", "d", "a", "c"), ordered = T) # You can also manually determine the value level
factor(f, levels = unique(f), labels = c(1:4, 1), ordered = T) # labels = c(1:4, 1) - change levels to 12345

# summary
library(tidyverse)

test <- data.frame(x=rnorm(10, mean = 50, sd=5),
                   y=sample(letters[1:3], 10, replace = T),
                   z_1=1:10,
                   z_2=2:11
)

test %>% group_by(y) %>% summarise(m.z.1= mean(z_1),
                                   m.z.2= mean(z_2),
                                   s.z.1= sd(z_1),
                                   s.z.2= sd(z_2))

# ANOVA
cholesterol %>% group_by(trt) %>% summarise(m.resp = mean(response),
                                            s.resp = sd(response))

# ANOVA must satisfy normal distribution and homogeneity of variance
install.packages("car")
library(car)

### tilde(波浪线) - SE Keyboard: option + ^¨

# Whether the qqPlot test satisfies the normal distribution
qqPlot(lm(response ~ trt, data = cholesterol),
         simulate=TRUE, main= "Q-Q Plot", labels=FALSE) #  quantile versus quantile graph
                                                        #  ⭕️ are distributed on both sides of the line and does not exceed the blue area
# bartlett.test for homogeneity of variance; it test variables
bartlett.test(response ~ trt, data = cholesterol) # Null Hypothesis: Equality of Variances

summary(aov(response ~ trt, data = cholesterol))# The null hypothesis of ANOVA in R follows the general convention,
                                                # is "no distinction between groups or methods",
                                                # Pr(>F) <= 0.05 means rejecting the null hypothesis,
                                                # Comes with a significance *** logo

# ===========================================
# Unit 11 Linear Regression  
# ===========================================

library(tidyverse)

####  generate a dataset 
set.seed(42)
#  generate a data frame with two vectors of independent vars
data.set <- data.frame(x1= sample(1:50, 20, replace = F),
                       x2= sample(3:30, 20, replace = F)) 
#  set the fumula of dependent var y and x1, x2
data.set <- data.set %>% mutate(y=x1+ 0.5*(x1)^2+ 0.002*x2 + rnorm(20))
data.set

#### linear regression 
# assumption: y and x have the linear relationship 
# model 1
model.1 <- lm(y ~ x1+x2, data = data.set) #  syntax of linear regression 
summary(model.1) #  show the summary of regression result
# it can be seen that x2 is insignificant 

par(mfrow=c(2,2)) #  plot by 2 figures * 2 figures (one by one by default)
## interpretation of the four figures:
# 1 - fitting, linear; 3,4 - fitting; 2 - normality 

#  add a ^2 factor, according to figure 1
# model 2
model.2 <- lm(y ~ x1+x2+I(x1^2), data = data.set) #  you need to use I() to add x1^2
summary(model.2) #  x1, x1^2 is siginificant, x2 is still insignificant,, r-squre go higher 
plot(model.2) 

# use step-wise method to kick off vars  
model.3 <- step(model.2) #  step-wise, here is default, use help() to learn more
# it showed the process of step-wise:
# it starts by adding AIC, and compare it with the results of AIC the smaller, the better 
# <none> means no change made to the model, each var's name in the first row means the model with kicking it off. 
# in the first round, it finds that the AIC of x2 drops, so kick off x2. 
# in the second round, it is better with no change. 

summary(model.3) #  it runs the model after step-wise 
plot(model.3)


# ===========================================
# Unit 12 Logit Model 
# ===========================================
#### Example one: A researcher is interested in how variables, 
# such as GRE, GPA and prestige of the undergraduate institution, 
# effect admission into graduate school. 
# The response variable, admit/don’t admit, is a binary variable.

#### Prepare the dataset 
graduate.dta <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
head(graduate.dta)

summary(graduate.dta)
sapply(graduate.dta, sd)
# two-way contingency table of categorical outcome and predictors we want
# to make sure there are not 0 cells
xtabs(~admit + rank, data = graduate.dta)

#### Run the model 
# a logistic regression model using the glm (generalized linear model) function
# convert rank to a factor to indicate that rank should be treated as a categorical variable
graduate.dta$rank <- factor(graduate.dta$rank)
mylogit <- glm(admit ~ gre + gpa + rank, data = graduate.dta, family = "binomial")
summary(mylogit)
# Interpretation:
# For every one unit change in gre, the log odds of admission (versus non-admission) increases by 0.002.
# For a one unit increase in gpa, the log odds of being admitted to graduate school increases by 0.804.
# The indicator variables for rank have a slightly different interpretation. For example, having attended an undergraduate institution with rank of 2, versus an institution with a rank of 1, changes the log odds of admission by -0.675.
# see https://stats.oarc.ucla.edu/other/mult-pkg/faq/general/faq-how-do-i-interpret-odds-ratios-in-logistic-regression/

#### Assess model fit
# use the confint function to obtain confidence intervals for the coefficient estimates

# 1. CIs using profiled log-likelihood
confint(mylogit)

# 2. CIs using standard errors
confint.default(mylogit)

# 3. Wald.test for an overall effect of variable "rank"
install.packages("aod")
library(aod)
wald.test(b = coef(mylogit), Sigma = vcov(mylogit), Terms = 4:6)
# b supplies the coefficients, while Sigma supplies the variance covariance matrix of the error terms, 
# finally Terms tells R which terms in the model are to be tested, 
# in this case, terms 4, 5, and 6, are the three terms for the levels of rank

#### Interpretation

#### Exponentiate the coefficients to odds ratios
exp(coef(mylogit))

#### Exponentiate the coefficients odds ratios and 95% CI
exp(cbind(OR = coef(mylogit), confint(mylogit)))
# Interpretation:
# Now we can say that for a one unit increase in gpa, the odds of being admitted to graduate school (versus not being admitted) increase by a factor of 2.23. 

#### Calculate the predicted probability 
# of admission at each value of rank, holding gre and gpa at their means

# 1. Create and view the data frame
newdata1 <- with(graduate.dta, data.frame(gre = mean(gre), gpa = mean(gpa), rank = factor(1:4)))
newdata1

# 2. Calculate the predicted probabilities
newdata1$rankP <- predict(mylogit, newdata = newdata1, type = "response")
# newdata1$rankP - create a new variable in the dataset (data frame) newdata1 called rankP
# mylogit - the predictions should be based on the analysis mylogit
# newdata = newdata1 - values of the predictor variables coming from newdata1
# type="response" - the type of prediction is a predicted probability 
newdata1
# # Interpretation:
# In the above output we see that the predicted probability of being accepted into a graduate program is 0.52 for 
# students from the highest prestige undergraduate institutions (rank=1), 
#and 0.18 for students from the lowest ranked institutions (rank=4), holding gre and gpa at their means.

# 3. (Optional) create a table of predicted probabilities varying the value of gre and rank. We are going to plot these, 
# so we will create 100 values of gre between 200 and 800, at each value of rank (i.e., 1, 2, 3, and 4).

newdata2 <- with(graduate.dta, data.frame(gre = rep(seq(from = 200, to = 800, length.out = 100),
                                              4), gpa = mean(gpa), rank = factor(rep(1:4, each = 100))))
# The code to generate the predicted probabilities (the first line below) is the same as before, 
# except we are also going to ask for standard errors so we can plot a confidence interval. 
# We get the estimates on the link scale and back transform both the predicted values and confidence limits into probabilities.
newdata3 <- cbind(newdata2, predict(mylogit, newdata = newdata2, type = "link",
                                    se = TRUE))
newdata3 <- within(newdata3, {
  PredictedProb <- plogis(fit)
  LL <- plogis(fit - (1.96 * se.fit))
  UL <- plogis(fit + (1.96 * se.fit))
})

# View first few rows of final dataset
head(newdata3)

# Use the ggplot2 package for graphing the predicted probabilities to to understand and/or present the model.
# Below we make a plot with the predicted probabilities, and 95% confidence intervals.
install.packages("ggplot2")
library(ggplot2)
ggplot(newdata3, aes(x = gre, y = PredictedProb)) + geom_ribbon(aes(ymin = LL,
                                                                    ymax = UL, fill = rank), alpha = 0.2) + geom_line(aes(colour = rank),
                                                                                                                      size = 1)

#### Example two: Breast Cancer Data Set from UCI Machine Learning Repository
# A researcher wants to know what are the factors that could affect the recurrence probability of a breast cancer and she got the data from the UCI Machine Learning Repository
# This is one of three domains provided by the Oncology Institute that has repeatedly appeared in the machine learning literature.
# This data set includes 201 instances of one class and 85 instances of another class. The instances are described by 9 attributes, some of which are linear and some are nominal.
# More information: https://archive.ics.uci.edu/ml/datasets/Breast+Cancer
# NOTE: .data, .names are the text files. Simply import it "From Text (base)". 

#### Open and name the dataset, head the first row and seperate it by comma
recurrence <- read.table(file.choose(), header = T, sep = ",")
head(recurrence) #  check the first 6 observations 

#### Change the labels 
# The independent variable is labeled and it is too long, 
# so we can change it to 0/1
# you can also do the reverse oepration (0/1 --> labels)
recurrence$no.recurrence.events <- factor(recurrence$no.recurrence.events, 
                                          levels = c("no-recurrence-events", "recurrence-events"),
                                          labels = c(0, 1))

#### Run the logit model 
mylogit.model1 <- glm(no.recurrence.events ~ ., recurrence, family= "binomial")
summary(mylogit.model1)
# There are too many variables insignificant 

#### Stepwise teh model to kick off varibales 
step(mylogit.model1) #    R suggests us to keep "no" and "x3"

# run the model again using the suggested vars 
mylogit.model2<- glm(no.recurrence.events ~ no + X3, recurrence, family= "binomial")
summary(mylogit.model2)

#### Exponentiate the coefficients
exp(coef(mylogit.model2))

#### Calculate the predicted probabilities   
prob.model2 <- predict(mylogit.model2, recurrence, type = "response")
prob.model2 #    while you can see that it simply shows the result 

#### Lets set a standard for the pred.probabilities 
# and generate a confusion matrix to check the accuracy of our predictions 
# Firstly, set probability >= 50% means there is "recurrence-events", otherwise is "no" 
pred.model2 <- as.factor(ifelse(prob.model2 >= 0.5, "recurrence-events", "no-recurrence-events"))
# Secondly, generate the confusion matrix 
confus.matrix <- table(recurrence$no.recurrence.events, pred.model2, dnn = c("Actual", "Predicted"))
confus.matrix
# Interpretation of the matrix:
# row - actual, column - predicted 
# 191 - actual is "no", predicted is "no", so 191 of all predicted correctly
# 9 - actual is "no", predicted is "yes", so 9 of all predicted wrongly (they actually are "no")
# similarly, 62 of all predicted wrongly (they actually are "yes"), 23 of all predicted correctly 


