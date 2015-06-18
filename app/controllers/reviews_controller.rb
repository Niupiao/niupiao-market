class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end
end

private

def review_params
  params.require(:review).permit(:user_id, 
                                 :body,
                                 :rating)
end