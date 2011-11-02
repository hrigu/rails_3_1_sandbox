class AdminController < ApplicationController

  def index
    @admin = Admin.new GameHolder.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def delete_game_instances
    GameHolder.delete_all
    GC.start
    redirect_to :admin
  end
  def delete_game
    id = params[:id].to_i
    GameHolder.delete(id)

    GC.start
    redirect_to :admin
  end
end