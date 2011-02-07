require 'helper'

class GeneratorTest < MiniTest::Unit::TestCase  
  def setup
    config     = Brisbane::Configuration.new(:default, source: source_dir)
    @generator = Generator.new(source: config[:source], hashtag: "cat")
  end
  
  def teardown
    FileUtils.rm_rf(source_dir)
  end
    
  def test_copy_template_should_copy_template_to_source
    @generator.copy_template
    assert File.exists?(File.join(source_dir, '_assets', 'brisbane.css'))
    assert File.exists?(File.join(source_dir, '_assets', 'brisbane.js'))
    
    html = Nokogiri::HTML(File.read(File.join(source_dir, 'template.erb')))
    assert_equal "#cat", html.css('title').text
    assert_equal "#cat", html.css('h1').text
  end

  def test_migrate_should_create_database_and_schema
    FileUtils.mkdir_p(source_dir)
    @generator.migrate
    assert File.exists?(File.join(source_dir, 'db.sqlite3'))
  end
    
  protected
    
  def source_dir
    File.join(File.expand_path(File.dirname(__FILE__)), '_source')
  end
end
