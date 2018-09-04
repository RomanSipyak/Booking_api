class Book < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :start_booking, :end_booking, presence: true
  validate :start_gt_current_time, :start_lt_end


=begin
  include ItemSpliter
  split(:title)
=end


  def start_lt_end
    if start_booking > end_booking
      errors.add(:start_booking, 'bed: start > end')
    end
  end

  def start_gt_current_time
    if start_booking < DateTime.current
      errors.add(:start_booking, 'bed: start < current time')
    end
  end
end
