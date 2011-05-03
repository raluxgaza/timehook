# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

role_collection = {
  :hr => 'Human Resource',
  :lm => 'Line Manger',
  :tm => 'Team Member',
  :admin => 'Administrator'
}

role_collection.each do |key, value|
  @a_role = { :name => value }
  Role.create(@a_role)
end
