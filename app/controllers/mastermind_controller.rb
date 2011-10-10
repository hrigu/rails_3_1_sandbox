class MastermindController < ApplicationController
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def new_game
    @game = Game.new params[:game][:master], params[:game][:solver]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end

  end


 end
