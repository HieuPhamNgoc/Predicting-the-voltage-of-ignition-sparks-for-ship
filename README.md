# Predicting-the-voltage-of-ignition-sparks-for-ship
This is the final project for the course CS-E5710 Bayesian Data Analysis D at Aalto University

## Introduction

- In this report we use the Bayesian approach to model the behavior of a particular ship diesel generator component during time. The aim is to predict the state of the component in pre-defined future time intervals in order to plan for its maintenance while preventing the unexpected breakdowns. In order to allow the ship crew to make informed decisions, we aim to use the data for inferring results that incorporate all types of uncertainties. the aim is to fit an adequate Bayesian Model using the observed data to answer the question "whether the ignition spark from a specific engine will exceed 30V in the next week".

## Data Description and Problem Analysis
- The data used in this project is provided by the crew of a shipping company. There are three real valued features for each data points: *ignition voltage*, *time* and *age*.
- The diesel generators are substantial for the safe operation of the ship. They operate in parallel to provide the power demand. For ship LNG-powered diesel generators (liquefied Natural Gas), the ignition spark is one of the critical components and is replaced when the ignition voltage reaches a certain limit value. Data is collected in noon-reports (a report where a sample every 24hours is recorded) of ignition sparks from three engines of same model but different ages. We know to some extent the age might affect the condition under which the ignition spark operates. The data contains the age of the engine, the time of operation of the ignition spark and the ignition spark voltage (which is the quantity we want to predict). 
- We understood from the ship crew that the ignition voltage increases with time and when it reaches 30V they should change it. However, due to some early failures that happened in the past, the ship crew members started to replace the ignition sparks before this limit(at 25V usually). So we could not see in the data values at/or above 30v. In order to avoid the premature replacement of the ignition sparks without risking a breakdown, the crew members want to know if in the next week (the defined time to plan maintenance actions) the ignition voltage will exceed 30V.

## Modelling

- Knowing that the data comes from engines with same type but with different ages, it is possible to use the data optimally under a Bayesian framework. Therefore, the hierarchical model, considering each engine as a group, was one of the potential models to test. In addition, a pooled model is another potential option to test if we assume that the data comes from same group.
- We use two covariates: *time* and *age*
The goal is to model the *ignition voltage* using the two covariates
