require File.dirname(__FILE__) + '/../spec_helper'

describe AudioFileAssignments do
  it "should be valid" do
    AudioFileAssignments.new.should be_valid
  end
end
