require File.dirname(__FILE__) + '/../spec_helper'

describe PlaylistPlayer do
  it "should be valid" do
    PlaylistPlayer.new.should be_valid
  end
end
