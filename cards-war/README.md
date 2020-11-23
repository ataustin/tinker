# War!

This code simulates a version of the card game War.  I'm using rules that I
remember them from my childhood and adding some arbitrary stopping conditions
because this game can go on _forever_.

This is a great game for your competitive kids on long road trips.

## Game objective

Collect all the cards from your opponent.

## Rules

* Use a standard deck of playing cards.  (The code allows you to change the kind of deck you use if you want.)
* All cards of the same rank are treated the same (_i.e._ there is no higher or lower suit).
* Aces are high.
* Shuffle the deck and distribute it face down alternately between two players.
* The players simultaneously turn over their top card.  The person with the
  higher card takes them both and places them at the bottom of their deck.
* In the event of a tie, each player lays out three additional cards (face down for suspense)
  and turns a fourth card face up.  The values of this last face up card are
  compared as before, and the winner (high card) takes all the cards in play.
* All ties trigger tie-breakers in the same way, including ties occurring while in a
  tie-breaking round.  (See the single exception in next bullet.)
* *Arbitrary rule for simulation*: If there is a tie and one player doesn't have
  enough cards left for a full layout of 5 cards (1 face up (the tie), 3 face down, 1 face up),
  then both parties play as many cards as the _smaller  hand_ can play, with the
  last card turned face up for comparison.  A tie here ends the game in favor of
  the player with the larger hand.  Everyone will be relieved the game is over.
* *Arbitrary rule for simulation*: when cards are placed at the bottom of the
  winner's deck, the winning cards go _below_ the losing cards so that
  those losing cards are played before the winning cards.


## Files

View the simulation code [here](https://github.com/ataustin/tinker/cards-war/war.R).

View a study of the game [here](https://github.com/pages/ataustin/tinker/cards-war/simulation.html).