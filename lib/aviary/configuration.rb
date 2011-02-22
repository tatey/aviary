module Aviary
  class Configuration    
    def initialize(envrionment, config = {})
      @config            = {}
      @config[:source]   = config[:source] || Dir.pwd
      @config[:dest]     = config[:dest] || File.join(@config[:source], '_site')
      @config[:query]    = config[:query]
      @config[:per_page] = config[:per_page]
      @config[:limit]    = config[:limit]

      ImageHost::Flickr.api_key(config[:flickr_api_key])
      
      send(envrionment)
    end
    
    # Get the value for the given key.
    #
    # Returns value.
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
