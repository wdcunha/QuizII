class IdeasController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]


  def new
    @idea = Idea.new
  end

  def index
    @ideas = Idea.all.order(created_at: :desc)
  end

  def create
    @idea = Idea.new idea_params

    @idea.user = current_user

    if @idea.save
      flash[:success] = 'Idea created!'
      redirect_to ideas_path
    else
      render :new
    end
  end

  def show
    @reviews = @idea.reviews.order(created_at: :desc)
    @review = Review.new
  end

  def edit

  end

  def update
    if @idea.update(idea_params)
      flash[:success] = 'Idea was deleted successfully!'
      redirect_to idea_path(@idea)
    else
      render :edit
    end
  end

  def destroy
    @idea.destroy

    redirect_to ideas_path
  end

  def find_idea
    @idea = Idea.find params[:id]
  end

  private
  def idea_params
    params.require(:idea).permit(:title, :description)
  end

    def authorize_user!
      unless can?(:manage, @idea)
        flash[:danger] = "Access denied!"
        redirect_to home_path
      end
    end

end
