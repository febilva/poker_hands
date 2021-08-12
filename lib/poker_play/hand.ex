defmodule PokerPlay.Hand do
  @ace_high "AKQJT98765432"
  @ace_low "KQJT98765432A"

  @moduledoc false

  @doc """
  this function will return the type of the hand based on the highest rank
  """
  def type(hand) do
    grouped_values =
      hand
      |> format

    hand_type(hand: hand, grouped_values: grouped_values)
  end

  def format(hand) do
    hand
    |> Enum.group_by(& &1.int_value)
    |> Enum.sort_by(fn {int_value, _items} -> int_value end)
    |> Enum.sort_by(fn {_int_value, items} -> Kernel.length(items) end)
    |> Enum.reverse()
    |> Enum.map(fn {_int_value, items} -> Enum.map(items, & &1.value) end)
  end

  defp hand_type(hand: hand, grouped_values: gp_values) do
    cond do
      hand_type(:straight_flush, hand) ->
        "straight flush"

      hand_type(:four_of_a_kind, gp_values) ->
        "four of a kind"

      hand_type(:full_house, gp_values) ->
        "full house"

      hand_type(:flush, hand) ->
        "flush"

      hand_type(:straight, hand) ->
        "straight"

      hand_type(:three_of_kind, gp_values) ->
        "three of a kind"

      hand_type(:two_pairs, gp_values) ->
        "two pairs"

      hand_type(:pair, gp_values) ->
        "pair"

      true ->
        "high card"
    end
  end

  def hand_type(:straight_flush, hand) do
    hand_type(:straight, hand) && hand_type(:flush, hand)
  end

  def hand_type(:four_of_a_kind, gp_values) do
    gp_values
    |> find_pair_at(0, 4)
  end

  def hand_type(:full_house, gp_values) do
    find_pair_at(gp_values, 0, 3) && find_pair_at(gp_values, 1, 2)
  end

  def hand_type(:straight, hand) do
    hand
    |> Enum.sort_by(& &1.int_value)
    |> Enum.reverse()
    |> check()
  end

  def hand_type(:three_of_kind, gp_values) do
    gp_values
    |> find_pair_at(0, 3)
  end

  def hand_type(:flush, hand) do
    hand
    |> Enum.map(& &1.suit)
    |> Enum.uniq()
    |> Kernel.length()
    |> Kernel.==(1)
  end

  def hand_type(:two_pairs, gp_values) do
    find_pair_at(gp_values, 0, 2) && find_pair_at(gp_values, 1, 2)
  end

  def hand_type(:pair, gp_values) do
    gp_values
    |> Enum.at(0)
    |> Kernel.length()
    |> Kernel.==(2)
  end

  defp find_pair_at(values, index_position, length_of_a_pair) do
    values
    |> Enum.at(index_position)
    |> Kernel.length()
    |> Kernel.==(length_of_a_pair)
  end

  def check(cards) do
    ace_high?(cards) || ace_low?(cards)
  end

  #   require IEx

  def ace_high?(cards) do
    cards |> hand_values() |> matches?(@ace_high)
  end

  def ace_low?(cards) do
    cards |> rotated_hand_values() |> matches?(@ace_low)
  end

  defp matches?(hand_values, all_values) do
    all_values
    |> :binary.match(hand_values)
    |> Kernel.!=(:nomatch)
  end

  def hand_values(cards) do
    cards
    |> Enum.map(fn x -> x.value end)
    |> Enum.join()
  end

  def rotated_hand_values(cards) do
    [head | tail] = Enum.map(cards, fn x -> x.value end)

    Enum.join(tail ++ [head])
  end
end
