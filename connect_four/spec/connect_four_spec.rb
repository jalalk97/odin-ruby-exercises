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

  describe "#win?" do
    describe "#win_on_column?" do
      it "returns true if there are #{ConnectFour::Board::NUMBER_TO_WIN} tokens of the same color on any column" do
        column = 1
        color = ConnectFour::Color::YELLOW

        board.place_token(column, ConnectFour::Color::RED)
        ConnectFour::Board::NUMBER_TO_WIN.times { board.place_token(column, color) }

        expect(board.send(:win_on_column?, color)).to be true
      end

      it "returns false if no column contains #{ConnectFour::Board::NUMBER_TO_WIN} tokens of the same color" do
        column = 1
        color = ConnectFour::Color::YELLOW

        board.place_token(column, ConnectFour::Color::RED)
        (ConnectFour::Board::NUMBER_TO_WIN - 1).times { board.place_token(column, color) }

        expect(board.send(:win_on_column?, color)).to be false
      end
    end

    describe "#win_on_row?" do
      it "returns true if there are #{ConnectFour::Board::NUMBER_TO_WIN} tokens of the same color on any row" do
        first_column = 1
        color = ConnectFour::Color::YELLOW

        board.place_token(first_column, ConnectFour::Color::RED)
        (first_column + 1).upto(first_column + ConnectFour::Board::NUMBER_TO_WIN) do |column|
          board.place_token(column, color)
        end

        expect(board.send(:win_on_row?, color)).to be true
      end

      it "returns false if no row contains #{ConnectFour::Board::NUMBER_TO_WIN} tokens of the same color" do
        first_column = 1
        color = ConnectFour::Color::YELLOW

        board.place_token(first_column, ConnectFour::Color::RED)
        (first_column + 1).upto(first_column + ConnectFour::Board::NUMBER_TO_WIN - 1) do |column|
          board.place_token(column, color)
        end

        expect(board.send(:win_on_row?, color)).to be false
      end
    end

    describe "#win_on_main_diagonal?" do
      it "returns true if there are #{ConnectFour::Board::NUMBER_TO_WIN} yellow tokens anywhere along the main " \
          "diagonal direction" do
        color = ConnectFour::Color::YELLOW

        1.upto(ConnectFour::Board::NUMBER_TO_WIN) do |column|
          column.times { board.place_token(column, color) }
        end

        expect(board.send(:win_on_main_diagonal?, color)).to be true
      end

      it "returns false if there are never #{ConnectFour::Board::NUMBER_TO_WIN} yellow tokens anywhere along the " \
          "main diagonal direction" do
        color = ConnectFour::Color::YELLOW

        1.upto(ConnectFour::Board::NUMBER_TO_WIN) do |column|
          (column - 1).times { board.place_token(column, color) }
          board.place_token(column, ConnectFour::Color::RED)
        end

        expect(board.send(:win_on_main_diagonal?, color)).to be false
      end
    end

    describe "#win_on_secondary_diagonal?" do
      it "returns true if there are #{ConnectFour::Board::NUMBER_TO_WIN} yellow tokens anywhere along the secondary " \
          "diagonal direction" do
        color = ConnectFour::Color::YELLOW

        1.upto(ConnectFour::Board::NUMBER_TO_WIN) do |column|
          (ConnectFour::Board::NUMBER_TO_WIN - column + 1).times { board.place_token(column, color) }
        end

        expect(board.send(:win_on_secondary_diagonal?, color)).to be true
      end

      it "returns false if there are never #{ConnectFour::Board::NUMBER_TO_WIN} yellow tokens anywhere along the " \
        "secondary diagonal direction" do
        color = ConnectFour::Color::YELLOW

        1.upto(ConnectFour::Board::NUMBER_TO_WIN) do |column|
          (ConnectFour::Board::NUMBER_TO_WIN - column).times { board.place_token(column, color) }
          board.place_token(column, ConnectFour::Color::RED)
        end

        expect(board.send(:win_on_secondary_diagonal?, color)).to be false
      end
    end
  end
end
