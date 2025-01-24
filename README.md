# Power-analysis-LME-
This R script simulates data for mixed-effects modelling and performs a power simulation to estimate the sample size needed to detect fixed effects. It generates a dataset with random participant effects, nested predictors, and an outcome variable. Using the `lme4` and `simr` packages, it fits a model, extends the sample size, and calculates power.

Overview

This R script performs a power simulation to determine the required sample size for detecting fixed effects in a mixed-effects model. The code simulates data with two predictors, one random effect (participants), and one outcome variable. It uses the lme4 package to build and analyze mixed-effects models and the simr package for power analysis.
Key Features

    Data Simulation:
        Simulates a dataset with:
            40 participants (random effects).
            5 observations per participant.
            Two nested predictors (predictor1 and predictor2).
            An outcome variable influenced by:
                Random participant effects.
                Fixed effects of predictor1 and predictor2.
                Random noise.

    Mixed-Effects Model:
        Fits a mixed-effects model to the simulated data:
            Random intercept for participants.
            Fixed effects for the two predictors.

    Power Simulation:
        Extends the sample size by adding participants.
        Runs 100 power simulations to assess the likelihood of detecting the effect of predictor1 using a likelihood ratio test.

Prerequisites
Required R Packages:

    lme4: For fitting linear mixed-effects models.
    simr: For simulating power and extending datasets.

Install the packages using:

install.packages(c("lme4", "simr"))

Setting Up

    Set your desired number of participants and observations per participant by modifying n_participants and n_obs_per_participant.
    Adjust the fixed effect sizes in the outcome formula as needed:
        0.5 for predictor1
        0.3 for predictor2

How to Run the Script

    Load Required Libraries: The script automatically loads the lme4 and simr packages.

    Simulate Data:
        Data is generated with random intercepts, nested predictors, and noise.

    Fit the Initial Model:
        The mixed-effects model (lmer) includes fixed effects for predictor1 and predictor2 and a random intercept for participants.

    Perform Power Simulation:
        If the initial model is not singular:
            Extend the dataset by increasing the number of participants.
            Perform a power simulation with 100 iterations to assess the power of detecting predictor1.

Output

    Simulated Dataset:
        A preview of the first few rows of the simulated data is displayed using head(simulated_data).

    Power Results:
        The script prints the results of the power simulation, indicating the probability of detecting a significant effect for predictor1 at the specified sample size.

    Interpretation of Effect Sizes:
        Small, medium, and large effect sizes are categorized based on:
            Cohen’s dd, correlation (rr), variance explained (R2R2), and odds ratios.

Troubleshooting

    Singular Model Warning:
        If the model is singular, simplify the random-effects structure or reduce variance components.

    Power Below Desired Threshold:
        Increase the number of participants or simulations (nsim) to improve power estimates.

References

    lme4 Package: Bates et al. (2015) – Linear Mixed-Effects Models.
    simr Package: Green and MacLeod (2016) – Simulating Power for Mixed Models.
