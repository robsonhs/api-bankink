defmodule ApiBankingTest do
  use ExUnit.Case
  doctest ApiBanking

  test "greets the world" do
    assert ApiBanking.hello() == :world
  end
end
