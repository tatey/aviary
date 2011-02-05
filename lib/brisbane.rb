require 'erb'
require 'fileutils'
require 'open-uri'

require 'base58'
require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'nokogiri'
require 'twitter'

require 'brisbane/configuration'
require 'brisbane/generator'
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
  def self.configuration(configuration = nil)
    @configuration = configuration if configuration
    @configuration
  end
end
