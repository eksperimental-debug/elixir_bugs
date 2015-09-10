Code.require_file "./test_helper.exs", __DIR__

import ExUnit.TestHelpers

defmodule ExUnit.DocTestTest.FunctionGood do
  @doc """
  iex> foo
  :all_good
  """
  def foo, do: :all_good
end |> write_beam

defmodule ExUnit.DocTestTest.FunctionClash do
  @doc """
  iex> hd(:all_good)
  :all_good
  """
  def hd(msg), do: msg
end |> write_beam


defmodule ElixirFail.DoctestTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "pass: import" do
    defmodule FunctionGoodTest do
      use ExUnit.Case
      doctest ExUnit.DocTestTest.FunctionGood, import: true
    end
    assert capture_io(fn -> ExUnit.run end) =~ "1 test, 0 failures"
  end

  test "pass: function clash" do
    defmodule FunctionClashPass do
      use ExUnit.Case
      import Kernel, except: [hd: 1]
      doctest ExUnit.DocTestTest.FunctionClash, import: true
    end
    assert capture_io(fn -> ExUnit.run end) =~ "1 test, 0 failures"
  end

  test "fail: function clash" do
    assert_raise CompileError, ~r"function hd/1 imported from both ExUnit.DocTestTest.FunctionClash and Kernel, call is ambiguous", fn ->
      defmodule FunctionClashFail do
        use ExUnit.Case
        #import Kernel, except: [hd: 1]
        doctest ExUnit.DocTestTest.FunctionClash, import: true

        setup test do
          assert test.doctest
          :ok
        end
      end
    end
  end

  test "fail: function clash 2" do
    assert_raise CompileError, ~r"function hd/1 imported from both ExUnit.DocTestTest.FunctionClash and Kernel, call is ambiguous", fn ->
      defmodule FunctionClashFail2 do
        import ExUnit.DocTest
        #import Kernel, except: [hd: 1]
        doctest ExUnit.DocTestTest.FunctionClash, import: true
      end
    end
  end
end
