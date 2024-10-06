
# Thompson Sampling






K = 5

T = 1000

alpha = 100
beta = 200

# a_1 = alpha
# a_2 = alpha
# a_3 = alpha
# 
# b_1 = beta
# b_2 = beta
# b_3 = beta

# sample from prior function

prior_sample = function(K,alpha_vec,beta_vec){
  
  theta_out = c()
  
  for(k in 1:K){
    
    theta_out[k] = rbeta(1,alpha_vec[k],beta_vec[k])
    
  }
  
  return(theta_out)
}



## Thompson Sampling

# initialize prior parameters

alpha_vec = rep(alpha,K)
beta_vec = rep(beta,K)

for(t in 1:T){
  
  # Sample from Prior Distribution
  theta_hat_vec = prior_sample(K,alpha_vec,beta_vec)

  
  # Pick the action with the highest probability of a reward
  theta_max = max(theta_hat_vec)
  
  arm = which.max(theta_hat_vec)
  
  # Generate reward [0,1]
  r = rbinom(1,1,theta_max)
  
  cat('Winner: ',arm,'\n')
  
  # Update distribution
  
  alpha_vec[arm] = alpha_vec[arm] + r
  beta_vec[arm] = beta_vec[arm] + 1 - r
}







