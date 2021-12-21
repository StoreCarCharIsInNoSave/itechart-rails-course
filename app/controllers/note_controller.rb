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
end
