require "email_predictor"
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
    find_email
  
    puts "Predict another email? (y):"
    response = gets.chomp.downcase
    run if response == "y"

    puts "Goodbye!"
  end

  def find_email
    begin
      puts "Enter a name to predict an email (ex. 'kiran surdhar'):"
      name = gets.chomp
      puts "Now enter a domain (ex. 'alphasights.com'):"
      domain = gets.chomp

      if valid_name?(name) && valid_domain?(domain)
        response = @predictor.predicted_emails(name, domain)
        puts "Use the following emails: \n"
        p response
      else
        raise ArgumentError.new "Cannot predict. Name or domain is invalid. \n"
      end
      
    rescue ArgumentError => e
      puts e.message
      retry
    end
  end

  def valid_name?(name)
    name[/^[a-zA-Z]+\s[a-zA-Z]+$/] ? true : false
  end

  def valid_domain?(domain)
    domain[/^[a-zA-Z0-9]+\.[a-zA-Z]{2,}$/] ? true : false
  end
end

if __FILE__ == $PROGRAM_NAME
  p = PredictorInterface.new
  p.run
end
