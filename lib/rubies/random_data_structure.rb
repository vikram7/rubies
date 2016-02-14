require_relative 'random_array'
require_relative 'random_hash'
require 'faker'

module Rubies
  class RandomDataStructure
    attr_accessor :data_structure

    def initialize
      @data_structure = []
      @all_values = []
    end

    def generate
      combo = Array.new
      rand(1..3).times do
        combo << RandomHash.new.hash_three
      end
      random_hash = RandomHash.new.generate
      random_array = RandomArray.new.generate
      @data_structure = [combo, random_hash, random_array].sample
    end

    def all_values
      values = Array.new
      if @data_structure.is_a? Hash
        values = @data_structure.values
      elsif @data_structure.flatten.first.is_a? Fixnum
        values = @data_structure.flatten
      else
        @data_structure.each do |hash|
          hash.deep_traverse { |_path, value| values << value }
        end
      end
      values.flatten
    end
  end
end
