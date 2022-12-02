def build_backpacks(file_name)
  backpacks = [[]]
  File.readlines(file_name).each do |line|
    line.chomp!
    if line.length == 0
      backpacks << []
    else
      backpacks.last << line.to_i
    end
  end
  backpacks
end

def largest_backpacks(backpacks)
  backpacks.map(&:sum).max
end

def top_3_largest_backpacks_total(backpacks)
  backpacks.map(&:sum).sort[-3..-1].sum
end

def run_part_1_test
  test_solution = largest_backpacks(build_backpacks("day1/inputs/test_input.txt"))
  raise "Invalid solution: got(#{test_solution}) and expected(24000)" unless  test_solution ==  24_000
end

def run_part_2_test
  test_solution = top_3_largest_backpacks_total(build_backpacks("day1/inputs/test_input.txt"))
  raise "Invalid solution: got(#{test_solution}) and expected(45000)" unless  test_solution ==  45_000
end
def solution
  puts "Part 1: #{largest_backpacks(build_backpacks("day1/inputs/input.txt"))}"
  puts "Part 2: #{top_3_largest_backpacks_total(build_backpacks("day1/inputs/input.txt"))}"
end

run_part_1_test
run_part_2_test
solution
