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