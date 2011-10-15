class MastermindController < ApplicationController
  def index
    @game_configuration = GameConfiguration.new
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
      format.html {render "play_game"}
      format.json { render json: @posts }
    end
  end

  def guess
    @game = session[:game]

    @game.guess params[:guess] if params[:guess]
    String next_page = @game.solved ? "game_solved" : "play_game"
    respond_to do |format|
      format.html {render next_page}
    end

  end


end
