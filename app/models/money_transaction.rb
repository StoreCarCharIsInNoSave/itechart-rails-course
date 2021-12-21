# frozen_string_literal: true

class MoneyTransaction < ApplicationRecord
  belongs_to :person_category
  belongs_to :note, optional: true
  before_destroy :destroy_note
  validates :amount_value, presence: true, numericality: { greater_than: 0 }
  def destroy_note
    note = Note.find_by(id: note_id)
    note.destroy if note.present?
  end
end
