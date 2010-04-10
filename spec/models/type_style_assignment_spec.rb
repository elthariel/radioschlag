require File.dirname(__FILE__) + '/../spec_helper'

describe TypeStyleAssignment do
  it "should be valid" do
    TypeStyleAssignment.new.should be_valid
  end
end
