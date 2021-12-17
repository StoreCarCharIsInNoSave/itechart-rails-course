# frozen_string_literal: true

class CategoryController < ApplicationController
  before_action :category_find, only: %i[edit update destroy]
  before_action :require_signed_user, only: %i[index edit update destroy new]
  before_action :require_same_signed_user, only: %i[edit update destroy]

  def new
    @category = Category.new
  end

  def edit; end

  #todo: refactor this method
  def update
    # if @category.update(category_params)
    #   PersonCategory.where(category_id: @category.id).destroy_all
    #   params[:category][:id].each do |person_id|
    #     @category.people << Person.find(person_id) if person_id.present?
    #   end
    #   flash[:notice] = 'Category updated'
    #   redirect_to categories_path
    # else
    #   render 'edit'
    # end



    if @category.update(category_params)
      non_empty_params_categories = params[:category][:id].reject(&:empty?)

      PersonCategory.where(category_id: @category.id).each do |person_category|
        person_category.destroy if non_empty_params_categories.exclude?(person_category.person_id.to_s)
      end

      non_empty_params_categories.each do |person_id|
        @category.people << Person.find(person_id) unless @category.people.include?(Person.find(person_id))
      end


      flash[:notice] = 'Category updated'
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def create
    @category = Category.new(category_params)
    params[:category][:id].each do |person_id|
      @category.people << Person.find(person_id) if person_id.present? # check for empty string in params id field
    end
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

  def info
    if params[:start_date].nil? || params[:end_date].nil?
      @start_date = Date.today.beginning_of_month
      @end_date = Date.today
    else
      @start_date = Date.parse(params[:start_date])
      @end_date = Date.parse(params[:end_date])
    end

    @category = Category.find(params[:id])
    all_person_category_of_this_category = PersonCategory.where(category_id: @category, created_at: @start_date..@end_date)
    @money_transactions = MoneyTransaction.where(person_category_id: all_person_category_of_this_category)
  end

  private

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
