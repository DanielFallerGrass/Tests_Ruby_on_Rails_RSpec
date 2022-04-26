class EnemiesController < ApplicationController

  before_action :set_enemy, only: [:show, :destroy, :update]

  def index
    @enemies = Enemy.all
  end

  def show
    @enemy
  end

  def create
    @enemy = Enemy.create(enemy_param)
    redirect_to enemies_path
  end

  def update
    if @enemy.update(enemy_params)
      render json: @enemy, status: :ok
    else
      render json: { erros: @enemy.erros }, status: :unprocessable_entity
    end
  end

  def destroy
    @enemy.destroy
    head 204
  end

  private

  def enemy_params
    params.permit(:name, :power_base, :power_step, :level, :kind)
  end

  def enemy_param
    params.require(:enemy).permit(:name, :power_base, :power_step, :level, :kind)
  end

  def set_enemy
    @enemy = Enemy.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: :not_found
  end
end
