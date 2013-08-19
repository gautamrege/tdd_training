class Hangman
  attr_reader :word_counter, :missing_counter, :word_placeholders, :missing_placeholders, :input

  def initialize(word)
    @word = word
    @word_counter = 0
    @missing_counter = 0
    @word_placeholders = []
    @missing_placeholders = []
  end

  def play(input)
    @input = input.strip[0]
    raise HangmanInvalidInput unless @input =~ /^[a-zA-z]$/
  end
end

class HangmanInvalidInput < Exception
end
