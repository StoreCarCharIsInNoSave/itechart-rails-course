require 'rails_helper'

RSpec.describe "MoneyTransactions", type: :request do
  let(:user) { User.create(email: 'someemail@gmail.com', password: 'somepassword') }
  let(:person) { Person.create(title:'fsdfsd', name:'fsdfsdf',lastname:'fsdfsdfsd', user: user) }
  let(:category) { Category.create(title: 'category', debit:false) }
  before do
    sign_in user
    category.people<< person
    category.save
  end
  it 'should get all money transaction with current and existing user' do
    get transactions_path
    expect(response.body).to include('Your transaction')
  end
  it 'should not get all money transaction without user' do
    sign_out user
    get transactions_path
    expect(response.body).to include('example')
  end
  it 'should get new money transaction form with current and existing user' do
    get transactions_new_path
    expect(response.body).to include('Create transaction')
  end
  it 'should not get new money transaction form without user' do
    sign_out user
    get transactions_new_path
    expect(response.body).to include('example')
  end
  it 'should get edit money transaction form with current and existing user' do
    mt = MoneyTransaction.create(amount_value: 100, person_category: user.people.first.person_categories.first )
    get edit_transaction_path(mt)
    expect(response.body).to include('Update transaction')
  end
  it 'should not get edit money transaction form of another user' do
    mt = MoneyTransaction.create(amount_value: 100, person_category: user.people.first.person_categories.first )
    sign_out user
    another_user = User.create(email: 'fsfsd@fsd.sfd', password: 'fsdfsdf')
    sign_in another_user
    get edit_transaction_path(mt)
    expect(response.body).to include('example')
  end
  it 'should show transaction of category after creating new transaction' do
    mt = MoneyTransaction.create(amount_value: 100, person_category: user.people.first.person_categories.first )
    get category_info_path(mt.person_category.category)
    expect(response.body).to include('Edit')
  end

end
