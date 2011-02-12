require 'aviary'
require 'webmock'
require 'minitest/autorun'

include WebMock::API
include Aviary

Struct.new("Status", :text)
