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
    game_spec = GameHolder.find_spec session[:game_id]
    if params[:game]
      begin
        game_spec.choose params[:game]
      rescue => detail
        flash[:notice] = detail.message
        redirect_to mastermind_path
        return #this is necessary, otherwise the flow goes further in this method
      end
    end
    @game = Game.new game_spec

    page = "play_game"
    if @game.state == Game::WAIT_FOR_SECRET_CODE
      page = "add_secret_code"
    end

    respond_to do |format|
      format.html { render page }
    end
  end

  def put
    @game = GameHolder.find session[:game_id]
    if @game
      begin
        @game.put build_guess(params[:put]) #if params[:guess]
      rescue MastermindError => detail
        flash[:notice] = detail.message
      end
      next_page = "play_game"
      if @game.state == Game::SOLVED
        next_page = "game_solved"
      elsif @game.state == Game::WAIT_FOR_EVALUATION
        next_page = "evaluate"
      end
      respond_to do |format|
        format.html { render next_page }
      end
    else
      redirect_to mastermind_path
    end
  end

  ##
  #  {"0"=>"red", "1"=>"green"}  -> ["black", "green"]
  ##
  def build_guess params
    return nil unless params
    guess = Array.new params.size
    params.each_pair { |key, value| guess[key.to_i] = value }
    guess
  end

end
