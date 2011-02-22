module Aviary
  class Generator
    attr_reader :source, :query
    
    def initialize(config)
      @source  = config[:source]
      @query = config[:query]
    end
    
    def process
      copy_template
      migrate
    end
    
    # Migrates the database for the first time.
    #
    # Returns nothing.
    def migrate
      DataMapper.auto_migrate!
    end
    
    # Copies the contents of the +generator+ directory into
    # the +source+ directory for setting up a new aviary.
    # 
    # Returns nothing.
    def copy_template
      FileUtils.mkdir_p(self.source) unless File.exists?(self.source)
      File.open(File.join(self.source, 'template.erb'), 'w') do |file|
        erb = File.read(File.join(generator_path, 'template.erb'))
        erb.gsub!('{{query}}', self.query) if self.query
        file.write(erb)
      end
      FileUtils.cp_r File.join(generator_path, '_assets'), self.source
    end
            
    def generator_path
      File.join(File.dirname(__FILE__), '..', '..', 'generator')
    end
  end
end
