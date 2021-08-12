defmodule PokerPlay.Comparer do
  @hands [
    "straight flush",
    "four of a kind",
    "full house",
    "flush",
    "straight",
    "three of a kind",
    "two pairs",
    "pair",
    "high card"
  ]

  def compare(left, right) when left == right, do: {:tie, left}

  def compare(left, right) do
    if hand_rank(left) < hand_rank(right), do: left, else: right
  end

  defp hand_rank(hand) do
    Enum.find_index(@hands, &(&1 == hand))
  end
end
