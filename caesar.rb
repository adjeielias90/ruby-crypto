require_relative 'formatting.rb'

class Array
  def caesar_shift n
    map do |letter|
      if letter =~ /[^A-Za-z]/ then letter
      else ((letter.downcase.to_alphabet_order + n) % 26).to_ascii_char.in_same_case_as(letter)
      end
    end.join
  end

  def in_cipher_alphabet char
    caesar_shift(char.downcase.ord - 97)
  end

  def caesar_shift_map mapping
    caesar_shift (mapping.keys[0].upcase.ord - mapping.values[0].upcase.ord).abs
  end

  def all_caesar_shifts
    ('A'..'Z').map { |letter| in_cipher_alphabet(letter) }
  end

  def caesar_candidates
    all_caesar_shifts.select.with_index do |text, i|
      print "[ #{i} ] Checking for words in {a => #{('a'..'z').to_a[i]}}: #{text.slice(0, 20)}... "
      found_words = text.downcase.gsub(/[^A-Za-z ]/, '').words.take(3).join(" ").any_nontrivial_words?
      puts found_words ? "\u2713" : "X"
      found_words
    end
  end
end