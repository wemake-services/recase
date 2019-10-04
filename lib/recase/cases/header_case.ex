defmodule Recase.HeaderCase do
  @moduledoc """
  Module to convert strings to `Header-Case`.

  This module should not be used directly.

  ## Examples

      iex> Recase.to_header "foo_barBaz-λambdaΛambda-привет-Мир"
      "Foo-Bar-Baz-Λambda-Λambda-Привет-Мир"

  Header case is the case suggested in [section 3.4.7 of RFC 822]
  (https://tools.ietf.org/html/rfc822#section-3.4.7) to be used
  in the message-creation process.
  """

  import Recase.Generic, only: [rejoin: 2]

  @sep "-"

  @spec convert(String.t()) :: String.t()
  def convert(value) when is_binary(value),
    do: rejoin(value, separator: @sep, case: :title)
end
