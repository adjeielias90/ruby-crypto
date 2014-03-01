require_relative 'diffie_helman.rb'
require 'minitest/autorun'

class Person
  include DiffieHelman
end

class TestDiffieHelman < MiniTest::Unit::TestCase
  def setup
    alice = Person.new
    bob = Person.new

    alice.private_key = rand(1000000)
    bob.private_key = rand(1000000)

    @alice_shared_key = alice.shared_secret_key bob.public_key
    @bob_shared_key = bob.shared_secret_key alice.public_key
  end

  def test_that_shared_keys_are_the_same
    assert_equal @alice_shared_key, @bob_shared_key
  end
end