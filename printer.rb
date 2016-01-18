class Printer
  attr_accessor :pages, :text

  def initialize
    @pages = []
    @text = ''
  end

  def add_page(page)
    @pages.push(page)
  end

  def set_text_to_print(text)
    @text = text
  end

  def print
    return puts('Nothing to print') if text.empty?
    while text.size > 0
      if pages.length > 0
        if text.size > 10
          @text.slice!(0..9) if @pages.first.write(@text[0..9])
        else
           if @pages.first.write(text)
             @text = ''
             puts 'Print complete!'
           end
        end
        @pages.shift
      else
        puts 'Error! Not enough paper!'
        break
      end
    end
  end

  def reset
    @text = ''
  end
end

class Page
  attr_accessor :text

  def initialize
    @text = nil
  end

  def write(text_to_write)
    if text.nil?
      @text = text_to_write
      puts "Printer prints [#{text}]"
      true
    else
      puts 'This page is not empty. Cannot print on it.'
      false
    end
  end
end

page_1 = Page.new
page_2 = Page.new
page_3 = Page.new
printer = Printer.new

puts '---------------------'
printer.set_text_to_print('I <3 basketball')
printer.add_page(page_1)
printer.print
printer.add_page(page_1)
printer.print
printer.add_page(page_2)
printer.print

puts '---------------------'
printer.set_text_to_print('I <3 ice hockey')
printer.print
printer.add_page(page_3)
printer.print
printer.reset
printer.print
