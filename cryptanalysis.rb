require 'ascii_charts'

class Array

  LETTER_FREQUENCY_LOOKUP = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

  def sanitize
    reject { |letter| !LETTER_FREQUENCY_LOOKUP.include? letter.upcase }
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
    map do |letter|
      translated = letter.ord - 'a'.ord
      shifted = translated + n
      modulated = shifted % 26
      retranslated = modulated + 'a'.ord
      retranslated.chr
    end
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
end