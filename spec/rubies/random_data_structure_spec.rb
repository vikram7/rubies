require "spec_helper"
require "faker"

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
      hash = Rubies::MyHash.new
      2.times do |num|
        details = Hash.new
        details["fox"] = "mulder#{num}"
        details["dana"] = "scully#{num}"
        details["phone"] = "123-456-789#{num}"
        details["company"] = "FBI#{num}"
        hash["xfiles#{num}"] = details
      end
      @random_data_structure.data_structure = hash
      values = []
      hash.deep_traverse { |_path, value| values << value }
      expected =
        [
          {
            "fox"=>"mulder1",
            "dana"=>"scully1",
            "phone"=>"123-456-7891",
            "company"=>"FBI1"
          },
          "FBI1",
          "123-456-7891",
          "scully1",
          "mulder1",
          {
            "fox"=>"mulder0",
            "dana"=>"scully0",
            "phone"=>"123-456-7890",
            "company"=>"FBI0"
          },
          "FBI0",
          "123-456-7890",
          "scully0",
          "mulder0"
        ]
      expect(values).to eq(expected)
    end
  end
end

def is_hash_my_hash_or_array(data_structure)
  klass = data_structure.class
  [Hash, Rubies::MyHash, Array].any?(&klass.method(:==))
end
