class ActivitiesController < ApplicationController
  before_filter :authenticate

  attr_accessor :f_date, :t_date
  $from_date = nil
  $to_date = nil
  
  def index
    #f_date = Date.civil(params[:from_date][:year].to_i, params[:from_date][:month].to_i, params[:from_date][:day].to_i)
    #t_date = Date.civil(params[:to_date][:year].to_i, params[:to_date][:month].to_i, params[:to_date][:day].to_i)

    @f_date = $from_date
    @t_date = $to_date
    @user_activities = Activity.find(:all, :conditions => ["user_id = ? and entry_date between ? and ? ", 
                                     current_user, @f_date, @t_date], :order => "entry_date asc")

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
      redirect_to date_path, :flash => { :success => "Time added successfully" }
    else
      @title = "Record working hours"
      render 'new'
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
