class AddCodeToSectors < ActiveRecord::Migration
  def change
    add_column :sectors, :code, :string
  end
end
