# == Schema Information
# Schema version: 20110215172200
#
# Table name: activities
#
#  id         :integer         not null, primary key
#  entry_date :date
#  start_time :string(255)
#  end_time   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
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

  # user is user's id
  # Usage
  #   Activity.total_duration(1) # total_working_hours, total_working_minutes
  def self.total_duration(user, from_date="", to_date="")
    working_hour = 0
    working_min = 0

    if((from_date && to_date) == "")
      user_activities = Activity.find(:all, :conditions => {:user_id => user})
    else
      user_activities = Activity.find(:all, :conditions => ["user_id = ? and entry_date between ? and ?", user, from_date, to_date])
    end

    user_activities.each do |activity|
      user_duration = Activity.duration(activity.start_time, activity.end_time)
      working_hour += user_duration.split[0].to_i
      working_min += user_duration.split[2].to_i
    end

    hours_in_minute = working_min / 60

    if hours_in_minute >= 1
      working_hour += hours_in_minute
      remainder_min = working_min % 60
      return "#{working_hour} hours, #{remainder_min} minutes"
    else
      "#{working_hour} hours, #{working_min} minutes"
    end
  end
end
