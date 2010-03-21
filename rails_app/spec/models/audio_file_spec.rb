require File.dirname(__FILE__) + '/../spec_helper'

describe AudioFile do
  it "should be valid" do
    AudioFile.new.should be_valid
  end
end
