module Aviary
  class ImageHost
    include DataMapper::Resource
    
    property :id,     Serial
    property :type,   Discriminator                                     
    
    # Unique identifier to the photo
    property :token,  String, :unique => true, :auto_validation => true 
    
    # Twitter status
    property :status, Object                                           
    
    # Store additional data for building +href+ and +src+
    property :meta,   Object                                          
    
    # Get descendants which are available for searching. Descendant 
    # classes should implement this method if they require additional 
    # configuration before they are available. Eg: ImageHost::Flickr
    # requires an API key to be set.
    #
    # Returns array of descendants.
    def self.available
      @available ||= descendants.select { |d| d.available? }
    end
            
    def self.available?
      true
    end

    # Set and get regular expressions for matching against links to image 
    # hosts. Passing an argument appends the it to the array. Passing nothing
    # gets the regular expressions.
    #
    # Returns array of regular expressions.
    def self.matches(regex = nil)
      @matches = (@matches || []) << regex if regex
      @matches
    end
    
    # Build an array of captures from matching text. Will capture multiple
    # times. An empty array means there were no captures.
    #
    # Returns array of captured strings.
    def self.match(text)
      text.scan(Regexp.union(matches)).flatten.compact
    end
    
    # Like match, but instead of returning an array of captures strings
    # it creates new records with the captured token. Status is an object
    # which has a text attribute returned by Twitter.
    #
    # Returns nothing.
    def self.match_and_create(status)
      match(status.text).each do |capture| 
        create(:token => capture, :status => status)
      end
    end

    # Link to the original photo. Descendant classes must implement this method.
    # 
    # Raises exception until implemented.
    def href
      raise NotImplementedError
    end

    # Link to the image. Descendant classes must implement this method.
    #
    # Raises exception until implemented.
    def src
      raise NotImplementedError
    end
  end
end
