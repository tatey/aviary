module Brisbane
  class Site
    attr_reader :source, :dest, :paginator, :template
    
    def initialize(config)
      @source    = config[:source]
      @dest      = config[:dest]
      @paginator = Paginator.new(config[:per_page] || 25)
      @template  = ERB.new(File.read(File.join(self.source, 'template.erb')))
    end    
    
    def process
      FileUtils.mkdir_p(page_path) unless File.exists?(page_path)
      
      begin
        render
        self.paginator.next!
      end while self.paginator.next?
      
      FileUtils.cp_r File.join(self.source, '_assets', '.'), 
                     self.dest
      FileUtils.cp   File.join(self.dest, "page1", "index.htm"), 
                     File.join(self.dest, "index.htm")
    end
    
    def render
      File.open(File.join(page_path, "index.htm"), "w") do |file|
        file.write self.template.result(Page.new(self.paginator).binding)
      end
    end
    
    def page_path
      File.join(self.dest, "page#{self.paginator.current_page}")
    end    
  end
end
