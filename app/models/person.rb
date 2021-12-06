# frozen_string_literal: true

class Person < ApplicationRecord
  belongs_to :user
  has_many :person_categories
  has_many :categories, through: :person_categories
  validates :title, presence: true, length: { minimum: 3, maximum: 30 }
  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :lastname, presence: true, length: { minimum: 5, maximum: 30 }
end
