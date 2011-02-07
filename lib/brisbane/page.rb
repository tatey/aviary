module Brisbane
  class Page
    attr_reader :paginator, :image_hosts
        
    def initialize(paginator)
      @paginator   = paginator
      @image_hosts = ImageHost.all(@paginator.query_options.merge(:order => :id.desc))
    end
    
    def h(string)
      string.gsub('<', '&lt;').gsub('>', '&gt;')
    end
    
    def binding
      super
    end
  end
end
