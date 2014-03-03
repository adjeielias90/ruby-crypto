require_relative 'transposition.rb'
require 'minitest/autorun'

class TestColumnarTransposition < MiniTest::Unit::TestCase
  def setup
    @plaintext = "WE ARE DISCOVERED. FLEE AT ONCE"
    @plaintext = @plaintext.gsub(/\W/,"")
    @key = "ZEBRAS"
  end

  def test_that_decrypted_and_plain_text_are_same
    encrypted_text = @plaintext.columnar_transposition_encrypt @key
    decrypted_text = encrypted_text.columnar_transposition_decrypt @key
    # Cut off any padding
    decrypted_text = decrypted_text[0, @plaintext.length]
    assert_equal @plaintext, decrypted_text
  end
end
