class Task < ApplicationRecord
  belongs_to :user
  has_one :reminder
  validates_presence_of :title, :user_id
end
