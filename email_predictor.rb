class EmailPredictor

  attr_accessor :companies

  def initialize(dataset)
    @companies = Hash.new([])

    dataset.each do |name, email|
      domain = email.split("@").last
      pattern = set_pattern(email)
      @companies[domain] += pattern if @companies[domain] != pattern
    end
  end

  def possible_emails(name, domain)
    name_arr = name.downcase.split(" ")
    first_name = name_arr.first
    last_name = name_arr.last

    patterns = @companies[domain]
    emails = []

    emails << (first_name[0] + "." + last_name[0] + "@" + domain) if patterns.include?(1) || patterns.empty?
    emails << (first_name[0] + "." + last_name + "@" + domain) if patterns.include?(2) || patterns.empty?
    emails << (first_name + "." + last_name[0] + "@" + domain) if patterns.include?(3) || patterns.empty?
    emails << (first_name + "." + last_name + "@" + domain) if patterns.include?(4) || patterns.empty?
  end

  def set_pattern(email)
    email_arr = email.split("@")
    name_arr = email_arr.first.split(".")

    first_length = name_arr[0].length
    last_length = name_arr[1].length
    
    return [1] if first_length + last_length == 2
    return [2] if first_length == 1
    return [3] if last_length == 1
    return [4] if first_length > 1 && last_length > 1
  end

  def update_pattern(domain, pattern)
    @companies[domain] = pattern
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

# p test.possible_emails("chad engleman", "alphasights.com")
# p test.possible_emails("chad engleman", "shmoogle.com")

