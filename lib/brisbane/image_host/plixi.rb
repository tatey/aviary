module Brisbane
  class ImageHost::Plixi < ImageHost
    before :create, :set_meta
    
    matches /plixi\.com\/p\/(\d+)/
  
    def href
      "http://plixi.com/p/#{self.token}"
    end
  
    def src
      self.meta[:medium_image_url]
    end
    
    protected
    
    def set_meta
      uri = URI.parse("http://api.plixi.com/api/tpapi.svc/photos/#{self.token}")
      doc = Nokogiri::XML(open(uri))
      self.meta = {
        :big_image_url       => doc.css('BigImageUrl').text,
        :large_image_url     => doc.css('LargeImageUrl').text,
        :medium_image_url    => doc.css('MediumImageUrl').text,
        :small_image_url     => doc.css('SmallImageUrl').text,
        :thumbnail_image_url => doc.css('ThumbnailUrl').text
      }
    end
  end
end
