require "matrix"
require 'set'

class Location
  attr_accessor :location, :elevation, :starting_location, :ending_location, :visited

  def initialize(location, elevation, starting_location, ending_location)
    @location = location
    @elevation = elevation
    @starting_location = starting_location
    @ending_location = ending_location
    @visited = starting_location
  end

  def can_move_to?(other_location)
    return false if other_location.nil?

    (location - other_location.location).magnitude <= 1 &&
    elevation.ord + 1 >= other_location.elevation.ord
  end

  def ==(other_location)
    location == other_location.location
  end

  def is_possible_start?
    ["a", "S"].include?(elevation)
  end

  def to_s
    if starting_location
      "S"
    elsif ending_location
      "E"
    else
      @elevation
    end
  end
end

class Grid
  attr_accessor :locations, :starting_location, :ending_location

  def initialize(file)
    @locations = []
    File.readlines(file, chomp: true).each_with_index do |elevations, row|
      @locations[row] = elevations.chars.each_with_index.map do |elevation, column|
        starting = false
        ending = false
        if elevation == "S"
          elevation = "a"
          starting = true
        elsif elevation == "E"
          elevation = "z"
          ending = true
        end
        location = Location.new(Vector[row, column], elevation, starting, ending)
        @starting_location = location if starting
        @ending_location = location if ending
        location
      end
    end
  end

  def print_grid(path=nil)
    output = ""
    locations.each do |row|
      row.each do |loc|
        if loc == ending_location
          output += "E"
        elsif path && path.include?(loc)
          output += loc.elevation # "#"
        else
          output += " "
        end
      end
      output += "\n"
    end
    puts "=" * 20
    puts output
    puts "=" * 20
    puts ""
  end

  def best_case_to_end(location)
    # (location.location - ending_location.location).magnitude # 2558 checks
    [(location.location[0] - ending_location.location[0]).abs, (location.location[1] - ending_location.location[1]).abs].max #2556 checks
  end

  def find_path(log: false, starting_node:nil, break_on_another_start: false)
    starting_node = starting_location if starting_node.nil?
    paths = [[starting_node]]
    visit = Set.new

    counter = 0
    while path = paths.shift
      if log
        counter += 1
        print_grid(path)
        puts "Path check #{counter}" if counter % 500 == 0
      end

      return path if path.last == ending_location

      current = path.last

      # Add possible next locations
      possible_next = []
      vert, hor = *current.location.to_a

      # up
      up = locations[vert-1][hor] unless vert.zero?
      possible_next << up if current.can_move_to?(up)

      # down
      down = locations[vert+1][hor] unless locations[vert+1].nil?
      possible_next << down if current.can_move_to?(down)

      # left
      left = locations[vert][hor-1] unless hor.zero?
      possible_next << left if current.can_move_to?(left)

      # right
      right = locations[vert][hor+1] unless locations[vert][hor+1].nil?
      possible_next << right if current.can_move_to?(right)

      # add possibilities if valid
      possible_next.each do |pn|
        next if visit.include?(pn) || (break_on_another_start && pn.is_possible_start?)

        visit.add(pn)
        paths.unshift (path + [pn]) # unshift gives better average resort than <<
      end

      # resort queue
      paths.sort_by! { |p| p.size + best_case_to_end(p.last) }
    end
    paths.first
  end

  def find_best_possible_path(log: false)
    current_best_path = nil
    paths_to_check = locations.flatten.select {|l| l.elevation == "a" || l.elevation == "S" }

    puts "Paths to check: #{paths_to_check.size}" if log

    paths_to_check.each  do |start|
      path = find_path(starting_node: start, break_on_another_start: true)
      if !path.nil? && (current_best_path.nil? || current_best_path.size > path.size)
        current_best_path = path
        print "*" if log
      else
        print "." if log
      end
    end
    puts "" if log
    current_best_path
  end
end

log = false
g = Grid.new("day12/inputs/input.txt")
path = g.find_path(log: log)
g.print_grid path if log
puts "Path Size: #{path.size - 1}"

best_path = g.find_best_possible_path(log: log)
g.print_grid best_path if log
puts "Best Possible Path Size: #{best_path.size - 1}"