class Amazon
  attr_accessor :books

  def initialize(books)
    @books = books
  end

  def find_book(id)
    books.detect { |movie| movie.id == id }
  end

  def display_books(ids)
    ids.map { |id| find_book(id) }
  end
end

class Book
  attr_accessor :id, :author, :title, :price, :publisher, :cover

  def initialize(id:, author:, title:, price:, publisher:, cover:)
    @id = id
    @author = author
    @title = title
    @price = price
    @publisher = publisher
    @cover = cover
  end

  def to_s
    "#{author}\t#{title}\t#{price}\t#{publisher}\t#{cover}"
  end
end

book_1 = Book.new(id: 1,
                  author: 'Paula Hawkins',
                  title: 'The Girl on the Train',
                  price: 13.47,
                  publisher: 'Riverhead Books',
                  cover: 'hardcover')
book_2 = Book.new(id: 2,
                  author: 'Johanna Basford',
                  title: 'Lost Ocean: An Inky Adventure and Coloring Book',
                  price: 10.17,
                  publisher: 'Penguin Books',
                  cover: 'paperback')
book_3 = Book.new(id: 3,
                  author: 'Toni Hammersley',
                  title: 'The Complete Book of Home Organization: 200+ Tips and Projects',
                  price: 25.57,
                  publisher: 'Weldon Owen',
                  cover: 'paperback')

amazon = Amazon.new([book_1, book_2, book_3])
puts amazon.display_books([1, 2, 3])
