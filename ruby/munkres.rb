# frozen_string_literal: true

require('./matrix');
#  Munkres algorithm implemented in ruby
class Munkres
  attr_reader :matrix, :original_matrix, :starred_zeros, :covered_zeros, :k
  def initialize(cost_matrix)
    @matrix = Matrix.new(matrix: cost_matrix)
    @original_matrix = Matrix.new(matrix: cost_matrix)
    @starred_zeros = Matrix.initialize_by_cell(cost_matrix) { false }
    @covered_zeros = Matrix.initialize_by_cell(cost_matrix) { false }
    @k = [matrix.row_count, matrix.col_count].min
  end

  # For each row of the matrix, find the smallest element and subtract it from
  # every element in its row.
  def step_one
    matrix.map_rows! do |row|
      min = row.min
      row.map { |cell| cell - min }
    end
  end

  # Find a zero in the resulting matrix.  If there is no starred zero in its
  # row or column, star Z Repeat for each element in the matrix
  def step_two
    zeros = find_starrable_zeros
    return unless zeros.any?

    zeros.each do |zero|
      row = zero.first
      col = zero.last
      starred_zeros.set_cell(row, col, true) if zero_starrable?(row, col)
    end
  end

  # Cover each column containing a starred zero.  If K columns are covered,
  # the starred zeros describe a complete set of unique assignments.
  def step_three
    zeros = starred_zeros.select_cells { |cell| cell }
    zeros.each do |zero|
      covered_zeros.set_col(zero[1], true)
    end
  end

  def zero_starrable?(row, col)
    !starred_zeros.cell(row, col) &&
      !starred_zeros.row(row).include?(true) &&
      !starred_zeros.col(col).include?(true)
  end

  def find_starrable_zeros
    matrix.select_cells(&:zero?)
  end
end
