
# Thompson Sampling


Times = 1000

alpha = 100
beta = 200



# sample from prior function

prior_sample = function(K,alpha_vec,beta_vec){
  
  theta_out = c()
  
  for(k in 1:K){
    
    theta_out[k] = rbeta(1,alpha_vec[k],beta_vec[k])
    
  }
  
  return(theta_out)
}



## Thompson Sampling

# From example in the paper
#alpha_vec = c(1000,1000,100)
#beta_vec = c(100,110,10)

# Random ground truth probabilities
#actual_thetas = c(runif(K))

# or, specify yourself
actual_thetas = c(.9,.8,.7) # graphed in the paper (figure 3.1)

# number of actions
K = length(actual_thetas)

# Win counts for each action
action_counts = c(rep(0,K))

# initialize prior parameters
alpha_vec = rep(0,K)
beta_vec = rep(0,K)


for(t in 1:Times){
  
  # Sample from Prior Distribution
  theta_hat_vec = prior_sample(K,alpha_vec,beta_vec)
  
  # Pick the action with the highest probability of a reward
  theta_max = max(theta_hat_vec)
  
  arm = which.max(theta_hat_vec)
  
  # Generate reward [0,1] from actual probabilities of success
  r = rbinom(1,1,actual_thetas[arm])
  
  # Observe action taken
  cat('Selected Action: ',arm,'\n')
  
  # Update distribution
  alpha_vec[arm] = alpha_vec[arm] + r
  beta_vec[arm] = beta_vec[arm] + 1 - r
  
  # Update action counts
  action_counts[arm] = 1 + action_counts[arm]
}

# Action probabilites
action_counts/Times







