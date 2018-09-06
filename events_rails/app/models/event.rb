class Event < ApplicationRecord

  def update_or_create(event_attributes)
    if self.new_record?
      self.attributes = event_attributes
      self.save
    else
      self.update_attributes(event_attributes)
    end
  end

end
