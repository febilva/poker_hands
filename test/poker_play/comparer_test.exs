defmodule PokerPlay.ComparerTest do
  use ExUnit.Case
  alias PokerPlay.Comparer

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
