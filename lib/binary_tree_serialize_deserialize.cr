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