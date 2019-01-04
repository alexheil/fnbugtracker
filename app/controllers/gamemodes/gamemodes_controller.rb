class Gamemodes::GamemodesController < ApplicationController

  before_action :authenticate_admin!, except: [:index, :show]

  def index
    @gamemodes = Gamemode.all
  end

  def show
    @gamemode = Gamemode.friendly.find(params[:id])
    @videos = @gamemode.videos.popular.page params[:page]
  end

  def new
    @gamemode = Gamemode.new
  end

  def create
    @gamemode = Gamemode.new(gamemode_params)
    if @gamemode.save
      flash[:notice] = "You just created " + @gamemode.title + "!"
      redirect_to gamemode_path(@gamemode)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def edit
    @gamemode = Gamemode.friendly.find(params[:id])
  end

  def update
    @gamemode = Gamemode.friendly.find(params[:id])
    if @gamemode.update_attributes(gamemode_params)
      flash[:notice] = "Good job!"
      redirect_to gamemode_path(@gamemode)
    else
      flash.now[:alert] = 'Bad job!'
      render 'edit'
    end
  end

  def destroy
    @gamemode = Gamemode.friendly.find(params[:id]).destroy
    redirect_to root_url
    flash[:notice] = "Delete successful."
  end

  private

    def authenticate_admin!
      unless user_signed_in? && current_user == User.find(1)
        redirect_to root_url
        flash[:notice] = "You do not have access to this page."
      end
    end

    def gamemode_params
      params.require(:gamemode).permit(:title, :description, :image)
    end

end