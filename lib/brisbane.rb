require 'cgi'
require 'erb'
require 'open-uri'

require 'base58'
require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'nokogiri'
require 'twitter'

require 'brisbane/image_host'
require 'brisbane/image_host/flickr'
require 'brisbane/image_host/plixi'
require 'brisbane/image_host/twitpic'
require 'brisbane/image_host/yfrog'
require 'brisbane/page'
require 'brisbane/paginator'
require 'brisbane/parser'
require 'brisbane/site'

module Brisbane
  DEFAULT = {
    :source         => Dir.pwd,
    :dest           => File.join(Dir.pwd, '_site'),
    :flickr_api_key => nil
  }
  
  def self.configuration(options = nil)
    @configuration = DEFAULT.merge(options) if options
    @configuration
  end
  
  def self.setup
    dbfile = File.join(configuration[:source], 'brisbane.sqlite3')
    DataMapper.setup(:default, "sqlite://#{dbfile}")
    DataMapper.auto_migrate! unless File.exists?(dbfile)
    DataMapper.finalize
  end
end
