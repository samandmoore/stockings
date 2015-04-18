class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :match
      t.references :user
      t.timestamps null: false
    end
  end
end
