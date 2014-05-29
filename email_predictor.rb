class EmailPredictor

  attr_accessor :companies

  def initialize(dataset)
    @companies = {}

    dataset.each do |name, email|
      @companies.merge!( set_pattern(email) )
    end
  end

  def set_pattern(email)
    email_arr = email.split("@")

    name_arr = email_arr.first.split(".")
    domain = email_arr.last

    first_length = name_arr[0].length
    last_length = name_arr[1].length
    
    return {domain => 1} if first_length + last_length == 2
    return {domain => 2} if first_length == 1
    return {domain => 3} if last_length == 1
    return {domain => 4} if first_length > 1 && last_length > 1
  end

end


#given a name and domain, predict an email address
#four patterns possible: first.last, f.last, first.l, f.l

#create a class which stores a hash of companies to patterns
#write two methods, produce_email(name, company) and update_pattern(company, pattern)

#patterns can also be stored and be represented by numbers
#produce_email will return either an array of four addresses, one address, or nothing

# test = EmailPredictor.new({"John Ferguson" => "john.ferguson@alphasights.com",
#   "Damon Aw" => "damon.aw@alphasights.com",
#   "Linda Li" => "linda.li@alphasights.com",
#   "Larry Page" => "larry.p@google.com",
#   "Sergey Brin" => "s.brin@google.com",
#   "Steve Jobs" => "s.j@apple.com"})

# p test.companies

