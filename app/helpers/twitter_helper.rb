module TwitterHelper
  def twitter_connect
    @twitter ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ""
      config.consumer_secret     = ""
      config.access_token        = ""
      config.access_token_secret = ""
    end
  end

  def twitter_timeline
    begin
      @home_timeline = twitter_connect.user_timeline('', count: 1)

    rescue Twitter::Error => e
      logger.error "Twitter broke due to: #{e}"
    end
  end

  def twitter_timeline_text
    #scan_for_links twitter_timeline[0].text
  end

  def twitter_timeline_ago
    #time_ago_in_words twitter_timeline[0].created_at
  end

  def scan_for_links(text)
    result = ""
    for word in text.split(" ")
      if word.include?("http://") || word.include?("https://")
        result << link_to(word, word, :target => "_blank").to_s + " "
      elsif word.start_with?("#")
        result << link_to(word, "https://twitter.com/#{word}", :target => "_blank").to_s + " "
      elsif word.start_with?("@")
        result << link_to(word, "https://twitter.com/#{word[1..-1]}", :target => "_blank").to_s + " "
      else
        result << "#{word} "
      end
    end
    result
  end
end
