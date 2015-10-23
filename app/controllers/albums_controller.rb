class AlbumsController < ApplicationController

  before_action :require_log_in!

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def new
    @album = Album.new(band_id: params[:band_id])
    @bands = Band.all
    render :new
  end

  def edit
    @bands = Band.all
    @album = Album.find(params[:id])
    render :edit
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.find_by(params[:id])
    @album.delete
  end

  private
  def album_params
    params.require(:album).permit(:title, :band_id, :set)
  end
end
