# frozen_string_literal: true

require "fibonacci"

RSpec.describe Fibonacci do
  tests = [
    { fixture: 0, oracle: [] },
    { fixture: 1, oracle: [0] },
    { fixture: 2, oracle: [0, 1] },
    { fixture: 8, oracle: [0, 1, 1, 2, 3, 5, 8, 13] }
  ]

  %i[fibs fibs_rec].each do |method|
    describe method do
      tests.each do |test|
        test in { fixture:, oracle:}
        it "works with n == #{fixture}" do
          expect(Fibonacci.send(method, fixture)).to eql(oracle)
        end
      end
    end
  end
end
