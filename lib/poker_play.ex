defmodule PokerPlay do
  alias PokerPlay.Comparer
  @moduledoc false

  def best_hand(lef_hand, right_hand) do
    left_hand_type =
      lef_hand
      |> PokerPlay.Card.init()
      |> PokerPlay.Hand.type()

    right_hand_type =
      right_hand
      |> PokerPlay.Card.init()
      |> PokerPlay.Hand.type()

    result = Comparer.compare(left_hand_type, right_hand_type)

    case result do
      ^left_hand_type ->
        "Black wins - #{left_hand_type}"

      ^right_hand_type ->
        "White wins - #{right_hand_type}"
    end
  end
end
