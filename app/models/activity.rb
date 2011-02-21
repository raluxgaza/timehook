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

  attr_accessible :entry_date, :start_time, :end_time, :user_id

  time_regex = /^([0-1]?[0-9]|2[0-3]):([0-5][0-9])(:[0-5][0-9])?$/

  validates :entry_date, :presence => true

  validates :start_time, :format => { :with => time_regex },
            :presence => true

  validates :end_time, :format => { :with => time_regex },
            :presence => true

  belongs_to :user

  def self.duration(s_time, e_time)
    total_hours = (Time.parse(e_time).hour - Time.parse(s_time).hour)
    total_min = (Time.parse(s_time).min + Time.parse(e_time).min)

    if((total_min >= 60) && (total_min < 120))
      total_hours += 1
      total_min -= 60
    end
    
    return "#{total_hours} hours, #{total_min} minutes"
  end
end
