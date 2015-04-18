class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|

      t.datetime :start_date
      t.datetime :end_date
      t.string :match_type
      t.timestamps null: false
    end
  end
end
