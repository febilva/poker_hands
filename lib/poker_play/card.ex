defmodule PokerPlay.Card do
  defstruct int_value: 0, suit: "", value: ""

  @moduledoc """
  false
  """

  def init(input_string) do
    input_string
    |> format_input
    |> Enum.map(&card_struct(&1))
  end

  defp card_struct(denotation) do
    [value, suit] = split_value_and_suit(denotation)

    %__MODULE__{
      value: value,
      suit: suit,
      int_value: int_value(value)
    }
  end

  defp split_value_and_suit(denotation) do
    String.split(denotation, "", trim: true)
  end

  defp format_input(hand) do
    hand
    |> String.trim("Black:")
    |> String.trim("White:")
    |> String.split(" ", trim: true)
  end

  defp int_value(value) when value in ["T", "J", "Q", "K", "A"] do
    map = %{
      "T" => 10,
      "J" => 11,
      "Q" => 12,
      "K" => 13,
      "A" => 14
    }

    map[value]
  end

  defp int_value(value), do: String.to_integer(value)

  # defp test(white: w_string, black: b_string) do
  #   IO.inspect(w_string)
  # end
end
