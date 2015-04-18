class CleanupTickerAndSectors < ActiveRecord::Migration
  def change
    remove_column :tickers, :company_name
    add_column :tickers, :industry_id, :integer
  end
end
