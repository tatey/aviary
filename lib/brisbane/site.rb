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
      end
    end
    
    def render
      File.open(File.join(self.dest, "page#{self.paginator.current_page}.htm"), "w") do |file|
        file.write self.template.result(Page.new(self.paginator).binding)
      end
    end    
  end
end
