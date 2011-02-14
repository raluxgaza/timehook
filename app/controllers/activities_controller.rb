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
    @activity = Activity.new(params[:user_activity])
    if @activity.save
      # let user know activity was saved correctly
    else
      # display error that stopped creation.
    end
  end

  def show
    @title = "Show working hours"
  end

  def delete
  end
end
