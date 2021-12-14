require 'rails_helper'

RSpec.describe Category, type: :model do

  let(:user) { User.create(email: 'someemail@gmail.com', password: 'somepassword') }


  it 'should be automatically created with new person' do
    person = Person.create(title:'fsdfsd', lastname:'fsdfsd',name: 'some name', user: user)
    expect(person.categories.any?).to eq(true)
  end
  it 'should not create category without person' do
    c = Category.new(title: 'some', debit:false)
    expect(c.save).to eq(false)
  end

  it 'should not create person with empty title' do
    c = Category.new(title: '', debit:false)
    c.people << user.people.first
    expect(c.save).to eq(false)
  end
  it 'should create person without debit field' do
    c = Category.new(title: 'sdf')
    c.people << user.people.first
    expect(c.save).to eq(true)
  end

  it 'should not create person without title length less then 3' do
    c = Category.new(title: 'df', debit:false)
    c.people << user.people.first
    expect(c.save).to eq(false)
  end

  it 'should create person without title length more then 3' do
    c = Category.new(title: 'dfff', debit:false)
    c.people << user.people.first
    expect(c.save).to eq(true)
  end

  it 'should not create category with title what consisting only of space characters' do
    c = Category.new(title: '             ', debit:false)
    c.people << user.people.first
    expect(c.save).to eq(false)
  end

  it 'should find user throught category ' do
    c = Category.new(title: 'dfff', debit:false)
    c.people << user.people.first
    expect(c.people.first.user != nil).to eq(true)
  end
end
