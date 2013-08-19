require './hangman.rb'

describe Hangman do
  context "start-up" do
    it "should have a word to play with"
    it "should show the empty word placeholders"
    it "should show the empty missed placeholders"
    it "should have missed_counter set to 0"
    it "should have word_counter set to 0"
  end

  context "play" do
    it "should accept only one character at a time"
    it "should ask for next character if missed_counter < 6 and word_counter < word count"

    context "for correct choice" do
      it "should update all the word placeholders if that character occurs more than once"
      it "should increment the word_counter for the count of placeholders updated"
      it "should not change the missed_counter"
      it "should not update the missed placeholders"
    end

    context "for wrong choice" do
      it "should increment the missed chances counter"
      it "should show the missed character in the missed placeholder"
      it "should not change the word_counter"
      it "should not update the word placeholders"
    end

    context "for repeated character" do
      it "should not update the word placeholders"
      it "should not update the missed placeholders"
    end
  end

  context "result" do
    context "win" do
      it "should have word_counter equal to the word placeholders count"
      it "should have missed_counter < 6"
    end

    context "lose" do
      it "should have word_counter < than word placeholders count"
      it "should have missed_counter equal to 6"
    end
  end
end
