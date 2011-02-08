require File.expand_path('../../helper', __FILE__)

class ImageHostTest < MiniTest::Unit::TestCase
  def setup
    Brisbane::Configuration.new(:test)
  end
  
  def teardown
    ImageHost.destroy
    ImageHost.instance_variable_set("@matches", nil)
    ImageHost.instance_variable_set("@available", nil)
    ImageHost::Flickr.instance_variable_set("@api_key", nil)
  end
  
  def test_available_should_have_four_descendants_with_flickr_api_key
    ImageHost::Flickr.api_key('secret')
    assert_equal [ImageHost::Flickr, ImageHost::Plixi, ImageHost::Twitpic, ImageHost::Yfrog], ImageHost.available
  end
  
  def test_available_should_have_three_descendants
    assert_equal [ImageHost::Plixi, ImageHost::Twitpic, ImageHost::Yfrog], ImageHost.available
  end
  
  def test_available_should_be_true
    assert ImageHost.available?
  end
  
  def test_get_and_set_matches
    ImageHost.matches /foo/
    assert_equal [/foo/], ImageHost.matches
  end
  
  def test_match_should_be_captures
    ImageHost.matches /foo/
    ImageHost.matches /bar/
    assert_equal [], ImageHost.match("alice and bob")
    assert_equal ["foo"], ImageHost.match("foo before baz") 
    assert_equal ["foo", "bar", "foo"], ImageHost.match("foo, bar and another foo")
  end
  
  def test_match_and_create_should_create_records
    ImageHost.matches /foo/
    ImageHost.match_and_create(Struct::Status.new("alice and bob"))
    assert_equal 0, ImageHost.count

    ImageHost.match_and_create(Struct::Status.new("foo before baz"))
    assert_equal 1, ImageHost.count
  end
  
  def test_match_and_create_should_not_duplicate_records
    ImageHost.matches /foo/
    ImageHost.matches /bar/
    ImageHost.match_and_create(Struct::Status.new("foo, bar and a duplicate foo"))
    assert_equal 2, ImageHost.count
    assert_equal ["foo", "bar"], ImageHost.all.map { |im| im.token }
  end
  
  def test_href
    assert_raises(NotImplementedError) { ImageHost.new.href }
  end
  
  def test_src
    assert_raises(NotImplementedError) { ImageHost.new.src }
  end
end
