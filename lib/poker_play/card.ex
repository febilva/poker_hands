defmodule PokerPlay.Card do
  alias PokerPlay.Card
  defstruct int_value: 0, suit: "", value: ""

  def init(input_string) do
    input_string
    |> IO.inspect(lable: "input_string")
    |> format_input
    |> IO.inspect(lable: "format input")
    |> Enum.map(&card_struct(&1))
  end

  def card_struct(denotation) do
    IO.inspect(denotation, label: "denotation")
    [value, suit] = split_value_and_suit(denotation)

    %__MODULE__{
      value: value,
      suit: suit,
      int_value: int_value(value)
    }
  end

  def split_value_and_suit(denotation) do
    String.split(denotation, "", trim: true)
  end

  defp format_input(hand) do
    hand
    |> String.trim("Black:")
    |> String.trim("White:")
    |> String.split(" ", trim: true)
  end

  def int_value(value) when value in ["T", "J", "Q", "K", "A"] do
    map = %{
      "T" => 10,
      "J" => 11,
      "Q" => 12,
      "K" => 13,
      "A" => 14
    }

    map[value]
  end

  def int_value(value), do: String.to_integer(value)
end
