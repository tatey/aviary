module Aviary
  class Search
    attr_reader :twitter, :limit, :current_page
    
    def initialize(config)
      @twitter      = Twitter::Search.new.filter('links').no_retweets.per_page(100).containing(config[:query])
      @limit        = config[:limit] || 50
      @current_page = 1
    end
    
    def process
      return unless next_page?
      self.twitter.each do |status|
        ImageHost.available.each do |image_host|
          image_host.match_and_create(status)
        end
      end
      next_page!
      process
    end
    
    # True if there is another page to fetch from Twitter and
    # we haven't exceeded the limit.
    #
    # Returns boolean.            
    def next_page?
      self.twitter.next_page? && self.current_page < self.limit
    end
    
    def next_page!
      @current_page += 1
    end
  end
end
