module Aviary
  class ImageHost
    include DataMapper::Resource
    
    property :id,     Serial
    property :type,   Discriminator
    property :token,  String, :unique => true, :auto_validation => true
    property :status, Object
    property :meta,   Object
        
    def self.available
      @available ||= descendants.select { |d| d.available? }
    end
            
    def self.available?
      true
    end

    def self.matches(regex = nil)
      @matches = (@matches || []) << regex if regex
      @matches
    end
    
    def self.match(text)
      text.scan(Regexp.union(matches)).flatten.compact
    end
    
    def self.match_and_create(status)
      match(status.text).each do |capture| 
        create(:token => capture, :status => status)
      end
    end

    def href
      raise NotImplementedError
    end

    def src
      raise NotImplementedError
    end
  end
end
