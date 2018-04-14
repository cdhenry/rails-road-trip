class CreateDestinationTags < ActiveRecord::Migration
  def change
    create_table :destination_tags do |t|
      t.belongs_to :destination
      t.belongs_to :tag

      t.timestamps null: false
    end
  end
end
