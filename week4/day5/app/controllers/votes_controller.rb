class VotesController < ApplicationController
  before_action :ensure_logged_in!
  
  def upvote
    if params.include?(:post_id)
      votable = Post.find(params[:post_id])
      source = sub_url(votable.sub)
    elsif params.include?(:comment_id)
      votable = Comment.find(params[:comment_id])
      source = post_url(votable.post)
    end
      votable.votes.create!(value: 1)
      redirect_to source
  end
  
  def downvote
    if params.include?(:post_id)
      votable = Post.find(params[:post_id])
      source = sub_url(votable.sub)
    elsif params.include?(:comment_id)
      votable = Comment.find(params[:comment_id])
      source = post_url(votable.post)
    end
      votable.votes.create!(value: -1)
      redirect_to source
  end
  
end
