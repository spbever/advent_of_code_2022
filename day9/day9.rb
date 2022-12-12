require "Set"
# position [vertical, horizontal]
# starting at 0,0
# log hash{vertical: set(horizontal)}

Rope = Struct.new(:head, :tail, :tail_location_log)

def tail_next_to_head?(rope)
  (rope.head[0] - rope.tail[0]).abs <= 1 && (rope.head[1] - rope.tail[1]).abs <= 1
end

def total_rope_tail_locations(rope)
  rope.tail_location_log.sum { |_vertical, horizontal_set| horizontal_set.size }
end

def move_tail(rope)
  vertical_difference = rope.head[0] - rope.tail[0]
  horizontal_difference = rope.head[1] - rope.tail[1]

  if vertical_difference.abs > 1
    rope.tail[0] += vertical_difference > 0 ? 1 : -1
    rope.tail[1] += horizontal_difference > 0 ? 1 : -1 if horizontal_difference.abs >= 1
  elsif horizontal_difference.abs > 1
    rope.tail[1] += horizontal_difference > 0 ? 1 : -1
    rope.tail[0] += vertical_difference > 0 ? 1 : -1 if vertical_difference.abs >= 1
  end
  rope.tail_location_log[rope.tail[0]] ||= Set.new
  rope.tail_location_log[rope.tail[0]].add rope.tail[1]
end

def move_head(rope, direction)
  case direction
  when "R"
    rope.head[1] += 1
  when "L"
    rope.head[1] -= 1
  when "U"
    rope.head[0] += 1
  when "D"
    rope.head[0] -= 1
  end
  move_tail(rope) unless tail_next_to_head?(rope)
end

def part1_follow_rope_instruction(rope, instruction)
  direction, times = instruction.split(" ")
  times.to_i.times do
    move_head(rope, direction)
  end
end

def run_part1_instruction_set(instructions)
  rope = Rope.new([0,0], [0,0], {})
  rope.tail_location_log[0] = Set.new([0])
  instructions.each {|i| part1_follow_rope_instruction(rope, i) }
  rope
end

def part2_follow_rope_instruction(ropes, instruction)
  direction, times = instruction.split(" ")
  times.to_i.times do
    move_head(ropes.first, direction)
    ropes.each_cons(2) do |hrope, trope|
      trope.head = hrope.tail.clone

      move_tail(trope) unless tail_next_to_head?(trope)
    end
  end
end

def run_part2_instruction_set(instructions)
  ropes = []
  9.times do
    rope = Rope.new([0,0], [0,0], {})
    rope.tail_location_log[0] = Set.new([0])
    ropes << rope
  end

  instructions.each do |i|
    part2_follow_rope_instruction(ropes, i)
  end
  ropes
end

test_instructions = File.readlines("day9/inputs/test_input.txt")
test_instructions2 = File.readlines("day9/inputs/test_input2.txt")
real_instructions = File.readlines("day9/inputs/input.txt")

part1_test = run_part1_instruction_set(test_instructions)
part1_test_got = total_rope_tail_locations(part1_test)
raise "Part1 error: got(#{part1_test_got}) expected(13)" unless part1_test_got == 13



part2_test = run_part2_instruction_set(test_instructions)
part2_test_got = total_rope_tail_locations(part2_test.last)
raise "Part1 error: got(#{part2_test_got}) expected(1)" unless part2_test_got == 1

part2_test2 = run_part2_instruction_set(test_instructions2)
part2_test_got2 = total_rope_tail_locations(part2_test2.last)
raise "Part1 error: got(#{part2_test_got2}) expected(36)" unless part2_test_got2 == 36

part1 = run_part1_instruction_set(real_instructions)

part1_got = total_rope_tail_locations(part1)


pp "Part1: #{part1_got}"

part2 = run_part2_instruction_set(real_instructions)

part2_got = total_rope_tail_locations(part2.last)


pp "Part2: #{part2_got}"
