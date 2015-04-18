class AddForeignKeys < ActiveRecord::Migration
  def change
    add_column :tickers, :sector_id, :integer
    remove_column :tickers, :sector
  end
end
