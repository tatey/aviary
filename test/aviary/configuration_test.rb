require File.expand_path('../../helper', __FILE__)

class ConfigurationTest < MiniTest::Unit::TestCase
  def teardown
    ImageHost::Flickr.instance_variable_set('@api_key', nil)
  end
  
  def test_default_configuration
    config = Configuration.new(:test)
    assert_equal Dir.pwd, config[:source]
    assert_equal File.join(Dir.pwd, '_site'), config[:dest]
  end
  
  def test_configuration_with_hashtag_sets_hashtag
    assert_equal 'cat', Configuration.new(:test, {:hashtag => 'cat'})[:hashtag]
  end
  
  def test_configuration_with_flickr_api_key_sets_api_key
    Configuration.new(:test, {:flickr_api_key => 'secret'})
    assert_equal 'secret', ImageHost::Flickr.api_key
  end
end
