class TracksController < ApplicationController
  before_action :require_signed_in!
  
  
  def new
    @track = Album.find(params[:album_id]).tracks.new
    render :new
  end
  
  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      render :new
    end
  end
  
  def edit
    @track = Track.find(params[:id])
    render :edit
  end
  
  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(track_params)
      redirect_to track_url(@track)
    else
      render :edit
    end
  end
  
  def index
    @tracks = Track.all
    render :index
  end
  
  def show
    @track = Track.find(params[:id])
    @note = Note.new

    render :show
  end
  
  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to album_url(@track.album)
  end
  
  private
  
  def track_params
    params.require(:track)
        .permit(:title, :album_id, :track_number, :status, :lyrics)
  end
  
end
