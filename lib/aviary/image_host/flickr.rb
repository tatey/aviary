module Aviary
  class ImageHost::Flickr < ImageHost
    before :create, :set_meta
  
    matches /flic\.kr\/p\/(\w+)/
    matches /flickr\.com\/photos\/\w+\/(\d+)/
    
    def self.api_key(key = nil)
      @api_key = key if key
      @api_key
    end
    
    def self.available?
      !api_key.nil?
    end
    
    def self.match_and_create(status)
      match(status.text).each do |capture|
        create :token  => (capture =~ /^\d+$/ ? Base58.encode(capture.to_i) : capture),
               :status => status
      end
    end
        
    def href
      "http://flic.kr/p/#{self.token}"
    end
  
    def src
      "http://farm#{self.meta[:farm_id]}.static.flickr.com/" + 
      "#{self.meta[:server_id]}/#{self.meta[:id]}_#{self.meta[:secret]}_z.jpg"
    end
            
    def set_meta
      uri = URI.parse "http://api.flickr.com/services/rest/?method=flickr" +
                      ".photos.getInfo&api_key=#{self.class.api_key}" + 
                      "&photo_id=#{Base58.decode(self.token)}"  
      photo = Nokogiri::XML(open(uri)).css('photo')
      self.meta = {
        :farm_id   => photo.first['farm'],
        :server_id => photo.first['server'],
        :id        => photo.first['id'],
        :secret    => photo.first['secret']
      }
    end
  end
end
