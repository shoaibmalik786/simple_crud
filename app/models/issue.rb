class Issue < ApplicationRecord
  STATUS = { active: 0, on_hold: 1, resolved: 2, closed: 3 }
  belongs_to :project
  has_many :comments, dependent: :destroy

  validates :title, presence: true

  enum status: STATUS
end
