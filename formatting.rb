class Array
  # TODO: allow spaces and some punctuation
  def sanitize
    select { |letter| ('A'..'Z').include? letter.upcase }
  end

  def chunk_by_identity
    chunk { |c| c }
  end
end

class String
  # Treat Strings as Arrays of String chars
  def method_missing(m, *args, &block)
    chars.send(m, *args)
  end

  def to_alphabet_order
    ord - 'a'.ord
  end

  def in_same_case_as letter
    letter.downcase == letter ? downcase : upcase
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
end