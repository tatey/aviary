module Brisbane
  class Paginator
    attr_reader :per_page, :current_page, :first_page, :last_page
  
    def initialize(per_page)
      @per_page     = per_page
      @current_page = 1
      @first_page   = 1
      @last_page    = ImageHost.count / self.per_page
    end
    
    def query_options
      {:limit => self.per_page, :offset => self.per_page * (self.current_page - 1)}
    end
        
    def next_page?
      self.current_page < self.last_page
    end
    
    def next_page
      self.current_page + 1
    end
  
    def next_page!
      @current_page = next_page
    end
  
    def prev_page?
      self.current_page > self.first_page
    end
    
    def prev_page
      self.current_page - 1
    end
  end
end
