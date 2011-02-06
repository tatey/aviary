module Brisbane
  class Site
    attr_reader :source, :dest, :paginator, :template
    
    def initialize(config)
      @source    = config[:source]
      @dest      = config[:dest]
      @paginator = Paginator.new(config[:per_page] || 25)
      @template  = ERB.new(File.read(File.join(self.source, 'template.erb')))
    end    
    
    # TODO: Branching every time is stupid
        
    def process
      render
      if self.paginator.next?
        self.paginator.next!
        process
      else
        FileUtils.cp_r File.join(self.source, '_assets', '.'), self.dest
        FileUtils.cp File.join(self.dest, "page1", "index.htm"), File.join(self.dest, "index.htm")
      end
    end
    
    def render
      dir = File.join(self.dest, "page#{self.paginator.current_page}")
      FileUtils.mkdir_p(dir) unless File.exists?(dir)
      File.open(File.join(dir, "index.htm"), "w") do |file|
        file.write self.template.result(Page.new(self.paginator).binding)
      end
    end    
  end
end
