def climb(n : Int32, k : Array(Int32))
    count = 0
    k.each do |step|
        if step > n
            break
        elsif step == n
            count += 1
            break
        else
            count += climb(n-step, k)
        end 
    end
    count
end

  
def climb_with_memoization(n : Int32, k : Array(Int32))
    return climb_with_memoization(n, k, {} of Int32 => Int32)
  end
  
private def climb_with_memoization(n : Int32, k : Array(Int32), memory : Hash(Int32, Int32))
    if memory.has_key? n
        return memory[n]
    end
  
    count = 0
    k.each do |step|
        if step > n
            break
        elsif step == n
            count += 1
            break
        else
            count += climb_with_memoization(n-step, k, memory)
        end 
    end
    memory[n] = count
    count
end

  