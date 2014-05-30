load "./email_predictor.rb"
require "io/console"

class PredictorInterface

  attr_accessor :predictor

  def initialize
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

  def run
    puts "Welcome to the email predictor! \n" 
    begin
      puts "Enter a name (ex. kiran surdhar):"
      name = gets.chomp
      puts "Enter a domain (ex. alphasights.com):"
      domain = gets.chomp

      response = @predictor.predicted_emails(name, domain)
    end
    puts "Use the following emails: \n"
    p response
  end
end

if __FILE__ == $PROGRAM_NAME
  p = PredictorInterface.new
  p.run
end