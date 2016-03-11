require 'spec_helper'

RSpec.describe Player do
  let(:player) { Player.new("Aaron") }

  it 'requires a name' do

    expect(player).to be_a(Player)
    expect(player.name).to eq("Aaron")
  end

  it 'does not require a symbol' do

    expect(player).to be_a(Player)
  end
end
