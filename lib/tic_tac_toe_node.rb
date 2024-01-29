require_relative 'tic_tac_toe'



class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos


  end

  def losing_node?(evaluator)
    if board.over?
      return board.won? && board.winner != evaluator
    end
    if self.next_mover_mark == evaluator
      self.children.all? do |node|
        node.losing_node?(evaluator)
      end
    else
      self.children.any? do |node|
        node.losing_node?(node.next_mover_mark)
      end
    end

  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    arr = []
    (0..2).each do |i|
      (0..2).each do |j|
        pos = [i, j]
        board_dup = board.dup
        if board_dup.empty?(pos)
          board_dup[pos] = self.next_mover_mark
          mark = (self.next_mover_mark == :x ? :o : :x)
          arr << TicTacToeNode.new(board_dup, mark, pos)
        end
      end
    end
    arr


  end
end
