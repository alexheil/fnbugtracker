class Bugs::BugsController < ApplicationController

  before_action :authenticate_admin!, except: [:index, :show]

  def index
    @bugs = Bug.all
  end

  def show
    @bug = Bug.friendly.find(params[:id])
  end

  def new
    @bug = Bug.new
  end
  
  def create
    @bug = Bug.new(bug_params)
    @bug.user_id = current_user.id
    if @bug.save
      flash[:notice] = "You just created " + @bug.title + "!"
      redirect_to bug_path(@bug)
    else
      flash.now[:alert] = 'Whoa! Something went wrong!'
      render 'new'
    end
  end

  def edit
    @bug = Bug.friendly.find(params[:id])
  end

  def update
    @bug = Bug.friendly.find(params[:id])
    if @bug.update_attributes(bug_params)
      flash[:notice] = "Good job!"
      redirect_to bug_path(@bug)
    else
      flash.now[:alert] = 'Bad job!'
      render 'edit'
    end
  end

  def destroy
    @bug = Bug.friendly.find(params[:id]).destroy
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

    def bug_params
      params.require(:bug).permit(:title, :description, :image)
    end

end