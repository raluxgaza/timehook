class AddManagerAttributeToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :manager, :boolean
  end

  def self.down
    remove_column :users, :manager
  end
end
