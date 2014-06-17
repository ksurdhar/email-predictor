class EmailPredictor
  attr_reader :company_patterns
  attr_reader :pattern_frequencies

  def initialize(dataset)
    @company_patterns = Hash.new([])
    @pattern_frequencies = Hash.new({})

    assign_patterns_to_companies(dataset)
  end

  def predicted_emails(name, domain)
    emails = all_emails(name, domain)
    patterns = @pattern_frequencies[domain]

    return nil if patterns.empty?

    weighted_emails(patterns, emails)     
  end

  private

  def assign_patterns_to_companies(dataset)
    dataset.each do |name, email|
      domain = email.split("@").last
      pattern = set_pattern(email)

      @company_patterns[domain] += pattern
    end

    calculate_frequencies
  end


  def calculate_frequencies
    @company_patterns.each do |company, patterns|
      uniq_patterns = patterns.uniq
      @pattern_frequencies[company] = {}

      uniq_patterns.each do |uniq_pattern|
        frequency = @company_patterns[company].count(uniq_pattern)
        @pattern_frequencies[company].merge!({ uniq_pattern => frequency })
      end
    end
  end

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
    @company_patterns[domain] = [pattern]
  end

  def weighted_emails(patterns, emails)
    predictions = {}
    sum_of_frequencies = patterns.values.reduce(:+).to_f

    patterns.each do |pattern, freq|
      possible_email = emails[pattern]
      predictions[possible_email] = freq / sum_of_frequencies
    end

    predictions
  end
end

predictor = EmailPredictor.new({
      "John Ferguson" => "john.ferguson@alphasights.com",
      "Damon Aw" => "damon.aw@alphasights.com",
      "Linda Li" => "linda.li@alphasights.com",
      "Larry Page" => "larry.p@google.com",
      "Sergey Brin" => "s.brin@google.com",
      "Steve Jobs" => "s.j@apple.com"
    })

p predictor.predicted_emails("kiran surdhar", "google.com")
