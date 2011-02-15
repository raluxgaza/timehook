require 'spec_helper'

describe User do

  before(:each) do
    @attr = { 
      :full_name  => 'Jason Fried',
      :email      => 'j@fried.com',
      :password   => 'foobar',
      :password_confirmation => 'foobar'
    }
  end

  it "should create an instance given valid attribute" do
    User.create!(@attr)
  end

  it "should reject empty full_name" do
    empty_fullname = User.new(@attr.merge(:full_name => ""))
    empty_fullname.should_not be_valid
  end

  it "should reject empty email field" do
    empty_email = User.new(@attr.merge(:email => ""))
    empty_email.should_not be_valid
  end

  it "should not allow more than 50 characters for full_name" do
    long_name = 'a' * 51
    erroreous_name = User.new(@attr.merge(:full_name => long_name))
    erroreous_name.should_not be_valid
  end

  it "should accept valid email address" do
    valid_emails = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    valid_emails.each do |email|
      good_email = User.new(@attr.merge(:email => email))
      good_email.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    bad_email = %w[use@fob,com user_at_me_com ex@me.]
    bad_email.each do |email|
      invalid_email = User.new(@attr.merge(:email => email))
      invalid_email.should_not be_valid
    end
  end

  it "should reject duplicate email" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject identical email address up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do

    before(:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirm attribute" do
      @user.should respond_to :password_confirmation
    end
  end

  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => ""))
      .should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => 'invalid')).
        should_not be_valid
    end

    it "should reject short passwords" do
      short_pass = 'a' * 5
      User.new(@attr.merge(:password => short_pass, 
                           :password_confirmation => short_pass)).should_not be_valid
    end

    it "should reject long passwords" do
      long_pass = 'a' * 41
      User.new(@attr.merge(:password => long_pass,
                           :password_confirmation => long_pass)).should_not be_valid
    end
  end

 describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password" do
      @user.should respond_to :encrypted_password
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    it "should have salt" do
      @user.should respond_to :salt
    end

    describe "has_password? method" do
      
      it "should exist" do
        @user.should respond_to(:has_password?)
      end

      it "should return true if passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should return false if passwords don't match" do
        @user.has_password?(@attr.merge(:password => 'invalid')).
          should be_false
      end
    end

    describe "authenticate method" do

      it "should exist" do
        User.should respond_to(:authenticate)
      end

      it "should return nil on email/password mismatch" do
        User.authenticate(@attr[:email], "wrongpass").should be_nil
      end

      it "should return nil on email address with no user" do
        User.authenticate("bar@foo.com", @attr[:password]).should be_nil
      end

      it "should return the user on email/password match" do
        User.authenticate(@attr[:email], @attr[:password]).should == @user
      end
    end
  end

  describe "backoffice users" do

    before(:each) do 
      @user = User.create!(@attr)
    end

    describe "admin attribute" do

      it "should be available" do
        @user.should respond_to :admin
      end

      it "should not be an admin by default" do
        @user.should_not be_admin
      end

      it "should be convertable by an admin" do
        @user.toggle!(:admin)
        @user.should be_admin
      end
    end

    describe "manager attribute" do

      it "should be available" do
        @user.should respond_to(:manager)
      end

      it "should not be a manager by default" do
        @user.should_not be_manager
      end

      it "should be convertable by an admin" do
        @user.toggle!(:manager)
        @user.should be_manager
      end
    end
  end  

  describe "relationships" do

    it "should have many activities" do
      user_activities = User.create!(@attr)
      user_activities.should respond_to(:activity)
    end
  end

end

