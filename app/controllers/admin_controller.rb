class AdminController < ApplicationController

  def index
    @admin = Admin.new $game_instances

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def delete_game_instances
    $game_instances = {}
    GC.start
    redirect_to :admin
  end
  def delete_game
    id = params[:id].to_i
    Game.delete(id)

    GC.start
    redirect_to :admin
  end
end