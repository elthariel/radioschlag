require File.dirname(__FILE__) + '/../spec_helper'

describe Playlist do
  it "should be valid" do
    Playlist.new.should be_valid
  end
end
