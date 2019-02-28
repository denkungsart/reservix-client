RSpec.describe Reservix::Client do
  let(:client) { described_class.new }

  before { Reservix.api_key = 'xxx' }

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
