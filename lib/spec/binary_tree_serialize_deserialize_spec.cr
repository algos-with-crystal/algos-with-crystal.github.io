require "spec"
require "../binary_tree_serialize_deserialize"

describe "#serialize" do
  it "produces correct results" do
#                   o
#         ol                 or
#      -      olr         orl   orr
#          olrl  -       -  -   -  -
#         -   -

      o = Node.new "o"
      ol = Node.new "ol"
      or = Node.new "or"
      olr = Node.new "olr"
      olrl = Node.new "olrl"
      orl = Node.new "orl"
      orr = Node.new "orr"

      o.left = ol
      o.right = or
      ol.right = olr
      or.left = orl
      or.right = orr
      olr.left = olrl

      expected = ["o", "ol", "-", "olr", "olrl", "-", "-", "-", "or", "orl", "-", "-", "orr", "-", "-"]
      actual = serialize o
      actual.should eq expected
  end
end

describe "#deserialize" do
tests = [
          ["o", "-", "-"],
          ["o", "-", "r", "-", "-"],
          ["o", "l", "-", "-", "-"],
          ["o", "ol", "-", "olr", "olrl", "-", "-", "-", "or", "orl", "-", "-", "orr", "-", "-"],
        ]

  tests.each do |test|
    it "produces correct results" do
      root = deserialize(test)
      deserialized =  serialize(root)
      deserialized.should eq test
    end
  end
end


