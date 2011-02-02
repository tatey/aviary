module Brisbane
  class Parser
    attr_reader   :twitter, :current_page
    attr_accessor :max_page
    
    def initialize(tag)
      self.twitter.hashtag(tag)
      self
    end
    
    def process
      return unless next_page?
      puts "Processing #{self.current_page}"
      self.twitter.each do |status|
        ImageHost.available.each do |image_host|
          image_host.match_and_create(status)
        end
      end
      sleep(1)
      increment!
      process
    end
    
    def twitter
      @twitter ||= Twitter::Search.new.filter('links').no_retweets.per_page(100)
    end
    
    def current_page
      @current_page ||= 1
    end
    
    def max_page
      @max_page ||= 100
    end
                
    def next_page?
      self.twitter.next_page? && self.current_page <= self.max_page
    end
    
    def increment!
      @current_page += 1
    end
  end
end
