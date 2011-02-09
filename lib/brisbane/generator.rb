module Brisbane
  class Generator
    attr_reader :source, :hashtag
    
    def initialize(config)
      @source  = config[:source]
      @hashtag = config[:hashtag]
    end
    
    def process
      copy_template
      migrate
    end
    
    def migrate
      DataMapper.auto_migrate!
    end
    
    def copy_template
      FileUtils.mkdir_p(self.source) unless File.exists?(self.source)
      File.open(File.join(self.source, 'template.erb'), 'w') do |file|
        erb = File.read(File.join(generator_path, 'template.erb'))
        erb.gsub!('{{hashtag}}', self.hashtag) if self.hashtag
        file.write(erb)
      end
      FileUtils.cp_r File.join(generator_path, '_assets'), self.source
    end
            
    def generator_path
      File.join(File.dirname(__FILE__), '..', '..', 'generator')
    end
  end
end
