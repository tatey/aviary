module Brisbane
  class Configuration    
    def initialize(envrionment, config = {})
      @config           = {}
      @config[:source]  = config[:source] || Dir.pwd
      @config[:dest]    = config[:dest] || File.join(@config[:source], '_site')
      @config[:hashtag] = config[:hashtag]
      
      ImageHost::Flickr.api_key(config[:flickr_api_key])
      
      send(envrionment)
    end
    
    def [](key)
      @config[key]
    end
    
    protected
    
    def default
      DataMapper.setup(:default, "sqlite://#{File.join(self[:source], 'db.sqlite3')}")
      DataMapper.finalize
    end
    
    def test
      DataMapper.setup(:default, 'sqlite::memory:')
      DataMapper.finalize
      DataMapper.auto_migrate!
    end
  end
end
