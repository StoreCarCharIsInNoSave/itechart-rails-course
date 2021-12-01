class Category < ApplicationRecord
  belongs_to :type
  has_many :person_categories
  has_many :people, through: :person_categories
end
