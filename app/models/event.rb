class Event < ApplicationRecord
  validates_presence_of :title, :zip
end
