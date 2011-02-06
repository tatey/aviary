require 'brisbane'
require 'minitest/autorun'

include Brisbane

Struct.new("Status", :text)

Brisbane::Configuration.new(:test, {:source => File.join(File.dirname(__FILE__), 'source')})
