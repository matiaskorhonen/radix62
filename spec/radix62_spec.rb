# -*- encoding: utf-8 -*-
require "spec_helper"

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
