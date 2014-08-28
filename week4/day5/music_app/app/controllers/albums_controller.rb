class AlbumsController < ApplicationController
  
  def new
    @album = Band.find(params[:band_id]).albums.new
    render :new
  end
  
  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      render :new
    end
  end
  
  def edit
    @album = Album.find(params[:id])
    render :edit
  end
  
  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      render :edit
    end
  end
  
  def index
    @albums = Album.all
    render :index
  end
  
  def show
    @album = Album.find(params[:id])
    render :show
  end
  
  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to band_url(@album.band)
  end
  
  private
  
  def album_params
    params.require(:album).permit(:title, :band_id, :venue)
  end
end
