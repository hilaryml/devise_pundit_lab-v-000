class NotesController < ApplicationController

  def new

  end

  def create
    note = Note.new(note_params)
    note.user = current_user
    authorize note
    note.save!
    redirect_to '/'
  end

  def update
    @note = Note.find(params[:id])
    authorize @note
    @note.update(note_params)
    redirect_to '/'
  end

  def edit
    @note = Note.find(params[:id])
  end

  def show
    @note = Note.find(params[:id])
    authorize @note
  end

  def index
    @notes = Note.none
    if current_user
      @notes = current_user.readable
    end
  end

  def destroy
    if current_user
      authorize @note
      @note.destroy
      redirect_to notes_path, alert: "Note successfully deleted."
    else
      redirect_to notes_path, alert: "Access Denied."
    end
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
end
