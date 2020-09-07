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