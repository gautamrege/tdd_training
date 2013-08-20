class Hangman
  attr_reader :word_counter, :missing_counter, :word_placeholders, :missing_placeholders, :input, :result

  def initialize(word)
    @word = word
    @word_counter = 0
    @missing_counter = 0
    @word_placeholders = Array.new(word.size, '_')
    @missing_placeholders = []
  end

  def play(input)
    @input = input.strip[0]
    raise HangmanInvalidInput unless @input =~ /^[a-zA-z]$/
  
    return if @word_placeholders.include?(@input) or @missing_placeholders.include?(@input)

    if @word.include?(@input) # Character is present in the word
      @word.split('').each_with_index do |c, index|
        if c == @input
          @word_placeholders[index] = @input 
          @word_counter += 1
        end
      end
    else # Charactor is not present in the word
      @missing_placeholders << @input
      @missing_counter += 1
    end

    # Check for result
    @result = "You lose!" if @missing_counter == 6
    @result = "You win!" if @word_counter == @word_placeholders.size 
  end
end

class HangmanInvalidInput < Exception
end

def game_play
  game = Hangman.new('elephantisis')
  while(!game.result) do
    begin
      puts ''
      puts "Word: #{game.word_placeholders}"
      game.play(gets)
      puts "Missed: #{game.missing_placeholders}"
    rescue HangmanInvalidInput
      puts "Wtf - invalid input.. try again"
    end
  end
  p game.result
end
