module DiffieHelman

  attr_reader :public_key

  def private_key= private_key
    @private_key = private_key
    @public_key = 7**@private_key % 11
  end

  def shared_secret_key public_key
    public_key**@private_key % 11
  end
end