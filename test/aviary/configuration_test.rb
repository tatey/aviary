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
  
  def test_configuration_with_per_page_sets_per_page
    assert_equal 5, Configuration.new(:test, {:per_page => 5})[:per_page]
  end
  
  def test_configuration_with_limit_sets_limit
    assert_equal 100, Configuration.new(:test, {:limit => 100})[:limit]
  end
  
  def test_configuration_with_query_sets_query
    assert_equal 'cat', Configuration.new(:test, {:query => 'cat'})[:query]
  end
  
  def test_configuration_with_flickr_api_key_sets_api_key
    Configuration.new(:test, {:flickr_api_key => 'secret'})
    assert_equal 'secret', ImageHost::Flickr.api_key
  end
end
