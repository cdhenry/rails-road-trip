class CreateRoadTrips < ActiveRecord::Migration
  def change
    create_table :road_trips do |t|
      t.integer :author_id
      t.string :name
      t.text :description
      t.integer :total_miles

      t.timestamps null: false
    end
  end
end
