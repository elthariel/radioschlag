require File.dirname(__FILE__) + '/../spec_helper'

describe IncomingAudioFile do
  it "should be valid" do
    IncomingAudioFile.new.should be_valid
  end
end
