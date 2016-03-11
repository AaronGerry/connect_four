require 'spec_helper'

RSpec.describe Game do
  let(:game) { Game.new }

  it 'initializes a new board' do
    board = Board.new

    expect(board).to be_a(Board)
  end

  it 'initailizes a new round' do
    round = Round.new

    expect(round).to be_a(Round)
  end

  it 'only allows players with unique names' do
    allow(game).to receive(:gets).and_return("Aaron", "Susan")
    game.user_names

    expect(game.player_1.name).to eq("Aaron")
    expect(game.player_2.name).to eq("Susan")
  end

end
