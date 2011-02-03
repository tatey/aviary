require 'helper'

class ImageHostTest < MiniTest::Unit::TestCase
  def teardown
    ImageHost.instance_variable_set("@matches", nil)
    ImageHost.instance_variable_set("@available", nil)
  end
  
  def test_available_descendants_without_flickr
    Brisbane.configuration[:flickr_api_key] = nil
    assert_equal [ImageHost::Plixi, ImageHost::Twitpic, ImageHost::Yfrog], ImageHost.available
  end
  
  def test_available_descendants_with_flickr
    Brisbane.configuration[:flickr_api_key] = 'secret'
    assert_equal [ImageHost::Flickr, ImageHost::Plixi, ImageHost::Twitpic, ImageHost::Yfrog], ImageHost.available
  end
    
  def test_available_is_true
    assert ImageHost.available?
  end
  
  def test_set_matches
    ImageHost.matches /foo/
    ImageHost.matches /bar/
    ImageHost.matches /baz/
    assert_equal 3, ImageHost.matches.size
  end
  
  def test_match_should_be_array_of_captures
    ImageHost.matches /foo/
    ImageHost.matches /bar/
    assert_equal [], ImageHost.match("alice and bob")
    assert_equal ["foo"], ImageHost.match("foo before baz")
    assert_equal ["foo", "bar", "foo"], ImageHost.match("foo is to bar is to foo")
  end
  
  def test_match_and_create
    skip("Setup test database")
  end
  
  def test_href_raises_not_implemented_error
    assert_raises(NotImplementedError) { ImageHost.new.href }
  end
  
  def test_src_raises_not_implemented_error
    assert_raises(NotImplementedError) { ImageHost.new.src }
  end
end
