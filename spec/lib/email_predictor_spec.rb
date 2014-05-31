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

  context "predicted_emails" do
    it "returns one address for a company with one pattern" do
      expect(@predictor.predicted_emails("tim douglas", "apple.com")).
        to eq(["t.d@apple.com"])
    end

    it "returns two addresses for a company with two patterns" do
      expect(@predictor.predicted_emails("john gesimondo", "google.com")).
        to eq(["john.g@google.com", "j.gesimondo@google.com"])
    end

    it "returns four addresses for a company with no patterns" do
      expect(@predictor.predicted_emails("doctor seuss", "shmoogle.com")).
        to eq(["d.s@shmoogle.com", "d.seuss@shmoogle.com", 
               "doctor.s@shmoogle.com", "doctor.seuss@shmoogle.com"])
    end
  end
end

