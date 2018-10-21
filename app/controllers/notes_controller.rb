class NotesController < ApplicationController
  before_action :ensure_logged_in

  def create
    note = Note.new(note_params)
    note.user_id = current_user.id
    if note.save

    else
      flash[:errors] = note.errors.full_messages
    end
    redirect_to track_url(note.track_id)
  end

  def edit
    @note = Note.find(params[:id])
    render :edit
  end

  def update
    note = Note.find(params[:id])
    if note && note.update(note_params)
      redirect_to track_url(note.track_id)
    elsif note
      flash[:errors] = note.errors.full_messages
      redirect_to track_url(note.track_id)
    else
      redirect_to bands_url
    end
  end

  def destroy
    note = Note.find(params[:id])
    if note && current_user.id == note.user_id
      track_id = note.track_id
      note.destroy
      redirect_to track_url(track_id)
    elsif note
      track_id = note.track_id
      redirect_to track_url(track_id), status: 403
    else
      redirect_to bands_url
    end
  end

  private

  def note_params
    params.require(:note).permit(:track_id, :body)
  end
end
