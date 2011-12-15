class Comment < ActiveRecord::Base
  belongs_to :post
  validates :post_id, :presence => true

  def destroy
    puts "destroy a Comment object..."
    super
  end

end
