# frozen_string_literal: true

require "connect_four"

describe ConnectFour::Board do
  let(:board) { ConnectFour::Board.new }

  describe "#place_token" do
    context "when the move is legal" do
      it "updates the right column of the board" do
        column = 1
        color = ConnectFour::Color::YELLOW

        board.place_token(column, color)

        expect(board.board[column - 1][0]).to eql(color)
      end
    end

    context "when the move is illegal" do
      it "fails if the column is full" do
        column = 1
        color = ConnectFour::Color::YELLOW
        ConnectFour::Board::N_ROWS.times { board.place_token(column, color) }

        expect do
          board.place_token(column, color)
        end.to raise_error(ConnectFour::IllegalMoveError, "Column #{column} is full")
      end

      it "fails if the column is invalid" do
        column = ConnectFour::Board::N_COLUMNS + 1
        color = ConnectFour::Color::YELLOW

        expect do
          board.place_token(column, color)
        end.to raise_error(ConnectFour::IllegalMoveError, "Column #{column} is outside the board")
      end
    end
  end
end
