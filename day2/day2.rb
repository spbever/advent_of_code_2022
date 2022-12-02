class RPC
  SHAPE_SCORES = {
    rock: 1,
    paper: 2,
    scissors: 3,
  }.freeze

  OUTCOME_SCORES = {
    lost: 0,
    draw: 3,
    won: 6,
  }.freeze

  def self.play_tournament(tournament_file)
    total_score = 0
    File.readlines(tournament_file).each do |line|
      total_score += round_score(*line.split(" ").reverse)
    end
    total_score
  end

  def self.play_tournament_with_outcomes(tournament_file)
    total_score = 0
    File.readlines(tournament_file).each do |line|
      total_score += round_score_with_outcome(*line.split(" "))
    end
    total_score
  end

  private

  def self.round_score(your_pick, other_pick)
    round_score = SHAPE_SCORES[translate_pick(your_pick)]
    round_score += OUTCOME_SCORES[calculate_outcome(translate_pick(your_pick), translate_pick(other_pick))]
  end

  def self.round_score_with_outcome(other_pick, outcome)
    round_score = OUTCOME_SCORES[translate_outcome(outcome)]
    round_score += SHAPE_SCORES[calculate_shape(translate_pick(other_pick), translate_outcome(outcome))]
    round_score
  end

  def self.translate_pick(pick)
    case pick.to_s.downcase
    when "a", "x"
      :rock
    when "b", "y"
      :paper
    when "c", "z"
      :scissors
    end
  end

  def self.translate_outcome(code)
    case code.to_s.downcase
    when "x"
      :lost
    when "y"
      :draw
    when "z"
      :won
    end
  end

  def self.calculate_outcome(your_pick, other_pick)
    pick_options = [:rock, :paper, :scissors]
    pick_options << pick_options.shift while pick_options[0] != your_pick
    [:draw, :lost, :won][pick_options.index(other_pick)]
  end

  def self.calculate_shape(other_pick, outcome)
    outcomes = [:draw, :won, :lost]
    pick_options = [:rock, :paper, :scissors]
    pick_options << pick_options.shift while pick_options[0] != other_pick
    pick_options[outcomes.index(outcome)]
  end
end


def run_part_1_test
  test_solution = RPC.play_tournament("day2/inputs/test_input.txt")
  raise "Invalid solution: got(#{test_solution}) and expected(15)" unless  test_solution ==  15
end

def run_part_2_test
  test_solution = RPC.play_tournament_with_outcomes("day2/inputs/test_input.txt")
  raise "Invalid solution: got(#{test_solution}) and expected(12)" unless  test_solution ==  12
end

def solution
  puts "Part 1: #{RPC.play_tournament("day2/inputs/input.txt")}"
  puts "Part 2: #{RPC.play_tournament_with_outcomes("day2/inputs/input.txt")}"
end

run_part_1_test
run_part_2_test
solution