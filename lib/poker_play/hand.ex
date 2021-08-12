defmodule PokerPlay.Hand do
  defstruct cards: [], grouped_values: []
  @moduledoc false

  @doc """
  this function will return the type of the hand
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
      hand_type(:flush, hand) ->
        "flush"

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
end
