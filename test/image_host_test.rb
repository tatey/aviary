require 'helper'

describe ImageHost do
  after do
    ImageHost.instance_variable_set("@matches", nil)
  end
  
  describe ".available" do
    after do
      ImageHost.instance_variable_set("@available", nil)
      ImageHost::Flickr.instance_variable_set("@api_key", nil)
    end
    
    describe "with flickr api key" do
      it "should be four children classes" do
        ImageHost::Flickr.api_key('secret')
        ImageHost.available.must_equal [ImageHost::Flickr, ImageHost::Plixi, ImageHost::Twitpic, ImageHost::Yfrog]
      end
    end
    
    describe "without flickr api key" do
      it "should be three children classes" do
        ImageHost.available.must_equal [ImageHost::Plixi, ImageHost::Twitpic, ImageHost::Yfrog]
      end
    end
  end
  
  describe ".available?" do
    it "should be true" do
      ImageHost.available?.must_equal true
    end
  end
  
  describe ".matches" do
    it "should set and get regular expressions" do
      ImageHost.matches /foo/
      ImageHost.matches.must_equal [/foo/]
    end
  end
  
  describe ".match" do
    before do
      ImageHost.matches /foo/
      ImageHost.matches /bar/
    end
    
    describe "no matches" do
      it "should be empty" do
        ImageHost.match("alice and bob").must_be_empty
      end
    end
    
    describe "one match" do
      it "should be one capture" do
        ImageHost.match("foo before baz").must_equal ["foo"]
      end
    end
    
    describe "three matches" do
      it "should be three captures" do
        ImageHost.match("foo, bar and another foo").must_equal ["foo", "bar", "foo"]
      end
    end
  end
  
  describe ".match_and_create" do
    before do
      ImageHost.matches /foo/
      ImageHost.matches /bar/
    end
    
    after do
      ImageHost.destroy
    end
    
    describe "no matches" do
      it "should not create any records" do
        ImageHost.match_and_create(Struct::Status.new("alice and bob"))
        ImageHost.count.must_equal 0
      end
    end
    
    describe "one match" do
      it "should create one record" do
        ImageHost.match_and_create(Struct::Status.new("foo before baz"))
        ImageHost.first.token.must_equal "foo"
      end
    end
    
    describe "three matches" do
      it "should not create duplicate records" do
        ImageHost.match_and_create(Struct::Status.new("foo, bar and a duplicate foo"))
        ImageHost.all.map { |im| im.token }.must_equal ["foo", "bar"]
      end
    end
  end
    
  describe "#href" do
    it "should raise NotImplementedError" do
      proc { ImageHost.new.href }.must_raise NotImplementedError
    end
  end
  
  describe "#src" do
    it "should raise NotImplementedError" do
      proc { ImageHost.new.src }.must_raise NotImplementedError
    end
  end
end
