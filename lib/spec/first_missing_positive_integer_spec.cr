require "spec"
require "../first_missing_positive_integer"

describe "#first_missing_positive_integer" do
    tests = [
        { list: [] of Int32, expected: 1 },
        { list: [1] of Int32, expected: 2 },
        { list: [1, 3] of Int32, expected: 2 },
        { list: [-1, 0] of Int32, expected: 1 },
        { list: [1, 2] of Int32, expected: 3 },
        { list: [4, 3] of Int32, expected: 1 },
        { list: [0, 3] of Int32, expected: 1 },
        { list: [5, 3, -1, 0, 1] of Int32, expected: 2 },
        { list: [-5, 3, -1, 0, 1, 2, -9] of Int32, expected: 4 },
        { list: [3, 1, -5] of Int32, expected: 2 }
    ]
    tests.each do |test|
        it "produces correct results" do
            actual = first_missing_positive_integer(test[:list])
            actual.should eq test["expected"]
        end
    end
end