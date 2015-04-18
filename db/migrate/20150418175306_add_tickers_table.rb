class AddTickersTable < ActiveRecord::Migration
  def change
    create_table :tickers do |t|
      t.string :symbol
      t.string :sector
      t.timestamps null: false
    end
  end
end

