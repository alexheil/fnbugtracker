class Platforms::PlatformsController < ApplicationController

  before_action :authenticate_admin!, except: [:index, :show]

  def index
    @platforms = Platform.all
  end

  def show
    @platform = Platform.friendly.find(params[:id])
    # @bugs = @platform.bugs.popular.page params[:page]
  end

  def new
    @platform = Platform.new
  end

  def create
    @platform = Platform.new(platform_params)
    if @platform.save
      flash[:notice] = "You just created " + @platform.title + "!"
      redirect_to platform_path(@platform)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def edit
    @platform = Platform.friendly.find(params[:id])
  end

  def update
    @platform = Platform.friendly.find(params[:id])
    if @platform.update_attributes(platform_params)
      flash[:notice] = "Good job!"
      redirect_to platform_path(@platform)
    else
      flash.now[:alert] = 'Bad job!'
      render 'edit'
    end
  end

  def destroy
    @platform = Platform.friendly.find(params[:id]).destroy
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

    def platform_params
      params.require(:platform).permit(:title, :description)
    end

end