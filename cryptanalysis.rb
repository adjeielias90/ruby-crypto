require 'facets'

class Array

  # TODO: allow spaces and some punctuation
  def sanitize
    select { |letter| ('A'..'Z').include? letter.upcase }
  end

  def letter_frequencies
    Hash[frequency.map { |k,v| [k, (v * 100.0/self.length).round(2)] }]
  end

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

  def shift_with_codeword codeword
    zip(codeword.chars.cycle).map { |text_char, code_char| text_char.in_cipher_alphabet(code_char) }
  end
  alias_method :vigenere, :shift_with_codeword

  def chunk_by_identity
    chunk { |c| c }
  end

  def consecutive_letters
    # http://stackoverflow.com/a/8499054/2954849
    chunk_by_identity.map { |n,a| a.join }
  end

  def double_letters
    consecutive_letters.select { |letters| letters.length == 2 }
  end

  def double_letter_frequencies
    double_letters.frequency
  end
end

class String

  attr_accessor :mappings

  # Treat Strings as Arrays of String chars
  def method_missing(m, *args, &block)
    chars.send(m, *args)
  end

  def substitute! new_mapping
    puts "\n\n"
    puts "text"
    @mappings = {} unless mappings
    @mappings = Hash[mappings.merge(new_mapping).sort]
    mappings.each do |ciphertext, plaintext|
      puts "#{ciphertext} -> #{plaintext}"
    end

    puts gsub!(new_mapping.keys[0], new_mapping.values[0])
  end

  def to_alphabet_order
    ord - 'a'.ord
  end

  def in_same_case_as letter
    letter.downcase == letter ? downcase : upcase
  end

  def n_letter_words n
    words.select { |word| word.length == n }
  end

  def word_frequencies
    words.frequency.sort_by_value
  end

  def n_letter_word_frequencies n
    n_letter_words(n).frequency.sort_by_value
  end

  def one_letter_word_frequencies
    n_letter_word_frequencies 1
  end

  def two_letter_word_frequencies
    n_letter_word_frequencies 2
  end

  def three_letter_word_frequencies
    n_letter_word_frequencies 3
  end

  def four_letter_word_frequencies
    n_letter_word_frequencies 4
  end

  def nth_letters n
    words.map { |word| word.chars[n] }
  end

  def nth_letter_frequencies n
    nth_letters(n).frequency.sort_by_value
  end

  def first_letter_frequencies
    nth_letter_frequencies 0
  end

  def second_letter_frequencies
    nth_letter_frequencies 1
  end

  def third_letter_frequencies
    nth_letter_frequencies 2
  end

  def last_letter_frequencies
    nth_letter_frequencies(-1)
  end

  def ngrams n
    each_with_index.map { |_,i| self[i..i+(n-1)] }.select { |letters| letters.length == n }
  end

  def ngram_frequencies n
    ngrams.frequency.sort_by_value
  end

  def bigram_frequencies
    ngram_frequencies 2
  end

  def trigram_frequencies
    ngram_frequencies 3
  end

  def highest_bigram_frequencies n=5
    bigram_frequencies.highest_frequencies(n)
  end

  def highest_trigram_frequencies n=5
    trigram_frequencies.highest_frequencies(n)
  end

  def in_dictionary &block
    dictionaries = ["/usr/share/dict/words", "/usr/share/lib/dict/words", "/usr/lib/dict"]
    dictionary = dictionaries.select { |dict| File.exists? dict }.first
    raise StandardError, "No dictionary file" unless dictionary
    File.open(dictionary) { |file| yield file }
  end

  def is_word?
    in_dictionary do |dictionary|
      dictionary.each_line.lazy.map(&:strip).any? { |word| word.include? self }
    end
  end

  def is_nontrivial_word?
    is_word? && length > 4
  end

  def any_words? &block
    words.any? { |word| word.is_word? }
  end

  def any_nontrivial_words?
    words.any? { |word| word.is_nontrivial_word? }
  end

  def all_words? &block
    words.all? { |word| word.is_word? }
  end
end

class Fixnum
  def to_ascii_char
    (self + 'a'.ord).chr
  end
end

class Hash
  # http://stackoverflow.com/a/13216103/2954849
  def sort_by_value
    Hash[self.sort_by { |k, v| v }.reverse]
  end

  def max_by_value
    max_by { |k,v| v }
  end

  def highest_frequencies n=5
    Hash[self.sort_by { |k,v| -v }[0..n-1]]
  end
end
