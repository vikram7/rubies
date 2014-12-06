# require "launch_drills/version"
require 'pry'
require 'faker'
require 'colorize'
require 'pp'
require 'awesome_print'

module LaunchDrills
  # Your code goes here...
end

class Hash
  def deep_traverse(&block)
    stack = self.map{ |k,v| [ [k], v ] }
    while not stack.empty?
      key, value = stack.pop
      yield(key, value)
      if value.is_a? Hash
        value.each{ |k,v| stack.push [ key.dup << k, v ] }
      end
    end
  end
end

def children
  array = Array.new
  rand(1..3).times do
    array << Faker::Name.first_name
  end
  array
end

def has_kids?
  rand(2) == 1
end

def random_hash
  hash = Hash.new
  length = rand(1..5)
  count = 1
  while count <= length
    details = Hash.new
    name = Faker::Name.name
    phone = Faker::PhoneNumber.cell_phone
    company = Faker::Company.name
    details["phone"] = phone
    details["company"] = company
    details["children"] = children if has_kids?
    hash[name] = details
    count += 1
  end
  hash
end

def mini_array
  (-1_000..1_000).sort_by{ rand }.sample 3
end

def nesting_array
  array = Array.new
  rand(1..3).times do
    array << mini_array
  end
  array.each do |a|
    a << mini_array
  end
  array
end

def random_array
  depth = rand(0..3)
  nesting_array.flatten(depth)
end

def data_structure
  choice = rand(1..2)
  array = Array.new
  if choice == 1
    rand(1..4).times do
      array << random_hash
    end
  elsif choice == 2
    array = random_array
  end
  array
end

def all_values(ds)
  values = Array.new

  if ds.flatten.first.is_a? Fixnum
    values = ds.flatten
  else
    ds.each do |hash|
      hash.deep_traverse{ |path, value| values << value }
    end

    values.each do |value|
      if value.is_a? Array
        value.each { |element| values << element }
        values.delete(value)
      end
    end
  end
  values
end




array = data_structure
playing = true
while playing == true
  correct = false
  answer = all_values(array).sample
  while correct == false
    puts
    puts "Here is an array of hashes we have some questions for you about:".colorize(:light_blue)
    puts "array = "
    ap array, index: false
    puts
    puts "Write some ruby code to find the following value: ".colorize(:light_blue) + answer.to_s
    input = gets.chomp
    if input == "NEW"
      array = data_structure
      break
    else
      begin
        output = eval(input)
      rescue
        puts
        puts "Sorry, that code resulted in an error.".colorize(:red)
      else
        if answer != output
          puts
          puts "Sorry, that code produced . . . ".colorize(:red)
          puts output.to_s
          puts "The right answer is . . . ".colorize(:red)
          puts answer.to_s
          puts "Try again!".colorize(:red)
        else
          puts "Correct!".colorize(:green)
          correct = true
        end
      end
    end
  end
end



