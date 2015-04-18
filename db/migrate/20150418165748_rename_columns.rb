class RenameColumns < ActiveRecord::Migration
  def change
    rename_column :matches, :start_date, :start_at
    rename_column :matches, :end_date, :end_at
  end
end
