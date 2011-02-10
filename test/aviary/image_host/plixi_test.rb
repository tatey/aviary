require File.expand_path('../../../helper', __FILE__)

class PlixiTest < MiniTest::Unit::TestCase
  def setup
    Aviary::Configuration.new(:test)
    stub_request(:get, "http://api.plixi.com/api/tpapi.svc/photos/74226939").
      to_return(:status => 200, :body => File.read(File.expand_path('../../../fixtures/plixi.xml', __FILE__)))
    @plixie = ImageHost::Plixi.create(:token => '74226939')
  end 
  
  def teardown
    ImageHost::Plixi.destroy
  end
  
  def test_href
    assert_equal "http://plixi.com/p/74226939", @plixie.href
  end
  
  def test_src
    assert_equal "http://c0013634.cdn1.cloudfiles.rackspacecloud.com/x2_46c9cfb", @plixie.src
  end
  
  def test_set_meta
    assert_equal "http://c0013633.cdn1.cloudfiles.rackspacecloud.com/x2_46c9cfb", @plixie.meta[:big_image_url]
    assert_equal "http://c0013633.cdn1.cloudfiles.rackspacecloud.com/x2_46c9cfb", @plixie.meta[:large_image_url]
    assert_equal "http://c0013634.cdn1.cloudfiles.rackspacecloud.com/x2_46c9cfb", @plixie.meta[:medium_image_url]
    assert_equal "http://c0013636.cdn1.cloudfiles.rackspacecloud.com/x2_46c9cfb", @plixie.meta[:small_image_url]
    assert_equal "http://c0013637.cdn1.cloudfiles.rackspacecloud.com/x2_46c9cfb", @plixie.meta[:thumbnail_image_url]
  end
end
