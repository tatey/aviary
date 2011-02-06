module Brisbane
  class Generator
    attr_reader :source, :hashtag
    
    def initialize(config)
      @source  = config[:source]
      @hashtag = config[:hashtag]
    end
    
    def process
      FileUtils.mkdir_p(self.source) unless File.exists?(self.source)
      
      DataMapper.auto_migrate!
      
      File.open(File.join(self.source, 'template.erb'), 'w') do |file|
        erb = File.read(File.join(template_path, 'template.erb'))
        erb.gsub!('{{hashtag}}', self.hashtag) if self.hashtag
        file.write(erb)
      end
      
      FileUtils.cp_r File.join(template_path, '_assets'), self.source
    end
            
    def template_path
      File.join(File.dirname(__FILE__), '..', '..', 'template')
    end
  end
end
