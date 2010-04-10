require File.dirname(__FILE__) + '/../spec_helper'

describe FtpAccount do
  it "should be valid" do
    FtpAccount.new.should be_valid
  end
end
