require File.dirname(__FILE__) + '/../spec_helper'

describe AudioFileStyle do
  it "should be valid" do
    AudioFileStyle.new.should be_valid
  end
end
