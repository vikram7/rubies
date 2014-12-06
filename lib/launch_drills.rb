# require "launch_drills/version"
require 'pry'
require 'faker'
require 'colorize'
require 'pp'

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
    hash[name] = details
    count += 1
  end
  hash
end

array = Array.new
rand(1..5).times do
  array << random_hash
end

values = Array.new
array.each do |hash|
  hash.deep_traverse{ |path, value| values << value }
end

playing = true
while playing == true
  correct = false
  answer = values.sample
  while correct == false
    puts
    puts "Here is an array of hashes we have some questions for you about:".colorize(:light_blue)
    PP.pp array
    puts
    puts "Write some ruby code to find the following value: ".colorize(:light_blue) + answer.to_s
    input = gets.chomp
    begin
      output = eval(input)
    rescue
      puts "Sorry, that code resulted in an error.".colorize(:red)
    else
      if answer != output
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
