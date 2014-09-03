class GamesController < ApplicationController

  def index
    @name = current_user.name
    @games = current_user.games
    @win_count = current_user.wins
    @loss_count = current_user.losses
    @draw_count = current_user.draws
    @in_progress = current_user.in_progress
    @win_loss = current_user.win_loss
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