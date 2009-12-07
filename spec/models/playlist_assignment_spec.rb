require File.dirname(__FILE__) + '/../spec_helper'

describe PlaylistAssignment do
  it "should be valid" do
    PlaylistAssignment.new.should be_valid
  end
end
