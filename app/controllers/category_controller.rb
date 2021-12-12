class CategoryController < ApplicationController

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

end
