class PolyTreeNode
    attr_accessor :children, :parent, :value
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def inspect
        target_node = self
        path = []
        current_node = target_node
        until current_node.parent == nil
            path.unshift(current_node.value)
            current_node = current_node.parent
        end
        path.unshift(current_node.value)
        path
    end

    def parent=(new_parent_node)
        @parent.children.delete(self) if @parent != nil
        @parent = new_parent_node
        @parent.children << self if @parent != nil
    end

    def add_child(child)
        child.parent = self
    end

    def remove_child(child)
        raise "Not a child." if child != nil && @children.none?(child)
        child.parent = nil
    end

    def dfs(target)
        return self if self.value == target
        self.children.each do |child|
            searched = child.dfs(target)
            return searched unless searched == nil
        end
        nil
    end

    def bfs(target)
        queue = []
        queue << self
        until queue.empty?
            first_node = queue.shift
            return first_node if first_node.value == target
            queue += first_node.children
        end
        nil
    end
end