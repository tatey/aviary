require File.expand_path('../../helper', __FILE__)

class PageTest < MiniTest::Unit::TestCase
  def setup
    Brisbane::Configuration.new(:test)
    10.times { |n| ImageHost.create(:token => n) }
    @page = Page.new(Paginator.new(5))
  end
  
  def teardown
    ImageHost.destroy
  end
  
  def test_binding_should_be_public
    assert @page.binding
  end
  
  def test_paginator_should_be_a_paginator
    assert_instance_of Paginator, @page.paginator
  end
  
  def test_image_hosts_should_have_five_image_hosts
    assert_equal 5, @page.image_hosts.size
  end
  
  def test_h_should_escape_unsafe_characters
    assert_equal "&lt;script&gt;", @page.h("<script>")
  end
end
