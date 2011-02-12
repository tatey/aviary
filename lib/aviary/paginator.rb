module Aviary
  class Paginator
    attr_reader :per_page     # Number of photos per page
    attr_reader :current_page # Number for the current page
    attr_reader :first_page   # Minimum number of pages
    attr_reader :last_page    # Maximum number of pages
  
    def initialize(per_page)
      @per_page     = per_page
      @current_page = 1
      @first_page   = 1
      @last_page    = ImageHost.count / self.per_page
    end
        
    # True if this is not the last page.
    # 
    # Returns boolean.  
    def next_page?
      self.current_page < self.last_page
    end
    
    # Get the page number for the next page.
    #
    # Returns page number.
    def next_page
      self.current_page + 1
    end
  
    # Get the page number for the next page and increment the +current_page+.
    #
    # Returns page number.
    def next_page!
      @current_page = next_page
    end
  
    # True if this is not the first page.
    #
    # Returns boolean.
    def prev_page?
      self.current_page > self.first_page
    end
    
    # Get the page number for the previous page.
    #
    # Returns page number.
    def prev_page
      self.current_page - 1
    end
    
    def query_options
      {:limit => self.per_page, :offset => self.per_page * (self.current_page - 1)}
    end
  end
end
