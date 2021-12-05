# frozen_string_literal: true

class User < ApplicationRecord
  has_many :people
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  after_create :create_person


  def create_person
    Person.create(user_id: self.id, title: 'I\'am', name: 'change this field', lastname: 'change this field')
  end
end
