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
  end
end
