class Event < ApplicationRecord

  class << self
    def list_upload(params_events)
      begin
        ActiveRecord::Base.transaction do
          self.delete_all
          events = []
          params_events.each do |event|
            self.create(event.permit(:id, :organizer, :title, :body, :pub_date, :image))
          end
        end
        true
      rescue
        false
      end
    end
  end

  def update_or_create(event_attributes)
    if self.new_record?
      self.attributes = event_attributes
      self.save
    else
      self.update_attributes(event_attributes)
    end
  end

end
