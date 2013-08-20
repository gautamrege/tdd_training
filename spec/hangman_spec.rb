require './hangman.rb'


describe Hangman do
  subject(:hangman) { Hangman.new("elephantisis") }

  context "#initialize" do
    it "should not be able to access the word" do
      expect { hangman.word }.to raise_error NoMethodError
    end

    it "should show the empty word placeholders" do
      expect(hangman.word_placeholders).to eq( %w( _ _ _ _ _ _ _ _ _ _ _ _) )
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
      before(:each) do
        hangman.play('e')
      end

      it "should update all the word placeholders if that character occurs more than once" do
        expect(hangman.word_placeholders).to eq( %w(e _ e _ _ _ _ _ _ _ _ _ ) )
      end

      it "should increment the word_counter for the count of placeholders updated" do
        expect(hangman.word_counter).to eq(2)
      end

      it "should not change the missing_counter" do
        expect(hangman.missing_counter).to eq(0)
      end

      it "should not update the missed placeholders" do
        expect(hangman.missing_placeholders).to be_empty
      end
    end

    context "for wrong choice" do
      before(:each) do
        hangman.play('x')
      end

      it "should increment the missing_counter" do
        expect(hangman.missing_counter).to eq(1)
      end

      it "should show the missed character in the missing_placeholders" do
        expect(hangman.missing_placeholders).to eq( %w(x) )
      end

      it "should not change the word_counter" do
        expect(hangman.word_counter).to eq(0)
      end

      it "should not update the word placeholders" do
        expect(hangman.word_placeholders).to eq( %w( _ _ _ _ _ _ _ _ _ _ _ _) )
      end
    end

    context "for repeated character" do
      before(:each) do
        hangman.play('e')
        hangman.play('x')

        # and again
        hangman.play('e')
        hangman.play('x')
      end

      it "should not update the word_placeholders again" do
        expect(hangman.word_placeholders).to eq( %w(e _ e _ _ _ _ _ _ _ _ _ ) )
      end

      it "should not update the missing_placeholders again" do
        expect(hangman.missing_placeholders).to eq( %w(x) )
      end

      it "should not increment the missing_counter" do
        expect(hangman.missing_counter).to eq(1)
      end

      it "should not update the word_counter" do
        expect(hangman.word_counter).to eq(2)
      end
    end
  end

  context ".result" do
    context "win" do
      before(:each) do
        hangman.play('e')
        hangman.play('l')
        hangman.play('p')
        hangman.play('h')
        hangman.play('a')
        hangman.play('n')
        hangman.play('t')
        hangman.play('i')
        hangman.play('s')
      end

      it "should have word_counter equal to the word placeholders count" do
        expect(hangman.word_counter).to eq(hangman.word_placeholders.size)
      end

      it "should have missing_counter < 6" do
        expect(hangman.missing_counter).to be < 6
      end

      it "should have result as 'You win!'" do
        expect(hangman.result).to eq('You win!')
      end
    end

    context "lose" do
      before(:each) do
        hangman.play('z')
        hangman.play('q')
        hangman.play('m')
        hangman.play('u')
        hangman.play('w')
        hangman.play('o')
      end

      it "should have word_counter < than word placeholders count" do
        expect(hangman.word_counter).to be < hangman.word_placeholders.size
      end

      it "should have missing_counter equal to 6" do
        expect(hangman.missing_counter).to eq(6)
      end

      it "should have result as 'You lose!'" do
        expect(hangman.result).to eq('You lose!')
      end
    end
  end
end
