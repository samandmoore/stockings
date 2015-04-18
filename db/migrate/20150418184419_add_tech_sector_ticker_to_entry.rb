class AddTechSectorTickerToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :tech_ticker_id, :int
  end
end
