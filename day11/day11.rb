require_relative  "../day11/inputs/input"
require_relative  "../day11/inputs/test_input"

class Monkey
  def initialize monkey_hsh, worry_reducer
    @items = monkey_hsh[:items].clone
    @operation = monkey_hsh[:operation]
    @test = monkey_hsh[:test]
    @inspections = 0
    @mod = monkey_hsh[:mod]
    @worry_reducer = worry_reducer
  end

  def add_items items, magic_num
    @items = @items + items.map{ |w| w % magic_num }
  end

  def inspections
    @inspections
  end

  def mod
    @mod
  end

  def process_item
    item = @items.shift
    @inspections += 1
    new_value = @operation.call(item) / @worry_reducer
    new_monkey = @test.call(new_value, @mod)
    [new_monkey, new_value]
  end

  def process_all_items
    results = []
    results << process_item while !@items.empty?
    results.reduce({}) {|r, (monkey, worry)| r[monkey] ||= []; r[monkey] << worry; r }
  end

end

def process_monkeys(monkeys, rounds, worry_reducer)
  ms = monkeys.map { |m| Monkey.new(m, worry_reducer) }
  magic_num = ms.map(&:mod).reduce(&:*)

  rounds.times do |r|
    ms.each do |m|
      results = m.process_all_items
      results.each do |monkey, worries|
        passed_to_monkey = ms[monkey]
        passed_to_monkey.add_items worries, magic_num
      end
    end
  end
  ms
end

def get_total_worry_level(monkeys)
  monkeys.map { |m| m.inspections }.sort.last(2).reduce(:*)
end

part1_test_result = get_total_worry_level(process_monkeys(TEST_MONKEYS, 20, 3))
raise "Part1 Test: expected(10605) got(#{part1_test_result})" unless part1_test_result == 10605

part1_result = get_total_worry_level(process_monkeys(MONKEYS, 20, 3))
puts "Part1: #{part1_result}"


part2_test_result = get_total_worry_level(process_monkeys(TEST_MONKEYS, 10000, 1))
raise "Part2 Test: expected(2713310158) got(#{part2_test_result})" unless part2_test_result == 2713310158

part2_result = get_total_worry_level(process_monkeys(MONKEYS, 10000, 1))
puts "Part2: #{part2_result}"
