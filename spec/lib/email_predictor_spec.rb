require "spec_helper"
require "email_predictor"

describe EmailPredictor do
  before(:each) do
    @dataset = {
      "John Ferguson" => "john.ferguson@alphasights.com",
      "Damon Aw" => "damon.aw@alphasights.com",
      "Linda Li" => "linda.li@alphasights.com",
      "Larry Page" => "larry.p@google.com",
      "Sergey Brin" => "s.brin@google.com",
      "Steve Jobs" => "s.j@apple.com"
    }

    @predictor = EmailPredictor.new(@dataset)
  end

  describe "predicted_emails" do

    context "when a company has one pattern and multiple records" do
      it "returns one address" do
        expect(@predictor.predicted_emails("kiran surdhar", "alphasights.com")).
          to eq({"kiran.surdhar@alphasights.com" => 1.0})
      end
    end
    it "returns one address for a company with one pattern" do
      expect(@predictor.predicted_emails("tim douglas", "apple.com")).
        to eq({"t.d@apple.com" => 1.0})
    end

    it "returns two addresses for a company with two patterns" do
      expect(@predictor.predicted_emails("john gesimondo", "google.com")).
        to eq({"john.g@google.com" => 0.5, "j.gesimondo@google.com" => 0.5})
    end

    it "returns four addresses for a company with no patterns" do
      expect(@predictor.predicted_emails("doctor seuss", "shmoogle.com")).
        to eq(nil)
    end
  end
end

