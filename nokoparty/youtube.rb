require 'httparty'
require 'nokogiri'

class YoutubeMovie
  attr_reader :doc

  def initialize(address)
    response = HTTParty.get(address)
    @doc = Nokogiri::HTML(response.body)
  end

  def to_s
    [
        "   TITLE: #{title}",
        "UPLOADER: #{uploader}",
        "    DATE: #{date}",
        "   VIEWS: #{views}",
        "   LIKES: #{likes}",
        "DISLIKES: #{dislikes}"
    ].join("\n")
  end

  def for_table
    "#{title[0..30]}... | #{uploader.rjust(25, ' ')} | #{date} | #{views.rjust(10, ' ')} | #{likes.rjust(10, ' ')} | #{dislikes.rjust(10, ' ')}"
  end

  private

  def title
    content_for('#eow-title')
  end

  def likes
    content_for('.like-button-renderer-like-button .yt-uix-button-content')
  end

  def dislikes
    content_for('.like-button-renderer-dislike-button .yt-uix-button-content')
  end

  def views
    content_for('.watch-view-count')
  end

  def uploader
    content_for('.yt-user-info a')
  end

  def date
    content_for('.watch-time-text').split.last
  end

  def content_for(css)
    doc.css(css).first.content.strip
  end
end

class YouTube
  attr_accessor :movies

  def to_s
    [table_header, movies.map(&:for_table).join("\n"), table_footer].join("\n")
  end

  def table_header
    ['-'*114,
     '                             TITLE |                  UPLOADER |       DATE |      VIEWS |      LIKES |   DISLIKES',
     '-'*114].join("\n")
  end

  def table_footer
    '-'*114
  end

  def initialize(movies)
    @movies = movies
  end
end

movie_1 = YoutubeMovie.new('https://www.youtube.com/watch?v=ro_wAOPPaUk')
movie_2 = YoutubeMovie.new('https://www.youtube.com/watch?v=xnv__ogkt0M')
movie_3 = YoutubeMovie.new('https://www.youtube.com/watch?v=hZUPQ1dQ3B8')
movie_4 = YoutubeMovie.new('https://www.youtube.com/watch?v=eJhGQi1ucvo')
movie_5 = YoutubeMovie.new('https://www.youtube.com/watch?v=OcAlu4S-BvI')

puts YouTube.new([movie_1, movie_2, movie_3, movie_4, movie_5])
