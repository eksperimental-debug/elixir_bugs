defmodule DocTestLineNumberMissing do
  @doc """
      iex> :this_should_fail
    :this_should_fail
  """
  def this_should_fail, do: :this_should_fail
end