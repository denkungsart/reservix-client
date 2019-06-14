RSpec.describe Reservix::Client do
  let(:client) { described_class.new }

  before { Reservix.api_key = 'xxx' }

  describe '#event' do
    it 'fetches event data' do
      VCR.use_cassette('event') do
        response = client.event(1_408_149)
        event = response.first

        expect(response.count).to eq(1)
        expect(event.name).to eq('Lieder der Frühe')
      end
    end
  end

  describe '#events' do
    it 'fetches events' do
      VCR.use_cassette('events') do
        response = client.events
        expect(response.count).to eq(12)

        event = response.first
        expect(event.name).to eq('Into The Woods - Really Into The Woods')
        expect(event.event_group.name).to eq('Into The Woods')
        expect(event.genre.name).to eq('Musical')
        expect(event.venue.name)
          .to eq('Alte Mälzerei  Kultur und Tagungszentrum')
      end
    end

    context 'with query params' do
      let(:params) do
        {
          startdate: Date.parse('2019/03/11'),
          genreid: 19,
          sidx: 'date',
          sord: 'asc'
        }
      end

      it 'fetches events for a week' do
        VCR.use_cassette('events_with_query_params') do
          response = client.events(params)
          expect(response.count).to eq(138)

          first_event = response.first
          last_event = response.last

          expect(first_event.starts_at.zone).to eq('UTC')

          expect(first_event.name)
            .to eq('Moskauer Kathedralchor')
          expect(last_event.name)
            .to eq('Ural Kosaken Chor - „Erinnerungen an Ivan Rebroff “')
          expect(first_event.startdate).to eq('2019-03-14')
          expect(last_event.startdate).to eq('2020-06-13')
        end
      end
    end
  end

  describe '#event_groups' do
    it 'fetches event groups' do
      VCR.use_cassette('event_groups') do
        response = client.event_groups
        expect(response.count).to eq(3)

        event_group = response.first
        expect(event_group.name).to eq('Klassikkonzert')
      end
    end
  end

  describe '#genres' do
    it 'fetches genres' do
      VCR.use_cassette('genres') do
        response = client.genres
        expect(response.count).to eq(200)

        genre = response.first
        expect(genre.name).to eq('Bühne')
      end
    end
  end
end
