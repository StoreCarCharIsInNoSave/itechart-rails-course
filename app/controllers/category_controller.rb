class CategoryController < ApplicationController
  before_action :category_find, only: [:edit, :update, :destroy]
  before_action :require_signed_user, only: [:index, :edit, :update, :destroy, :new]
  before_action :require_same_signed_user, only: [:edit, :update, :destroy]
  def new
    @category = Category.new
  end

  def edit

  end

  def update

    if @category.update(category_params)
      PersonCategory.where(:category_id => @category.id).destroy_all
      params[:category][:id].each do |person_id|
        @category.people << Person.find(person_id) if person_id.present?
      end
      flash[:notice] = "Category updated"
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
      flash[:notice] = "Category created successfully"
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
