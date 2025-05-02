dot_count = 10
string = String.duplicate(".", 10) <> "🪳"

clear = fn terminal ->
  terminal
  |> tap(fn _ -> :timer.sleep(1000) end)
  |> Termite.Screen.cursor_back(3)
  |> Termite.Screen.delete_chars()
end

terminal =
  Termite.Terminal.start()
  |> Termite.Terminal.write(string)
  |> Termite.Screen.hide_cursor()
  |> Termite.Screen.cursor_back(2)

terminal = Enum.reduce(1..dot_count, terminal, fn _, term -> clear.(term) end)

Termite.Screen.show_cursor(terminal)
