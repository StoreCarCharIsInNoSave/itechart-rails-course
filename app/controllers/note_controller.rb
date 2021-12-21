class NoteController < ApplicationController

  def show
    @note = Note.find(params[:id])
  end

  def destroy
    @note = Note.find(params[:id])
    category = MoneyTransaction.find_by_note_id(@note.id).person_category.category
    @note.destroy
    flash[:notice] = 'Note successfully deleted.'
    redirect_to category_info_path(category)
  end

  def new
    @note = Note.new
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(note_params)
      flash[:notice] = 'Note successfully updated.'
      redirect_to category_info_path(MoneyTransaction.find_by_note_id(@note.id).person_category.category)
    else
      render 'edit'
    end
  end

  private

  def note_params
    params.require(:note).permit(:body, :color)
  end

end
