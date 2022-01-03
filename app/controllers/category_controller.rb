# frozen_string_literal: true

class CategoryController < ApplicationController
  before_action :category_find, only: %i[edit update destroy]
  before_action :require_signed_user, only: %i[index edit update destroy new info]
  before_action :require_same_signed_user, only: %i[edit update destroy info]

  def new
    @category = Category.new
  end

  def edit; end

  def update
    if @category.update(category_params)
      non_empty_params_categories = params[:category][:id].reject(&:empty?)
      destroy_person_categories(@category, non_empty_params_categories)
      add_person_to_category(@category, non_empty_params_categories)
      flash[:notice] = 'Category updated'
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def create
    @category = Category.new(category_params)
    params[:category][:id].each { |id| @category.people << Person.find(id) if id.present? }
    if @category.save
      flash[:notice] = 'Category created successfully'
      redirect_to categories_path
    else
      render :new
    end
  end

  def index
    @categories = current_user.people.collect(&:categories).flatten.uniq
  end

  def destroy
    if @category.destroy
      flash[:notice] = 'Category deleted successfully'
    else
      flash[:alert] = 'For one of your persons this category is the only one. Last category could not be deleted'
    end
    redirect_to categories_path
  end

  # rubocop:disable Metrics/AbcSize
  def info
    if params_date_validator(params)
      @start_date = Date.today.beginning_of_month
      @end_date = date_to_datetime(Date.today)
    else
      @start_date = Date.parse(params[:money_transaction][:start_date])
      @end_date = date_to_datetime(Date.parse(params[:money_transaction][:end_date]))
    end
    @category = Category.find(params[:id])
    @transactions = transaction_selector(pc_of_category(@category, @start_date, @end_date), params)
    @sum_amount_value = @transactions.inject(0) { |sum, t| sum + t.amount_value }
  end

  private

  def transaction_selector(person_category, params)
    trs = MoneyTransaction.where(person_category_id: person_category)
    trs = trs.where.not(note: nil) if !params[:with_note].nil? && (params[:with_note].values[0] == '1')
    trs.where(important: true) if !params[:important].nil? && (params[:important].values[0] == '1')
    trs
  end
  # rubocop:enable Metrics/AbcSize

  def date_to_datetime(date)
    date.to_datetime.end_of_day
  end

  def date?(date)
    date =~ /\d{4}-\d{2}-\d{2}/
  end

  def pc_of_category(category, start_date, end_date)
    PersonCategory.where(category_id: category, created_at: start_date..end_date)
  end

  def params_date_validator(params)
    params[:money_transaction].nil? || params[:money_transaction][:start_date].nil? ||
      params[:money_transaction][:end_date].nil? || !date?(params[:money_transaction][:start_date]) ||
      !date?(params[:money_transaction][:end_date])
  end

  def destroy_person_categories(category, non_empty_params)
    PersonCategory.where(category_id: category.id).each do |person_category|
      person_category.destroy if non_empty_params.exclude?(person_category.person_id.to_s)
    end
  end

  def add_person_to_category(category, non_empty_params)
    non_empty_params.each do |person_id|
      category.people << Person.find(person_id) unless category.people.include?(Person.find(person_id))
    end
  end

  def category_params
    params.require(:category).permit(:title, :debit)
  end

  def category_find
    @category = Category.find(params[:id])
  end

  def require_signed_user
    return if user_signed_in?

    flash[:alert] = 'You must be signed in to do that'
    redirect_to root_path
  end

  def require_same_signed_user
    category = Category.find(params[:id])
    return if current_user == category.people.first.user

    flash[:alert] = 'You must be the owner to do this.'
    redirect_to root_path
  end
end
