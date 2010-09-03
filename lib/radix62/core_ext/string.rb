# -*- encoding: utf-8 -*-
class String
  def decode62
    Radix62.decode62(self)
  end
end
