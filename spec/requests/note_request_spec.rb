require 'rails_helper'

RSpec.describe "Notes", type: :request do
  let(:user) { User.create(email: 'someemail@gmail.com', password: 'somepassword') }
  let(:person) { Person.create(title:'fsdfsd', name:'fsdfsdf',lastname:'fsdfsdfsd', user: user) }
  let(:category) { Category.new(title: 'category', debit:false) }
  before do
    sign_in user
    category.people << person
    category.save
  end
  it 'should show notes on info page' do
    n = Note.create(body: 'sometext', color: '#000000')
    pc = category.person_categories.first
    mt = MoneyTransaction.create(amount_value:100, note: n, important:true, person_category: pc)
    get category_info_path(mt.person_category.category)
    expect(response.body).to include('Note')
  end
  it 'should get edit page of note' do
    n = Note.create(body: 'sometext', color: '#000000')
    pc = category.person_categories.first
    MoneyTransaction.create(amount_value:100, note: n, important:true, person_category: pc)
    get edit_note_path(n)
    expect(response.body).to include('Update note')
  end
  it 'should not show note on info page for another user ' do
    n = Note.create(body: 'sometext', color: '#000000')
    pc = category.person_categories.first
    mt = MoneyTransaction.create(amount_value:100, note: n, important:true, person_category: pc)
    sign_out user
    sign_in User.create(email: 'fsfsdffsf@fsdf.sdf, password: fsdfsdf')
    get category_info_path(mt.person_category.category)
    expect(response.body).to include('example')
  end

  it 'should not get edit page for another user' do
    n = Note.create(body: 'sometext', color: '#000000')
    pc = category.person_categories.first
    MoneyTransaction.create(amount_value:100, note: n, important:true, person_category: pc)
    sign_out user
    sign_in User.create(email: 'fsfsdffsf@fsdf.sdf, password: fsdfsdf')
    get edit_note_path(n)
    expect(response.body).to include('example')
  end
  
end
