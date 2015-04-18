class Match < ActiveRecord::Base
  scope :open, -> { joins('LEFT JOIN entries ON entries.match_id = matches.id').group('matches.id').having('count(matches.id) < matches.max_entries')}
  scope :tomorrow, -> { where(start_at: DateTime.now.change(hour: 9, min: 30) + 1.day) }

  has_many :entries

  monetize :wager_cents, allow_nil: true

  before_validation :set_dates
  validates :start_at, :end_at, :max_entries, :duration, :wager_cents, presence: true
  validate :entries_below_max

  def started?
    Time.now > start_at
  end

  private

  def set_dates
    if duration
      self.start_at ||= 1.business_day.after(DateTime.now.change(hour: 9, min: 30))
      self.end_at = duration.business_days.after(start_at)
    end
  end

  def entries_below_max
    if max_entries && entries.length > max_entries
      errors.add :entries, 'Too many entries'
    end
  end
end
