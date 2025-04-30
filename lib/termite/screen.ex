defmodule Termite.Screen do
  @moduledoc """
  This module handles terminal related escape sequences.
  See the source for valid escape sequences.
  """

  defp seq(:cursor_up, [n]), do: "#{n}A"
  defp seq(:cursor_down, [n]), do: "#{n}B"
  defp seq(:cursor_forward, [n]), do: "#{n}C"
  defp seq(:cursor_back, [n]), do: "#{n}D"
  defp seq(:cursor_next_line, [n]), do: "#{n}E"
  defp seq(:cursor_previous_line, [n]), do: "#{n}F"
  defp seq(:cursor_move, [y, x]), do: "#{x};#{y}H"

  defp seq(:screen_clear, []), do: "2J"

  defp seq(:screen_alt, []), do: "?1049h"
  defp seq(:screen_alt_exit, []), do: "?1049l"

  defp seq(:cursor_show, []), do: "?25h"
  defp seq(:cursor_hide, []), do: "?25l"

  @doc """
  Return the escape code for the terminal.

  ```elixir
  iex> Termite.Screen.escape_code()
  "\e["
  ```
  """
  def escape_code() do
    "\x1b["
  end

  @doc """
  Return an escape sequence.

  ```elixir
  iex> Termite.Screen.escape_sequence(:cursor_back, [3])
  "\e[3D"
  ```
  """
  def escape_sequence(command, args \\ []) do
    escape_code() <> seq(command, args)
  end

  @doc """
  Write an escape sequence to the terminal.
  """
  def run_escape_sequence(term, command, args \\ []) do
    write(term, escape_sequence(command, args))
  end

  @doc """
  Move the cursor up by n lines.
  """
  def cursor_up(term, n \\ 1) do
    run_escape_sequence(term, :cursor_up, [n])
  end

  @doc """
  Move the cursor down by n lines.
  """
  def cursor_down(term, n \\ 1) do
    run_escape_sequence(term, :cursor_down, [n])
  end

  @doc """
  Move the cursor forward by n cells.
  """
  def cursor_forward(term, n \\ 1) do
    run_escape_sequence(term, :cursor_forward, [n])
  end

  @doc """
  Move the cursor back by n cells.
  """
  def cursor_back(term, n \\ 1) do
    run_escape_sequence(term, :cursor_back, [n])
  end

  @doc """
  Move the cursor down by n lines and place cursor at the beginning of the line.
  """
  def cursor_next_line(term, n \\ 1) do
    run_escape_sequence(term, :cursor_next_line, [n])
  end

  @doc """
  Move the cursor up by n lines and place cursor at the beginning of the line.
  """
  def cursor_previous_line(term, n \\ 1) do
    run_escape_sequence(term, :cursor_previous_line, [n])
  end

  @doc """
  Set the cursor position to x,y.
  """
  def cursor_position(term, x, y) do
    run_escape_sequence(term, :cursor_move, [x, y])
  end

  @doc """
  Show the cursor.
  """
  def show_cursor(term) do
    run_escape_sequence(term, :cursor_show, [])
  end

  @doc """
  Hide the cursor.
  """
  def hide_cursor(term) do
    run_escape_sequence(term, :cursor_hide, [])
  end

  @doc """
  Clears the screen.
  """
  def clear_screen(term) do
    run_escape_sequence(term, :screen_clear, [])
  end

  @doc """
  Switch to alt screen.
  """
  def alt_screen(term) do
    run_escape_sequence(term, :screen_alt, [])
  end

  @doc """
  Exit to alt screen.
  """
  def exit_alt_screen(term) do
    run_escape_sequence(term, :screen_alt_exit, [])
  end

  defdelegate write(term, str), to: Termite.Terminal
end
