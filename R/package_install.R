# Part 1 - Install Packages
pckgs <- list('tidyverse','here','nlme','nycflights13','hrbrthemes','ggrepel','ggplot2','dplyr','tidyyr')
install_me <- function(x){
    has_pckg <- require(x,character.only=TRUE)
    if( !has_pckg ){
        install.packages(x,character.only=TRUE)
    }
}
result <- lapply(pckgs,install_me)

# Part 2: Collatz Cojecture in R
# The rest of this code is optional but I highly encourage to read thorugh the comments and code below and execute the code as you go. 
# load some packages that were just installed. 
library(ggplot2)
library(dplyr)
library(tidyr)

# Visualization of the Collatz Conjecture in R. 
# The Collatz Conjecture is a famous mathematical problem that has yet to be solved. 
# Check out this video to learn more about the Collatz Conjecture.
# https://www.youtube.com/watch?v=094y1Z2wpJg
# In a nutshell the conjecture says that you can Take any positive integer, n. 
# If n is even divide it by 2 (n/2). If n is odd multiple by 3 and add 1 (3n+1). 
# Repeat the process on the new value. The Collatz Conjecture is that this sequence will 
# eventually reach 1 (and then get stuck in the loop 4 -> 2 -> 1 -> 4). 
# The routes from n to 1 can be visualized as a graph. 
#Check this out https://en.wikipedia.org/wiki/File:Collatz-graph-all-30-no27.svg

# This is a great starting point to get acquainted with R and its code structure. 
# We will visualize the Collatz conjecture Hailstone Sequence for five random numbers. 

# First we have to write a function for the collatz conjecture. 

collatz_sequence <- function(n) {
  # Initialize a vector called sequence starting with the input number
  sequence <- c(n)
  # Start a while loop to iterate through each number and apply the 3n+1 logic
  # the while loop will run as long as n does not equal 1
  while(n != 1) {
    # we then do a logic check to see if n is an even number using the modulo operator
    # the module operator %% is fancy code to get the reminder of a division. 
    if(n %% 2 == 0){
      # if n is even number then we divide it by 2
      n <- n / 2
    } else {
      # otherwise we apply our 3n+1 function
      n <- 3 * n + 1
    }
    # then we add it to our sequence
    sequence <- c(sequence, n)
  }
  # return the sequence as an output
  return(sequence)
}

# Now lets generate five random numbers
# Lets set a seed to make sure we can reproduce this random numbers
set.seed(42) 
# Our random numbers will be between 1 and maximum value of 2,147,483,647 or 2 to the power of 31
start_numbers <- sample(1: (2^{31}-1),5)

# Lets create a data from of all sequences for our five random numbers. Start by creating an empty dataframe
hailstone_data <- data.frame()
# then use a for loop in R to iterate through our random five numbers
for(start in start_numbers) {
  # for each loop of the iteration we put the number through the function we
  # created above, the collatz_sequence function
  seq <- collatz_sequence(start)
  # we initialize the a data frame to store the the output of the of the 
  # colltaz conjecture function. Remember that we are starting with a random
  # number and applying the arithmetic over and over, saving the ouput, 
  # and we do this over and over till we reach 1. 
  # so for every run of this loop we end up with a few or possible many numbers.
  df <- data.frame(
    Step = 0:(length(seq)-1),
    Value = seq,
    Start = as.factor(start)
  )
  #finally we push our loop output into our main data frame.
  hailstone_data <- rbind(hailstone_data,df)
}

## Now we are ready to create a plot. We will review this in class. 
ggplot(hailstone_data, aes(x=Step,y=Value,color=Start))+
  geom_line(size=1.2) +
  geom_point(size = 2) +
  labs(
    title = "Collatz Cojecture (Hailstone Sequences)",
    subtitle = "Each line represnets a different random starting number",
    x = "Step",
    y = "Value",
    color = "starting Number"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold"),
    legend.position = "right"
  )


## There, a nice looking Visual of the Collatz Conjecture!








