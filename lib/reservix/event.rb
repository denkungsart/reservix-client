module Reservix
  class Event < OpenStruct
    include Referenceable

    def starts_at
      DateTime.parse("#{startdate} #{starttime}")
    end

    def ends_at
      DateTime.parse("#{enddate} #{endtime}") if enddate
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
  end
end
