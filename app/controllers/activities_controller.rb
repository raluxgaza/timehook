class ActivitiesController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => [:edit, :update, :destory]

  def index
    if((params[:from_date] != nil) && (params[:to_date] != nil))
      f_date = Date.civil(params[:from_date][:year].to_i, params[:from_date][:month].to_i, params[:from_date][:day].to_i) 
      t_date = Date.civil(params[:to_date][:year].to_i, params[:to_date][:month].to_i, params[:to_date][:day].to_i) 

      @summary_hours = 
        Activity.paginate(:all, :page => params[:page], :per_page => 10, 
                          :conditions => ["user_id = ? and entry_date between ? and ? ", 
                          current_user, f_date, t_date], :order => "entry_date asc")
    else 
      @summary_hours = Activity.paginate(:all, :page => params[:page], :per_page => 10, 
                                         :conditions => ["user_id = ?", current_user],
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
      #redirect_to date_path, :flash => { :success => "Time added successfully" }
      redirect_to new_activity_path, :flash => { :success => "Working time recorded successfully" }
    else
      @title = "Record working hours"
      render 'new', :flash => { :fail => "There was an error please try again" }
    end
  end

  def edit
    @title = "Edit activity"
  end

  def update
    if @activity.update_attributes(params[:activity])
      redirect_to activity_path, :flash => { :success => "Working time updated successfully" }
    else
      @title = "Edit activity"
      render 'edit'
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

  def destroy
    @activity.destroy
    redirect_to root_path, :flash => { :success => "Working time removed successfully" }
  end

  private

    def authorized_user
      @activity = Activity.find(params[:id])
      redirect_to root_path unless current_user?(@activity.user)
    end
end
