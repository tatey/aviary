require 'brisbane'
require 'minitest/autorun'

include Brisbane

Brisbane.configuration({})
# TODO: We shouldn't have to invoke configuration
# TODO: Setup in-memory DB for testing

def stub_status
  Struct.new("Status", :text).new("Lorem ipsum dolar sit amet")
end
