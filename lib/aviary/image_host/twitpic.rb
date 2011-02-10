module Aviary
  class ImageHost::Twitpic < ImageHost  
    matches /twitpic\.com\/(\w+)/
    
    def href
      "http://twitpic.com/#{self.token}"
    end
  
    def src
      "http://twitpic.com/show/large/#{self.token}.jpg"
    end
  end
end
