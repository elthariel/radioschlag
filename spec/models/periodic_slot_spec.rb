require File.dirname(__FILE__) + '/../spec_helper'

describe PeriodicSlot do
  it "should be valid" do
    PeriodicSlot.new.should be_valid
  end
end
