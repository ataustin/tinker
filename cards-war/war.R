shuffle_deck <- function(ranks = 13, suits = 4) {
  cards <- rep(1:ranks, each = suits)
  deck  <- sample(cards)
  deck
}


deal_player_hands <- function(deck) {
  player_hands <- list(p1 = seq(1, length(deck), by = 2),
                       p2 = seq(2, length(deck), by = 2))
  player_hands
}


play_card <- function(deck, player_ix, card) deck[player_ix[card]]


transfer_cards <- function(from, to, count = 1) {
  # from and to are losing and winning player indices, respectively
  transfer_ix <- 1:count
  from_cards  <- from[transfer_ix]
  to_cards    <- to[transfer_ix]
  reward_cards <- c(from[transfer_ix], to[transfer_ix]) # winner's cards go last
  to   <- c(to[-transfer_ix], reward_cards)
  from <- from[-transfer_ix]

  list(from = from, to = to)
}


execute_war <- function(val1, val2, player_hands, card_number) {
  round_winner <- which.max(c(val1, val2))
  round_loser  <- 3 - round_winner
  player_names <- c("p1", "p2")
  cards <- transfer_cards(from = get(player_names[round_loser], pos = player_hands),
                          to = get(player_names[round_winner], pos = player_hands),
                          count = card_number)
  assign(player_names[round_winner], cards$to)
  assign(player_names[round_loser], cards$from)
  list(p1 = p1, p2 = p2)
}


play_round <- function(deck, player_hands, card_number = 1) {
  p1 <- player_hands$p1
  p2 <- player_hands$p2

  p1_card <- play_card(deck, p1, card_number)
  p2_card <- play_card(deck, p2, card_number)

  if(p1_card == p2_card) {
    p1_hand_ct <- length(p1)
    p2_hand_ct <- length(p2)
    least_hand_size <- min(p1_hand_ct, p2_hand_ct)

    if(card_number == least_hand_size) {
      outcome <- execute_war(p1_hand_ct, p2_hand_ct, player_hands, card_number)
      return(outcome)
    }

    card_number <- min(least_hand_size, card_number + 4)
    outcome <- play_round(deck, player_hands, card_number = card_number)

  } else {
    outcome <- execute_war(p1_card, p2_card, player_hands, card_number)
  }

  outcome
}


at_least_one_card_in <- function(player_hands) {
  all(lengths(player_hands) > 0)
}



simulate_game <- function(ranks = 13, suits = 4) {
  deck <- shuffle_deck(ranks, suits)
  player_hands <- deal_player_hands(deck)
  n_rounds <- 0

  while (at_least_one_card_in(player_hands)) {
    player_hands <- play_round(deck, player_hands)
    n_rounds <- n_rounds + 1
  }

  data.frame(round_count = n_rounds, winner = which.max(lengths(player_hands)))
}