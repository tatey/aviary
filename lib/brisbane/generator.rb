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
