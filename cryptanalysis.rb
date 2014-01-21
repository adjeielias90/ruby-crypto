# require 'facets'
require 'ascii_charts'

class Array
  def letter_frequencies
    # freq = self.frequency
    # freq.map { |k,v| freq[k] * 100.0/length }
    p = Hash.new(0); each{ |v| p[v] += 100*(1.0/self.length)}; p
    pr = Hash.new(0); each{ |v| pr[v] = p[v].round(2) }; pr
  end
end

class String
  def letter_frequencies
    split(//).letter_frequencies
  end

  def letters
    letter_frequency_lookup = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    split(//).reject { |letter| !letter_frequency_lookup.include? letter }
  end
end

frankenstein = File.read("frankenstein.txt")
letters = frankenstein.upcase.letters
frankenstein_lf = letters.letter_frequencies
puts frankenstein_lf
