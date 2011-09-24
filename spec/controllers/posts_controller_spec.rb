require 'spec_helper'
require 'database_cleaner'

  DatabaseCleaner.strategy = :truncation

  # then, whenever you need to clean the DB


describe PostsController do

  before(:each) {
    DatabaseCleaner.clean
    @post = Post.new
    @post.save
    puts @post.id.to_s

  }

  describe "GET 'show'" do
    it "should be successful" do
      get 'show', id: @post.id
      response.should be_success
    end
  end

end
