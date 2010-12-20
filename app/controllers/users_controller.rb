class UsersController < ApplicationController

  def new
    @user = User.new
    @title = "Register"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to @user, :flash => { :success => "Welcome to Timehook" }
    else
      @title = "Register"
      render 'new'
    end
  end
end

