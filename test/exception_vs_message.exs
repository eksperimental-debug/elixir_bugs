Code.require_file "./test_helper.exs", __DIR__

defmodule FailException.Code.LoadError do
  defexception [:file, :message]

  def exception(opts) do
    file = Keyword.fetch!(opts, :file)
    %FailException.Code.LoadError{message: "could not load #{file}", file: file}
  end
end

defmodule FailMessage.CompileError do
  defexception [:file, :line, description: "compile error"]

  def message(exception) do
    Exception.format_file_line(Path.relative_to_cwd(exception.file), exception.line) <>
      " " <> exception.description
  end
end

defmodule ElixirFail.ExceptionVsMessageTest do
  use ExUnit.Case, async: true

  test "ok: FailException.Code.LoadError" do
    assert_raise FailException.Code.LoadError,
      "could not load test.ex",
      fn -> raise FailException.Code.LoadError, [file: "test.ex"]
    end
  end

  test "ok: FailMessage.CompileError" do
    assert_raise FailMessage.CompileError,
      "test.ex: compile error",
      fn -> raise FailMessage.CompileError, [file: "test.ex"]
    end
  end


  test "error: FailException.Code.LoadError" do
    assert_raise FailException.Code.LoadError,
      ~r{while retrieving Exception.message/1 for},
      fn -> raise FailException.Code.LoadError
    end
  end

  test "error: FailMessage.CompileError" do
    assert_raise FailMessage.CompileError,
      ~r{while retrieving Exception.message/1 for},
      fn -> raise FailMessage.CompileError
    end
  end

end