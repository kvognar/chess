module Votable
  extend ActiveSupport::Concern
  included do
    has_many(
      :votes,
      as: :votable
    )
  end
  
  def score
    self.votes.inject(0) { |sum, vote| sum + vote.value }
  end
end