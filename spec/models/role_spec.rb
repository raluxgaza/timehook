require 'spec_helper'

describe Role do

  before(:each) do
    @attr = { :name => "Human Resource" }
  end

  it "should create instance given valid attributes" do
    Role.create!(@attr)
  end

  it "should reject blank names" do
    empty_role = Role.new(@attr.merge(:name => ""))
    empty_role.should_not be_valid
  end
end
