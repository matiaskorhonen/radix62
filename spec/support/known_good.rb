# -*- encoding: utf-8 -*-
module KnownGood
   # Workaround for JRuby bug JRUBY-5064 (http://jira.codehaus.org/browse/JRUBY-5064)
  if defined?(JRUBY_VERSION)
    ENCODE62 = Marshal.load(File.read("./spec/support/encode62_examples"))
    DECODE62 = Marshal.load(File.read("./spec/support/decode62_examples"))
  else
    ENCODE62 = Marshal.load(File.open("./spec/support/encode62_examples", "r"))
    DECODE62 = Marshal.load(File.open("./spec/support/decode62_examples", "r"))
  end
end
