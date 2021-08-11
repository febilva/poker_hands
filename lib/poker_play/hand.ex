defmodule PokerPlay.Hand do
  @moduledoc false

  @doc """
  this function will return the type of the hand
  """
  def type(hand) do
    hand
    |> format
    |> hand_type()
  end

  def format(hand) do
    hand
    |> Enum.group_by(& &1.int_value)
    |> Enum.sort_by(fn {int_value, _items} -> int_value end)
    |> Enum.sort_by(fn {_int_value, items} -> Kernel.length(items) end)
    |> Enum.reverse()
    |> Enum.map(fn {_int_value, items} -> Enum.map(items, & &1.value) end)
  end

  defp hand_type(hand) do
    cond do
      hand_type(:two_pairs, hand) ->
        "two pairs"

      hand_type(:pair, hand) ->
        "pair"
    end
  end

  def hand_type(:two_pairs, hand) do
    find_pair_at(hand, 0, 2) && find_pair_at(hand, 1, 2)
  end

  def hand_type(:pair, hand) do
    hand
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
