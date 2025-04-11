defmodule Colors do
  def start() do
    Termite.Terminal.start()
    |> draw()
  end

  defp newline(str, i, i), do: str <> "\n"
  defp newline(str, _i, _limit), do: str

  defp color_block(foreground, background, padding \\ 3) do
    Termite.Style.ansi256()
    |> Termite.Style.background(background)
    |> Termite.Style.foreground(foreground)
    |> Termite.Style.render_to_string(
      " #{String.pad_leading(to_string(background), padding, " ")}   "
    )
  end

  def draw(term) do
    str = Termite.Style.bold() |> Termite.Style.render_to_string("Basic ANSI Colors\n")
    term = Termite.Screen.write(term, str)

    term =
      Enum.reduce(0..15, term, fn i, acc ->
        foreground = if i < 5, do: 7, else: 0
        str = color_block(foreground, i, 2)
        Termite.Screen.write(acc, newline(str, i, 7))
      end)

    str = Termite.Style.bold() |> Termite.Style.render_to_string("\n\nExtended ANSI Colors\n")
    term = Termite.Screen.write(term, str)

    term =
      Enum.reduce(16..231, term, fn i, acc ->
        foreground = if i < 28, do: 7, else: 0
        str = color_block(foreground, i)
        Termite.Screen.write(acc, newline(str, rem(i - 16, 6), 5))
      end)

    str = Termite.Style.bold() |> Termite.Style.render_to_string("\n\Extended ANSI Grayscale\n")
    term = Termite.Screen.write(term, str)

    term =
      Enum.reduce(232..255, term, fn i, acc ->
        foreground = if i < 244, do: 7, else: 0
        str = color_block(foreground, i)
        Termite.Screen.write(acc, newline(str, rem(i - 232, 6), 5))
      end)

    Termite.Screen.write(term, "\n")
  end
end

Colors.start()
