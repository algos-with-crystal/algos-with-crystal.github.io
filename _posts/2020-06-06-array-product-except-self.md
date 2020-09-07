---
title: Array product except self
tags: array medium

is_post: true
difficulty: medium
---

### Problem Description

You are provided an array `k` of `n` integers. Return a new array where each element is the product of all elements in `k` except self. Assume that `n > 1` and all elements in `k` are greater than `1`.


### Example

Input: `k=[1, 2, 3, 4]`
Output: `[24, 12, 8, 6]` Since `24 = 2x3x4, 12 = 1x3x4, 8 = 1x2x4, 6 = 1x2x3`

### Thought Process

This can be easily computed by first generating a product of all numbers in `k` and for dividing it by the value in `k[i]` for each element `i` in output.
However, the challenge here is to do it without division, and with a runtime of `O(n)`.

Let's start with the element at index `i=0`. It has a value of `24` which is calculated only by multiplying the elements at index `i=1,2,3`. Similarly, the last index element `i=3` with value of `6` is calculated by multiplying the first 3 elements at index `i=0,1,2` only. How about the middle elements? Let's try for index `i=1`. It's value `12` rnd that requires multiplying values at `i=0` and `i=2,3`. And same goes for value at index `i=2`. It requires multiplying elements at index `i=0,1` and `i=3`. There is a pattern here. For any index `i` we need to know the product of elements before `i` and also right after `i`, and multiply those two values.

Let's imagine a helper method `a` that takes `i` and provides product of elements from index `0` to `i-1`.
And another helper method `b` that takes `i` and provides product of elements from index `i+1` to `n`.

So any element at index `i` has value of `a(i) * b(i)`.

If method `a` were simply an array, it would look like `[1, 1, 2, 6]` for our above example. The first element has to be `1` because it is the identity for multiplication. Similarly, the array representation for `b` would look like `[24, 12, 4, 1]`. Again, the last element has to be `1`.


The following code below is a solution to the problem.


### Solution
<small>[source code](https://github.com/algos-with-crystal/algos-with-crystal.github.io/blob/master/lib/array_product_except_self.cr){:target="_blank" rel="noopener"}</small>


```ruby
def product(k : Array(Int32)) : Array(Int32)
    pre = construct_pre_product(k)
    post = construct_post_product(k)

    (0...(k.size())).map {|i| pre[i] * post[i] }
end

private def construct_pre_product(k : Array(Int32)) : Array(Int32)
    prev = 1
    output = [1]

    0.upto(k.size() - 2) do |i|
        prev *= k[i]
        output << prev
    end

    output
end

private def construct_post_product(k : Array(Int32)) : Array(Int32)
    prev = 1
    output = [1]

    (k.size() - 1).downto(1) do |i|
        prev *= k[i]
        output.unshift(prev)
    end

    output
end
```

**Spec**
<small>[source code](https://github.com/algos-with-crystal/algos-with-crystal.github.io/blob/master/lib/spec/array_product_except_self_spec.cr){:target="_blank" rel="noopener"}</small>

```ruby
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
```