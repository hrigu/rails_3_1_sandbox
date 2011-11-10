#http://net.tutsplus.com/tutorials/javascript-ajax/using-unobtrusive-javascript-and-ajax-with-rails-3/
class AjaxController < ApplicationController

  def index
  end

  def clear
    respond_to do |format|
      format.js   {render }
    end

  end

  def add_comment
    @message = params[:comment][:message]
    respond_to do |format|
      format.html { render }
      format.js
    end

  end

end
