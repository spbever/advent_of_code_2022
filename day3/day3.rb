def priority(letter)
  (('a'..'z').to_a + ("A".."Z").to_a).index(letter) + 1
end

def part_1(file)
  File.readlines(file).map(&:chomp).sum { |line| priority line.chars.each_slice(line.length / 2).to_a.reduce(&:&).first  }
end

def part_2(file)
  File.readlines(file).map(&:chomp).each_slice(3).to_a.sum { |group| priority group.map { |line| line.split("") }.reduce(&:&).first }
end

def part_1_test
  test_solution = part_1 "day3/inputs/test_input.txt"
  raise "Invalid solution for part 1: got(#{test_solution}) and expected(157)" unless  test_solution ==  157
end

def part_2_test
  test_solution = part_2 "day3/inputs/test_input.txt"
  raise "Invalid solution for part 2: got(#{test_solution}) and expected(70)" unless  test_solution ==  70
end

def solutions
  part_1_solution = part_1 "day3/inputs/input.txt"
  part_2_solution = part_2 "day3/inputs/input.txt"

  pp "Part 1: #{part_1_solution}"
  pp "Part 2: #{part_2_solution}"
end

part_1_test
part_2_test
solutions