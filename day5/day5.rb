Part1Instruction = Struct.new(:amount, :starting, :destination)

def parse_part_1_instruction(line)
  Part1Instruction.new(*line.scan(/\d+/).map(&:to_i))
end

def run_part_1_instruction(instruction, stacks)
  instruction.amount.times do
    stacks[instruction.destination - 1] << stacks[instruction.starting - 1].pop
  end
end

def run_part_2_instruction(instruction, stacks)
  stacks[instruction.destination - 1] += stacks[instruction.starting - 1].pop(instruction.amount)
end

def build_columns(file)
  column_data = []
  num_columns = nil
  instructions = []

  File.readlines(file).each do |line|
    line.chomp!
    next if line.size == 0

    if num_columns.nil?
      if line =~ /\d/
        num_columns = line.scan(/\d+/).last.to_i
      else
        column_data << line
      end
    else
      instructions << parse_part_1_instruction(line)
    end
  end

  stacks = column_data.map do |column|
    column.ljust(4*num_columns, " ").chars.each_slice(4).map { |c| c.join.gsub(/[^A-Z]/, "") }
  end.reverse.reduce([]) do |stack, row|
      num_columns.times do |i|
        stack[i] ||= []
        stack[i] << row[i] unless row[i].length == 0
      end
      stack
    end

  p1_stacks = stacks.map { |stack| stack.clone }
  p2_stacks = stacks.map { |stack| stack.clone }
  instructions.each do |instruction|
    run_part_1_instruction instruction, p1_stacks
    run_part_2_instruction instruction, p2_stacks
  end

  pp "Part 1: #{p1_stacks.map(&:last).join}"
  pp "Part 2: #{p2_stacks.map(&:last).join}"
end