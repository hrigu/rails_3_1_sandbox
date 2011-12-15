class Post < ActiveRecord::Base
  has_many :comments, :dependent => :destroy

  def destroy
    puts "destroy a Post object..."
    super
  end
end
