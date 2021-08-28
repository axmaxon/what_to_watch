require 'movie'

RSpec.describe Movie do
  let(:film) { Movie.new('Терминатор', 'Кэмерон', '1984') }

  describe '.from_file' do
    it 'creates an instance using data from a file' do
      file_path = "#{__dir__}/fixtures/01.txt"

      expect(Movie.from_file(file_path)).to be_instance_of(Movie)
    end
  end

  describe '.new' do
    it 'asigns the arguments' do
      expect(film.title).to eq 'Терминатор'
      expect(film.director).to eq 'Кэмерон'
      expect(film.year).to eq '1984'
    end
  end

  describe '#to_s' do
    it 'returns all info as string' do
      expect(film.to_s).to eq('Кэмерон - Терминатор (1984)')
    end
  end
end
