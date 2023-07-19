# frozen_string_literal: true

require "colorize"

# Encapsulates all of the Connect Four game rules, logic and gameplay
module ConnectFour
  class IllegalMoveError < StandardError
  end

  module Color
    YELLOW = 0
    RED = 1
  end

  # Represents a Connect Four board
  class Board
    N_ROWS = 6
    N_COLUMNS = 7
    NUMBER_TO_WIN = 4

    attr_reader :board

    def initialize
      @board = Array.new(N_COLUMNS) { Array.new(N_ROWS) }
      @column_levels = Array.new(N_COLUMNS, 0)
    end

    def place_token(column, color)
      columns_index = column - 1

      raise IllegalMoveError, "Column #{column} is outside the board" unless column.between?(1, N_COLUMNS)
      raise IllegalMoveError, "Column #{column} is full" unless column_levels[columns_index] < N_ROWS

      board[columns_index][column_levels[columns_index]] = color
      column_levels[columns_index] += 1
    end

    def win?(color)
      [win_on_row?(color), win_on_column?(color), win_on_main_diagonal?(color), win_on_secondary_diagonal?(color)].any?
    end

    def board_full?
      board.flatten.count(nil).zero?
    end

    def game_over?
      board_full? || [Color::YELLOW, Color::RED].any? { |color| win?(color) }
    end

    def to_s
      width = 2 * N_COLUMNS - 1

      border = add_border("=" * (width + 2), 0)
      title = add_border("CONNECT  FOUR".center(width))
      content = pretty_string
      labels = add_border((1..N_COLUMNS).to_a.join(" "))

      [border, title, border, content, border, labels, border].join("\n")
    end

    private

    attr_accessor :column_levels

    def add_border(line, padding_amount = 1)
      padding = " " * padding_amount
      "|#{padding}#{line}#{padding}|"
    end

    def pretty_string
      blank_circle = "\u25cb"
      circle = "\u25cf"
      colors = { Color::YELLOW => circle.yellow, Color::RED => circle.red, nil => blank_circle }

      board.transpose.reverse.map do |line|
        add_border(line.map { |cell| colors[cell] }.join(" "))
      end.join("\n")
    end

    def win_on_line?(line, color)
      (line.length - NUMBER_TO_WIN + 1).times do |i|
        return true if line[i, NUMBER_TO_WIN].all?(&color.method(:==))
      end
      false
    end

    def win_on_column?(color)
      board.any? { |column| win_on_line?(column, color) }
    end

    def win_on_row?(color)
      board.transpose.any? { |row| win_on_line?(row, color) }
    end

    def win_on_main_diagonal?(color)
      (N_COLUMNS - NUMBER_TO_WIN + 1).times do |j|
        (N_ROWS - NUMBER_TO_WIN + 1).times do |i|
          line = NUMBER_TO_WIN.times.map { |k| board[j + k][i + k] }
          return true if win_on_line?(line, color)
        end
      end
      false
    end

    def win_on_secondary_diagonal?(color)
      (N_COLUMNS - NUMBER_TO_WIN + 1).times do |j|
        (N_ROWS - 1).downto(NUMBER_TO_WIN - 1) do |i|
          line = NUMBER_TO_WIN.times.map { |k| board[j + k][i - k] }
          return true if win_on_line?(line, color)
        end
      end
      false
    end
  end
end