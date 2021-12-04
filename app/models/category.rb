# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :person_categories
  has_many :people, through: :person_categories
end
