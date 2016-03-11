require_relative 'round'
require 'pry'

class Board
  FOOTER =  ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
  attr_reader :win

  def initialize
    @board = []
    # build_board
    10.times do |row|
      # row = BoardRow.new()
      row = []
      10.times do |col|
        # binding.pry
        row << nil
        #BoardSlot.new()
      end
      @board << row
    end
    @board << FOOTER
  end

  def print
    board_printout = ""
    @board.each_with_index do |row, row_index|
      cell = []
      row.each_with_index do |spot, col_index|
        if col_index == 0
          if spot.nil?
            cell << "| "
          elsif FOOTER.include?(spot)
            cell << " #{spot}"
          else
            cell << "|#{spot}"
          end
        elsif col_index == 9
          if spot.nil?
            cell << " |"
          elsif FOOTER.include?(spot)
            cell << "#{spot}"
          else
            cell << "#{spot}|"
          end
        elsif spot.nil?
          cell << " "
        else
          cell << spot
        end
      end
      board_printout << cell.join(" ") + "\n"
    end
    board_printout
  end

  def piece_placement(round_info)
    if @board[0][round_info.current_players_move - 1].nil?
      @board[0..9].reverse.each do |row|
        if row[round_info.current_players_move - 1].nil?
          row[round_info.current_players_move - 1] = round_info.current_players_turn
          break
        end
      end
    end
    @board
  end

  def column_full(column)
    full = false
    if @board[0][column - 1] == "X" || @board[0][column - 1] == "O"
      full = true
    end
    full
  end

  def win(column)

    game_won = false

    col_array = []
    x_winner = ["X", "X", "X", "X"]
    o_winner = ["O", "O", "O", "O"]

    if game_won == false
      # Row winner
      @board[0..9].reverse.each do |row|
        if row.each_cons(4).include?(x_winner) || row.each_cons(4).include?(o_winner)
          game_won = true
        end

        # Column winner
        col_array << row[column - 1]
        col_array
          if col_array.each_cons(4).include?(x_winner) || col_array.each_cons(4).include?(o_winner)
            game_won = true
          end

        # Tie
        if @board[9].count(nil) == 0 && @board[0].count(nil) == 0
          game_won = "tie"
        end
      end
    end
    game_won
  end

end
