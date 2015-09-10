defmodule DocRedefined do

  @moduledoc """
  ElixirBug module.
  """

  @moduledoc """
  @moduledoc is being redefined without warning.
  """

  @doc """
  Returns `:avocado` no matter what.
  """

  @doc """
  @doc is being redefined without warning.
  """
  def get_fruit do
    :avocado
  end
end

defmodule Mix.Tasks.DocRedefined do
  use Mix.Task

  @shortdoc """
  Returns favourite fruit.
  """

  @shortdoc """
  @shortdoc is being redefined without warning.
  """
  def run(_) do
    IO.inspect DocRedefined.get_fruit
  end
end
