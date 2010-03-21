require File.dirname(__FILE__) + '/../spec_helper'

describe Slot do
  it "should be valid" do
    Slot.new.should be_valid
  end
end
