class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.date :entry_date
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
