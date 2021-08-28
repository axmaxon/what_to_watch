require 'movie'
require 'movies_collection'

RSpec.describe MoviesCollection do
  let(:movie1) { Movie.new('Терминал', 'Спилберг', '2004') }
  let(:movie2) { Movie.new('Форест Гамп', 'Земекис', '1994') }
  let(:movie3) { Movie.new('Джентельмены', 'Ричи', '2020') }
  let(:movie4) { Movie.new('Карты, деньги, два ствола', 'Ричи', '1998') }
  let(:collection) { MoviesCollection.new([movie1, movie2, movie3, movie4]) }

  describe '.from_files' do
    it 'creates an instance using data from a file' do
      file_paths = ["#{__dir__}/fixtures/01.txt", "#{__dir__}/fixtures/02.txt"]

      expect(MoviesCollection.from_files(file_paths)).to be_instance_of(MoviesCollection)
      expect(MoviesCollection.from_files(file_paths).movies.sample).to be_instance_of(Movie)
      expect(MoviesCollection.from_files(file_paths).movies.first.to_s).to eq('Спилберг - Терминал (2004)')
      expect(MoviesCollection.from_files(file_paths).movies.last.to_s).to eq('Рефн - Вальгалла: Сага о викинге (2009)')
    end
  end

  describe '#directors' do
    it 'returns array of directors without repetitions' do
      expect(collection.directors).to eq(%w[Спилберг Земекис Ричи])
    end
  end

  describe '#random_movie_by_director' do
    context 'when director is exist' do
      it 'returns film of the selected director' do
        expect(collection.random_movie_by_director('Ричи')).to be_instance_of(Movie)
        expect(collection.random_movie_by_director('Ричи')).to satisfy{ |movie| [movie3, movie4].include?(movie)}
      end
    end

    context 'when director is not exist' do
      it 'does not return any movie' do
        expect(collection.random_movie_by_director('Кустурица')).to be_nil
      end
    end
  end
end
