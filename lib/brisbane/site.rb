module Brisbane
  class Site
    attr_reader :paginator, :template
    
    def initialize
      @paginator = Paginator.new
      @template  = ERB.new(File.read(File.join(Brisbane.configuration[:source], 'template.erb')))
    end    
    
    # TODO: Branching every time is stupid
        
    def process
      render
      if self.paginator.next?
        self.paginator.next!
        process
      else
        FileUtils.cp File.join(Brisbane.configuration[:source], '_assets'),
                     Brisbane.configuration[:dest]
        FileUtils.cp File.join(Brisbane.configuration[:dest], "page1", "index.htm"), 
                     File.join(Brisbane.configuration[:dest], "index.htm")
      end
    end
    
    def render
      dir = File.join(Brisbane.configuration[:dest], "page#{self.paginator.current_page}")
      FileUtils.mkdir_p(dir) unless File.exists?(dir)
      File.open(File.join(dir, "index.htm"), "w") do |file|
        file.write self.template.result(Page.new(self.paginator).binding)
      end
    end    
  end
end
