module CategoryHelper

  def can_be_deleted?(category)
    category.people.each do |person|
      return false if person.categories.count == 1
    end
    return true
  end

end
