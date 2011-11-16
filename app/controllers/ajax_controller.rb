#http://net.tutsplus.com/tutorials/javascript-ajax/using-unobtrusive-javascript-and-ajax-with-rails-3/
class AjaxController < ApplicationController

  def index
  end

  def clear
    respond_to do |format|
      format.js { render }
    end

  end

  def add_comment
    @message = params[:comment][:message]
    respond_to do |format|
      format.html { render }
      format.js
    end
  end

  def post_data
    position = params[:position]
    respond_to do |format|
      format.text {render text: "id: #{id}, top is #{position[:top]}, left is #{position[:left]}"}
    end
  end

  def json_data
    respond_to do |format|
      format.json do
        @example = Example.new("Piotr", 99);
        x = render json: @example
        puts x
        x
      end
    end
  end

end

class Example
  attr_accessor :name, :age
  def initialize name, age
    @name, @age = name, age
  end
end
