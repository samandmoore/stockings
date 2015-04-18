class AddDurationToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :duration, :int
  end
end
