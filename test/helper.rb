require 'webmock'
require 'minitest/autorun'
require 'brisbane'

include WebMock::API
include Brisbane

Struct.new("Status", :text)
