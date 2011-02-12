require File.expand_path('../../helper', __FILE__)

class SiteTest < MiniTest::Unit::TestCase
  def setup
    Aviary::Configuration.new(:test)
    10.times { |n| ImageHost.create(:token => n) }
    @site = Site.new(:source => source_dir, :dest => dest_dir, :per_page => 5)
  end
  
  def teardown
    ImageHost.destroy
    FileUtils.rm_rf(dest_dir)
  end
  
  def source_dir
    File.expand_path('../../fixtures/source', __FILE__)
  end
  
  def dest_dir
    File.join(source_dir, '_site')
  end
  
  def test_process_should_create_dest
    assert !File.exists?(dest_dir)
    
    @site.process
    assert File.exists?(dest_dir)
  end
  
  def test_process_should_generate_gallery
    @site.process
    assert File.exists?(File.join(dest_dir, 'index.htm'))
    assert File.exists?(File.join(dest_dir, 'static'))
    assert File.exists?(File.join(dest_dir, 'subdir', 'static'))
    assert File.exists?(File.join(dest_dir, 'page1', 'index.htm'))
    assert File.exists?(File.join(dest_dir, 'page2', 'index.htm'))
  end
  
  def test_render_should_generate_current_page
    @site.render
    assert File.exists?(File.join(dest_dir, 'page1', 'index.htm'))
    
    @site.paginator.next_page!
    @site.render
    assert File.exists?(File.join(dest_dir, 'page2', 'index.htm'))
  end
  
  def test_copy_index_should_copy_page1_to_index
    @site.render
    @site.copy_index
    assert File.exists?(File.join(dest_dir, 'index.htm'))
  end
  
  def test_copy_assets_should_copy_assets_into_dest
    @site.copy_assets
    assert File.exists?(File.join(dest_dir, 'static'))
    assert File.exists?(File.join(dest_dir, 'subdir', 'static'))
  end
  
  def test_current_page_path_should_be_path_to_current_page
    assert_equal File.join(dest_dir, 'page1'), @site.current_page_path
    
    @site.paginator.next_page!
    assert_equal File.join(dest_dir, 'page2'), @site.current_page_path
  end
end
