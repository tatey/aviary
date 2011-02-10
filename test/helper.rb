require 'webmock'
require 'minitest/autorun'
require 'aviary'

include WebMock::API
include Aviary

Struct.new("Status", :text)
