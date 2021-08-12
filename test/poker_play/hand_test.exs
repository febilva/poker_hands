defmodule PokerPlay.HandTest do
  use ExUnit.Case

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
      flush_to_8 = "Black: 3H 6H 7H 8H 5H"
      high_card = "Black: 2H 4S TS AH 6D"
      three_fours = "White: 4S 5H 4C 8S 4H"

      hand_1 = PokerPlay.Card.init(pairs_of_two_and_five)
      hand_2 = PokerPlay.Card.init(pairs_of_two)
      hand_3 = PokerPlay.Card.init(flush_to_8)
      hand_4 = PokerPlay.Card.init(high_card)
      hand_5 = PokerPlay.Card.init(three_fours)

      assert PokerPlay.Hand.type(hand_1) == "two pairs"
      assert PokerPlay.Hand.type(hand_2) == "pair"
      assert PokerPlay.Hand.type(hand_3) == "flush"
      assert PokerPlay.Hand.type(hand_4) == "high card"
      assert PokerPlay.Hand.type(hand_5) == "three of a kind"
    end
  end
end
