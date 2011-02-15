require 'spec_helper'

describe Activity do

  before(:each) do
    @attr = {
      :entry_date => Date.today, :start_time => '10:00', :end_time => '17:00'
    }
  end

  it "should create an instance given valid attributes" do
    Activity.create!(@attr)
  end

  it "should require an entry date" do
    no_date = Activity.new(@attr.merge(:entry_date => ""))
    no_date.should_not be_valid
  end

  it "should require a start_time" do
    no_start_time = Activity.new(@attr.merge(:start_time => ""))
    no_start_time.should_not be_valid
  end

  it "should require an end time" do
    no_end_time = Activity.new(@attr.merge(:end_time => ""))
    no_end_time.should_not be_valid
  end

  describe "time format" do

    it "should reject wrong start_time" do
      invalid_time = Activity.new(@attr.merge(:start_time => '24:00'))
      invalid_time.should_not be_valid       
    end

    it "should reject wrong end_time" do
      invalid_time = Activity.new(@attr.merge(:end_time => '45:23'))
      invalid_time.should_not be_valid
    end
    
    it "should accept valid time" do
      valid_time = Activity.new(@attr)
      valid_time.should be_valid
    end
  end

  describe "relationships" do

    it "should belong to user" do
      user_activity = Activity.new(@attr)
      user_activity.should respond_to(:user)
    end
  end
end
