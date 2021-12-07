require 'rails_helper'

RSpec.describe Person, type: :model do

  User.create(email: 'someemail@gmail.com', password: 'somepassword');

  it 'should not create new person without user' do
    person = Person.new(title: 'persontitle', name: 'personname', lastname: 'personlastnane')
    expect(person.save).to eq(false)
  end

  it 'should create new person with user' do
    person = Person.new(title: 'persontitle', name: 'personname', lastname: 'personlastnane')
    person.user = User.first
    expect(person.save).to eq(true)
  end

  it 'should not create person with empty title' do
    person = Person.new(title: '', name: 'personname', lastname: 'personlastnane')
    person.user = User.first
    expect(person.save).to eq(false)
  end

  it 'should not create person with empty name' do
    person = Person.new(title: 'sdfsdf', name: '', lastname: 'personlastnane')
    person.user = User.first
    expect(person.save).to eq(false)
  end

  it 'should not create person with empty lastname' do
    person = Person.new(title: 'fdfsdf', name: 'personname', lastname: '')
    person.user = User.first
    expect(person.save).to eq(false)
  end

  it 'should not create person with title length less then 3' do
    person = Person.new(title: 'qw', name: 'personname', lastname: 'personlastnane')
    person.user = User.first
    expect(person.save).to eq(false)
  end

  it 'should not create person with name length less then 3' do
    person = Person.new(title: 'qwfsdf', name: 'qw', lastname: 'personlastnane')
    person.user = User.first
    expect(person.save).to eq(false)
  end

  it 'should not create person with name length lastname then 3' do
    person = Person.new(title: 'qwfsdf', name: 'qwfsdf', lastname: 'fd')
    person.user = User.first
    expect(person.save).to eq(false)
  end

  it 'should not create person with title what consisting only of space characters' do
    person = Person.new(title: '        ', name: 'personname', lastname: 'personlastnane')
    person.user = User.first
    expect(person.save).to eq(false)
  end

  it 'should not create person with name what consisting only of space characters' do
    person = Person.new(title: 'fsdfsdfsdfsd', name: '              ', lastname: 'personlastnane')
    person.user = User.first
    expect(person.save).to eq(false)
  end

  it 'should not create person with lastname what consisting only of space characters' do
    person = Person.new(title: 'fsdfasfsd', name: 'personname', lastname: '       ')
    person.user = User.first
    expect(person.save).to eq(false)
  end
end
