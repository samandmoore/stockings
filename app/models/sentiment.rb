class Sentiment
  include ActiveModel::Model
  attr_accessor :bullish_intensity, :bearish_intensity, :bull_minus_bear, :bull_scored_messages, :bear_scored_messages, :bull_bear_msg_ratio, :total_scanned_messages
end
