require 'spec_helper'

describe Role do

  before(:each) do
    @attr = { :name => "Human Resource" }
  end

  it "should create instance given valid attributes" do
    Role.create!(@attr)
  end
end
