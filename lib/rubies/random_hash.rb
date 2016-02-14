module Rubies
  class MyHash < ::Hash
    def deep_traverse(&block)
      stack = self.map { |k, v| [[k], v] }
      while not stack.empty?
        key, value = stack.pop
        yield(key, value)
        if value.is_a? Hash
          value.each { |k, v| stack.push [key.dup << k, v] }
        end
      end
    end
  end

  class RandomHash < MyHash
    def initialize
      @data_structure = MyHash.new
    end

    def children
      rand = rand(1..3)
      Array.new(rand) { Faker::Name.first_name }
    end

    def has_kids?
      [true, false].sample
    end

    def hash_one
      hash = Hash.new
      10.times do
        name = Faker::Company.name
        bs = Faker::Company.bs
        hash[name] = bs
      end
      hash
    end

    def hash_two
      hash = MyHash.new
      10.times do
        email = Faker::Internet.email
        num = rand(1..1000)
        hash[email] = num
      end
      hash
    end

    def hash_three
      hash = MyHash.new
      rand(1..5).times do
        details = Hash.new
        details["phone"] = Faker::PhoneNumber.cell_phone
        details["company"] = Faker::Company.name
        details["children"] = children if has_kids?
        hash[Faker::Name.name] = details
      end
      hash
    end

    def generate
      @data_structure = [hash_one, hash_two, hash_three].sample
    end
  end
end
