Code.require_file "./test_helper.exs", __DIR__

defmodule ElixirBugs.ExUnitNoMatchMessagePinOperator do
  use ExUnit.Case

  test "ExUnit.assert_receive/3: match pinned variables" do
    fruits = "Apples and Pears"
    send self, fruits
    assert_receive ^fruits
    assert_receive ^fruits
  end

  test "ExUnit.asssert_received/2: match pinned variables" do
    fruits = "Apples and Pears"
    send self, fruits
    assert_received ^fruits
    assert_received ^fruits
  end
end