class Badge < ApplicationRecord
  has_many :user_badges
  has_many :users, through: :user_badges, dependent: :destroy

  validates :name, presence: true
  validates :img, presence: true
  validates :conditions, presence: true

end
