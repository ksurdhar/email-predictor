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

  def all_emails(name, domain)
    full_name = name.downcase.split(" ")
    first_name = full_name.first
    last_name = full_name.last

    strings = [
      first_name[0] + "." + last_name[0] + "@" + domain,
      first_name[0] + "." + last_name + "@" + domain,
      first_name + "." + last_name[0] + "@" + domain,
      first_name + "." + last_name + "@" + domain
    ]
  end

  def predicted_emails(name, domain)
    if valid_name?(name) && valid_domain?(domain)
      emails = all_emails(name, domain)
      patterns = @companies[domain]
      predictions = []

      if patterns.empty?
        predictions = emails
      else
        patterns.each { |pattern| predictions << emails[pattern] }
      end
      predictions
    else
      ["Name or domain is invalid."]
    end
  end

  def set_pattern(email)
    email_arr = email.split("@")
    full_name = email_arr.first.split(".")

    first_length = full_name[0].length
    last_length = full_name[1].length
    
    return [0] if first_length + last_length == 2
    return [1] if first_length == 1
    return [2] if last_length == 1
    return [3] if first_length > 1 && last_length > 1
  end

  def update_pattern(domain, pattern)
    @companies[domain] = [pattern]
  end

  def valid_name?(name)
    name[/^[a-zA-Z]+\s[a-zA-Z]+$/] ? true : false
  end

  def valid_domain?(domain)
    domain[/^[a-zA-Z0-9]+\.[a-zA-Z]{2,}$/] ? true : false
  end
end
