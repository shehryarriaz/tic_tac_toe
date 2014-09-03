class GamesController < ApplicationController

  def index
    @name = current_user.name
    @games = current_user.games
  end

  def new
    @game = Game.new
  end

  def create
    Game.create(params[:game])
    redirect_to games_path
  end

  def show
    @game = Game.find(params[:id])
  end

end