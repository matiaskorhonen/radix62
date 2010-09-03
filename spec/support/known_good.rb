# -*- encoding: utf-8 -*-
module KnownGood
  ENCODE62 = Marshal.load(File.open("./spec/support/encode62_examples", "r"))
  DECODE62 = Marshal.load(File.open("./spec/support/decode62_examples", "r"))
end
