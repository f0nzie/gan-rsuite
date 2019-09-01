library(rTorch)
library(tictoc)

tic()

nn       <- torch$nn
optim    <- torch$optim
Variable <- torch$autograd$Variable

# seeds
torch$manual_seed(123L)
np$random$seed(seed=123L)

# Data params
data_mean <- 4
data_stddev <- 1.25


# lambda functions
name         <- "Only 4 moments"
preprocess   <- function(data) get_moments(data)
d_input_func <- function(x) 4L


get_distribution_sampler <- function(mu, sigma) {
    # in Python: torch.Tensor(np.random.normal(mu, sigma, (1, n)))
    # the last member of the normal is the shape vector
    function(n) torch$Tensor(np$random$normal(mu, sigma, c(1L, n)))
}

get_generator_input_sampler <- function(){
    #  in Python: lambda m, n: torch.rand(m, n)
    function(m, n) torch$rand(m, n)
}

d_sampler <- get_distribution_sampler(data_mean, data_stddev)

get_moments <- function(d) {
    mean <- torch$mean(d)
    diffs <- d - mean
    var <- torch$mean(torch$pow(diffs, 2.0))
    std <- torch$pow(var, 0.5)
    zscores <- diffs / std
    skews <- torch$mean(torch$pow(zscores, 3.0))
    kurtoses <- torch$mean(torch$pow(zscores, 4.0)) - 3.0
    #  in Python: torch.cat((mean.reshape(1,), std.reshape(1,),
    #                        skews.reshape(1,), kurtoses.reshape(1,)))
    final <- torch$cat(c(torch$reshape(mean, list(1L)), torch$reshape(std, list(1L)),
                         torch$reshape(skews, list(1L)), torch$reshape(kurtoses, list(1L))))
    return(final)
}


py_run_string("import torch")
main = py_run_string(
    "
import torch.nn as nn

class Generator(nn.Module):
    # Two hidden layers
    # Three linear maps
    def __init__(self, input_size, hidden_size, output_size, f):
        super(Generator, self).__init__()
        self.map1 = nn.Linear(input_size, hidden_size)
        self.map2 = nn.Linear(hidden_size, hidden_size)
        self.map3 = nn.Linear(hidden_size, output_size)
        self.f = f

    def forward(self, x):
        x = self.map1(x)
        x = self.f(x)
        x = self.map2(x)
        x = self.f(x)
        x = self.map3(x)
        return x


class Discriminator(nn.Module):
    # also two hidden layer and three linear maps
    def __init__(self, input_size, hidden_size, output_size, f):
        super(Discriminator, self).__init__()
        self.map1 = nn.Linear(input_size, hidden_size)
        self.map2 = nn.Linear(hidden_size, hidden_size)
        self.map3 = nn.Linear(hidden_size, output_size)
        self.f = f

    def forward(self, x):
        x = self.f(self.map1(x))
        x = self.f(self.map2(x))
        return self.f(self.map3(x))
"
)

Generator     <- main$Generator
Discriminator <- main$Discriminator

extract <- function(v){
    return(v$data$storage()$tolist())
}


stats <- function(d) {
    return(list(np$mean(d), np$std(d)))
}

# Prepare a 1D list for printing with cat()
list_for_cat <- function(li) {
    cum <- ""
    len <- length(li)
    for (i in seq(length(li))) {
        sep <- ifelse(i != len, ", ",  "")   # use comma at the end only if not last
        cum <- paste0(cum, paste0(li[i], sep))  # compose the string
    }
    paste0("[", cum, "]")  # return list elements as a string enclosed by square brackets
}


