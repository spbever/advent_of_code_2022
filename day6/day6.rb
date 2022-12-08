def detect_message_start(message, distinct_amount)
  chars = message.chars
  idx = 0
  idx += 1 while chars[idx..idx+distinct_amount-1].uniq.count != distinct_amount
  idx + distinct_amount
end

raise "Invalid part 1" unless detect_message_start(File.read("day6/inputs/test_input.txt"), 4) == 11
pp "Part 1: #{detect_message_start(File.read("day6/inputs/input.txt"), 4)}"

raise "Invalid part 2" unless detect_message_start(File.read("day6/inputs/test_input.txt"), 14) == 26
pp "Part 2: #{detect_message_start(File.read("day6/inputs/input.txt"), 14)}"