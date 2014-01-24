require 'ascii_charts'

class Array

  def sanitize
    reject { |letter| !('A'..'Z').include? letter.upcase }
  end

  def letter_frequencies
    # Derived from facets Enumerable#frequency
    # http://rdoc.info/github/rubyworks/facets/master/Enumerable#frequency-instance_method
    p = Hash.new(0)
    each do |v|
      p[v] = (p[v] + 100*(1.0/self.length)).round(2)
    end
    p
  end

  def caesar_shift n
    map { |letter| ((letter.to_alphabet_order + n) % 26).to_ascii_char }
  end

  def in_cipher_alphabet char
    caesar_shift(char.ord - 97)
  end

  def caesar_shift_map mapping
    caesar_shift (mapping.keys[0].upcase.ord - mapping.values[0].upcase.ord).abs
  end

  def shift_with_codeword codeword
    zip(codeword.chars.cycle).map { |text_char, code_char| text_char.in_cipher_alphabet(code_char) }
  end
  alias_method :vigenere, :shift_with_codeword
end

class String

  attr_accessor :mappings

  def method_missing(m, *args, &block)
    result = chars.send(m, *args)
    result.kind_of?(Array) ? result.join : result
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
end

class Fixnum
  def to_ascii_char
    (self + 'a'.ord).chr
  end
end
