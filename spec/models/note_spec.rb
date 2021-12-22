require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:user) { User.create(email: 'someemail@gmail.com', password: 'somepassword') }
  let(:person) { Person.create(title:'fsdfsd', name:'fsdfsdf',lastname:'fsdfsdfsd', user: user) }
  let(:category) { Category.create(title: 'category', debit:false) }
  before do
    category.people << person
    category.save
  end

  it 'should create note' do
    n = Note.create(body: 'sometext', color: '#000000')
    expect(n.save).to eq(true)
  end
  it 'should not create not with empty body' do
    n = Note.create(body: '', color: '#000000')
    expect(n.save).to eq(false)
  end
  it 'should not create not with empty color' do
    n = Note.create(body: 'sometext', color: '')
    expect(n.save).to eq(false)
  end
  it 'should not create note with body consisting only of whitespace' do
    n = Note.create(body: '   ', color: '#000000')
    expect(n.save).to eq(false)
  end
  it 'should not create note with color consisting only of whitespace' do
    n = Note.create(body: 'sometext', color: '   ')
    expect(n.save).to eq(false)
  end
end
