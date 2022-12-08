DirectoryStruct = Struct.new(:parent, :name, :files, :directories, :total_size) do
  def total_size_calc
    directories.sum(&:total_size_calc) + files.sum(&:size)
  end
end
FileStruct = Struct.new(:name, :size)

def build_system(file)
  base = DirectoryStruct.new(nil, "/", [], [])
  current_directory = base
  File.readlines(file).each do |command|
    parts = command.chomp.split(" ")
    if parts[0] == "$"
      if parts[1] == "cd"
        if parts[2] == "/"
          current_directory = base
        elsif parts[2] == ".."
          current_directory = current_directory.parent unless current_directory.parent.nil?
        else
          new_directory = current_directory.directories.find {|directory| directory.name == parts[2] }
          new_directory = DirectoryStruct.new(current_directory, parts[2], [], []) if new_directory.nil?
          current_directory = new_directory
        end
      end
    elsif parts[0] == "dir"
      directory = current_directory.directories.find { |directory| directory.name == parts[1] }
      current_directory.directories << DirectoryStruct.new(current_directory, parts[1], [], [])  if directory.nil?
    else # is file
      file = current_directory.files.find { |file| file.name == parts[1] }
      current_directory.files << FileStruct.new(parts[1], parts[0].to_i) if file.nil?
    end
  end

  base.total_size_calc
  base
end

def directories_with_max_size(current_directory, size_max, results=[])
  results << current_directory if current_directory.total_size_calc <= size_max
  current_directory.directories.each { |directory| directories_with_max_size(directory, size_max, results) }
  results
end

def all_directory_list(current_directory, dir_list=[])
  dir_list << current_directory
  current_directory.directories.each { |d| all_directory_list(d, dir_list) }
  dir_list
end

def get_smallest_directory_with_min_size(current_directory, min_size)
  dir_list = all_directory_list(current_directory)
  dir_list.sort_by!(&:total_size_calc)
  dir_list.find { |dir| dir.total_size_calc >= min_size }
end

test_base = build_system("day7/inputs/test_input.txt")
raise "part 1 invalid" unless directories_with_max_size(test_base, 100000).sum(&:total_size_calc) == 95437
raise "part 2 invalid" unless get_smallest_directory_with_min_size(test_base, 30000000 - (70000000 - test_base.total_size_calc)).total_size_calc == 24933642


base = build_system("day7/inputs/input.txt")
pp "Part 1: #{directories_with_max_size(base, 100000).sum(&:total_size_calc)}"
pp "Part 2: #{get_smallest_directory_with_min_size(base, 30000000 - (70000000 - base.total_size_calc)).total_size_calc}"
