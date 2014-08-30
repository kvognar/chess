class NotesController < ApplicationController
  before_action :require_signed_in!
  before_action :require_authorship!, only: :destroy
  
  def create
    @note = Note.new(note_params)
    @note.track = Track.find(params[:track_id])
    @note.author = current_user
    
    @note.save!
    redirect_to track_url(@note.track)
  end
  
  def note_params
    params.require(:note).permit(:track_id, :author_id, :body)
  end
  
  def destroy
    @note ||= Note.find(params[:id])
    @note.destroy
    redirect_to track_url(@note.track)
  end
  
  def require_authorship!
    @note = Note.find(params[:id])
    unless @note.author == current_user
      render text: "403 FORBIDDEN"
    end
  end

end
