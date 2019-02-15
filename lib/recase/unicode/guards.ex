# The code in this module is mostly gracefully stolen from unicode/properties.ex

data_path = Path.join(__DIR__, "UnicodeData.txt")
special_path = Path.join(__DIR__, "SpecialCasing.txt")

to_binary = fn
  "" ->
    nil

  codepoints ->
    codepoints
    |> :binary.split(" ", [:global])
    |> Enum.map(&<<String.to_integer(&1, 16)::utf8>>)
    |> IO.iodata_to_binary()
end

rangify = fn [head | tail] ->
  {first, last, acc} =
    Enum.reduce(tail, {head, head, []}, fn
      number, {first, last, acc} when number == first - 1 ->
        {number, last, acc}

      number, {first, last, acc} ->
        {number, number, [{first, last} | acc]}
    end)

  [{first, last} | acc]
end

# The categories are computed later.
case_ignorable = [
  0x0027,
  0x002E,
  0x2018,
  0x2019,
  0x2024,
  0xFE52,
  0xFF07,
  0xFF0E,
  0x00B7,
  0x0387,
  0x05F4,
  0x2027,
  0x003A,
  0xFE13,
  0xFE55,
  0xFF1A
]

acc = {[], [], case_ignorable, [], %{}, %{}}
cased_letter_categories = :binary.compile_pattern(["Ll", "Lt", "Lu"])
case_ignorable_categories = :binary.compile_pattern(["Mn", "Me", "Cf", "Lm", "Sk"])

{codes, cased_letters, case_ignorable, non_breakable, decompositions, combining_classes} =
  Enum.reduce(File.stream!(data_path), acc, fn line, {cacc, lacc, iacc, wacc, dacc, kacc} ->
    [
      codepoint,
      _name,
      category,
      class,
      _bidi,
      decomposition,
      _numeric_1,
      _numeric_2,
      _numeric_3,
      _bidi_mirror,
      _unicode_1,
      _iso,
      upper,
      lower,
      title
    ] = :binary.split(line, ";", [:global])

    title = binary_part(title, 0, byte_size(title) - 1)

    cacc =
      if upper != "" or lower != "" or title != "" do
        [{to_binary.(codepoint), to_binary.(upper), to_binary.(lower), to_binary.(title)} | cacc]
      else
        cacc
      end

    cased_letter_categories = :binary.compile_pattern(["Ll", "Lt", "Lu"])
    case_ignorable_categories = :binary.compile_pattern(["Mn", "Me", "Cf", "Lm", "Sk"])

    {lacc, iacc} =
      cond do
        match?({0, _}, :binary.match(category, cased_letter_categories)) ->
          {[String.to_integer(codepoint, 16) | lacc], iacc}

        match?({0, _}, :binary.match(category, case_ignorable_categories)) ->
          {lacc, [String.to_integer(codepoint, 16) | iacc]}

        true ->
          {lacc, iacc}
      end

    wacc =
      case decomposition do
        "<noBreak>" <> _ -> [to_binary.(codepoint) | wacc]
        _ -> wacc
      end

    dacc =
      case decomposition do
        # Decomposition
        <<h, _::binary>> when h != ?< ->
          decomposition =
            decomposition
            |> :binary.split(" ", [:global])
            |> Enum.map(&String.to_integer(&1, 16))

          Map.put(dacc, String.to_integer(codepoint, 16), decomposition)

        _ ->
          dacc
      end

    kacc =
      case Integer.parse(class) do
        {0, ""} -> kacc
        {n, ""} -> Map.put(kacc, String.to_integer(codepoint, 16), n)
      end

    {cacc, lacc, iacc, wacc, dacc, kacc}
  end)

codes =
  Enum.reduce(File.stream!(special_path), codes, fn line, acc ->
    if String.starts_with?(line, ["#", "\n"]) do
      acc
    else
      [codepoint, lower, title, upper, _] = :binary.split(line, "; ", [:global])
      key = to_binary.(codepoint)

      :lists.keystore(
        key,
        1,
        acc,
        {key, to_binary.(upper), to_binary.(lower), to_binary.(title)}
      )
    end
  end)

# Guards

[lowers, uppers] =
  codes
  |> Enum.reduce([[], []], fn
    {_codepoint, upper, lower, _title}, [lowers, uppers] ->
      [[lower | lowers], [upper | uppers]]
  end)
  |> Enum.map(&MapSet.new/1)
  |> Enum.map(&MapSet.delete(&1, nil))
  |> Enum.map(&MapSet.to_list/1)

[casing_lower, casing_upper] = [lowers, uppers]

[lowers, uppers] =
  [lowers, uppers]
  |> Enum.map(&Enum.chunk_every(&1, 700))
  |> Enum.map(fn chunks ->
    for chunk <- chunks do
      {:in, [context: Elixir, import: Kernel], [{:value, [], nil}, chunk]}
    end
  end)

defmodule Recase.Guards do
  @moduledoc """
  Declares guards to be used for fast string parsing.
  """
  @doc "Returns `:lower | :upper | :not_a_letter` for a codepoint"
  @spec casing(codepoint :: non_neg_integer()) :: :lower | :upper | :not_a_letter
  Enum.each(casing_lower, fn letter ->
    def casing(unquote(letter)), do: :lower
  end)

  Enum.map(casing_upper, fn letter ->
    def casing(unquote(letter)), do: :upper
  end)

  def casing(_), do: :not_a_letter

  @doc "Checks if the codepoint is a lowercased Unicode letter"
  defguard is_lowercase(value) when unquote({:or, [context: Elixir, import: Kernel], lowers})
  @doc "Checks if the codepoint is a uppercased Unicode letter"
  defguard is_uppercase(value) when unquote({:or, [context: Elixir, import: Kernel], uppers})
end
