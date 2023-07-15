# frozen_string_literal: true

# Iterative and recursive implementation of the Fibonacci sequence
module Fibonacci
  def self.fibs(n)
    a = 0
    b = 1
    n.times.map do
      tmp = a
      a, b = b, a + b
      tmp
    end
  end

  def self.fibs_rec(n, a = 0, b = 1, acc = [])
    n.zero? ? acc : fibs_rec(n - 1, b, a + b, acc + [a])
  end
end
