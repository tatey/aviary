require File.expand_path('../../helper', __FILE__)

class GeneratorTest < MiniTest::Unit::TestCase  
  def setup
    config     = Aviary::Configuration.new(:default, :source => source_dir)
    @generator = Generator.new(:source => config[:source], :hashtag => "cat")
  end
  
  def teardown
    FileUtils.rm_rf(source_dir)
  end
  
  def source_dir
    File.expand_path('../../fixtures/_source', __FILE__)
  end
    
  def test_copy_template_should_copy_template_to_source
    @generator.copy_template
    assert File.exists?(File.join(source_dir, '_assets', 'aviary.css'))
    assert File.exists?(File.join(source_dir, '_assets', 'aviary.js'))
    
    html = Nokogiri::HTML(File.read(File.join(source_dir, 'template.erb')))
    assert_equal "#cat", html.css('title').text
    assert_equal "#cat", html.css('h1').text
  end

  def test_migrate_should_create_database_and_schema
    FileUtils.mkdir_p(source_dir)
    @generator.migrate
    assert File.exists?(File.join(source_dir, 'db.sqlite3'))
  end
end
