# frozen_string_literal: true

class MoneyTransactionController < ApplicationController
  before_action :money_transaction_find, only: %i[edit update destroy]
  before_action :require_signed_user, only: %i[new create edit update destroy index]
  before_action :require_same_signed_user, only: %i[edit update destroy]
  def index
    current_user_person_categories = PersonCategory.where(person_id: current_user.people)
    @money_transactions = MoneyTransaction.where(person_category_id: current_user_person_categories)
  end

  def new
    @money_transaction = MoneyTransaction.new
  end

  def edit; end

  def update
    if @money_transaction.update_attributes(money_transaction_params)
      flash[:notice] = 'Money transaction was successfully updated.'
      redirect_to transactions_path
    else
      render 'edit'
    end
  end

  def create
    @money_transaction = MoneyTransaction.new(money_transaction_params)
    add_note(@money_transaction, params)
    if @money_transaction.save
      flash[:notice] = 'Money transaction was successfully created.'
      redirect_to transactions_path
    else
      render :new
    end
  end

  def destroy
    if @money_transaction.destroy
      flash[:notice] = 'Money transaction was successfully deleted.'
    else
      flash[:alert] = 'Money transaction was not deleted.'
    end
    redirect_to transactions_path
  end

  private

  def add_note(transaction, params)
    return if params[:note_required].nil?

    note = Note.new(body: params[:note_body].values[0], color: params[:color].values[0])
    transaction.note = note
  end

  def money_transaction_find
    @money_transaction = MoneyTransaction.find(params[:id])
  end

  def money_transaction_params
    params.require(:money_transaction).permit(:amount_value, :important, :person_category_id)
  end

  def require_signed_user
    return if user_signed_in?

    flash[:alert] = 'You must be signed in to do that'
    redirect_to root_path
  end

  def require_same_signed_user
    mt = MoneyTransaction.find(params[:id])
    return if current_user == mt.person_category.person.user

    flash[:alert] = 'You must be the owner to do this.'
    redirect_to root_path
  end
end