train <- function(){
    # Model parameters
    g_input_size <- 1L      # Random noise dimension coming into generator, per output vector
    g_hidden_size <- 5L     # Generator complexity
    g_output_size <- 1L     # Size of generated output vector
    d_input_size <- 500L    # Minibatch size - cardinality of distributions
    d_hidden_size <- 10L    # Discriminator complexity
    d_output_size <- 1L     # Single dimension for 'real' vs. 'fake' classification
    minibatch_size <- d_input_size

    d_learning_rate <- 1e-3
    g_learning_rate <- 1e-3
    sgd_momentum <- 0.9

    num_epochs <- 500
    print_interval <- 100
    d_steps <- 20
    g_steps <- 20

    dfe <- 0; dre <- 0; ge <- 0
    d_real_data <- NULL; d_fake_data <- NULL; g_fake_data <- NULL

    # Activation functions
    discriminator_activation_function <- torch$sigmoid
    generator_activation_function     <- torch$tanh

    d_sampler = get_distribution_sampler(data_mean, data_stddev)
    gi_sampler = get_generator_input_sampler()


    G = Generator(input_size=g_input_size,
                  hidden_size=g_hidden_size,
                  output_size=g_output_size,
                  f=generator_activation_function)

    D = Discriminator(input_size=d_input_func(d_input_size),
                      hidden_size=d_hidden_size,
                      output_size=d_output_size,
                      f=discriminator_activation_function)

    criterion   <- nn$BCELoss()  # Binary cross entropy: http://pytorch.org/docs/nn.html#bceloss
    d_optimizer <- optim$SGD(D$parameters(), lr = d_learning_rate, momentum = sgd_momentum)
    g_optimizer <- optim$SGD(G$parameters(), lr = g_learning_rate, momentum = sgd_momentum)

    # Now, training loop alternates between Generator and Discriminator modes

    # for (epoch in (0:num_epochs)) {
    lapply(0:num_epochs, function(epoch) {
        ## cat(sprintf("%5d:", epoch))
        for (i in (0:d_steps)) {
        #lapply(seq(0, d_steps), function(x) {

            ## cat(sprintf("%3d", d_index))

            # 1. Train D on real+fake
            D$zero_grad()

            #  1A: Train D on real data
            d_real_data = Variable(d_sampler(d_input_size))

            d_real_decision = D(preprocess(d_real_data))
            d_real_error = criterion(d_real_decision, Variable(torch$ones( list(1L, 1L) )))  # ones = true
            d_real_error$backward()  # compute/store gradients, but don't change params

            #  1B: Train D on fake data
            d_gen_input = Variable(gi_sampler(minibatch_size, g_input_size))
            d_fake_data = G(d_gen_input)$detach()  # detach to avoid training G on these labels
            d_fake_decision = D(preprocess(d_fake_data$t()))
            d_fake_error = criterion(d_fake_decision, Variable(torch$zeros( list(1L, 1L) ))) # zeros = fake
            d_fake_error$backward()
            # Only optimizes D's parameters; changes based on stored gradients from backward()
            d_optimizer$step()
            dre <- extract(d_real_error)[1]; dfe <- extract(d_fake_error)[1]
        }
        # print(d_real_data)
        ## cat("\n")

        for (g_index in (0:g_steps)) {
            # 2. Train G on D's response (but DO NOT train D on these labels)
            G$zero_grad()

            gen_input = Variable(gi_sampler(minibatch_size, g_input_size))
            g_fake_data <- G(gen_input)
            dg_fake_decision = D(preprocess(g_fake_data$t()))
            # Train G to pretend it's genuine
            g_error = criterion(dg_fake_decision, Variable(torch$ones( list(1L, 1L) )))

            g_error$backward()
            g_optimizer$step()  # Only optimizes G's parameters
            ge = extract(g_error)[1]
        }

        if ((epoch %% print_interval) == 0) {
            cat(sprintf("\t Epoch %4d: D (%8f5 real_err, %8f5 fake_err) G (%8f5 err); Real Dist (%s),  Fake Dist (%s) \n",
                        epoch, dre, dfe, ge,
                        list_for_cat(stats(extract(d_real_data))),
                        list_for_cat(stats(extract(d_fake_data))) ))
        }
    })
    print("Plotting the generated distribution...")
    values = extract(g_fake_data)
    cat(sprintf(" Values: %s", str(values)))
    hist(values, breaks = 50, col =  "lightblue")

    return(values)
}

ret_values <- train()
toc()
