require "rubies"
require "coveralls"
Coveralls.wear!

#provides the stdin interface to test the Rubies::Game class.
class FakeInput

  def initialize(strings)
    @strings = strings
  end

  def gets
    next_string = @strings.shift
    # Uncomment the following line if you'd like to see the faked $stdin#gets
    # puts "(DEBUG) Faking #gets with: #{next_string}"
    next_string
  end

  def <<(strings)
    @strings << strings
  end

  def size
    @strings.length
  end

end
