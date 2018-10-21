class TracksController < ApplicationController
  before_action :ensure_logged_in

  def index
    @tracks = Track.all
    render :index
  end

  def new
    @track = Track.new
    render :new
  end

  def create
    @track = Track.new(track_params)
    @track.is_bonus = bonus_or_regular?(track_params[:is_bonus])
    if @track.save
      redirect_to track_url(@track.id)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to new_album_track_url(album_id: @track.album_id)
    end
  end

  def show
    @track = Track.find_by(id: params[:id])
    if @track
      render :show
    else
      redirect_to tracks_url
    end
  end

  def edit
    @track = Track.find_by(id: params[:id])
    render :edit
  end

  def update
    track = Track.find_by(id: params[:id])
    if !track
      redirect_to tracks_url
    elsif track.update(track_params)
      track.update(is_bonus: bonus_or_regular?(track_params[:is_bonus]))
      redirect_to track_url(track.id)
    else
      flash[:errors] = track.errors.full_messages
      redirect_to edit_track_url(track.id)
    end
  end

  def destroy
    track = Track.find_by(id: params[:id])
    album_id = track.album_id
    track.destroy
    redirect_to album_url(album_id)
  end

  private

  def track_params
    params.require(:track).permit(:album_id, :title, :ord, :lyrics, :is_bonus)
  end

  def bonus_or_regular?(is_bonus)
    is_bonus == 'bonus'
  end

end
