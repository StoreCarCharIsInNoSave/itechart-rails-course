require 'rails_helper'

RSpec.describe MoneyTransaction, type: :model do

  let(:user) { User.create(email: 'someemail@gmail.com', password: 'somepassword') }
  let(:person) { Person.create(title:'fsdfsd', name:'fsdfsdf',lastname:'fsdfsdfsd', user: user) }
  let(:category) { Category.create(title: 'category', debit:false) }
  before do
    category.people<< person
    category.save
  end
  it 'should create new MoneyTransaction' do
    mt = MoneyTransaction.create(amount_value: 100, note_id: nil, important: false, person_category: PersonCategory.first)
    mt.save
    expect(mt.save).to eq(true)
  end
  it 'should not create new MoneyTransaction without PersonCategory' do
    mt = MoneyTransaction.create(amount_value: 100, note_id: nil, important: false)
    mt.save
    expect(mt.save).to eq(false)
  end
  it 'should not create new MoneyTransaction without amount_value' do
    mt = MoneyTransaction.create( note_id: nil, important: false, person_category: PersonCategory.first)
    mt.save
    expect(mt.save).to eq(false)
  end
  it 'should not create new MoneyTransaction with incorrect amount_value' do
    mt = MoneyTransaction.create(amount_value: -1, note_id: nil, important: false, person_category: PersonCategory.first)
    mt.save
    expect(mt.save).to eq(false)
  end
end
