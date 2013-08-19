require './hangman.rb'


describe Hangman do
  subject(:hangman) { Hangman.new("elephantisis") }

  context "#initialize" do
    it "should not be able to access the word" do
      expect { hangman.word }.to raise_error NoMethodError
    end

    it "should show the empty word placeholders" do
      expect(hangman.word_placeholders).to be_empty
    end

    it "should show the empty missed placeholders" do
      expect(hangman.missing_placeholders).to be_empty
    end

    it "should have missed_counter set to 0" do
      expect(hangman.missing_counter).to eq(0)
    end

    it "should have word_counter set to 0" do
      expect(hangman.word_counter).to eq(0)
    end
  end

  context ".play" do
    context 'valid input' do
      it "should accept only first character" do
        hangman.play('abc')
        expect(hangman.input).to eq('a')
      end

      it "should have first character as valid alphabet" do
        hangman.play('a12')
        expect(hangman.input).to eq('a')
      end

      it "should should accept only characters" do
        expect { hangman.play('1') }.to raise_error HangmanInvalidInput
      end

      it "should should accept only characters" do
        expect { hangman.play('$') }.to raise_error HangmanInvalidInput
      end
    end

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

  context ".result" do
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
