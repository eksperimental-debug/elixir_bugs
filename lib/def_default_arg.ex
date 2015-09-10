defmodule DefDefaultArg do
  @spec sample(integer, atom, String.t) :: :atom | tuple
  def sample(a, b, c)

  def sample(1, _, _), do: :one
  def sample(2, _, _), do: :two

  def sample(aaa, bbb, ccc)
  def sample(alpha, beta, gama), do: {alpha, beta, gama}
end

defmodule DefDefaultArg2 do
  @spec sample(integer, atom, String.t) :: :atom | tuple
  def sample(a, b, c)
  def sample(1, _, _), do: :one
  def sample(2, _, _), do: :two

  def sample(a, b, c)
  def sample(a, b, c), do: {a, b, c}
end


DefDefaultArg.sample(1, :one, "One") |> IO.inspect
DefDefaultArg.sample(2, :two, "Two") |> IO.inspect
DefDefaultArg.sample(3, :three, "Three") |> IO.inspect