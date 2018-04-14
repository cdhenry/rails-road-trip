class CreateDestinationRoadTrips < ActiveRecord::Migration
  def change
    create_table :destination_road_trips do |t|
      t.belongs_to :road_trip
      t.belongs_to :destination
      t.integer :destination_order

      t.timestamps null: false
    end
  end
end
