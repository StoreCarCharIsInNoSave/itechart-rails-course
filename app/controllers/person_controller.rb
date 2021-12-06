class PersonController < ApplicationController
  before_action :require_signed_user, only: [:index, :destroy, :create, :new]
  before_action :require_same_signed_user, only: [:destroy]

  def index
    @persons = current_user.people
  end

  def new
    @person = Person.new
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

  def destroy
    @person = Person.find(params[:id])
    if current_user.people.count > 1
      @person.destroy
      flash[:notice] = "Person deleted successfully"
    else
      flash[:alert] = 'You must have at least one person in your account'
    end
    redirect_to person_index_path
  end

  private

  def require_signed_user
    unless user_signed_in?
      flash[:alert] = 'You must be signed in to do that'
      redirect_to root_path
    end
  end

  def require_same_signed_user
    @person = Person.find(params[:id])
    unless current_user == @person.user
      flash[:alert] = 'You can only delete your own person'
      redirect_to root_path
    end
  end

  def person_params
    params.require(:person).permit(:title, :name, :lastname)
  end
end
