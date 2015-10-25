Code.require_file "test_helper.exs", __DIR__

defmodule DocTestLineNumberMissingTest do
  use ExUnit.Case, async: true
  doctest DocTestLineNumberMissing, import: true
end