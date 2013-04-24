# -*- encoding: utf-8 -*-
require "spec_helper"
require "support/known_good"

describe Radix62 do
  context "alphabet" do
    it "has the ALPHABET array" do
      Radix62::ALPHABET.should be_kind_of Array
    end
    
    it "has 62 items" do
      Radix62::ALPHABET.should_not be_empty
      Radix62::ALPHABET.count.should == 62
    end
    
    it "has the right contents" do
      Radix62::ALPHABET.should == ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    end
  end
  
  context "alphabet_hash" do
    it "has the ALPHABET_HASH hash" do
      Radix62::ALPHABET_HASH.should be_kind_of Hash
    end
    
    it "has 62 items" do
      Radix62::ALPHABET_HASH.should_not be_empty
      Radix62::ALPHABET_HASH.count.should == 62
    end
    
    it "has the right contents" do
      Radix62::ALPHABET_HASH.should == {"0"=>0, "1"=>1, "2"=>2, "3"=>3, "4"=>4, "5"=>5, "6"=>6, "7"=>7, "8"=>8, "9"=>9, "a"=>10, "b"=>11, "c"=>12, "d"=>13, "e"=>14, "f"=>15, "g"=>16, "h"=>17, "i"=>18, "j"=>19, "k"=>20, "l"=>21, "m"=>22, "n"=>23, "o"=>24, "p"=>25, "q"=>26, "r"=>27, "s"=>28, "t"=>29, "u"=>30, "v"=>31, "w"=>32, "x"=>33, "y"=>34, "z"=>35, "A"=>36, "B"=>37, "C"=>38, "D"=>39, "E"=>40, "F"=>41, "G"=>42, "H"=>43, "I"=>44, "J"=>45, "K"=>46, "L"=>47, "M"=>48, "N"=>49, "O"=>50, "P"=>51, "Q"=>52, "R"=>53, "S"=>54, "T"=>55, "U"=>56, "V"=>57, "W"=>58, "X"=>59, "Y"=>60, "Z"=>61}
    end
  end
  
  context "encode62" do
    it "raises an exception with negative numbers" do
      (-1000..-1).step(100).each do |n|
        lambda { Radix62.encode62(n) }.should raise_error(RangeError)
      end
      (-99999..-9999).step(1000).each do |n|
        lambda { Radix62.encode62(n) }.should raise_error(RangeError)
      end
      (-9999999..-999999).step(10000).each do |n|
        lambda { Radix62.encode62(n) }.should raise_error(RangeError)
      end
      (-333333333..-222222222).step(1000000).each do |n|
        lambda { Radix62.encode62(n) }.should raise_error(RangeError)
      end
    end
    
    it "fails if the input number is not an Integer" do
      lambda { Radix62.encode62("123") }.should raise_error(TypeError)
      lambda { Radix62.encode62(true) }.should raise_error(TypeError)
      lambda { Radix62.encode62(:symbol) }.should raise_error(TypeError)
      lambda { Radix62.encode62([1]) }.should raise_error(TypeError)
      lambda { Radix62.encode62(0.1) }.should raise_error(TypeError)
    end
    
    it "has output which matches known good examples" do
      KnownGood::ENCODE62.each do |key, value|
        Radix62.encode62(key).should == value
      end
    end
  end
  
  context "decode62" do
    it "raises an exception with invalid characters" do
      lambda { Radix62.decode62("/") }.should raise_error(ArgumentError)
      lambda { Radix62.decode62("123.0") }.should raise_error(ArgumentError)
      lambda { Radix62.decode62("-100") }.should raise_error(ArgumentError)
      lambda { Radix62.decode62("Ä") }.should raise_error(ArgumentError)
      lambda { Radix62.decode62("ö") }.should raise_error(ArgumentError)
      lambda { Radix62.decode62(" ") }.should raise_error(ArgumentError)
      lambda { Radix62.decode62("123 000") }.should raise_error(ArgumentError)
      lambda { Radix62.decode62("123,9") }.should raise_error(ArgumentError)
      lambda { Radix62.decode62("123\t123") }.should raise_error(ArgumentError)
      lambda { Radix62.decode62("1&1") }.should raise_error(ArgumentError)
      lambda { Radix62.decode62("1%") }.should raise_error(ArgumentError)
    end
    
    it "has output which matches known good examples" do
      KnownGood::DECODE62.each do |key, value|
        Radix62.decode62(key).should == value
      end
    end
  end
  
  context "core_ext" do
    it "extends the Integer class with #encode62" do
      9999.encode62.should be_kind_of String
      9999.encode62.should == "2Bh"
    end
    
    it "extends the String class with #decode62" do
      "aBC".decode62.should be_kind_of Integer
      "aBc".decode62.should == 40746
    end
  end
end
