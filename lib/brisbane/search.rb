module Brisbane
  class Search
    attr_reader :twitter, :limit, :current_page
    
    def initialize(config)
      @twitter      = Twitter::Search.new.filter('links').no_retweets.per_page(100).hashtag(config[:hashtag])
      @limit        = config[:limit] || 100
      @current_page = 1
    end
    
    def process
      return unless next_page?
      self.twitter.each do |status|
        ImageHost.available.each do |image_host|
          image_host.match_and_create(status)
        end
      end
      sleep 1
      next_page!
    end
                
    def next_page?
      self.twitter.next_page? && self.current_page < self.limit
    end
    
    def next_page!
      @current_page += 1
    end
  end
end