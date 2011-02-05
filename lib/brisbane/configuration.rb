module Brisbane
  class Configuration
    DEFAULT_OPTIONS = {
      :source         => Dir.pwd,
      :dest           => File.join(Dir.pwd, '_site'),
      :flickr_api_key => nil
    }
        
    attr_reader :options
    
    def initialize(options = {}, environment)
      @options = DEFAULT_OPTIONS.merge(options)
      send(environment)
    end
    
    protected
    
    def default
      DataMapper.setup(:default, "sqlite://#{File.join(self.options[:source], 'db.sqlite3')}")
      DataMapper.finalize
    end
    
    def test
      DataMapper.setup(:default, 'sqlite::memory')
      DataMapper.finalize
      DataMapper.auto_migrate!
    end
  end
end
