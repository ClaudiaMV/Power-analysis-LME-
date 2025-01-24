# Power simulation for sample size ----------------------------------------

# Load required packages
library(lme4)
library(simr)

# Suppress verbose output
options(verbose = FALSE)

# Set seed for reproducibility
set.seed(123)

# Simulate data for 2 predictors, 1 random effect (participant), and 1 outcome
n_participants <- 40  # Number of participants (random effect)
n_obs_per_participant <- 5  # Each participant has 5 observations

# Generate data
simulated_data <- data.frame(
  participant = factor(rep(1:n_participants, each = n_obs_per_participant))  # Random effect: participants
)

# Add random intercepts for participants
random_intercept_participant <- rnorm(n_participants, mean = 0, sd = 1)  # Variance for participants

# Assign random intercepts to the simulated data
simulated_data$participant_effect <- random_intercept_participant[as.numeric(simulated_data$participant)]

# Add nested predictors: same score for each participant across their observations
nested_predictor1 <- rnorm(n_participants, mean = 0, sd = 1)  # Generate unique scores for predictor1
nested_predictor2 <- rnorm(n_participants, mean = 0, sd = 1)  # Generate unique scores for predictor2

# Assign the nested predictors
simulated_data$predictor1 <- rep(nested_predictor1, each = n_obs_per_participant)  # Same value within participant
simulated_data$predictor2 <- rep(nested_predictor2, each = n_obs_per_participant)  # Same value within participant

# Add outcome variable with random effects and predictors
simulated_data$outcome <- simulated_data$participant_effect +
  simulated_data$predictor1 * 0.5 +  # Add fixed effect of predictor1
  simulated_data$predictor2 * 0.3 +  # Add fixed effect of predictor2
  rnorm(nrow(simulated_data), mean = 0, sd = 1)  # Random noise

# Inspect the first few rows of simulated data to confirm structure
head(simulated_data)

# Power simulation --------------------------------------------------------

# Define the initial mixed-effects model
model <- lmer(
  outcome ~ predictor1 + predictor2 + (1 | participant),  # Random effect: participant only
  data = simulated_data
)

# Check if the model is singular
if (isSingular(model, tol = 1e-4)) {
  cat("The model is singular. Consider simplifying further.\n")
} else {
  # Extend the model to simulate a larger sample size
  extended_model <- extend(
    model, 
    along = "participant",  # Extend along participants
    n = n_participants + 10 # Increase number of participants 
  )
  
  # Perform proper power simulation
  power_results <- powerSim(
    extended_model, 
    nsim = 100,  # Simulate 100 datasets
    test = fixed("predictor1", method = "lr")  # Use likelihood ratio test
  )
  
  # Print power simulation results
  print(power_results)
}

#Interpretation:

# Metric	         Small	Medium Large
# Cohen's dd	      0.20	0.50	 0.80
# Correlation rr	  0.10	0.30	 0.50
# Variance r2r2	    0.01	0.09	 0.25
# Odds Ratio (OR)	  1.5	  2	     3+




