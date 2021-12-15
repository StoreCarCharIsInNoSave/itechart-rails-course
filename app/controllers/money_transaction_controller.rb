class MoneyTransactionController < ApplicationController
  def index
    current_user_person_categories = PersonCategory.where(person_id: current_user.people)
    p current_user_person_categories
    @money_transactions = MoneyTransaction.where(person_category_id: current_user_person_categories)


  end
end
