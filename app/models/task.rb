class Task < ApplicationRecord
  validates :subject, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
end