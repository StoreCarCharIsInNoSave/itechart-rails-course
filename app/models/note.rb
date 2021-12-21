# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :money_transaction, optional: true
  validates :body, presence: true, length: { maximum: 50 }
  validates :color, presence: true
end
