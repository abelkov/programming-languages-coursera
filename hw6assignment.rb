# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

require_relative './hw6provided'

class MyTetris < Tetris
  def key_bindings
  	super()
  	@root.bind('u', proc {@board.move(:cw); @board.move(:cw)})
  end

end

class MyPiece < Piece
  # class array holding all the pieces and their rotations
  All_My_Pieces = [[[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
               rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
               [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
               [[0, 0], [0, -1], [0, 1], [0, 2]]],
               rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
               rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
               rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
               rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]), # Z
               rotations([[0, 0], [1, 0], [0, 1], [1, 1], [2, 1]]),
               [[[0, 0], [-1, 0], [1, 0], [2, 0], [3, 0]], # very long
               [[0, 0], [0, -1], [0, 1], [0, 2], [0, 3]]],
               rotations([[0, 0], [0, -1], [1, 0]])]  

	def self.next_piece (board)
		Piece.new(All_My_Pieces.sample, board)
  end

end

class MyBoard < Board
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..locations.length-1).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end

end
