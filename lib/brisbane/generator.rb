module Brisbane
  class Generator
    attr_reader :hashtag
    
    # TODO: Take path of dir to create
    def initialize(hashtag)
      @hashtag = hashtag
    end
    
    def process
      DataMapper.auto_migrate!
      
      file = File.open(File.join(Brisbane.configuration[:source], 'template.erb'), 'w')
      file.write File.read(File.join(generator_path, 'template.erb')).gsub('{{hashtag}}', self.hashtag)
      file.close
      
      FileUtils.cp_r File.join(generator_path, '_assets'), Brisbane.configuration[:source]
    end
            
    def generator_path
      File.join(File.dirname(__FILE__), '..', 'generator')
    end
  end
end
