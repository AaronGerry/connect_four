require 'spec_helper'

describe BoardRow do

  it 'is an array' do
    new_row = BoardRow.new

    expect(new_row.contents.class).to be(Array)
  end

end
