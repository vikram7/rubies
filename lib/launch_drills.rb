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
  hash = Hash.new
  10.times do
    email = Faker::Internet.email
    num = rand(1..1000)
    hash[email] = num
  end
  hash
end

def hash_three
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
  choice = rand(1..4)
  array = Array.new
  case choice
  when 1
    hash_one
  when 2
    hash_two
  when 3
    rand(1..4).times do
      array << hash_three
    end
    array
  when 4
    random_array
  end
end

def all_values(ds)
  values = Array.new
  if ds.is_a? Hash
    values = ds.values
  elsif ds.flatten.first.is_a? Fixnum
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

puts "\e[H\e[2J"
puts "==============================".colorize(:light_magenta)
puts "Welcome to Ruby Driller"
puts "         /\\_/\\          "
puts "    ____/ o o \\         "
puts "  /~____  =ø= /         "
puts " (______)__m_m)         "
puts
puts "            LEGEND            ".colorize(:light_magenta)
puts "NEW : get a new data structure"
puts "RUN : executes any inputted code"
puts "EXIT: exit program"
puts "==============================".colorize(:light_magenta)
puts "Press enter to continue . . . "
gets.chomp

num_correct = 0
num_wrong = 0
current = data_structure
playing = true
while playing == true
  correct = false
  answer = all_values(current).sample
  while correct == false
    puts
    puts "We have some questions for you about this #{current.class.to_s.downcase}:".colorize(:light_blue)
    puts "current = "
    if current.first.is_a? Array
      PP.pp current
    elsif current.first.is_a? Fixnum
      PP.pp current
    else
      ap current, index: false
    end
    puts
    puts "Write some ruby code to find the following value: ".colorize(:light_blue)
    puts answer.to_s
    puts
    print "[1] ruby_drills(main)> "
    input = gets.chomp
    # $/ = "RUN"
    # input = STDIN.gets
    # input = input.gsub("\n", ";").gsub("RUN", "")
    if input == "NEW"
      puts "\e[H\e[2J"
      current = data_structure
      break
    else
      begin
        output = eval(input)
      rescue
        puts
        puts "Sorry, that code resulted in an error.".colorize(:light_red)
      else
        if answer != output
          num_wrong += 1
          puts "=> " + output.to_s
          puts
          puts "Sorry, that code is incorrect. ".colorize(:light_red)
          puts
          puts "The right answer is . . . ".colorize(:light_red)
          puts answer.to_s
          puts "Try again!".colorize(:light_red)
        else
          num_correct += 1
          puts "=> " + output.to_s
          puts
          puts "Correct!".colorize(:green)
          correct = true
        end
      end
    end
    puts "==============================".colorize(:light_yellow)
    puts "Number correct this session: ".colorize(:green) + num_correct.to_s
    puts "Number wrong this session  : ".colorize(:light_red) + num_wrong.to_s
    puts "==============================".colorize(:light_yellow)
    puts "Press enter to continue . . . "
    gets.chomp
    puts "\e[H\e[2J"
  end
end



