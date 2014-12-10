# require "rubies/version"
require 'colorize'
require 'awesome_print'
require 'pp'
require_relative 'random_array'
require_relative 'random_hash'
require_relative 'random_data_structure'

class Game

  def initialize
    @num_right = 0
    @num_wrong = 0
    @playing = true
    @correct = false
    @rds = RandomDataStructure.new
  end

  def splash
    puts "\e[H\e[2J"
    puts "
    .______       __    __  .______    __   _______     _______.
    |   _  \\     |  |  |  | |   _  \\  |  | |   ____|   /       |
    |  |_)  |    |  |  |  | |  |_)  | |  | |  |__     |   (----`
    |      /     |  |  |  | |   _  <  |  | |   __|     \\   \\
    |  |\\  \\----.|  `--'  | |  |_)  | |  | |  |____.----)   |
    | _| `._____| \\______/  |______/  |__| |_______|_______/

    ".colorize(:light_magenta)
    puts "================================================================".colorize(:light_magenta)
    puts "                           LEGEND            ".colorize(:light_magenta)
    puts "               NEW : get a new data structure"
    puts "               EXIT: exit program"
    puts "================================================================".colorize(:light_magenta)
    puts "Press enter to continue . . . "

    gets.chomp
    puts "\e[H\e[2J"
  end

  def continuer
    puts "Press enter to continue . . . "
    gets.chomp
    puts "\e[H\e[2J"
  end

  def scoreboard(num_right, num_wrong)
    puts
    puts "==============================".colorize(:light_yellow)
    puts "Number correct this session: ".colorize(:green) + @num_right.to_s
    puts "Number wrong this session  : ".colorize(:light_red) + @num_wrong.to_s
    puts "==============================".colorize(:light_yellow)
  end

  def questioner(current)
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
  end

  def eprinter(error)
    puts
    puts "Sorry, that code resulted in an error:".colorize(:light_red)
    puts "#{error}".colorize(:red)
  end

  def itswrong(output, answer)
    @num_wrong += 1
    puts "=> " + output.to_s
    puts
    puts "Sorry, that code is incorrect. ".colorize(:light_red)
    puts
    puts "The right answer is . . . ".colorize(:light_red)
    puts answer.to_s
    puts "Try again!".colorize(:light_red)
  end

  def itsright(output)
    @num_right += 1
    puts "=> " + output.to_s
    puts
    puts "Correct!".colorize(:green)
  end

  def byebye
    puts "Thanks for using ".colorize(:green) + "rubies!".colorize(:light_red)
    puts
  end

  def evaluator

  end

  def game
    splash
    while @playing
      current = @rds.generate
      answer = @rds.all_values.sample
      while !@correct
        questioner(current)
        puts "Write some ruby code to find the following value (or enter ".colorize(:light_blue) + 'NEW'.colorize(:green) + " for a new challenge): ".colorize(:light_blue)
        puts answer.to_s
        puts
        print "[1] ruby_drills(main)> "
        input = gets.chomp
        input.gsub("\"", "\'")
        if input == "NEW" || input == "new"
          puts "\e[H\e[2J"
          rds = RandomDataStructure.new
          break
        elsif input == "EXIT" || input == "exit"
          scoreboard(@num_right, @num_wrong)
          byebye
          exit
        else
          begin
            routine = lambda { eval(input) }
            output = routine.call
          rescue NoMethodError => e
            eprinter(e)
          rescue Exception => e
            eprinter(e)
          else
            if answer != output
              itswrong(output, answer)
            else
              itsright(output)
              @correct = true
            end
          end
        end
        scoreboard(@num_right, @num_wrong)
        continuer
      end
    end
  end
end
