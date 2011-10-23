class MastermindController < ApplicationController

  def index
    @game = Game.find (session[:game_id])
    unless @game
      @game = Game.new
      session[:game_id] = @game.id
    end
    puts session.inspect
    respond_to do |format|
      format.html { render "index" } # index.html.erb
    end
  end

  def start_game
    @game = Game.find (session[:game_id])
    if params[:game]
      @game.properties = (params[:game])
    end
    begin
      @game.start
    rescue => detail
    end

    respond_to do |format|
      format.html { render "play_game" }
    end
  end

  def guess
    @game = Game.find session[:game_id]
    puts "game = #{@game}"
    if @game
      begin
        @game.guess params[:guess] #if params[:guess]
      rescue => detail
        puts detail
        flash[:notice] = "could not make a guess, because I don't have possible solutions any more'"
      end
      String next_page = @game.solved ? "game_solved" : "play_game"
      respond_to do |format|
        format.html { render next_page }
      end
    else
      redirect_to mastermind_path
    end
  end
end
