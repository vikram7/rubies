require 'spec_helper'

module Rubies
  describe RandomArray do

    before do
      @random_array = Rubies::RandomArray.new
    end

    it "generates" do
      Rubies::RandomArray.new.generate
    end

    it "#mini_array returns three elements" do
      expect(@random_array.mini_array.size).to eq(3)
    end

    it "#mini_array returns three numbers" do
      array = @random_array.mini_array.map(&:class)
      expect(array.uniq.first).to eq(Fixnum)
    end

    it "#nesting_array returns an array" do
      array = @random_array.nesting_array
      expect(array).to be_instance_of(Array)
    end

    it "#nesting_array returns array with Fixnum only elements" do
      array = @random_array.nesting_array.flatten.map(&:class).uniq
      expect(array).to eq([Fixnum])
    end
  end
end
