class Task < ApplicationRecord
  validates :subject, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true

  before_save :set_default_completed

  private

  def set_default_completed
    self.completed = false if self.completed.nil?
  end
end