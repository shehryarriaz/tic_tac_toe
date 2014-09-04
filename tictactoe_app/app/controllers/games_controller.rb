class GamesController < ApplicationController

  def index
    @name = current_user.try(:name)
    @games = current_user.try(:games)
    @win_count = current_user.try(:wins)
    @loss_count = current_user.try(:losses)
    @draw_count = current_user.try(:draws)
    @in_progress = current_user.try(:in_progress)
    @win_loss = current_user.try(:win_loss)
  end

  def new
    @game = Game.new
  end

  def create
    @new_game = Game.new(params[:game])
    if @new_game.save
      flash[:notice] = "Game created."
      redirect_to @new_game
    else
      flash[:error] = "Invalid game. #{@new_game.errors.full_messages.to_sentence}"
      redirect_to new_game_path
    end
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
      flash[:error] = "Invalid move. #{@move.errors.full_messages.to_sentence}"
    end
    redirect_to @game
  end

end