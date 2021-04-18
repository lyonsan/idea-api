class Category < ApplicationRecord
  has_many :ideas
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
