class Goal < ApplicationRecord
  validates_presence_of :description, :amount, :target_date
  validates_numericality_of :amount, greater_than: 0.0

  validate :target_date_cannot_be_in_the_past

  def target_date_cannot_be_in_the_past
    errors.add(:target_date, "can't be in the past") if target_date.present? && target_date.past?
  end

  belongs_to :user
end
