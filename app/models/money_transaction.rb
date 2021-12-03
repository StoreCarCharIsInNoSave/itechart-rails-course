class MoneyTransaction < ApplicationRecord
  belongs_to :person_category
  belongs_to :note, optional: true
  before_destroy :destroy_note

  def destroy_note
    note = Note.find_by(id: self.note_id)
    note.destroy if note.present?
  end

end
