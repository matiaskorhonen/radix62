# -*- encoding: utf-8 -*-
class Integer
  def encode62
    Radix62.encode62(self)
  end
end
