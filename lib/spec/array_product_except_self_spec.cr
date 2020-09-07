require "spec"
require "../array_product_except_self"

describe "#product" do
  cases = [
            {k: [1, 2] of Int32, expected: [2, 1]},
            {k: [1, 2, 3, 4] of Int32, expected: [24, 12, 8, 6]},
            {k: [4, 3, 2, 1] of Int32, expected: [6, 8, 12, 24]},
          ]

  cases.each do |test|
    it "produces correct results" do
        product(test[:k]) .should eq test[:expected]
    end
  end
end
