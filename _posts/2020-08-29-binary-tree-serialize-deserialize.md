---
title: Binary tree serialize and deserialize
tags: recursion tree medium 

is_post: true
difficulty: medium
---

### Problem Description

You are provided the root node `root` for a binary tree. Implement a `serialize` function to serialize the tree into an array or a string. Additionally, implement `deserialize` function to convert it back to the binary tree. It does not matter what the serialized representation looks like as long as it gets correctly deserialized. 
Remember than a node can have up to 2 child nodes.

### Example

An example binary tree might look like one below. Here, `o` denotes root, `l` is left, `r` is right, and `-` is null node. Note that each node's left and right node need to be explored in order to determine that the node is truly a leaf node.

```
                   o
         ol                 or
      -      olr         orl   orr
          olrl  -       -  -   -  -
         -   -
```



### Thought Process

Since this problem is a tree problem, recursive approach will come in handy. There are several ways to traverse a binary tree like in-order, pre-order, post-order and level-order. Each of those traversal methods will reach every node in the tree. So as you traverse, store the values in an array during serialization. Terminal null nodes can be represented with special character `-` for simplicity.

Once serialized, reverse of serialization method can be used to deserialize it back to a tree.


The following solution below user pre-order traversal technique to serialize and deserialize the tree. 


### Solution
<small>[source code](https://github.com/algos-with-crystal/algos-with-crystal.github.io/blob/master/lib/binary_tree_serialize_deserialize.cr){:target="_blank" rel="noopener"}</small>


```ruby
NULL_NODE_MARKER = "-"

class Node
    getter value
    property left : Node?
    property right : Node?

    def initialize(@value : String)
    end
end

def serialize(root : Node?)
    output = [] of String
    pre_order_serialize(root, output)
    output
end

def deserialize(list : Array(String))
    pre_order_deserialize(list.clone)
end


private def pre_order_serialize(node : Node?, output : Array(String))
    if node.nil?
        output.push(NULL_NODE_MARKER)
    else
        output.push(node.value)
        pre_order_serialize(node.left, output)
        pre_order_serialize(node.right, output)
    end
end

private def pre_order_deserialize(list : Array(String))
    if(list.size > 0)
        item = list.shift()
        if item != NULL_NODE_MARKER
            node = Node.new item
            node.left = pre_order_deserialize(list)
            node.right = pre_order_deserialize(list)
            return node
        end
    end
end
```

During serialization, it stores the node's value in an array list. If the node happens to be null, then it stores `-` for it. After inserting itself into the output array list, it repeats the process for the left child node, and then the right. 

Deserialization follow the opposite pattern. It pops the first item in the list, since the root would've been the first item to be serialized as well. Then it assigns the left node, and right node recursively with the remaining items in the list. If the list value happens to be `-`, it stops further recursion and unwinds. This is when the program switches from assigning left child node to right, and eventually move control back to parent node from child nodes. And if there are no more items left in the list, the recursion halts.

I recommend putting debug statements in the program as it can be helpful for reasoning.

**Spec**
<small>[source code](https://github.com/algos-with-crystal/algos-with-crystal.github.io/blob/master/lib/spec/binary_tree_serialize_deserialize_spec.cr){:target="_blank" rel="noopener"}</small>

```ruby
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



```