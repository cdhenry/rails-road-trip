class AddAuthorIdToDestinations < ActiveRecord::Migration
  def change
    add_column :destinations, :author_id, :integer
  end
end
