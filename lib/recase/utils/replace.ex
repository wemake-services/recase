defmodule Recase.Replace do
  @moduledoc """
  Helper module to pipe and replace values easily.
  """

  @doc """
  Replaces `value` if it matches `regex` with `new_value`.

  Standard `Regex.replace/3` accepts `value` to replace
  as the second argument. Which is not quite convenient to
  use in pipes.

  This function accepts `value` as the first argument and
  then passes it to `Regex.replace/3` as the second one.
  """
  @spec replace(String.t(), Regex.t(), String.t() | (... -> String.t())) ::
          String.t()
  def replace(value, regex, new_value) do
    Regex.replace(regex, value, new_value)
  end
end
