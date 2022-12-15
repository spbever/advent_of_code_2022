TEST_MONKEYS = [
  {
    items: [79, 98],
    operation: proc { |old| old * 19 },
    test: proc {|value, mod| value % mod == 0 ? 2 : 3 },
    mod: 23,
    inspections: 0
  },
  {
    items: [54, 65, 75, 74],
    operation: proc { |old| old + 6 },
    test: proc {|value, mod| value % mod == 0 ? 2 : 0 },
    mod: 19,
    inspections: 0
  },
  {
    items: [79, 60, 97],
    operation: proc { |old| old * old },
    test: proc {|value, mod| value % mod == 0 ? 1 : 3 },
    mod: 13,
    inspections: 0
  },
  {
    items: [74],
    operation: proc { |old| old + 3 },
    test: proc {|value, mod| value % mod == 0 ? 0 : 1 },
    mod: 17,
    inspections: 0
  }
]
=begin
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
=end
