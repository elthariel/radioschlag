require File.dirname(__FILE__) + '/../spec_helper'

describe ProgramAssignments do
  it "should be valid" do
    ProgramAssignments.new.should be_valid
  end
end
