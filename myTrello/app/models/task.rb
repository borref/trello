class Task < ActiveRecord::Base
  belongs_to :user

  validates :title, :duration, :start_date, :due_date, presence: true
  validate :due_date_has_to_be_greater_than_start_date, :start_date_has_to_be_greater_than_today

  def due_date_has_to_be_greater_than_start_date
    if due_date < start_date or due_date < Date.today
      errors.add(:due_date, "can't be lower than start date or today")
    end
  end

  def start_date_has_to_be_greater_than_today
    if start_date < Date.today
      errors.add(:start_date, "can't be lower than today")
    end
  end
end
