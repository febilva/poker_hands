defmodule PokerPlay do
  alias PokerPlay.Comparer
  alias PokerPlay.Card
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

      {:tie, _type} ->
        high_rank_check(lef_hand, right_hand)
        |> case do
          {:left, higher_rank_card_value} ->
            higher_card = char_value(higher_rank_card_value)

            "Black wins - high card: #{higher_card}"

          {:right, higher_rank_card_value} ->
            higher_card = char_value(higher_rank_card_value)

            "White wins - high card: #{higher_card}"

          :tie ->
            "Tie"
        end
    end
  end

  defp high_rank_check(lef_hand, right_hand) do
    left_values =
      lef_hand
      |> find_values

    right_valus =
      right_hand
      |> find_values

    compare(left_values, right_valus)
  end

  def find_values(hand) do
    hand
    |> PokerPlay.Card.init()
    |> PokerPlay.Hand.format()
    |> high_card_values
  end

  def high_card_values(hand) do
    # require IEx
    # IEx.pry()

    hand
    |> Enum.concat()
    |> Enum.map(&Card.int_value(&1))
  end

  def compare(left, right) do
    left
    |> Enum.zip(right)
    |> Enum.find(fn {l, r} -> l != r end)
    |> left_or_right()
  end

  defp left_or_right(nil), do: :tie
  defp left_or_right({left, right}) when left > right, do: {:left, left}
  defp left_or_right({left, right}) when left < right, do: {:right, right}

  def char_value(value) when value in [10, 11, 12, 13, 14] do
    map = %{10 => "J", 11 => "Q", 12 => "K", 14 => "Ace"}
    map[value]
  end

  def char_value(value) do
    value
  end
end
