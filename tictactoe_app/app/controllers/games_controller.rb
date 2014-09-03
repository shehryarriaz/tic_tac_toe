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
    @markers = @game.board
  end

  def make_move
    @game = Game.find(params[:id])
    @move = @game.moves.new(user_id: current_user.id, space: params[:space], marker: @game.next_marker )
    if @move.save
      flash[:notice] = "Move made."
    else
      flash[:error] = "Invalid move."
    end
    redirect_to @game
  end

end