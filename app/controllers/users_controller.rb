class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]

  def index
    @users = User.find(:all)
    @title = "All users"
  end

  def show
    @user = User.find(params[:id])
    @title = @user.full_name
  end

  def new
    @user = User.new
    @title = "Register"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to @user, :flash => { :success => "Welcome to Timehook!" }
    else
      @title = "Register"
      render 'new'
    end
  end
end

