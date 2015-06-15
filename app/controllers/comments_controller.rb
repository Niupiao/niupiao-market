class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end
end

private

def comment_params
        params.require(:comment).permit(:user_id, :body,
                                      :rating)
end
