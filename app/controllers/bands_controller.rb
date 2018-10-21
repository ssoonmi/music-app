class BandsController < ApplicationController
  before_action :ensure_logged_in

  def index
    @bands = Band.all
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band.id)
    else
      flash[:errors] = @band.errors.full_messages
      redirect_to new_band_url
    end
  end

  def show
    @band = Band.find_by(id: params[:id])
    if @band
      render :show
    else
      redirect_to bands_url
    end
  end

  def edit
    @band = Band.find_by(id: params[:id])
    render :edit
  end

  def update
    band = Band.find_by(id: params[:id])
    if !band
      redirect_to bands_url
    elsif band.update(band_params)
      redirect_to band_url(band.id)
    else
      flash[:errors] = band.errors.full_messages
      redirect_to edit_band_url(band.id)
    end
  end

  def destroy
    Band.find_by(id: params[:id]).destroy
    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end

end
