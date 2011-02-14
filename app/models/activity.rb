# == Schema Information
# Schema version: 20110214122631
#
# Table name: activities
#
#  id         :integer         not null, primary key
#  entry_date :date
#  start_time :string(255)
#  end_time   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Activity < ActiveRecord::Base

  attr_accessible :entry_date, :start_time, :end_time

  time_regex = /^([0-1]?[0-9]|2[0-3]):([0-5][0-9])(:[0-5][0-9])?$/

  validates :entry_date, :presence => true

  validates :start_time, :format => { :with => time_regex },
            :presence => true

  validates :end_time, :format => { :with => time_regex },
            :presence => true

  belongs_to :user
end
