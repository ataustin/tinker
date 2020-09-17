library(ggplot2)

spin <- function(n) {
  sample(0:36, size = n, replace = TRUE)
}


is_win <- function(spin, bet_function) {
  bet_function(spin)
}


bet_evens <- function(spin) {
  spin %% 2 == 0 & spin != 0
}


bet_first_third <- function(spin) {
  spin <= 12 & spin >= 1
}


bet_on_1 <- function(spin) {
  spin == 1
}


compute_multiplier <- function(bet_function) {
  winners  <- bet_function(1:36)
  win_prob <- sum(winners) / 36
  1 / win_prob
}


first_play <- function(x) {
  x[1]
}


compute_win_index <- function(is_win) {
  win_index_adjustment <- if(first_play(is_win)) NULL else 0
  which_win            <- which(is_win)
  win_index            <- c(win_index_adjustment, which_win)
  win_index
}


compute_loss_multiplier <- function(is_win, multiplier) {
  win_index          <- compute_win_index(is_win)
  loss_streak_length <- diff(win_index) - 1
  
  cumprod_correction       <- 1 / (multiplier ^ loss_streak_length)
  cumprod_correction_index <- win_index[2:length(win_index)]
  
  loss_multiplier <- (!is_win) * multiplier
  loss_multiplier[cumprod_correction_index] <- cumprod_correction
  
  loss_multiplier_adjustment <- if(first_play(is_win)) 1 else first_play(loss_multiplier)
  loss_multiplier[1]         <- loss_multiplier_adjustment
  
  loss_multiplier
}


compute_bet <- function(loss_multiplier) {
  n_rounds              <- length(loss_multiplier)
  bets_after_first_play <- cumprod(loss_multiplier)
  round_bet             <- c(1, head(bets_after_first_play, n_rounds - 1))
  round_bet
}


compute_running_profit <- function(is_win, multiplier, bets) {
  win_multiplier    <- is_win * multiplier
  winnings          <- win_multiplier * bets
  profit            <- winnings - bets
  cumulative_profit <- cumsum(profit)
  cumulative_profit
}



simulate <- function(n_plays, bet_function) {
  numbers    <- spin(n_plays)
  multiplier <- compute_multiplier(bet_function)
  
  round_win       <- is_win(numbers, bet_function)
  loss_multiplier <- compute_loss_multiplier(round_win, multiplier)
  bets            <- compute_bet(loss_multiplier)
  accum_profit    <- compute_running_profit(round_win, multiplier, bets)
  
  out <- data.frame(spin = numbers,
                    win  = round_win,
                    bet  = bets,
                    running_profit = accum_profit)
  out
}


make_data <- function(n_iter, n_rounds_per_iter, bet_function) {
  data <- replicate(n_iter,
                    simulate(n_rounds_per_iter, bet_function),
                    simplify = FALSE)
  data <- do.call(rbind, data)
  
  data$round <- rep(1:n_rounds_per_iter, times = n_iter)
  data$iter  <- rep(1:n_iter, each = n_rounds_per_iter)
  
  data
}


plot_martingale <- function(data) {
  ylim  <- max(data$running_profit)
  alpha <- min(25 / length(unique(data$iter)), 0.5)
  
  ggplot(data, aes(x = round, y = running_profit, group = factor(iter))) +
    geom_line(color = "black", alpha = alpha, lwd = 1.1) +
    coord_cartesian(ylim = c(-ylim, ylim)) +
    theme_minimal()
}


data <- make_data(100, 100, bet_evens)

plot_martingale(data)
