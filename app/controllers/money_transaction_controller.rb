class MoneyTransactionController < ApplicationController
  def index
    current_user_person_categories = PersonCategory.where(person_id: current_user.people)
    @money_transactions = MoneyTransaction.where(person_category_id: current_user_person_categories)
  end

  def new
    @money_transaction = MoneyTransaction.new
  end

  def edit
    @money_transaction = MoneyTransaction.find(params[:id])
  end

  def update
    @money_transaction = MoneyTransaction.find(params[:id])
    if @money_transaction.update_attributes(money_transaction_params)
      flash[:notice] = 'Money transaction was successfully updated.'
      redirect_to transactions_path
    else
      render 'edit'
    end
  end

  def create
    @money_transaction = MoneyTransaction.new(money_transaction_params)
    if @money_transaction.save
      flash[:notice] = "Money transaction was successfully created."
      redirect_to transactions_path
    else
      render :new
    end
  end

  def destroy
    @money_transaction = MoneyTransaction.find(params[:id])
    if @money_transaction.destroy
      flash[:notice] = "Money transaction was successfully deleted."
    else
      flash[:alert] = "Money transaction was not deleted."
    end
    redirect_to transactions_path
  end

  private

  def money_transaction_params
    params.require(:money_transaction).permit(:amount_value, :important, :person_category_id)
  end

end
