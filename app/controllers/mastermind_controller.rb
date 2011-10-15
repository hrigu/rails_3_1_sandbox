class MastermindController < ApplicationController
  def index
    @game = session[:game] ||= Game.new
    session[:game] = @game
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def start_game
    @game = session[:game]
    if params[:game]
      @game.properties= (params[:game])
    end
    @game.start

    respond_to do |format|
      format.html {render "play_game"}
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
