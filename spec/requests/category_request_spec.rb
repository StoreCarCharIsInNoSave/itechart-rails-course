require 'rails_helper'

RSpec.describe "Categories", type: :request do

  let(:user) { User.create(email: 'someemail@gmail.com', password: 'somepassword') }
  before do
    sign_in user
  end

  it 'should get all user categories with existing user' do
    get categories_path
    expect(response.body).to include('Your categories')
  end

  it 'should not get all user categories without user' do
    sign_out user
    get categories_path
    expect(response).to have_http_status(302)
  end

  it 'should get edit page of category' do
    category = Category.new(title: 'category', debit:false)
    category.people << user.people.first
    category.save
    get '/categories/'+category.id.to_s+'/edit'
    expect(response.body).to include('Edit category')
  end

  it 'should not get edit page of category with own of other user' do
    sign_out user
    other_user = User.create(email: 'sgsdf@gmail.com', password: 'fsdffsdfsd')
    other_category = other_user.people.first.categories.first
    sign_in user
    get '/categories/'+other_category.id.to_s+'/edit'
    expect(response.body).not_to include('Edit category')
  end
  it 'should get new category page is user signed in' do
    get categories_new_path
    expect(response.body).to include('Create category')
  end
  it 'should not get new category page is user not signed in' do
    sign_out user
    get categories_new_path
    expect(response).to have_http_status(302)
  end


end
