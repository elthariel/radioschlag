require File.dirname(__FILE__) + '/../spec_helper'

describe AudioFileType do
  it "should be valid" do
    AudioFileType.new.should be_valid
  end
end
