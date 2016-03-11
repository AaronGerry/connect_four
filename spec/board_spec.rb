require 'spec_helper'

RSpec.describe Board do
  let(:round) { Round.new }
  let(:board) { Board.new }
  let(:player_1) { Player.new("Aaron") }
  let(:player_2) { Player.new("Susan") }

  it 'creates a board with 10 rows and 10 columns' do

    expect(board.rows.size).to eq(11)
    expect(board.rows[0].size).to eq(10)
  end

  it 'has a footer that lists the column names' do
    footer = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    # " A B C D E F G H I J "

    expect(board.rows.last).to eq(footer)
  end

  it 'prints the board to the terminal' do
    board_printout =
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    " A B C D E F G H I J \n"

    expect(board.print).to eq(board_printout)
  end

  it 'prints out player X selection' do
    board_printout =
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|        X          |\n" +
    " A B C D E F G H I J \n"

    round.sort(player_1, player_2)
    allow(round).to receive(:gets).and_return("5")
    current_player_turn = round.user_selection(player_1, player_2)
    column_placement = round.move(player_1, player_2)

    expect(board.piece_placement(column_placement, current_player_turn)).to eq(board_printout)
  end

  it 'prints out player X selection in the next row up' do
    board_printout =
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|                   |\n" +
    "|        X          |\n" +
    "|        X          |\n" +
    " A B C D E F G H I J \n"

    round.sort(player_1, player_2)
    allow(round).to receive(:gets).and_return("5")
    current_player_turn = round.user_selection(player_1, player_2)
    column_placement = round.move(player_1, player_2)
    board.piece_placement(column_placement, current_player_turn)

    expect(board.piece_placement(column_placement, current_player_turn)).to eq(board_printout)
  end
#
#   it 'tells you when the column is full' do
#     round.sort(player_1, player_2)
#     allow(round).to receive(:gets).and_return("5")
#     current_turn = round.user_selection(player_1, player_2)
#     current_move = round.move(player_1, player_2)
#
# # binding.pry
#     expect{ board.piece_placement(current_move, current_turn) }.to output("Column is full!\n").to_stdout
#   end

  it 'tells you when the column is full' do
    board_printout =
    "|        X          |\n" +
    "|        X          |\n" +
    "|        X          |\n" +
    "|        X          |\n" +
    "|        X          |\n" +
    "|        X          |\n" +
    "|        X          |\n" +
    "|        X          |\n" +
    "|        X          |\n" +
    "|        X          |\n" +
    " A B C D E F G H I J \n"

    round.sort(player_1, player_2)
    allow(round).to receive(:gets).and_return("5")
    current_player_turn = round.user_selection(player_1, player_2)
    column_placement = round.move(player_1, player_2)
    9.times do |round|
      board.piece_placement(column_placement, current_player_turn)
    end

    expect(board.piece_placement(column_placement, current_player_turn)).to eq(board_printout)
  end

  it 'tells you when the column is full' do
    round.sort(player_1, player_2)
    allow(round).to receive(:gets).and_return("5")
    current_turn = round.user_selection(player_1, player_2)
    current_move = round.move(player_1, player_2)
    1.times do |round|
      board.piece_placement(current_move, current_turn)
    end

    expect{ board.piece_placement(current_move, current_turn) }.to output("Column is full!\n").to_stdout
  end

  # it 'prints out player O selection'

  # it '#piece_placement: prints out player selection'

end
