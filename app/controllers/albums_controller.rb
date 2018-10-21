class AlbumsController < ApplicationController
  before_action :ensure_logged_in

  def index
    @albums = Album.all
    render :index
  end

  def new
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    @album.is_live = live_or_studio?(params[:album][:is_live])
    if @album.save
      redirect_to album_url(@album.id)
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to new_band_album_url(band_id: @album.band_id)
    end
  end

  def show
    @album = Album.find_by(id: params[:id])
    if @album
      render :show
    else
      redirect_to albums_url
    end
  end

  def edit
    @album = Album.find_by(id: params[:id])
    render :edit
  end

  def update
    album = Album.find_by(id: params[:id])
    if !album
      redirect_to albums_url
    elsif album.update(album_params)
      album.update(is_live: live_or_studio?(params[:album][:is_live]))
      redirect_to album_url(album.id)
    else
      flash[:errors] = album.errors.full_messages
      redirect_to edit_album_url(album.id)
    end
  end

  def destroy
    album = Album.find_by(id: params[:id])
    band_id = album.band_id
    album.destroy
    redirect_to band_url(band_id)
  end

  def live_or_studio?(is_live)
    is_live == 'live'
  end

  private

  def album_params
    params.require(:album).permit(:band_id, :title, :year, :is_live)
  end

end
