class ActivitiesController < ApplicationController
  before_filter :authenticate

  def index
    if((params[:from_date] != nil) && (params[:to_date] != nil))
      f_date = Date.civil(params[:from_date][:year].to_i, params[:from_date][:month].to_i, params[:from_date][:day].to_i) 
      t_date = Date.civil(params[:to_date][:year].to_i, params[:to_date][:month].to_i, params[:to_date][:day].to_i) 

      @summary_hours = Activity.find(:all, :conditions => ["user_id = ? and entry_date between ? and ? ", 
                                     current_user, f_date, t_date], :order => "entry_date asc")
    else 
      @summary_hours = Activity.find(:all, :conditions => ["user_id = ?", current_user],
                                     :order => "entry_date asc")
    end
    @title = "Users activities"
  end

  def new
    @activity = Activity.new
    @title = "Record working hours"
  end

  # Add a new user activity
  def create
    @activity = Activity.new(params[:activity])
    if @activity.save
      render 'new', :flash => { :success => "Time added successfully" }
    else
      @title = "Record working hours"
      render 'new', :flash => { :error => "There was a problem please try again" }
    end
  end

  def show
    @title = "#{current_user.full_name}'s working hours"
    @user_activities = Activity.find(params[:id])
  end

  def summary
    @title = "Summary of working hours"
    @f_date = Date.civil(params[:from_date][:year].to_i, params[:from_date][:month].to_i, params[:from_date][:day].to_i)
    @t_date = Date.civil(params[:to_date][:year].to_i, params[:to_date][:month].to_i, params[:to_date][:day].to_i) 

    $from_date = @f_date
    $to_date = @t_date

    @summary_hours = Activity.total_duration(current_user, @f_date, @t_date)
  end

  def choose_date
    @title = "Date range"
  end

  def delete
  end
end
