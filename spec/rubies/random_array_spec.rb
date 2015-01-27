require 'spec_helper'

module Rubies
  describe RandomArray do

    before do
      @array = Rubies::RandomArray.new
    end

    it "generates" do
      Rubies::RandomArray.new.generate
    end

  end
end
