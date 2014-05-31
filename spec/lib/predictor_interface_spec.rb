require "spec_helper"
require "predictor_interface"

describe PredictorInterface do
  before(:each) do
    @interface = PredictorInterface.new
  end

  context "valid_name?" do
    it "returns true with valid first and last name" do
      expect(@interface.valid_name?("james bond")).to eq(true)
    end

    it "returns false without a full name" do
      expect(@interface.valid_name?("garblegarble")).to eq(false)
    end
  end

  context "valid_domain?" do
    it "returns true with valid domain" do
      expect(@interface.valid_domain?("apple.com")).to eq(true)
    end

    it "returns false without a top level domain" do
      expect(@interface.valid_domain?("ibm")).to eq(false)
    end
  end
end

