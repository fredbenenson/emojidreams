class Dream < ActiveRecord::Base

  serialize :content

  def self.generate_dream
    [ male_or_female, "thought_balloon", EmojiList::VALID_UNICODE.sample(3) ].flatten
  end

  def self.male_or_female
    rand <= 0.5 ? "bow" : "massage"
  end

  def self.update_twitter

    client = Twitter::REST::Client.new do |config|
      config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    Time.zone = "America/New_York"

    if (rand <= 0.25) && (Time.now.hour >= 8 || Time.now.hour <= 2)
      d = new
      d.content = generate_dream
      client.update(d.to_tweet)
      d.save
    end

  end

  def to_unicode
    content.map do |emoji|
      EmojiList.to_unicode(emoji)
    end
  end

  def to_tweet
    to_unicode.join " "
  end


end
