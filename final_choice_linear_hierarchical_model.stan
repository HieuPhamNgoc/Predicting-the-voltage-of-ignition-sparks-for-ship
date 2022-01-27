data {
  int<lower=0> J; //number of engines 
  int<lower=0> N; //number of observations
  matrix[N,J] y; //ignition voltage
  vector[J] age;  //ages of engine (predictor1)
  matrix[N,J] time; //time of operation of ignition voltage (predictor2)
  real time_pred; //time for prediction
  real age_pred; //age of the new engine for prediction
  
}

parameters {
  vector[J] a;
  real a_mu;
  real<lower=0> a_sigma;
  vector[J] b1;
  real<lower=0> b1_mu;
  real<lower=0> b1_sigma;
  real b2;
  real<lower=0> sigma;
}

transformed parameters{
  matrix[N,J] mu ;
  
  for (j in 1:J){
    for (n in 1:N){
      mu[n,j]=a[j] + b1[j]*time[n,j] + b2*age[j];
    }
  }
}

model {
  //hyperpriors
  a_mu ~ normal(0,30);
  a_sigma ~ cauchy(0, 5);
  b1_mu ~ normal(0,5);
  b1_sigma ~ cauchy(0, 2.5);
  
  //priors
  for (j in 1:J){
    a[j] ~ normal(a_mu,a_sigma);
    b1[j] ~ normal(b1_mu,b1_sigma);
  }
  b2 ~ normal(0, 20);
  sigma ~ cauchy(0, 10);
  
  //likelihood
  for (j in 1:J){
    for (n in 1:N){
      y[n,j] ~ normal(mu[n,j], sigma);
    }
  }
  
}

generated quantities{
  real y_pred1;
  real a_pred;
  real b1_pred;
  real y_pred_new;
  real y_pred2;
  real y_pred3;
  matrix[N,J] log_lik;
  
  y_pred1 = normal_rng(a[1] + b1[1]*time_pred + b2*age[1],sigma);
  y_pred2 = normal_rng(a[2] + b1[2]*time_pred + b2*age[2], sigma);
  y_pred3 = normal_rng(a[3] + b1[3]*time_pred + b2*age[3], sigma);
  
  a_pred = normal_rng(a_mu,a_sigma);
  b1_pred = normal_rng(b1_mu, b1_sigma);
  y_pred_new = normal_rng(a_pred + b1_pred*time_pred +b2*age_pred, sigma);
  
  for (j in 1:J) {
    for (n in 1:N) {
      log_lik[n,j] = normal_lpdf(y[n,j]|mu[n,j], sigma);
    }
  }
}

