module Aviary
  class Page
    # Photos for the current page
    attr_reader :image_hosts 
    
    # Next page, previous page and current page
    attr_reader :paginator   
        
    def initialize(paginator)
      @paginator   = paginator
      @image_hosts = ImageHost.all(@paginator.query_options.merge(:order => :id.desc))
    end
    
    # Escapes text by replacing < and > with their HTML character entity 
    # reference.
    #
    # Returns escaped string.
    def h(string)
      string.gsub('<', '&lt;').gsub('>', '&gt;')
    end
    
    def binding
      super
    end
  end
end
