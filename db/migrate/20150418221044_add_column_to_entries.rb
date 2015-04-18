class AddColumnToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :financial_services_ticker_id, :integer
    add_column :entries, :telecommunications_ticker_id, :integer
    add_column :entries, :energy_ticker_id, :integer
    add_column :entries, :healthcare_ticker_id, :integer
    add_column :entries, :flex_1_ticker_id, :integer
    add_column :entries, :flex_2_ticker_id, :integer
    add_column :entries, :flex_3_ticker_id, :integer
    add_column :entries, :flex_4_ticker_id, :integer
  end
end
