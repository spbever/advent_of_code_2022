def part_1(file)
  File.readlines(file).map(&:chomp).count do |line|
    first, second = line.split(",").map { |range| range.split("-").map(&:to_i) }
    (first[0] >= second[0] && first[1] <= second[1]) || (first[0] <= second[0] && first[1] >= second[1])
  end
end

def part_2(file)
  File.readlines(file).map(&:chomp).count do |line|
    first, second = line.split(",").map { |range| range.split("-") }.map{ |s, e| (s.to_i..e.to_i).to_a }
    !(first & second).empty?
  end
end

def part_1_test
  test_solution = part_1 "day4/inputs/test_input.txt"
  raise "Invalid solution for part 1: got(#{test_solution}) and expected(2)" unless  test_solution ==  2
end

def part_2_test
  test_solution = part_2 "day4/inputs/test_input.txt"
  raise "Invalid solution for part 2: got(#{test_solution}) and expected(4)" unless  test_solution ==  4
end


def solutions
  pp "Solution part 1: #{part_1("day4/inputs/input.txt")}"
  pp "Solution part 2: #{part_2("day4/inputs/input.txt")}"
end

part_1_test
solutions