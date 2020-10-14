class BoardsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :create, :show, :update, :destroy]
  before_action :set_board, only: [:show, :edit, :update, :destroy]

  def index
    if user_signed_in?
      @boards = Board.where(user_id: current_user.id)
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @tasks = Task.where(board_id: @board.id)
  end

  def new
    @board = Board.new
  end

  def edit
  end

  def create
    @board = Board.new(board_params)
    set_user_id
    respond_to do |format|
      if @board.save
        format.html { redirect_to root_path, notice: 'O quadro foi criado com sucesso.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      set_user_id
      if @board.update(board_params)
        format.html { redirect_to root_path, notice: 'O quadro foi atualizado com sucesso.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url, notice: 'O quadro foi removido com sucesso.' }
    end
  end

  private

    def set_board
      @board = Board.find(params[:id])
    end

    def board_params
      params.require(:board).permit(:name, :description)
    end

    def set_user_id
      @board.user_id = current_user.id
    end
end
