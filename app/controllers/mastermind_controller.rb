class MastermindController < ApplicationController
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def start_game
    if params[:game]
      game = Game.new params[:game]
      session[:game] = game
    end
    @game = session[:game]
    @game.start

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end


end
