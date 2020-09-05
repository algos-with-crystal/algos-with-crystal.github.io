---
title: Pair Sum to K
tags: map

is_post: true
difficulty: easy
---


### Problem Description

You're provided an array list of integers `numbers` and an int `k`. Determine if any two numbers in `numbers` will sum up to `k` or not.

### Example
Input: `numbers = [1, 2]`, `k=3`
Output: `True`

Input: `numbers = [1, 2]`, `k=2`
Output: `False`

Input: `numbers = [1, 2, 3, 4, 5, 6, 7, 8, -8]`, `k=0`
Output: `True`

### Thought Process

For each number `n` in the `numbers` you will need to determine if `k-n` also exists in `numbers`. You can achieve this by looping over the list twice. This approach has a low constant memory footprint, but has a runtime of `O(N^2)`.

In order to improve runtime, you can take a slightly different approach. Essentially, for each number, you can also check if `k-n` already exists in the list. If it does, then output must be `True`. Using this approach, in a single iteration, you can build the HashMap as well as check if `k-n` already exists. This approach will incur `O(N)` of memory but also a runtime of `O(N)`.

### Solution
Code
<small>[source code](https://github.com/algos-with-crystal/algos-with-crystal.github.io/blob/master/lib/pair_sum_to_k.cr){:target="_blank" rel="noopener"}</small>


```
def has_pair_sum(numbers : Array(Int32), k : Int32) : Bool
    if numbers.size < 2
      return false
    end
  
    map = {} of Int32 => Bool
  
    numbers.each do |n|
      diff = k - n
      if map.has_key? diff
        return true
      end
      map[n] = true
    end

    false
  end
  ```

Spec 
<small>[source code](https://github.com/algos-with-crystal/algos-with-crystal.github.io/blob/master/lib/spec/pair_sum_to_k_spec.cr){:target="_blank" rel="noopener"}</small>


```
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
```

{% include  fb_comments.html %}