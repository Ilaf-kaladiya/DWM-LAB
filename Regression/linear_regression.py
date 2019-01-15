# -*- coding: utf-8 -*-
"""
Created on Tue Jan 15 20:15:45 2019

@author: ilaf
"""

import numpy as np
import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt

#IMPORTING DATASET
dataset=pd.read_csv('Salary_Data.csv')
X = dataset.iloc[:,:-1].values      #EXPERIENCE COLUMN
Y = dataset.iloc[:,:1].values        #SALARY COLUMN 

#splitting the dataset into the training and test sets
from sklearn.model_selection import train_test_split
X_train,X_test,Y_train,Y_test = train_test_split(X,Y,test_size =1/3,random_state=0)

#fitting simple linear regression to the trainig set

from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(X_train,Y_train)

#predicting the test set result
Y_pred = regressor.predict(X_test)

#visualizaing the training set results
plt.scatter(X_train,Y_train,color='red')
plt.plot(X_train,regressor.predict(X_train),color='blue')
plt.title('salary vs experience(Trainig set)')
plt.xlabel('Years of experience')
plt.ylabel('salary')
plt.show()


#visualizaing the training set results
plt.scatter(X_test,Y_test,color='red')
plt.plot(X_test,regressor.predict(X_test),color='blue')
plt.title('salary vs experience(Trainig set)')
plt.xlabel('Years of experience')
plt.ylabel('salary')
plt.show()