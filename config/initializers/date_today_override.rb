# frozen_string_literal: true

class Date
  class << self
    alias original_today today

    def today
      Time.zone.today.to_date
    end
  end
end
