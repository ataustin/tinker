# players: number of players in game
# rounds: number of rounds of play to simulate
# start_money: how much each player starts with
# transfer: size of monetary transfer in a given round

# Rules: players pair up randomly.  A random member of the pair
# is selected to give a transfer to the other.  If the "losing" agent
# does not have enough funds, no transfer takes place.

# Note: this function pre-allocates a (players x rounds)-dimension
# matrix, so large games (many players, many rounds) may not work.

# Goal: what happens to the distribution of money?

library(ggplot2)
library(ggridges)

simulate_money_transfer <- function(players, rounds, start_money = 10, transfer = 1) {
  results <- matrix(0L, nrow = players, ncol = rounds + 1L)
  results[, 1L] <- start_money
  n_pairs <- players / 2
  player_index <- 1:players
  transfer_vector <- numeric(players)
  
  for(i in 1:rounds) {
    winners <- sample(player_index, n_pairs)
    losers  <- sample(player_index[-winners])
    
    transfer_occurs <- results[losers, i] >= transfer
    
    get_transfer  <- winners[transfer_occurs]
    lose_transfer <- losers[transfer_occurs]
    no_transfer   <- player_index[-c(get_transfer, lose_transfer)]
    
    transfer_vector[get_transfer]  <- transfer
    transfer_vector[lose_transfer] <- -transfer
    transfer_vector[no_transfer]   <- 0
    
    results[, i + 1] <- results[, i] + transfer_vector
  }

  results
}


# results: the output matrix of the simulation
# rounds: integer vector of the rounds to plot

plot_results <- function(results, rounds) {
  rounds_of_interest <- as.data.frame(results[, rounds])
  names(rounds_of_interest) <- paste0("round_", rounds)
  rounds_data <- stack(rounds_of_interest)
  
  ggplot(rounds_data, aes(x = values, y = ind)) +
    geom_density_ridges(stat = "binline",
                        bins = 50,
                        draw_baseline = FALSE) +
    theme_minimal(base_size = 14)
}