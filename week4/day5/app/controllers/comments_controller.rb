class CommentsController < ApplicationController
  before_action :ensure_logged_in!
  
  def create
    @comment = current_user.comments.create(comment_params)
    redirect_to post_url(@comment.post)  
  end
  
  def comment_params
    params.require(:comment).permit(:post_id, :parent_id, :content)
  end
  
end
