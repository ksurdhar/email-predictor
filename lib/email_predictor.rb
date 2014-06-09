class EmailPredictor
  attr_accessor :companies

  def initialize(dataset)
    @companies = Hash.new([])

    dataset.each do |name, email|
      domain = email.split("@").last
      pattern = set_pattern(email)

      @companies[domain] += pattern if !@companies[domain].include?(pattern)
    end
  end

  def predicted_emails(name, domain)
    emails = all_emails(name, domain)
    patterns = @companies[domain]
    predictions = []

    if patterns.empty?
      predictions = emails.values
    else
      patterns.each { |pattern| predictions << emails[pattern] }
    end
    predictions
  end

  private

  def all_emails(name, domain)
    full_name = name.downcase.split(" ")
    first_name = full_name.first
    last_name = full_name.last

    strings = {
      :initial_dot_initial => first_name[0] + "." + last_name[0] + "@" + domain,
      :initial_dot_name => first_name[0] + "." + last_name + "@" + domain,
      :name_dot_initial => first_name + "." + last_name[0] + "@" + domain,
      :name_dot_name => first_name + "." + last_name + "@" + domain
    }
  end

  def set_pattern(email)
    email_arr = email.split("@")
    full_name = email_arr.first.split(".")

    first_length = full_name[0].length
    last_length = full_name[1].length
    
    return [:initial_dot_initial] if first_length + last_length == 2
    return [:initial_dot_name] if first_length == 1
    return [:name_dot_initial] if last_length == 1
    return [:name_dot_name] if first_length > 1 && last_length > 1
  end

  def update_pattern(domain, pattern)
    @companies[domain] = [pattern]
  end
end
