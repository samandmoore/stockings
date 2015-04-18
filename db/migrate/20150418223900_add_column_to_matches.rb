class AddColumnToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :wager_cents, :integer, limit: 8
  end
end
