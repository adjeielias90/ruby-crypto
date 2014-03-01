class String
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