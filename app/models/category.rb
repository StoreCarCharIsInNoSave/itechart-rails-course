# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :person_categories
  has_many :people, through: :person_categories, dependent: :destroy
  validates :title, presence: true, length: { minimum: 3, maximum: 10 }



  def destroy
    self.people.each do |person|
      return false if person.categories.count == 1
    end

    super
  end
end
