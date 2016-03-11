require_relative 'game'

class Player
  attr_reader :name
  attr_accessor :symbol

  def initialize(name, symbol = nil)
    @name = name
    @symbol = symbol
  end
end
