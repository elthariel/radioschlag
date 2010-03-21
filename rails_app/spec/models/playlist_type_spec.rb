require File.dirname(__FILE__) + '/../spec_helper'

describe PlaylistType do
  it "should be valid" do
    PlaylistType.new.should be_valid
  end
end
