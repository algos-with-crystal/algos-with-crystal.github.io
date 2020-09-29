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