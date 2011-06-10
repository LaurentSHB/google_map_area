class CreatePoints < ActiveRecord::Migration
  def self.up
    create_table :points do |t|
      t.integer :area_id
      t.float :latitude
      t.float :longitude
      t.integer :position
      t.timestamps
    end
  end

  def self.down
    drop_table :points
  end
end
