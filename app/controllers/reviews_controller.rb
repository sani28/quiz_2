class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def create
    @review = Review.new(review_params)
    @idea = Idea.find(params[:idea_id])
    @review.idea = @idea
    @review.user = current_user

  if @review.save
    redirect_to @idea
  else
    @reviews = @idea.reviews.order(created_at: :desc)
    flash[:alert] = 'Review not created'
    render '/ideas/show'
  end
end

  def edit
    @review = Review.find(params[:id])
    @idea = Idea.find(params[:idea_id])
  end

  def update
    @review = Review.find(params[:id])
    @idea = Idea.find(params[:idea_id])

    if @review.update(review_params)
      flash[:notice] = 'Review successfully updated!'
      render 'ideas/show'
    end
  end

  def destroy
      @review = Review.find(params[:id])

      if @review.user != current_user
        redirect_to ideas_path, alert: 'Access Denied'
      else
      @review.destroy
      redirect_to idea_path(params[:idea_id]), notice: 'Review Deleted!'

      end

    end

  private

  def review_params
    params.require(:review).permit(:body, :rating)
  end


end
