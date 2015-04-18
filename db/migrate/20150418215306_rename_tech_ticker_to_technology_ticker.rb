class RenameTechTickerToTechnologyTicker < ActiveRecord::Migration
  def change
    rename_column :entries, :tech_ticker_id, :technology_ticker_id
  end
end
