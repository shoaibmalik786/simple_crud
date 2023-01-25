class Project < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  has_many :issues, dependent: :destroy
end
