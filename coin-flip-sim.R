# players: number of players in game
# rounds: number of rounds of play to simulate
# start_money: how much each player starts with

# Rules: players pair up randomly.  They flip a coin.
# Heads means player 1 gives player 2 a dollar; tails the opposite.

# Goal: what happens to the distribution of money?

library(ggplot2)
library(ggridges)

simulate_coin_flip <- function(players, rounds, start_money) {
  results <- matrix(0L, nrow = players, ncol = rounds + 1L)
  results[, 1L] <- start_money
  
  for(i in 1:rounds) {
    player_money <- results[, i]
    eligible_players <- which(player_money > 0)
    if(length(eligible_players) == 1L) return(results[, 1:i])
    
    players_per_side <- floor(length(eligible_players) / 2L)
    winners <- sample(eligible_players, players_per_side)
    losers  <- sample(eligible_players[!eligible_players %in% winners],
                      players_per_side)
    sitting_out <- eligible_players[!eligible_players %in% c(winners, losers)]
    
    results[winners, i + 1] <- results[winners, i] + 1L
    results[losers, i + 1] <- results[losers, i] - 1L
    results[sitting_out, i + 1] <- results[sitting_out, i]
  }

results
}


plot_results <- function(results, rounds) {
  rounds_of_interest <- as.data.frame(results[, rounds])
  names(rounds_of_interest) <- paste0("round_", rounds)
  rounds_data <- stack(rounds_of_interest)
  
  ggplot(rounds_data, aes(x = values, y = ind)) +
    geom_density_ridges(stat = "binline",
                        bins = 100,
                        scale = 0.95,
                        draw_baseline = FALSE) +
    theme_minimal(base_size = 14)
}