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

  describe "type/1" do
    test "will return the type of the hand" do
      pairs_of_two_and_five = "Black: 2H 2D 5S 5C KD"
      pairs_of_two = "Black: 2D 5H 6S 7D 2C"

      hand_1 = PokerPlay.Card.init(pairs_of_two_and_five)
      hand_2 = PokerPlay.Card.init(pairs_of_two)

  describe "compare/2" do
    test "will compare the hand and return the best hand" do
      assert Comparer.compare("straight flush", "four of a kind") == "straight flush"
      assert Comparer.compare("full house", "flush") == "full house"
      assert Comparer.compare("straight", "three of a kind") == "straight"
      assert Comparer.compare("two pairs", "pair") == "two pairs"
      assert Comparer.compare("pair", "high card") == "pair"
    end
  end
end
