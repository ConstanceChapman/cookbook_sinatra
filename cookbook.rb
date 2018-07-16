require 'csv'
require_relative 'recipe'

class Cookbook
  attr_reader :filepath
  attr_accessor :cookbook

  def initialize(filepath)
    @filepath = filepath
    @cookbook = []
    CSV.foreach(filepath) do |row|
      @cookbook << Recipe.new({name: row[0], description: row[1], prep_time: row[2], done: row[3] == "true", difficulty: row[4] })
    end
  end

  def all
    @cookbook
  end

  def add_recipe(recipe)
    @cookbook << recipe
    write_csv
  end

  def remove_recipe(index)
    @cookbook.delete_at(index)
    write_csv
  end

  def update_recipe(i)
    @cookbook[i].done = true
    write_csv
  end

  private

  def write_csv
    CSV.open(filepath, 'wb') do |csv|
      @cookbook.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.done, recipe.difficulty]
      end
    end
  end
end
