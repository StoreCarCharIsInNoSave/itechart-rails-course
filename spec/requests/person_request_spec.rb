require 'rails_helper'

RSpec.describe "People", type: :request do


  before(:each) do
    @user = User.create(email: "fsdfs@fsdf.fsd", password:'sdfsfsfsd')
    sign_in @user
  end

  it "should get all person of user" do
    get person_index_path
    expect(response.body).to include('Your persons')
  end


  it 'should get main page' do
    get root_path
    expect(response.body).to include('Financial supervision')
  end

  it "should get new person with existing user" do
    get new_person_path
    expect(response.body).to include('Create person')
  end


  # it "should not get all person of user without user" do
  #   sign_out @user
  #   get person_index_path
  #   expect(response.body).to include('You must be signed in to do that')
  # end






end
