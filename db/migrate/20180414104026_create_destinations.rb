class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :name
      t.text :description
      t.string :city
      t.string :state
      t.string :street_address

      t.timestamps null: false
    end
  end
end
