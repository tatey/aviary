require 'aviary'
require 'minitest/autorun'
require 'webmock'

include WebMock::API
include Aviary

# Mock a status returned by Twitter
Struct.new("Status", :text)
