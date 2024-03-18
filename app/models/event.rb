class Event < ApplicationRecord
  has_many :runnings

  def self.circle_data(event)
    ran_distance_sum  = event.runnings.sum(:ran_distance)
    users = event.runnings.id
    [ran_distance_sum, users] 
  end
end
