require File.expand_path('../../helper', __FILE__)

class PaginatorTest < MiniTest::Unit::TestCase
  def setup 
    Aviary::Configuration.new(:test)
    10.times { |n| ImageHost.create(:token => n) }
    @paginator = Paginator.new(5)
  end
  
  def teardown
    ImageHost.destroy
  end
  
  def test_query_options_should_limit_results
    assert_equal({limit: 5, offset: 0}, @paginator.query_options)
    
    @paginator.next_page!
    assert_equal({limit: 5, offset: 5}, @paginator.query_options)
  end
  
  def test_next_page_boolean
    assert @paginator.next_page?
    
    @paginator.instance_variable_set("@current_page", @paginator.last_page)
    assert !@paginator.next_page?
  end
  
  def test_next_page_should_be_current_page_plus_one
    assert_equal 2, @paginator.next_page
  end
  
  def test_next_page_bang_should_set_current_page
    @paginator.next_page!
    assert_equal 2, @paginator.current_page
  end
  
  def test_prev_page_boolean
    assert !@paginator.prev_page?
    
    @paginator.instance_variable_set("@current_page", @paginator.last_page)
    assert @paginator.prev_page?
  end
  
  def test_prev_page_should_be_current_page_less_one
    @paginator.instance_variable_set("@current_page", @paginator.last_page)
    assert_equal 1, @paginator.prev_page
  end
end
