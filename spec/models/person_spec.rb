# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person, type: :model do



  let(:user) { User.new(email: 'someemail@gmail.com', password: 'somepassword') }

  it 'should not create new person without user' do
    person = Person.new(title: 'persontitle', name: 'personname', lastname: 'personlastnane')
    expect(person.save).to eq(false)
  end



  it 'should create new person with user' do
    person = Person.new(title: 'persontitle', name: 'personname', lastname: 'personlastnane')
    person.user = user
    expect(person.save).to eq(true)
  end


  it 'should create two new persons with user' do
    person = Person.new(title: 'persontitle', name: 'personname', lastname: 'personlastnane')
    person.user = user
    # 2 because when we create a new person, we saving user
    # to database and new user automatically create one more person by default and then we have 2 persons
    expect { person.save }.to change(Person, :count).by(2)
  end


  it 'should not create person with empty title' do
    person = Person.new(title: '', name: 'personname', lastname: 'personlastnane')
    person.user = user
    expect(person.save).to eq(false)
  end

  it 'should not create person with empty name' do
    person = Person.new(title: 'sdfsdf', name: '', lastname: 'personlastnane')
    person.user = user
    expect(person.save).to eq(false)
  end

  it 'should not create person with empty lastname' do
    person = Person.new(title: 'fdfsdf', name: 'personname', lastname: '')
    person.user = user
    expect(person.save).to eq(false)
  end

  it 'should not create person with title length less then 3' do
    person = Person.new(title: 'qw', name: 'personname', lastname: 'personlastnane')
    person.user = user
    expect(person.save).to eq(false)
  end

  it 'should not create person with name length less then 3' do
    person = Person.new(title: 'qwfsdf', name: 'qw', lastname: 'personlastnane')
    person.user = user
    expect(person.save).to eq(false)
  end

  it 'should not create person with name length lastname then 3' do
    person = Person.new(title: 'qwfsdf', name: 'qwfsdf', lastname: 'fd')
    person.user = user
    expect(person.save).to eq(false)
  end

  it 'should not create person with title what consisting only of space characters' do
    person = Person.new(title: '        ', name: 'personname', lastname: 'personlastnane')
    person.user = user
    expect(person.save).to eq(false)
  end

  it 'should not create person with name what consisting only of space characters' do
    person = Person.new(title: 'fsdfsdfsdfsd', name: '              ', lastname: 'personlastnane')
    person.user = user
    expect(person.save).to eq(false)
  end

  it 'should not create person with lastname what consisting only of space characters' do
    person = Person.new(title: 'fsdfasfsd', name: 'personname', lastname: '       ')
    person.user = user
    expect(person.save).to eq(false)
  end
end
