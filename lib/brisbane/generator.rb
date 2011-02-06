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
        template = File.read(File.join(generator_path, 'template.erb'))
        template.gsub!('{{hashtag}}', self.hashtag) if self.hashtag
        file.write(template)
      end
      
      FileUtils.cp_r File.join(generator_path, '_assets'), self.source
    end
            
    def generator_path
      File.join(File.dirname(__FILE__), '..', 'generator')
    end
  end
end
