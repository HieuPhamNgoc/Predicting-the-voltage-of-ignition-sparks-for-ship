data {
  int<lower=0> J; //number of engines 
  int<lower=0> N; //number of observations
  vector[N*J] y; //ignition voltage
  vector[N*J] age;  //ages of engine (predictor1)
  vector[N*J] time; // time of operationof ignitino voltage (predictor2)
  real age_pred;
  real time_pred;
}

parameters {
  real a;
  real b1;
  real b2;
  real<lower=0> sigma;
}

transformed parameters{
 vector[N*J] mu= log(a) + b1*log(time) + b2*log(age);
}

model {
  //priors
  a ~ normal(0,1000);
  b1 ~ normal(0,1000);
  b2 ~ normal(0,1000);
  sigma ~ normal(0,1000);
  
  //likelihood
  log(y) ~ normal(mu, sigma);
}

generated quantities{
  real y_pred;
  vector[N*J] log_lik;
  y_pred = exp(normal_rng(log(a) + b1*log(time_pred) + b2*log(age_pred),sigma));
  for(i in 1:N*J) {
    log_lik[i] = normal_lpdf(log(y[i])|mu[i], sigma);
  }
}
