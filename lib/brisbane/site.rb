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
      render
      if self.paginator.next_page?
        self.paginator.next_page!
        process
      else
        copy_index
        copy_assets
      end
    end
    
    def render
      FileUtils.mkdir_p(current_page_path) unless File.exists?(current_page_path)
      File.open(File.join(current_page_path, "index.htm"), "w") do |file|
        file.write self.template.result(Page.new(self.paginator).binding)
      end
    end
    
    def copy_index
      FileUtils.cp File.join(self.dest, "page1", "index.htm"), 
                   File.join(self.dest, "index.htm")
    end
    
    def copy_assets
      FileUtils.cp_r File.join(self.source, '_assets', '.'), self.dest
    end
        
    def current_page_path
      File.join(self.dest, "page#{self.paginator.current_page}")
    end    
  end
end
