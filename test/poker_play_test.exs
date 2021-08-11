defmodule PokerPlayTest do
  use ExUnit.Case
  doctest PokerPlay

  describe "intialize" do
    test "and format the given input into Card Struct" do
      input = "Black: 2H 3D 5S 9C KD"

      assert PokerPlay.Card.init(input) == [
               %PokerPlay.Card{value: "2", suit: "H", int_value: 2},
               %PokerPlay.Card{value: "3", suit: "D", int_value: 3},
               %PokerPlay.Card{value: "5", suit: "S", int_value: 5},
               %PokerPlay.Card{value: "9", suit: "C", int_value: 9},
               %PokerPlay.Card{value: "K", suit: "D", int_value: 13}
             ]
    end

    test "input hand to Card struct" do
      assert PokerPlay.Card.init("2H") == [%PokerPlay.Card{value: "2", suit: "H", int_value: 2}]

      assert PokerPlay.Card.init("TS") == [
               %PokerPlay.Card{
                 value: "T",
                 suit: "S",
                 int_value: 10
               }
             ]

      assert PokerPlay.Card.init("KD") == [
               %PokerPlay.Card{
                 value: "K",
                 suit: "D",
                 int_value: 13
               }
             ]
    end
  end
end
