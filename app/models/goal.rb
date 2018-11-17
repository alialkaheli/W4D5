class Goal < ApplicationRecord
  validates :user_id, :title, presence: true 
  
  
  belongs_to :user
end
