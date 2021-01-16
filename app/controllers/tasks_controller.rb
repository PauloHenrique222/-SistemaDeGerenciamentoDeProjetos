class TasksController < ApplicationController

  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    redirect_to root_path
  end

  def new
    @task = Task.new
    @board = Board.find(params[:id])
    @task.board_id = @board.id
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to board_path(@task.board_id), notice: 'A tarefa foi criada com sucesso.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to board_path(@task.board_id), notice: 'A tarefa foi atualizada com sucesso.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to board_path(@task.board_id), notice: 'A tarefa foi removida com sucesso.' }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:description, :board_id)
    end
end
