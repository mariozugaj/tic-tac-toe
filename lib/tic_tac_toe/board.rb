module TicTacToe
  # Board setup and logic
  class Board
    attr_reader :grid
    def initialize(args = {})
      @grid = args.fetch(:grid, default_grid)
    end

    def get_cell(first_coordinate, second_coordinate)
      grid[first_coordinate][second_coordinate]
    end

    def set_cell(first_coordinate, second_coordinate, value)
      get_cell(first_coordinate, second_coordinate).value = value
    end

    def game_over
      return :winner if winner?
      return :draw if draw?
      false
    end

    def formatted_grid
      grid.each do |row|
        puts row.map { |cell| cell.value.empty? ? '[ ]' : "[#{cell.value}]" }.join(' ')
      end
    end

    private

    def draw?
      grid.flatten.map(&:value).none_empty?
    end

    def winner?
      winning_positions.each do |winning_position|
        next if winning_position_values(winning_position).all_empty?
        return true if winning_position_values(winning_position).all_same?
      end
      false
    end

    def winning_position_values(winning_position)
      winning_position.map(&:value)
    end

    def winning_positions
      grid + # rows
        grid.transpose + # columns
        diagonals # two diagonals
    end

    def diagonals
      [
        [get_cell(0, 0), get_cell(1, 1), get_cell(2, 2)],
        [get_cell(0, 2), get_cell(1, 1), get_cell(2, 0)]
      ]
    end

    def default_grid
      Array.new(3) { Array.new(3) { Cell.new } }
    end
  end
end
