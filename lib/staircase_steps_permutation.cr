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