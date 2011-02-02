require 'helper'

class TwitpicTest < Test::Unit::TestCase
  def setup
    @twitpic = Twitpic.new(:token => '3pbkz3')
  end
  
  def test_href
    assert_equal 'http://twitpic.com/3pbkz3', @twitpic.href
  end
  
  def test_src
    assert_equal 'http://twitpic.com/show/large/3pbkz3', @twitpic.src
  end
end
