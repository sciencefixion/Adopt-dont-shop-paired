class Favorites < ApplicationRecord
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents
  end

  def total_count
    return 0 if @contents.nil?
    @contents.values.sum
  end
end
