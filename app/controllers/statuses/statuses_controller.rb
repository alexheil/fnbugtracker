class Statuses::StatusesController < ApplicationController

  before_action :authenticate_admin!, except: [:index, :show]

  def index
    @statuses = Status.all
  end

  def show
    @status = Status.friendly.find(params[:id])
    # @bugs = @status.bugs.popular.page params[:page]
  end

  def new
    @status = Status.new
  end

  def create
    @status = Status.new(status_params)
    if @status.save
      flash[:notice] = "You just created " + @status.title + "!"
      redirect_to status_path(@status)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def edit
    @status = Status.friendly.find(params[:id])
  end

  def update
    @status = Status.friendly.find(params[:id])
    if @status.update_attributes(status_params)
      flash[:notice] = "Good job!"
      redirect_to status_path(@status)
    else
      flash.now[:alert] = 'Bad job!'
      render 'edit'
    end
  end

  def destroy
    @status = Status.friendly.find(params[:id]).destroy
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

    def status_params
      params.require(:status).permit(:title, :description)
    end

end