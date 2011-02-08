require File.expand_path('../../../helper', __FILE__)

class YfrogTest < MiniTest::Unit::TestCase
  def setup
    @yfrog = ImageHost::Yfrog.new(:token => 'h4tsukzj')
  end
  
  def test_href
    assert_equal 'http://yfrog.com/h4tsukzj', @yfrog.href
  end
  
  def test_src
    assert_equal 'http://yfrog.com/h4tsukzj:medium', @yfrog.src
  end
end
