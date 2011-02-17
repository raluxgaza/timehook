class ActivitiesController < ApplicationController
  before_filter :authenticate
  
  def index
    @activities = Activity.find(params[:id])
    @title = "All activities"
  end

  def new
    @activity = Activity.new
    @title = "Record working hours"
  end

  # Add a new user activity
  def create
    @activity = Activity.new(params[:activity])
    if @activity.save
      flash[:success] = "Working time added successfully."
    else
      @title = "Record working hours"
      render 'new'
    end
  end

  def show
    @title = "Show working hours"
    @user_activities = Activity.find(:all)
  end

  def delete
  end
end
