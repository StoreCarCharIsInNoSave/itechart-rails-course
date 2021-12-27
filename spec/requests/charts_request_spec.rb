require 'rails_helper'

RSpec.describe "Charts", type: :request do
  let(:user) { User.create(email: 'someemail@gmail.com', password: 'somepassword') }
  before do
    sign_in user
  end
  it 'should get access to chart page' do
    get information_page_path
    expect(response.body).to include('Chart information')
  end
  it 'should get access to chart page without user' do
    sign_out user
    get information_page_path
    expect(response.body).to include('example')
  end
end
