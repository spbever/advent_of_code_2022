def run_instructions(instructions)
  register = 1
  signal_strengths = []
  processing = false
  position = 0


  240.times do |idx|
    pixil = (position-1..position+1).include?(register) ? "#" : "."
    print pixil
    position +=1
    if position == 40
      puts ""
      position = 0
    end

    signal_strengths << register * (idx + 1) if (idx + 21) % 40 == 0
    next_instruction = instructions.peek
    if next_instruction.include?("noop")
      instructions.next
    elsif processing
      processing = false
      instructions.next
      register += next_instruction.split(" ").last.to_i
    else
      processing = true
    end
  end
  signal_strengths.sum
end

test_result = run_instructions(File.readlines("day10/inputs/test_input.txt", chomp: true).each)
raise "Part1 error: expected(13140) got(#{test_result})" unless test_result == 13140
puts "-"*25
part1_result = run_instructions(File.readlines("day10/inputs/input.txt", chomp: true).each)
pp "Part1: #{part1_result}"


####.####..##..####.####.#....#..#.####.
#....#....#..#....#.#....#....#..#.#....
###..###..#......#..###..#....####.###..
#....#....#.....#...#....#....#..#.#....
#....#....#..#.#....#....#....#..#.#....
#....####..##..####.####.####.#..#.####.

# FECZELHE