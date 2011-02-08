require File.expand_path('../../../helper', __FILE__)

class FlickrTest < MiniTest::Unit::TestCase
  def setup
    Brisbane::Configuration.new(:test)
    ImageHost::Flickr.api_key('secret')
  end
  
  def teardown
    ImageHost::Flickr.instance_variable_set("@api_key", nil)
    ImageHost::Flickr.destroy
  end
  
  def stub_get(url)
    stub_request(:get, url).
      to_return(:status => 200, :body => File.read(File.expand_path('../../../fixtures/flickr.xml', __FILE__)), :headers => {:content_type => "application/xml; charset=utf-8"})
  end
  
  def create_flickr
    stub_get("http://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=secret&photo_id=5332667092")
    @flickr = ImageHost::Flickr.create(:token => '98ej95')
  end
  
  def test_get_and_set_api_key
    ImageHost::Flickr.instance_variable_set('@api_key', nil)
    assert_nil ImageHost::Flickr.api_key
    
    ImageHost::Flickr.api_key('secret')
    assert_equal 'secret', ImageHost::Flickr.api_key
  end
  
  def test_available_should_be_true_when_api_key
    assert ImageHost::Flickr.available?
    
    ImageHost::Flickr.instance_variable_set('@api_key', nil)
    assert !ImageHost::Flickr.available?
  end
  
  def test_match_and_create_long_url_should_encode_id_to_token_and_create_record
    stub_get("http://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=secret&photo_id=5332667092")
    ImageHost::Flickr.match_and_create(Struct::Status.new("Check out my photo http://www.flickr.com/photos/tatejohnson/5332667092/"))
    assert_equal '98ej95', ImageHost::Flickr.first.token
  end
  
  def test_match_and_create_short_url_should_create_record
    stub_get("http://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=secret&photo_id=5332667092")
    ImageHost::Flickr.match_and_create(Struct::Status.new("Check out my photo http://www.flic.kr/p/98ej95"))
    assert_equal '98ej95', ImageHost::Flickr.first.token
  end
  
  def test_href
    create_flickr
    assert_equal "http://flic.kr/p/98ej95", @flickr.href
  end
  
  def test_src
    create_flickr
    assert_equal "http://farm6.static.flickr.com/5010/5332667092_41a375fca3_z.jpg", @flickr.src
  end
end
