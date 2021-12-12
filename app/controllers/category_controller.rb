class CategoryController < ApplicationController




  def new
    @category = Category.new
  end

  def create
    category = Category.new(category_params)
    params[:category][:id].each do |person_id|
      category.people << Person.find(person_id) if person_id.present? # check for empty string in params id field
    end
    if category.save
      flash[:notice] = "Category created successfully"
      redirect_to categories_path
    else
      flash[:alert] = "Category not created"
      render :new
    end
  end

  def index
    @categories = []
    current_user.people.each do |person|
      person.categories.each do |person_category|
        @categories << person_category unless @categories.include?(person_category)
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:notice] = 'Category deleted successfully'
    else
      flash[:alert] = 'For one of your persons this category is the only one. Last category could not be deleted'
    end
    redirect_to categories_path
  end


  def category_params
    params.require(:category).permit(:title, :debit)
  end

end
