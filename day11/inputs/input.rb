MONKEYS = [
  {
    items: [64, 89, 65, 95],
    operation: proc { |old| old * 7 },
    test: proc {|value, mod| value % mod == 0 ? 4 : 1 },
    mod: 3,
    inspections: 0
  },
  {
    items: [76, 66, 74, 87, 70, 56, 51, 66],
    operation: proc { |old| old + 5 },
    test: proc {|value, mod| value % mod == 0 ? 7 : 3 },
    mod: 13,
    inspections: 0
  },
  {
    items: [91, 60, 63],
    operation: proc { |old| old * old },
    test: proc {|value, mod| value % mod == 0 ? 6 : 5 },
    mod: 2,
    inspections: 0
  },
  {
    items: [92, 61, 79, 97, 79],
    operation: proc { |old| old + 6 },
    test: proc {|value, mod| value % mod == 0 ? 2 : 6 },
    mod: 11,
    inspections: 0
  },
  {
    items: [93, 54],
    operation: proc { |old| old * 11},
    test: proc {|value, mod| value % mod == 0 ? 1 : 7 },
    mod: 5,
    inspections: 0
  },
  {
    items: [60, 79, 92, 69, 88, 82, 70],
    operation: proc { |old| old + 8 },
    test: proc {|value, mod| value % mod == 0 ? 4 : 0 },
    mod: 17,
    inspections: 0
  },
  {
    items: [64, 57, 73, 89, 55, 53],
    operation: proc { |old| old + 1 },
    test: proc {|value, mod| value % mod == 0 ? 0 : 5 },
    mod: 19,
    inspections: 0
  },
  {
    items: [62],
    operation: proc { |old| old + 4 },
    test: proc {|value, mod| value % mod == 0 ? 3 : 2 },
    mod: 7,
    inspections: 0
  }
]

=begin
   Monkey 0:
    Starting items: 64, 89, 65, 95
      Operation: new = old * 7
        Test: divisible by 3
        If true: throw to monkey 4
        If false: throw to monkey 1

Monkey 1:
  Starting items: 76, 66, 74, 87, 70, 56, 51, 66
    Operation: new = old + 5
    Test: divisible by 13
    If true: throw to monkey 7
    If false: throw to monkey 3

Monkey 2:
  Starting items: 91, 60, 63
Operation: new = old * old
Test: divisible by 2
If true: throw to monkey 6
If false: throw to monkey 5

Monkey 3:
  Starting items: 92, 61, 79, 97, 79
Operation: new = old + 6
Test: divisible by 11
If true: throw to monkey 2
If false: throw to monkey 6

Monkey 4:
  Starting items: 93, 54
Operation: new = old * 11
Test: divisible by 5
If true: throw to monkey 1
If false: throw to monkey 7

Monkey 5:
  Starting items: 60, 79, 92, 69, 88, 82, 70
Operation: new = old + 8
Test: divisible by 17
If true: throw to monkey 4
If false: throw to monkey 0

Monkey 6:
  Starting items: 64, 57, 73, 89, 55, 53
Operation: new = old + 1
Test: divisible by 19
If true: throw to monkey 0
If false: throw to monkey 5

Monkey 7:
  Starting items: 62
Operation: new = old + 4
Test: divisible by 7
If true: throw to monkey 3
If false: throw to monkey 2
=end
