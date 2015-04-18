class HistoricQuote
  include ActiveModel::Model
  attr_accessor :date, :open, :high, :low, :close, :volume, :adj_close
end
