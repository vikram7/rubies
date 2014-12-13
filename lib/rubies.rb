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
  end

  def display_splash
    puts "\e[H\e[2J"
    puts "
    .______       __    __  .______    __   _______     _______.
    |   _  \\     |  |  |  | |   _  \\  |  | |   ____|   /       |
    |  |_)  |    |  |  |  | |  |_)  | |  | |  |__     |   (----`
    |      /     |  |  |  | |   _  <  |  | |   __|     \\   \\
    |  |\\  \\----.|  `--'  | |  |_)  | |  | |  |____.----)   |
    | _| `._____| \\______/  |______/  |__| |_______|_______/

    ".colorize(:light_magenta)
    puts "
    ================================================================
                               LEGEND
                   NEW : get a new data structure
                   EXIT: exit program
    ================================================================
    ".colorize(:light_magenta)
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
    puts "Number correct this session: ".colorize(:green) + num_right.to_s
    puts "Number wrong this session  : ".colorize(:light_red) + num_wrong.to_s
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

  def itswrong(answer)
    @num_wrong += 1
    puts "Sorry, that code is incorrect. ".colorize(:light_red)
    puts
    puts "The right answer is . . . ".colorize(:light_red)
    puts answer.to_s
    puts "Try again!".colorize(:light_red)
  end

  def itsright
    @num_right += 1
    puts "Correct!".colorize(:green)
  end

  def prompter(answer)
    print "Write ruby code to find the following value".colorize(:light_blue)
    print " (or enter ".colorize(:light_blue) + 'NEW'.colorize(:green)
    puts " for a new challenge): ".colorize(:light_blue)
    puts answer.to_s
    puts
    print "[1] rubies(main)> "
  end

  def byebye
    puts
    puts "Thanks for using ".colorize(:green) + "rubies!".colorize(:light_red)
    display_score
  end

  def display_score
    scoreboard(@num_right, @num_wrong)
  end

  def clear_screen
    puts "\e[H\e[2J"
  end

  def prompt(data_structure, target)
    questioner(data_structure)
    prompter(target)
    gets.chomp.gsub("\"", "\'")
  end

  def check_answer(current, input, target)
    begin
      routine = lambda { eval(input) }
      output = routine.call
      puts "=> #{output}"
      puts
      output == target
    rescue Exception => e
      eprinter(e)
      false
    end
  end

  def generate_data_structure
    rds = RandomDataStructure.new
    current = rds.generate
    target = rds.all_values.sample
    [current, target]
  end

  def play_round # new, exit or check if right/wrong
    clear_screen
    correct = false
    current, target = generate_data_structure
    until correct
      input = prompt(current, target)
      if input == "NEW" || input == "new"
        return
      elsif input == "EXIT" || input == "exit"
        @playing = false
        return
      else
        if check_answer(current, input, target)
          itsright
          correct = true
        else
          itswrong(target)
        end
      end
      scoreboard(@num_right, @num_wrong)
      continuer
    end
  end

  def gameover?
    !@playing
  end

  def game
    display_splash
    until gameover?
      play_round
    end
    byebye
  end
end
