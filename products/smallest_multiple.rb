#!/usr/bin/env ruby
# Smallest multiple that can be divided without remainder
# by all the number from 1..N, where N is the commandline
# argument passed to this script.
#
# Eg. ruby smallest_multiple.rb 10 -> 2520

chosen = []
limit = ARGV[0].to_i(10)

for factor in (2..limit).to_a
  chosen << chosen.inject(factor) { |f,c| f%c == 0 ? f/c : f }
end

puts chosen.inject(:*)
