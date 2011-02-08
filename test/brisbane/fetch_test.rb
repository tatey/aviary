require File.expand_path('../../helper', __FILE__)

class FetchTest < MiniTest::Unit::TestCase
  def setup
    Brisbane::Configuration.new(:test)
    stub_get("https://search.twitter.com/search.json?q=filter:links%20-rt%20%23cat&rpp=100")
    stub_get("https://search.twitter.com/search.json?max_id=34911824591724544&page=2&q=filter:links%20-rt%20%23cat&rpp=100")
  end
  
  def teardown
    ImageHost.destroy
  end
  
  def stub_get(url)
    stub_request(:get, url).
      to_return(:status => 200, :body => File.read(File.expand_path('../../fixtures/twitter.json', __FILE__)), :headers => {:content_type => "application/json; charset=utf-8"})
  end
    
  def test_process_should_match_and_create_records
    Fetch.new(:hashtag => 'cat').process
    assert_equal 2, ImageHost::Yfrog.count
    assert_equal 13, ImageHost::Twitpic.count
  end
  
  def test_next_page_boolean_should_be_false_when_at_limit
    assert !Fetch.new(:hashtag => 'cat', :limit => 1).next_page?
  end
  
  def test_next_page_bang_should_increment_current_page
    fetch = Fetch.new(:hashtag => 'cat')
    assert_equal 1, fetch.current_page
    
    fetch.next_page!
    assert_equal 2, fetch.current_page
  end
end
