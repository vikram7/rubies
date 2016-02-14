require "spec_helper"

module Rubies
  describe RandomDataStructure do
    before do
      @random_data_structure = Rubies::RandomDataStructure.new
    end

    it "initializer variable data_structure is []" do
      expect(@random_data_structure.data_structure).to eq([])
    end

    it "initializer variable all_values is []" do
      expect(@random_data_structure.all_values).to eq([])
    end

    it "#generate sets data_structure" do
      expect(@random_data_structure.data_structure).to eq([])
      @random_data_structure.generate
      expect(@random_data_structure.data_structure).to_not eq([])
    end

    it "#generate sets data_structure to Hash, MyHash or Array" do
      @random_data_structure.generate
      data_structure = @random_data_structure.data_structure
      expected = is_hash_my_hash_or_array(data_structure)
      expect(expected).to eq(true)
    end

    it "#all_values returns an array" do
      @random_data_structure.generate
      expect(@random_data_structure.all_values).to be_instance_of(Array)
    end

    it "#all_values returns expected array for Array" do
      @random_data_structure.data_structure = [1, 2, [3, 4], [5, [6]]]
      expect(@random_data_structure.all_values).to eq([1, 2, 3, 4, 5, 6])
    end

    it "#all_values returns Array of values for Hash" do
      @random_data_structure.data_structure = {
        a: 1,
        b: 2,
        c: 3,
        d: 4,
        e: 5,
        f: 6
      }
      expect(@random_data_structure.all_values).to eq([1, 2, 3, 4, 5, 6])
    end

    it "#all_values returns expected array for MyHash" do
      # pending
    end
  end
end

def is_hash_my_hash_or_array(data_structure)
  klass = data_structure.class
  [Hash, Rubies::MyHash, Array].any?(&klass.method(:==))
end
