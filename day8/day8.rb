def calculate_visible_trees(tree_grid)
  visible_trees = 0
  tree_grid.each_with_index do |tree_row, col_idx|
    tree_row.each_with_index do |tree, row_idx|
      if col_idx == 0 || row_idx == 0 || col_idx == tree_grid.size - 1 || row_idx == tree_row.size - 1 ||
        tree_row[..row_idx-1].max < tree || tree_row[row_idx+1..].max < tree ||
        tree_grid[..col_idx-1].map{ |tr| tr[row_idx] }.max < tree || tree_grid[col_idx+1..].map{ |tr| tr[row_idx] }.max < tree
        visible_trees += 1
      end
    end
  end
  visible_trees
end

def calculate_highest_scenic_value(tree_grid)
  highest_scenic_value = 0
  tree_grid.each_with_index do |tree_row, col_idx|
    next if col_idx == 0 || col_idx == tree_grid.size - 1
    tree_row.each_with_index do |tree, row_idx|
      next if row_idx == 0 || row_idx == tree_row.size - 1
      above = 0
      tree_grid[..col_idx-1].reverse.each { |tr| above += 1; break unless tr[row_idx] < tree }
      below = 0
      tree_grid[col_idx+1..].each { |tr| below += 1; break unless tr[row_idx] < tree }
      left = 0
      tree_row[..row_idx-1].reverse.each { |tr| left += 1; break unless tr < tree }
      right = 0
      tree_row[row_idx+1..].each { |tr| right += 1; break unless tr < tree }
      scenic = above * below * left * right
      highest_scenic_value = scenic if scenic > highest_scenic_value
    end
  end
  highest_scenic_value
end

def build_tree_grid(file)
  File.readlines(file).map { |row| row.chomp.chars.map(&:to_i) }
end

test_solution =  calculate_visible_trees(build_tree_grid("day8/inputs/test_input.txt"))
raise "Error part 1: got(#{test_solution}) expected 21" unless test_solution == 21

test_solution =  calculate_highest_scenic_value(build_tree_grid("day8/inputs/test_input.txt"))
raise "Error part 2: got(#{test_solution}) expected 8" unless test_solution == 8

pp "Part 1: #{ calculate_visible_trees(build_tree_grid("day8/inputs/input.txt")) }"
pp "Part 2: #{ calculate_highest_scenic_value(build_tree_grid("day8/inputs/input.txt")) }"
