require 'spec_helper'

RSpec.describe Round do
  let(:round) { Round.new }
  let(:board) { Board.new }
  let(:player_1) { Player.new("Aaron") }
  let(:player_2) { Player.new("Susan") }

  it 'creates players for the game' do

    expect(round.player_1).to be_nil
    expect(round.player_2).to be_nil
  end

  it 'associates unique symbols to players' do
    round.sort(player_1, player_2)

    expect(player_1.symbol).not_to be_nil
    expect(player_2.symbol).not_to be_nil
    expect(player_1.symbol).not_to eq(player_2.symbol)
  end


  it 'asks player where to put piece' do
    round.sort(player_1, player_2)
    round.move(player_1, player_2)
    allow(round).to receive(:gets).and_return("5")

    expect(round.user_selection(player_1, player_2)).to_not be_nil
    expect(round.user_selection(player_1, player_2)).to eq(5)
  end

  it 'only accepts column numbers 1-10' do
    allow(round).to receive(:gets).and_return("11")

    expect{ round.user_selection(player_1, player_2) }.to output("#{player_1.name} what column would you like to drop a piece in? (1-10): That's not a valid column!\n").to_stdout
  end

  describe '#move' do

    it 'starts the game with x player' do
      board
      round.sort(player_1, player_2)
      allow(round).to receive(:gets).and_return("5")
      round.move(player_1, player_2)

      expect(round.current_players_turn).to eq("X")
    end

    it 'accepts column information to play player\'s move' do
      board
      round.sort(player_1, player_2)
      allow(round).to receive(:gets).and_return("5")
      round.user_selection(player_1, player_2)
      round.move(player_1, player_2)

      expect(round.current_players_move).to eq(5)
    end

    it 'switches between player 1 and player 2 turn' do
      board
      round.sort(player_1, player_2)
      allow(round).to receive(:gets).and_return("5")
      round.user_selection(player_1, player_2)
      round.move(player_1, player_2)

      round_1 = round.current_players_turn
      round.move(player_1, player_2)
      round_2 = round.current_players_turn

      expect(round_1).to_not eq(round_2)
    end
  end

end
