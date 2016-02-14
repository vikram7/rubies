require "spec_helper"

module Rubies
  describe RandomHash do
    before do
      @random_hash = Rubies::RandomHash.new
    end

    it "#children returns an array" do
      children = @random_hash.children
      expect(children).to be_instance_of(Array)
    end

    it "#children returns an array of names" do
      children = @random_hash.children.map(&:class).uniq
      expect(children.length).to eq(1)
      expect(children).to eq([String])
    end

    it "#has_kids? returns a boolean" do
      expect([true, false]).to include @random_hash.has_kids?
    end

    it "#hash_one returns a hash" do
      hash_one = @random_hash.hash_one
      expect(hash_one).to be_instance_of(Hash)
    end

    it "#hash_one returns a hash of 10 elements" do
      hash_one = @random_hash.hash_one
      expect(hash_one.count).to eq(10)
    end

    it "#hash_one returns hash with String keys" do
      hash_one = @random_hash.hash_one
      keys = hash_one.keys
      expect(keys.map(&:class).uniq.length).to eq(1)
      expect(keys.map(&:class).uniq).to eq([String])
    end

    it "#hash_one returns hash with String values" do
      hash_one = @random_hash.hash_one
      values = hash_one.values
      expect(values.map(&:class).uniq.length).to eq(1)
      expect(values.map(&:class).uniq).to eq([String])
    end

    it "#hash_two returns a hash of 10 elements" do
      hash_two = @random_hash.hash_two
      expect(hash_two.count).to eq(10)
    end

    it "#hash_two returns hash with String keys" do
      hash_two = @random_hash.hash_two
      keys = hash_two.keys
      expect(keys.map(&:class).uniq.length).to eq(1)
      expect(keys.map(&:class).uniq).to eq([String])
    end

    it "#hash_one returns hash with Fixnum values" do
      hash_two = @random_hash.hash_two
      values = hash_two.values
      expect(values.map(&:class).uniq.length).to eq(1)
      expect(values.map(&:class).uniq).to eq([Fixnum])
    end

    it "#hash_three returns an instance of MyHash" do
      hash_three = @random_hash.hash_three
      expect(hash_three).to be_instance_of(Rubies::MyHash)
    end
  end
end
