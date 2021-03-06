# frozen_string_literal: true

class PersonController < ApplicationController
  before_action :require_signed_user, only: %i[index destroy create new edit update]
  before_action :require_same_signed_user, only: %i[destroy edit update]
  before_action :find_person, only: %i[edit update destroy]

  def index
    @persons = current_user.people
  end

  def new
    @person = Person.new
  end

  def edit; end

  def update
    if @person.update(person_params)
      flash[:notice] = 'Person updated successfully'
      redirect_to person_index_path
    else
      render :edit
    end
  end

  def create
    @person = Person.new(person_params)
    @person.user = current_user
    if @person.save
      flash[:notice] = 'Person was successfully created.'
      redirect_to person_index_path
    else
      render :new
    end
  end

  def categories_index
    @categories = find_person.categories
  end

  def destroy
    if @person.destroy
      flash[:notice] = 'Person deleted successfully'
    else
      flash[:alert] = 'Last person could not be deleted'
    end

    redirect_to person_index_path
  end

  private

  def require_signed_user
    return if user_signed_in?

    flash[:alert] = 'You must be signed in to do that'
    redirect_to root_path
  end

  def find_person
    @person = Person.find(params[:id])
  end

  def require_same_signed_user
    person = Person.find(params[:id])
    return if current_user == person.user

    flash[:alert] = 'You can only delete your own person'
    redirect_to root_path
  end

  def person_params
    params.require(:person).permit(:title, :name, :lastname)
  end
end
