---
title: Staircase steps permutation
tags: recursion memoization

is_post: true
difficulty: difficult
---

### Problem Description

You have to climb a staircase that has `n` number of total steps in it. As you climb, you can only climb `step` steps at a time where `step` is a member of an array `k`. Determine all the possible ways you can climb the stairs up to `n`.

### Example

Input: `n=4`, `k=[2]`
Output: `1` Since you can take 2 steps and then again 2 steps.

Input: `n=4`, `k=[1,2]`
Output: `5` Since the possible ways are `[1,1,1,1], [1,1,2], [1,2,1], [2,2], [2,1,1]`

### Thought Process

At any point of your climb, you have `length(k)` possibilities of steps to choose from. However, not all of those possible values in `k` will lead you to exactly to the final step in staircase.

So, take a step forward for all possible values of `k` and if you happen to exactly traverse `n` steps, you can increase your answer by 1. If you've gone over `n` then discontinue your climbing, and if you're under `n` then continue climbing.

For simplicity sake, you can consider that `k` may contain duplicate but your solution can treat them as unique still.


### Solution
<small>[source code](https://github.com/algos-with-crystal/algos-with-crystal.github.io/blob/master/lib/staircase_steps_permutation.cr#L1){:target="_blank" rel="noopener"}</small>


```ruby
def climb(n : Int32, k : Array(Int32))
    return climb(n, k, n)
end

private def climb(n : Int32, k : Array(Int32), remaining_steps : Int32)
    count = 0

    k.each do |step|
        new_remaining_steps = remaining_steps - step
        if new_remaining_steps == 0
            return count + 1
        elsif new_remaining_steps > 0
            count += climb(n, k, new_remaining_steps)
        else
            return 0
        end
    end

    count
end
```

This solution has runtime of <code>O(k<sup>n</sup>)</code> as in each iteration, we have `k` possibilities until we reach `n`.
While this works, there is a possible optimization. Anytime you find out there are `x` ways to climb `p` steps, you can store that value and reuse it anytime you need to solve for total ways to climb `p` more steps again. This should reduce your runtime to `O(n*k)` with a memory footprint of `O(n)`.

<small>[source code](https://github.com/algos-with-crystal/algos-with-crystal.github.io/blob/master/lib/staircase_steps_permutation.cr#L22){:target="_blank" rel="noopener"}</small>

```ruby
def climb_with_memoization(n : Int32, k : Array(Int32))
    return climb_with_memoization(n, k, n, {} of Int32 => Int32)
  end

private def climb_with_memoization(n : Int32, k : Array(Int32), remaining_steps : Int32, memory : Hash(Int32, Int32))
    if memory.has_key? remaining_steps
        return memory[remaining_steps]
    end
  
    count = 0

    k.each do |step|
        new_remaining_steps = remaining_steps - step
        if new_remaining_steps == 0
            count += 1
            memory[new_remaining_steps] = count
            return count
        elsif new_remaining_steps > 0
            count += climb_with_memoization(n, k, new_remaining_steps, memory)
        else
            return 0
        end
    end

    count
end
```

And you can also trace the solutions.

<small>[source code](https://github.com/algos-with-crystal/algos-with-crystal.github.io/blob/master/lib/staircase_steps_permutation.cr#L49){:target="_blank" rel="noopener"}</small>

```ruby
def climb_with_memoization_trace(n : Int32, k : Array(Int32))  
    return climb_with_memoization_trace(n, k, n, {} of Int32 => Int32, [] of Int32)
end

private def climb_with_memoization_trace(n : Int32, k : Array(Int32), remaining_steps : Int32, memory : Hash(Int32, Int32), trace)
    if memory.has_key? remaining_steps
        return memory[remaining_steps]
    end
  
    count = 0
    k.each do |step|
        new_remaining_steps = remaining_steps - step
        if new_remaining_steps == 0
            count += 1
            memory[new_remaining_steps] = count
            puts (trace + [step])
            return count
        elsif new_remaining_steps > 0
            trace << step
            count += climb_with_memoization_trace(n, k, new_remaining_steps, memory, trace)
            trace.pop()
        else
            return 0
        end
    end

    count
end
```

**Spec**
<small>[source code](https://github.com/algos-with-crystal/algos-with-crystal.github.io/blob/master/lib/spec/staircase_steps_permutation_spec.cr){:target="_blank" rel="noopener"}</small>

```ruby
def climb_with_memoization_trace(n : Int32, k : Array(Int32))  
    return climb_with_memoization_trace(n, k, n, {} of Int32 => Int32, [] of Int32)
end

private def climb_with_memoization_trace(n : Int32, k : Array(Int32), remaining_steps : Int32, memory : Hash(Int32, Int32), trace)
    if memory.has_key? remaining_steps
        return memory[remaining_steps]
    end
  
    count = 0
    k.each do |step|
        new_remaining_steps = remaining_steps - step
        if new_remaining_steps == 0
            count += 1
            memory[new_remaining_steps] = count
            puts (trace + [step])
            return count
        elsif new_remaining_steps > 0
            trace << step
            count += climb_with_memoization_trace(n, k, new_remaining_steps, memory, trace)
            trace.pop()
        else
            return 0
        end
    end

    count
end
```

```ruby
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
```

{% include  fb_comments.html %}