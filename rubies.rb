# require "rubies/version"
require 'pry'
require 'faker'
require 'colorize'
require 'pp'
require 'awesome_print'
require_relative 'random_array'
require_relative 'random_hash'

def data_structure
  choice = rand(1..3)
  case choice
  when 1
    RandomHash.new.generate
  when 2
    RandomArray.new.generate
  when 3
    array = Array.new
    hash = RandomHash.new.generate
    rand(1..3).times do
      array << RandomHash.new.hash_three
    end
    array
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
puts"
.______       __    __  .______   ____    ____
|   _  \\     |  |  |  | |   _  \\  \\   \\  /   /
|  |_)  |    |  |  |  | |  |_)  |  \\   \\/   /
|      /     |  |  |  | |   _  <    \\_    _/
|  |\\  \\----.|  `--'  | |  |_)  |     |  |
| _| `._____| \\______/  |______/      |__|

 _______  .______       __   __       __          _______.
|       \\ |   _  \\     |  | |  |     |  |        /       |
|  .--.  ||  |_)  |    |  | |  |     |  |       |   (----`
|  |  |  ||      /     |  | |  |     |  |        \\   \\
|  '--'  ||  |\\  \\----.|  | |  `----.|  `----.----)   |
|_______/ | _| `._____||__| |_______||_______|_______/

".colorize(:light_magenta)
puts "==============================".colorize(:light_magenta)
puts "            LEGEND            ".colorize(:light_magenta)
puts "NEW : get a new data structure"
# puts "RUN : executes any inputted code"
# puts "EXIT: exit program"
puts "==============================".colorize(:light_magenta)
puts "Press enter to continue . . . "
gets.chomp
puts "\e[H\e[2J"

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
    if current.is_a? Hash
      ap current, index: false
    elsif current.first.is_a? Array
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
    input.gsub("\"","\'")
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
      rescue StandardError => e
        puts
        puts "Sorry, that code resulted in an error:".colorize(:light_red)
        puts "#{e}".colorize(:red)
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



