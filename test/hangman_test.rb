require './hangman.rb'
require 'minitest/autorun'

class HangmanTest < Minitest::Test
  def setup
    @hangman = Hangman.new("elephantisis")
  end

  # test cases for initialize method
  def test_should_not_be_able_to_access_the_word
    assert_raises(NoMethodError) { @hangman.word }
  end

  def test_should_show_the_empty_word_placeholders
    assert_equal @hangman.word_placeholders, %w(_ _ _ _ _ _ _ _ _ _ _ _)
  end

  def test_should_show_the_empty_missed_placeholders
    assert_empty @hangman.missing_placeholders
  end

  def test_should_have_missed_counter_set_to_0
    assert_equal @hangman.missing_counter, 0
  end

  def test_should_have_word_counter_set_to_0
    assert_equal @hangman.word_counter, 0
  end

  #test cases for play instance method
  def test_play_on_valid_input_should_accept_only_first_character
    @hangman.play('abc')
    assert_equal @hangman.input, 'a'
  end

  def test_play_on_valid_input_should_have_first_character_as_valid_alphabet
    @hangman.play('a12')
    assert_equal @hangman.input, 'a'
  end

  def test_play_on_valid_input_should_not_accept_numbers
    assert_raises (HangmanInvalidInput) { @hangman.play('1') }
  end

  def test_play_on_valid_input_should_not_accept_special_characters
    assert_raises (HangmanInvalidInput) { @hangman.play('$') }
  end

  #test cases for correct choice of play method

  def test_correct_choice_of_play_should_update_all_the_word_placeholders_if_that_character_occurs_more_than_once
    @hangman.play('e')
    assert_equal @hangman.word_placeholders, %w(e _ e _ _ _ _ _ _ _ _ _ )
  end

  def test_correct_choice_of_play_should_increment_the_word_counter_for_the_count_of_placeholders_updated
    @hangman.play('e')
    assert_equal @hangman.word_counter, 2
  end

  def test_correct_choice_of_play_should_not_change_the_missing_counter
    @hangman.play('e')
    assert_equal @hangman.missing_counter, 0
  end

  def test_correct_choice_of_play_should_not_update_the_missed_placeholders
    @hangman.play('e')
    assert_empty @hangman.missing_placeholders
  end

  # for wrong input choice in play method
  def test_wrong_choice_should_increment_the_missing_counter
    @hangman.play('x')
    assert_equal @hangman.missing_counter, 1
  end

  def test_wrong_choice_should_show_the_missed_character_in_the_missing_placeholders
    @hangman.play('x')
    assert_equal @hangman.missing_placeholders, %w(x)
  end

  def test_wrong_choice_should_not_change_the_word_counter
    @hangman.play('x')
    assert_equal @hangman.word_counter, 0
  end

  def test_wrong_choice_should_not_update_the_word_placeholders
    @hangman.play('x')
    assert_equal @hangman.word_placeholders, %w( _ _ _ _ _ _ _ _ _ _ _ _)
  end

  # test cases for repeated characters
  def test_repeated_character_should_not_update_the_word_placeholders_again
    @hangman.play('e')
    @hangman.play('x')

    # and again
    @hangman.play('e')
    @hangman.play('x')

    assert_equal @hangman.word_placeholders, %w(e _ e _ _ _ _ _ _ _ _ _ )
  end

  def test_repeated_character_should_not_update_missing_placeholders_again
    @hangman.play('e')
    @hangman.play('x')

    # and again
    @hangman.play('e')
    @hangman.play('x')

    assert_equal @hangman.missing_placeholders, %w(x)
  end

  def test_repeated_character_should_not_increment_the_missing_counter
    @hangman.play('e')
    @hangman.play('x')

    # and again
    @hangman.play('e')
    @hangman.play('x')

    assert_equal @hangman.missing_counter, 1
  end

  def test_repeated_character_should_not_update_the_word_counter
    @hangman.play('e')
    @hangman.play('x')

    # and again
    @hangman.play('e')
    @hangman.play('x')

    assert_equal @hangman.word_counter, 2
  end

  # test cases for winning scenario for result method
  def test_result_should_have_word_counter_equal_to_the_word_placeholders_count_on_win
    @hangman.play('e')
    @hangman.play('l')
    @hangman.play('p')
    @hangman.play('h')
    @hangman.play('a')
    @hangman.play('n')
    @hangman.play('t')
    @hangman.play('i')
    @hangman.play('s')

    assert_equal @hangman.word_counter, @hangman.word_placeholders.size
  end

  def test_result_should_have_missing_counter_less_than_6_on_win
    @hangman.play('e')
    @hangman.play('l')
    @hangman.play('p')
    @hangman.play('h')
    @hangman.play('a')
    @hangman.play('n')
    @hangman.play('t')
    @hangman.play('i')
    @hangman.play('s')

    assert_operator @hangman.missing_counter, :<, 6
  end

  def test_result_should_have_result_as_you_win_message_on_win
    @hangman.play('e')
    @hangman.play('l')
    @hangman.play('p')
    @hangman.play('h')
    @hangman.play('a')
    @hangman.play('n')
    @hangman.play('t')
    @hangman.play('i')
    @hangman.play('s')

    assert_equal @hangman.result, 'You win!'
  end

  # test cases for losing scenario on play method
  def test_on_losing_should_have_word_counter_less_than_word_placeholders_count
    @hangman.play('z')
    @hangman.play('q')
    @hangman.play('m')
    @hangman.play('u')
    @hangman.play('w')
    @hangman.play('o')

    assert_operator @hangman.word_counter, :<, @hangman.word_placeholders.size
  end

  def test_on_losing_should_have_missing_counter_equal_to_6
    @hangman.play('z')
    @hangman.play('q')
    @hangman.play('m')
    @hangman.play('u')
    @hangman.play('w')
    @hangman.play('o')

    assert_equal @hangman.missing_counter, 6
  end

  def test_on_losing_should_have_result_as_you_lose
    @hangman.play('z')
    @hangman.play('q')
    @hangman.play('m')
    @hangman.play('u')
    @hangman.play('w')
    @hangman.play('o')

    assert_equal @hangman.result, 'You lose!'
  end
end