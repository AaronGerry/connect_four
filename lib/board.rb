require_relative 'round'
require_relative 'board_row'
require 'pry'

class Board
  FOOTER = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
  attr_reader :win, :gameboard

  def initialize
    @gameboard = []
    10.times do |row|
      row = BoardRow.new
      10.times do |col|
        row.contents << nil
        #BoardSlot.new()
      end
      @gameboard << row
    end
  end

  def print
    board_printout = ""

    @gameboard.each_with_index do |row, row_index|
      cell = []

      row.contents.each_with_index do |spot, col_index|
        if col_index == 0
          if spot.nil?
            cell << "| "
          else
            cell << "|#{spot}"
          end
        elsif col_index == 9
          if spot.nil?
            cell << " |"
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
    board_printout << self.print_footer
  end

  def print_footer
    board_printout = ""
    cell = []

    FOOTER.each_with_index do |spot, array_index|
      if array_index == 0
        cell << " #{spot}"
      elsif array_index == 9
        cell << "#{spot} "
      else
        cell << spot
      end
    end
    board_printout << cell.join(" ")
    board_printout
  end

  def piece_placement(round_info)
    # binding.pry
    if @gameboard[0].contents[round_info.current_players_move - 1].nil?
      @gameboard[0..9].reverse.each do |row|
        if row.contents[round_info.current_players_move - 1].nil?
          row.contents[round_info.current_players_move - 1] = round_info.current_players_turn
          break
        end
      end
    end
    @gameboard
  end

  def column_full(column)
    full = false
    if @gameboard[0].contents[column - 1] == "X" || @gameboard[0].contents[column - 1] == "O"
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

      @gameboard[0..9].reverse.each do |row|
        if row.contents.each_cons(4).include?(x_winner) || row.contents.each_cons(4).include?(o_winner)
          game_won = true
        end

        # Column winner
        col_array << row.contents[column - 1]
        col_array
          if col_array.each_cons(4).include?(x_winner) || col_array.each_cons(4).include?(o_winner)
            game_won = true
          end

        # Tie
        if @gameboard[9].contents.count(nil) == 0 && @gameboard[0].contents.count(nil) == 0
          game_won = "tie"
        end
      end
    end
    game_won
  end

end
