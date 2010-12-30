class CreateCables < ActiveRecord::Migration
  def self.up
    create_table :cables do |t|
      t.string :classification
      t.string :subject, :limit => 2048
      t.string :link
      t.string :country
      t.date :dateofcreation
      t.date :dateofrelease

      t.timestamps
    end
  end

  def self.down
    drop_table :cables
  end
end
