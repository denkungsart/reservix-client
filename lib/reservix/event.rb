require 'time'
require 'tzinfo'

module Reservix
  class Event < OpenStruct
    include Referenceable

    def starts_at
      time_zone.local_to_utc(Time.parse("#{startdate} #{starttime}"))
    end

    def ends_at
      time_zone.local_to_utc(Time.parse("#{enddate} #{endtime}")) if enddate
    end

    def event_group
      EventGroup.new(fetch_reference('eventgroup'))
    end

    def genre
      Genre.new(fetch_reference('genre'))
    end

    def venue
      Venue.new(fetch_reference('venue'))
    end

    private

    def time_zone
      @time_zone ||= TZInfo::Timezone.get('Europe/Berlin')
    end
  end
end
