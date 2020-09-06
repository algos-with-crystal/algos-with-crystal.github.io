require "spec"
require "../staircase_steps_permutation"

tests = [
    {n: 1, k:[2], expected: 0},
    {n: 1, k:[1], expected: 1},
    {n: 2, k:[1], expected: 1},
    {n: 2, k:[1, 2], expected: 2},
    {n: 4, k:[1,2], expected: 5},
    {n: 4, k:[2], expected: 1},
    {n: 4, k:[2, 2], expected: 2}, # for simplicity sake, consider these unique
    {n: 8, k:[1,2,3,4], expected: 108},
]

tests.each do |test|
    describe "#climb" do
        it "determines count" do
            climb(test[:n], test[:k]).should eq test[:expected]
        end
    end

    describe "#climb_with_memoization" do
        it "determines count with memoization" do
            climb_with_memoization(test[:n], test[:k]).should eq test[:expected]
        end
    end
end