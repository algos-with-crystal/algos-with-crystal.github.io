---
title: First missing positive integer
tags: array difficult

is_post: true
difficulty: difficult
---

### Problem Description

You are provided an array of integers. Find the smallest positive integer that is missing from the array.

### Example
Input: `[1, 3]`
Output: `2`

Input: `[-1, 0]`
Output: `1`

Input: `[-5, 3, -1, 0, 1, 2, -9]`
Output: `4`

### Thought Process

It helps solving a simpler version of this problem first. Consider cases where the input `list` only has positive numbers (1 and up), e.g `[3, 1, 5]`. If the list were to be sorted, `[1, 3, 5]` then the `index` in the list where `index + 1 != list[index]`, then that value must be the missing element. So in this example, index `0` has value `1`, but index `1` has value `3` so value `2` is the needed answer.

However, if you are restricted to limit your runtime to `O(n)` and constant memory footprint, then sorting is not an option anymore. How else can it be denoted that certain value exists in the array? Back to the example `[3, 1, 5]`, while reading the first item `3` in list, you could make the 3rd item in the list to be negative, indicating that `3` exists in list. The list now becomes `[3, 1, -5]`. Then read the second element `1`, and convert the first item to be negative. The list now becomes `[-3, 1, -5]`. Read the final element in list. Remember to read an absolute value since it could have been tainted before. Since the list has no 5th item, it can be ignored.

Now, iterate through the final list and the index where you do not find a negative number, that `index + 1` is the needed solution. So, in above example, `2` is the minimal positive integer that is missing.

Let us now make it a bit harder and make it so that the list contains 0 and negative numbers. Well, the original concept still remains the same if we could isolate all the positive numbers in a separate list. You can create a new smaller list with just the positive numbers and reuse your algorithm on the positive only list. What if you are not allowed to create the new list structures? In that case, the list can be rearranged so that all the positive numbers are to the left most side of the list while 0 and negatives are on the right end. Now effectively you have a smaller list with just positive numbers.

### Solution
<small>[source code](https://github.com/algos-with-crystal/algos-with-crystal.github.io/blob/master/lib/first_missing_positive_integer.cr){:target="_blank" rel="noopener"}</small>


```ruby
def first_missing_positive_integer(list : Array(Int32))
    positive_index_till = rearrange_positives(list)
    first_missing_positive_integer(list, positive_index_till) 
end

private def first_missing_positive_integer(list : Array(Int32), till)
    (0..till).each do |i|
        positive_index = list[i].abs() - 1

        if (positive_index <= till)
            list[positive_index] = -list[positive_index].abs()
        end
    end

    first_positive_index = 0
    while (first_positive_index <= till && list[first_positive_index] < 0)
        first_positive_index += 1
    end

    first_positive_index + 1
end

# rearranges original list with all positive integers contiguously on the left side
# returns the index with last positive number in list, or -1 if none
private def rearrange_positives(list : Array(Int32))
    start_pointer = 0
    size = list.size()
    end_pointer  = size - 1

    while (true)
        while(start_pointer < size && list[start_pointer] > 0)
            start_pointer += 1
        end

        while(end_pointer > -1 && list[end_pointer] < 1)
            end_pointer -= 1
        end

        if end_pointer < start_pointer
            break
        end

        temp = list[start_pointer]
        list[start_pointer] = list[end_pointer]
        list[end_pointer] = temp

        start_pointer += 1
        end_pointer -= 1
    end

    start_pointer - 1
end
```

**Spec**
<small>[source code](https://github.com/algos-with-crystal/algos-with-crystal.github.io/blob/master/lib/spec/first_missing_positive_integer_spec.cr){:target="_blank" rel="noopener"}</small>

```ruby
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
```