class DreamsController < ApplicationController

  def index

    client = Twitter::REST::Client.new do |config|
      config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    @tweets = EmojiList::VALID_UNICODE.sample(3).map{|e| EmojiList.to_unicode(e) }

  end

end
