class CreateRoadTripDestinations < ActiveRecord::Migration
  def change
    create_table :road_trip_destinations do |t|
      t.belongs_to :road_trip
      t.belongs_to :destination
      t.integer :destination_order

      t.timestamps null: false
    end
  end
end
