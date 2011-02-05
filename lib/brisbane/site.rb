module Brisbane
  class Site
    attr_reader :source, :dest, :paginator, :template
    
    def initialize(source, dest)
      @source    = source
      @dest      = dest
      @paginator = Paginator.new
      @template  = ERB.new(File.read(File.join(self.source, 'template.erb')))
    end    
        
    def process
      render
      if self.paginator.next?
        self.paginator.next!
        process
      else
        FileUtils.cp File.join(self.dest, "page1", "index.htm"), 
                     File.join(self.dest, "index.htm")
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
