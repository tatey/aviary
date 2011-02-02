module Brisbane
  class ImageHost::Yfrog < ImageHost
    matches /yfrog\.com\/(\w+)/
  
    def href
      "http://yfrog.com/#{self.token}"
    end
  
    def src
      "http://yfrog.com/#{self.token}:medium"
    end
  end
end
