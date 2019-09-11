# frozen_string_literal: true

require('./munkres.rb')

cost_matrix = [
  [1, 2, 3, 4],
  [2, 4, 6, 8],
  [3, 6, 9, 12],
  [4, 8, 12, 16]
]

munk = Munkres.new(cost_matrix)
munk.step_one
munk.step_two
munk.step_three

puts '------ matrix -------'
munk.matrix.pretty_print
puts '------ starred zeros -------'
munk.starred_zeros.pretty_print
puts '------ covered zeros -------'
munk.covered_zeros.pretty_print