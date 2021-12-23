# frozen_string_literal: true

class NoteController < ApplicationController
  before_action :require_signed_user, only: %i[new create edit update destroy]
  before_action :require_same_signed_user, only: %i[edit update destroy]
  before_action :find_note, only: %i[show edit update destroy]
  def show; end

  def destroy
    category = MoneyTransaction.find_by_note_id(@note.id).person_category.category
    @note.destroy
    flash[:notice] = 'Note successfully deleted.'
    redirect_to category_info_path(category)
  end

  def new
    @note = Note.new
  end

  def edit; end

  def update
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

  def find_note
    @note = Note.find(params[:id])
  end

  def require_signed_user
    return if user_signed_in?

    flash[:alert] = 'You must be signed in to do that'
    redirect_to root_path
  end

  def require_same_signed_user
    transaction = MoneyTransaction.find_by_note_id(params[:id])
    return if current_user == transaction.person_category.person.user

    flash[:alert] = 'You must be the owner to do this.'
    redirect_to root_path
  end
end
