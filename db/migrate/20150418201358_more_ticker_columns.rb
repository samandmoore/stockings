class MoreTickerColumns < ActiveRecord::Migration
  def change
    add_column :tickers, :company_name, :string
    add_column :tickers, :cusip, :string
  end
end
