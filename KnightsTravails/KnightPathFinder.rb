require_relative "../PolyTreeNode/lib/00_tree_node"

class KnightPathFinder

    attr_accessor :root_node

    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        @considered = [start_pos]
        build_move_tree
    end

    def inspect
        puts "root: #{root_node.value}"
        "considered #{@considered}"
    end

    def self.valid_moves(pos)
        moves = [[(pos.first - 2), (pos.last - 1)], 
        [(pos.first - 2), (pos.last + 1)], 
        [(pos.first - 1), (pos.last - 2)],
        [(pos.first - 1), (pos.last + 2)],
        [(pos.first + 1), (pos.last - 2)],
        [(pos.first + 1), (pos.last + 2)],
        [(pos.first + 2), (pos.last - 1)],
        [(pos.first + 2), (pos.last + 1)]]
        moves.select { |move| move.first >= 0 && move.first <= 7 && move.last >= 0 && move.last <= 7 }
    end

    def new_positions(pos)
        new_moves = []
        KnightPathFinder.valid_moves(pos).each do |move|
            if @considered.none?(move)
                new_moves << move
                @considered << move
            end
        end
        new_moves
    end

    def build_move_tree
        queue = []
        queue << @root_node

        until queue.empty?
            dequeued = queue.shift
            new_positions(dequeued.value).each do |move|
                move_node = PolyTreeNode.new(move)
                move_node.parent = dequeued
                queue << move_node
            end
        end
    end


    def find_path(target)
        @root_node.dfs(target)
    end


    def trace_path_back(target)
        target_node = find_path(target)
        path = []
        current_node = target_node
        until current_node.parent == nil || current_node = @root_node
            path.unshift(current_node.value)
            current_node = current_node.parent
        end
        path
    end

end