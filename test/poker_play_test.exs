defmodule PokerPlayTest do
  use ExUnit.Case
  # doctest PokerPlay

  describe "best_hand/2" do
    test "will return the best hand" do
      pairs_of_two_and_five = "Black: 2H 2D 5S 5C KD"
      pairs_of_two = "White: 2D 5H 6S 7D 2C"

      assert PokerPlay.best_hand(pairs_of_two_and_five, pairs_of_two) == "Black wins - two pairs"
    end

    test "two pairs beats one pair" do
      pair_of_two = "Black: 2S 8H 6S 8D JH"
      five_and_fours = "White: 4S 5H 4C 8C 5C"

      assert PokerPlay.best_hand(pair_of_two, five_and_fours) == "White wins - two pairs"
    end

    test "flush beats a two pairs" do
      flush_to_8 = "Black: 3H 6H 7H 8H 5H"
      pairs_of_two = "White: 2D 5H 6S 7D 2C"

      assert PokerPlay.best_hand(flush_to_8, pairs_of_two) == "Black wins - flush"
    end

    test "multiple hands with the same high cards, tie compares next highest ranked, down to last card" do
      high_of_8_low_of_3 = "Black: 3S 5H 6S 8D 7H"
      high_of_8_low_of_2 = "White: 2S 5D 6D 8C 7S"

      assert PokerPlay.best_hand(high_of_8_low_of_3, high_of_8_low_of_2) ==
               "Black wins - high card: 3"
    end

    test "one pair beats high card" do
      high_of_king = "Black: 4S 5H 6C 8D KH"
      pair_of_4 = "White: 2S 4H 6S 4D JH"

      assert PokerPlay.best_hand(high_of_king, pair_of_4) ==
               "White wins - pair"
    end

    test "highest pair wins" do
      pair_of_2 = "Black: 4S 2H 6S 2D JH"
      pair_of_4 = "White: 2S 4H 6C 4D JD"

      assert PokerPlay.best_hand(pair_of_2, pair_of_4) ==
               "White wins - high card: 4"
    end

    test "both hands have two pairs, highest ranked pair wins" do
      eights_and_twos = "Black: 2S 8H 2D 8D 3H"
      fives_and_fours = "White: 4S 5H 4C 8S 5D"

      assert PokerPlay.best_hand(eights_and_twos, fives_and_fours) ==
               "Black wins - high card: 8"
    end

    test "both hands have two pairs, with the same highest ranked pair, tie goes to low pair" do
      queens_and_twos = "Black: 2S QS 2C QD JH"
      queens_and_jacks = "White: JD QH JS 8D QC"

      assert PokerPlay.best_hand(queens_and_twos, queens_and_jacks) ==
               "White wins - high card: Q"
    end

    test "both hands are identical" do
      queens_and_twos = "Black: 2S QS 2C QD JH"
      queens_and_jacks = "White: 2S QS 2C QD JH"

      assert PokerPlay.best_hand(queens_and_twos, queens_and_jacks) ==
               "Tie"
    end

    test "three of a kind beats two pair" do
      eights_and_twos = "Black: 2S 8H 2H 8D JH"
      three_fours = "White: 4S 5H 4C 8S 4H"

      assert PokerPlay.best_hand(eights_and_twos, three_fours) ==
               "White wins - three of a kind"
    end

    test "both hands have three of a kind, tie goes to highest ranked triplet" do
      three_twos = "Black: 2S 2H 2C 8D JH"
      three_aces = "White: 4S AH AS 8C AD"

      assert PokerPlay.best_hand(three_twos, three_aces) ==
               "White wins - high card: Ace"
    end

    test "a straight beats three of a kind" do
      three_fours = "Black: 4S 5H 4C 8D 4H"
      straight = "White: 3S 4D 2S 6D 5C"

      assert PokerPlay.best_hand(three_fours, straight) ==
               "White wins - straight"
    end

    test "flush beats a straight" do
      straight_to_8 = "Black: 4C 6H 7D 8D 5H"
      flush_to_7 = "White: 2S 4S 5S 6S 7S"

      assert PokerPlay.best_hand(straight_to_8, flush_to_7) ==
               "White wins - flush"
    end
  end
end
