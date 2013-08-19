class Hangman
  attr_reader :word_counter, :missing_counter, :word_placeholders, :missing_placeholders

  def initialize(word)
    @word = word
    @word_counter = 0
    @missing_counter = 0
    @word_placeholders = []
    @missing_placeholders = []
  end
end
