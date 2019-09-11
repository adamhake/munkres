# frozen_string_literal: true

# Models a two-dimensional matrix
class Matrix
  attr_reader :matrix
  def initialize(opts = {})
    @matrix = opts[:matrix] if opts[:matrix]
  end

  def self.initialize_by_cell(matrix)
    new_matrix = matrix.map.with_index do |row, i|
      row.map.with_index{ |cell, j| yield(cell, i, j) }
    end

    Matrix.new(matrix: new_matrix)
  end

  def map_cells
    matrix.map.with_index do |row, i|
      row.map.with_index{ |cell, j| yield(cell, i, j) }
    end
  end

  def map_cells!
    matrix.map!.with_index do |row, i|
      row.map.with_index{ |cell, j| yield(cell, i, j) }
    end
  end

  def map_rows
    matrix.map { |row| yield(row) }
  end

  def map_rows!
    matrix.map!.with_index { |row, i| yield(row, i) }
  end

  def row(index)
    matrix[index]
  end

  def col(index)
    matrix.map { |row| row[index] }
  end

  def set_col(index, value)
    map_rows! do |row|
      row[index] = value
      row
    end
  end

  def cell(row, col)
    matrix[row][col]
  end

  def set_cell(row, col, value)
    matrix[row][col] = value
  end

  def row_count
    matrix.length
  end

  def col_count
    matrix.first.length
  end

  def select_cells(&block)
    matches = []
    matrix.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        matches << [i, j] if block.call(cell)
      end
    end
    matches
  end

  def pretty_print
    matrix.each do |row|
      puts row.join(' ')
    end
    ''
  end
end
