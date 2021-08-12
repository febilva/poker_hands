# PokerPlay

**How To run**

```elixir
#get the dependencies
mix deps.get

#for test
mix test

#run the app
iex -S mix
```

## how to play

```
iex(4)> left_hand = "Black: 2H 2D 5S 5C KD"
"Black: 2H 2D 5S 5C KD"

iex(5)> right_hand = "White: 2D 5H 6S 7D 2C"
"White: 2D 5H 6S 7D 2C"

iex(6)> PokerPlay.best_hand(left_hand,right_hand)
"Black wins - two pairs"


```
