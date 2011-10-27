class MastermindController < ApplicationController

  def index
    @game_spec = GameHolder.find_spec (session[:game_id])
    unless @game_spec
      @game_spec = GameSpecification.new
      session[:game_id] = @game_spec.id
    end
    respond_to do |format|
      format.html { render "index" } # index.html.erb
    end
  end

  def start_game
    game_spec = GameHolder.find_spec (session[:game_id])
    if params[:game]
#      begin
    game_spec.choose = (params[:game])
#      rescue => detail
#        flash[:notice] = detail.message
#        redirect_to mastermind_path
#        return  #this is necessary, otherwise the flow goes further in this method
#      end
    end
    @game = Game.new game_spec
    @game.start

    puts @game.secret_code

    respond_to do |format|
      format.html { render "play_game" }
    end
  end

  #def enter_code
  #  @game = GameHolder.find (session[:code])
  #  @game.enter_code
  #  respond_to do |format|
  #    format.html { render "play_game" }
  #  end
  #
  #end

  def guess
    @game = GameHolder.find session[:game_id]
    if @game
      begin
        @game.guess build_guess(params[:guess]) #if params[:guess]
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

  def build_guess params
    return nil unless params
    guess = Array.new params.size
    params.each_pair { |key, value| guess[key.to_i] = value }
    guess
  end

end
