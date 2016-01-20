class YouTube
  attr_accessor :movies

  def initialize(movies)
    @movies = movies
  end

  def find_movie(id)
    movies.detect { |movie| movie.id == id }
  end

  def display_movies(ids)
    ids.map { |id| find_movie(id) }
  end
end

class Movie
  attr_reader :id, :title, :description, :url, :date, :likes, :dislikes, :views

  def initialize(id:, title:, description:, url:, date:, likes:, dislikes:, views:)
    @id = id
    @title = title
    @description = description
    @url = url
    @date = date
    @likes = likes
    @dislikes = dislikes
    @views = views
  end

  def to_s
    "#{title}\t#{views}\t#{date}\t#{likes}\t#{dislikes}\t#{description}"
  end
end

movie_1 = Movie.new(id: 1,
                    title: 'Adele - Hello',
                    description: "'Hello' is taken from the new album, 25, out November 20",
                    url: 'https://www.youtube.com/watch?v=YQHsXMglC9A',
                    date: '22.10.2015',
                    likes: 7815648,
                    dislikes: 304219,
                    views: 1003554438)
movie_2 = Movie.new(id: 2,
                    title: 'Taylor Swift - Bad Blood ft. Kendrick Lamar',
                    description: "Check out Taylor’s new video 'Bad Blood!'",
                    url: 'https://www.youtube.com/watch?v=QcIy9NiNbmo',
                    date: '17.05.2015',
                    likes: 3819607,
                    dislikes: 332972,
                    views: 713438460)
movie_3 = Movie.new(id: 3,
                    title: 'This is Poland | EHF EURO 2016',
                    description: 'Players from host nation Poland share their feelings ahead of the biggest tournament in their lives.',
                    url: 'https://www.youtube.com/watch?v=gnf5j1YEh1Q',
                    date: '15.01.2016',
                    likes: 68,
                    dislikes: 1,
                    views: 14368)
movie_4 = Movie.new(id: 4,
                    title: 'NHL Tonight: Goals of the Week',
                    description: 'Watch the best goals of the week around the NHL.',
                    url: 'https://www.youtube.com/watch?v=_ONeCGEC_Ec',
                    date: '03.01.2016',
                    likes: 203,
                    dislikes: 4,
                    views: 23420)

youtube = YouTube.new([movie_1, movie_2, movie_3, movie_4])
puts youtube.display_movies([1, 3])
