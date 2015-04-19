class AddWinningEntry < ActiveRecord::Migration
  def change
    add_column :matches, :winning_entry_id, :integer
    add_column :entries, :grade, :decimal, precision: 5, scale: 2
  end
end
