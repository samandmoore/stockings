class AddParticipantLimitToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :max_entries, :int
  end
end
