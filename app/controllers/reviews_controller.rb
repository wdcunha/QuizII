class ReviewsController < ApplicationController
  before_action :authenticate_user!, :find_idea
  before_action :find_review, :authorize_user!, only: [:destroy]


  def create
    @review = Review.new(review_params)
    @review.idea = @idea
    @review.user = current_user

    if @review.save
      redirect_to idea_path(@idea)
    else
      @reviews = @idea.reviews.order(created_at: :desc)
      render 'ideas/show'
    end
  end


  def destroy
    @review.destroy
    redirect_to idea_path(@idea)
  end

  private
  def review_params
    params.require(:review).permit(:body)
  end

  def find_idea
    @idea = Idea.find params[:idea_id]
  end


  def find_review
    @review = Review.find params[:id]
  end

  def authorize_user!
    unless can?(:manage, @review)
      flash[:alert] = "Access Denied!"
      redirect_to home_path
    end
  end
end
