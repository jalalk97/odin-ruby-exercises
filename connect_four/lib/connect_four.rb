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

    def to_s
      width = 2 * N_COLUMNS - 1

      border = Utils.add_border("=" * (width + 2), padding_amount: 0)
      title = Utils.add_border("CONNECT  FOUR".center(width))
      content = pretty_string
      labels = Utils.add_border((1..N_COLUMNS).to_a.join(" "))

      [border, title, border, content, border, labels, border].join("\n")
    end

    private

    attr_accessor :column_levels

    def pretty_string
      blank_circle = "\u25cb"
      circle = "\u25cf"
      colors = { Color::YELLOW => circle.yellow, Color::RED => circle.red, nil => blank_circle }

      board.transpose.reverse.map do |line|
        Utils.add_border(line.map { |cell| colors[cell] }.join(" "))
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

  # Represents a Connect Four human player. A Player has a name and a chosen symbol that is used to when making moves a
  # Board
  class Player
    attr_reader :name, :color

    def initialize(name, color)
      @name = name
      @color = color
    end

    def to_s
      circle = "\u25cf"
      colored_circle = color == Color::YELLOW ? circle.yellow : circle.red
      "#{colored_circle} #{name}"
    end
  end

  # Encapsulates the state of a game of Connect Four and acts as an abstraction layer over an instance of Board
  class GameState
    attr_reader :players, :board, :turn, :score

    def initialize(players)
      reset_board_and_players(players)
      @score = [0, 0]
    end

    def reset_board
      @board = Board.new
      @turn = 0
    end

    def reset_board_and_players(players)
      @players = players
      reset_board
    end

    def current_player
      players[turn % 2]
    end

    def make_move(column)
      board.place_token(column, current_player.color)
      @turn += 1
    end

    def game_over?
      board.board_full? || [Color::YELLOW, Color::RED].any? { |color| board.win?(color) }
    end

    def winner
      players.find { |player| board.win?(player.color) }
    end

    def update_score
      index = players.find_index(&winner.method(:===))
      score[index] += 1
    end

    def to_s
      "#{board.to_s.split("\n").zip(score_board_content).map(&:join).join("\n")}\n\n"
    end

    private

    FORMATTING_OPTIONS = {
      margin_amount: 4,
      line_width: 20
    }.freeze

    def score_board_content
      [
        border,
        format_line("Turn: #{turn + 1}"),
        border,
        format_line("Score:"),
        *2.times.map { |i| format_player_score(i) },
        border
      ]
    end

    def format_line(line, line_width: FORMATTING_OPTIONS[:line_width], **kwargs)
      Utils.add_border(line.ljust(line_width), margin_amount: FORMATTING_OPTIONS[:margin_amount], **kwargs)
    end

    def border
      format_line("=" * FORMATTING_OPTIONS[:line_width], padding_char: "=")
    end

    def format_player_score(player_number)
      line_width = FORMATTING_OPTIONS[:line_width] + 14
      format_line("#{players[player_number]}: #{score[player_number]}", line_width: line_width)
    end
  end

  # Utility methods
  module Utils
    def self.add_border(line, padding_amount: 1, padding_char: " ", margin_amount: 0, margin_char: " ")
      padding = padding_char * padding_amount
      margin = margin_char * margin_amount
      "#{margin}|#{padding}#{line}#{padding}|"
    end

    def self.clear_screen
      system("clear") || system("cls")
    end
  end
end
