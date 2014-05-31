require "spec_helper"
require "email_predictor"

describe EmailPredictor do
  before do
    @dataset = {
      "John Ferguson" => "john.ferguson@alphasights.com",
      "Damon Aw" => "damon.aw@alphasights.com",
      "Linda Li" => "linda.li@alphasights.com",
      "Larry Page" => "larry.p@google.com",
      "Sergey Brin" => "s.brin@google.com",
      "Steve Jobs" => "s.j@apple.com"
    }
  end 
  context "predicted_emails" do
    it "returns two names for a company with two patterns" do
      predictor = EmailPredictor.new(@dataset)
      expect(predictor.predicted_emails("john gesimondo", "google.com")).
        to eq(["john.g@google.com", "j.gesimondo@google.com"])
    end
  end
end

