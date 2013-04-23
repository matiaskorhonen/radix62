# -*- encoding: utf-8 -*-
require "radix62/core_ext/string"
require "radix62/core_ext/integer"

# Convert integers to base 62 strings and back.
module Radix62
  ALPHABET = ('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a
  ALPHABET_HASH = {}
  ALPHABET.each_with_index { |v,k| ALPHABET_HASH[v] = k }
  
  # Encode an Integer to a base 62 string. The input value *must* be a positive 
  # integer.
  # 
  # If the input number is not an Integer, a TypeError will be raised and if the
  # input number is negative, a RangeError will be raised.
  def self.encode62(number)
    unless number.is_a? Integer
      raise TypeError.new "number not an integer"
    end
  
    if number > 0
      base62 = ""
      while number > 0
        base62 << ALPHABET[number % 62]
        number /= 62
      end
      base62.reverse
    elsif number == 0
      "0"
    else
      raise RangeError.new "number must be greater than or equal to 0"
    end
  end

  
  # Decode a base 62 String to a base 10 Integer. The input value 
  # <b>must not</b> contain illegal characters.
  # 
  # If the input is not alphanumeric, an ArgumentError will be raised.
  def self.decode62(string)
    begin
      integer = 0
      string.split(//).each do |char|
        integer = integer * 62 + ALPHABET_HASH.fetch(char)
      end
      integer
    rescue KeyError
      raise ArgumentError.new "Input is not alphanumeric."
    end
  end
end
