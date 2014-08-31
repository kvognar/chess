module VotablesController
  extend ActiveSupport::Concern
  
  def upvote
    @votable = controller_name.classify.constantize.find(params[:id])
    @votable.votes.create(value: 1, voter: current_user)
    redirect_to request.referrer
  end
  
  def downvote
    @votable = controller_name.classify.constantize.find(params[:id])
    @votable.votes.create(value: -1, voter: current_user)
    redirect_to request.referrer
  end
  
end