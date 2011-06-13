# == Schema Information
# Schema version: 20110613115044
#
# Table name: user_roles
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  role_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class UserRole < ActiveRecord::Base
  
  validates :user_id,   :presence => true
  validates :role_id, :presence => true
end
