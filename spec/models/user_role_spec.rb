require 'spec_helper'

describe UserRole do

  before(:each) do
    @attr = { :user_id => 3, :role_id => 1 }
  end

  it "should create an instance given valid attributes" do
    UserRole.create!(@attr)
  end

  it "should reject empty user_id" do
    empty_user = UserRole.new(@attr.merge(:user_id => ""))
    empty_user.should_not be_valid
  end

  it "should reject empty role_id" do
    empty_role = UserRole.new(@attr.merge(:role_id => ""))
    empty_role.should_not be_valid
  end
end
