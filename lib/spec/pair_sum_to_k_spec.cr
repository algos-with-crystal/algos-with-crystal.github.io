require "spec"
require "../pair_sum_to_k"

describe "#has_pair_k" do
  cases = [
            {numbers: [] of Int32, k: 0, expected: false},
            {numbers: [1], k: 1, expected: false},
            {numbers: [1], k: 0, expected: false},
            {numbers: [1, 2, 3], k: 4, expected: true},
            {numbers: [1, -1], k: 0, expected: true},
            {numbers: [1, -1], k: 2, expected: false},
          ]

  cases.each do |test|
    it "produces correct results" do
        has_pair_sum(test[:numbers], test[:k]).should eq test[:expected]
    end
  end
end
