class Date
    class << self
      alias_method :original_today, :today
  
      def today
        Time.zone.today.to_date
      end
    end
  end
  