require_relative 'formatting.rb'

class String
  def random_padding n
    SecureRandom.base64(n).delete('/+=').upcase[0, n]
  end

  def columnar_transposition_encrypt key, pad=true
    plaintext = self
    if pad && plaintext.length % key.length != 0
      padding = random_padding(key.length - (plaintext.length % key.length))
      plaintext = plaintext + padding
    end
    transposition = plaintext.scan(/.{1,#{key.length}}/).map { |c| c.split(//) }.transpose.map(&:join)
    sorted_transposition = key.split(//).zip(transposition).sort
    ciphertext = sorted_transposition.map { |key, text| text }.join(" ")
    return ciphertext
  end

  def columnar_transposition_decrypt key
    ciphertext = self
    ciphertext = ciphertext.split(" ")
    key_ordering = key.split(//).map.each_with_index.sort
    key_ciphertext_mapping = key_ordering.zip(ciphertext)
    ordered_ciphertext = key_ciphertext_mapping.sort { |x,y| x[0][1] <=> y[0][1] }
                                                .map { |x| x[1] }
    plaintext = ordered_ciphertext.transpose.join
    return plaintext
  end
end