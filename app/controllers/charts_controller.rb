# frozen_string_literal: true

class ChartsController < ApplicationController
  before_action :require_signed_user, only: %i[index]

  # rubocop:disable Metrics/AbcSize
  def index
    if non_empty_params_categories?(params)
      @start_date = Date.today.beginning_of_month
      @end_date = date_to_datetime(Date.today)
    else
      @start_date = Date.parse(params[:money_transaction][:start_date])
      @end_date = date_to_datetime(Date.parse(params[:money_transaction][:end_date]))
    end
    @categories = current_user.people.collect(&:categories).flatten.uniq
    @chart_debit_data = get_debit_transactions(@categories, @start_date, @end_date)
    @chart_credit_data = get_credit_transactions(@categories, @start_date, @end_date)
  end
  # rubocop:enable Metrics/AbcSize

  private

  def get_debit_transactions(categories, sdate, edate)
    debit_transactions = []
    categories.select(&:debit).each do |category|
      debit_transactions += [[category.title, MoneyTransaction.where(person_category_id: category.person_categories,
                                                                     created_at: sdate..edate).sum(:amount_value)]]
    end
    debit_transactions
  end

  def get_credit_transactions(categories, sdate, edate)
    credit_transactions = []
    categories.reject(&:debit).each do |category|
      credit_transactions += [[category.title, MoneyTransaction.where(person_category_id: category.person_categories,
                                                                     created_at: sdate..edate).sum(:amount_value)]]
    end
    credit_transactions
  end

  def non_empty_params_categories?(params)
    params[:money_transaction].nil? ||
      params[:money_transaction][:start_date].nil? ||
      params[:money_transaction][:end_date].nil?
  end

  def date_to_datetime(date)
    date.to_datetime.end_of_day
  end

  def require_signed_user
    return if user_signed_in?

    flash[:alert] = 'You must be signed in to access this page.'
    redirect_to root_path
  end
end
