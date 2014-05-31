require "spec_helper"
require "predictor_interface"

describe PredictorInterface do 
  context "valid_name?" do
    it "returns true with valid first and last name" do
      interface = PredictorInterface.new
      expect(interface.valid_name?("john gesimondo")).to eq(true)
    end

    it "returns false with invalid name" do
      interface = PredictorInterface.new
      expect(interface.valid_name?("garblegarble")).to eq(false)
    end
  end


end

