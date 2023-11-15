require_relative 'book'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
require_relative 'classroom'
require_relative 'app_interface'

class App
  attr_accessor :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
    @app_interface = AppInterface.new(self)
  end

  def run
    @app_interface.run
  end

  def create_person(person_type)
    case person_type
    when '1'
      student = create_student
      @people << student
      puts 'Student created successfully'
    when '2'
      teacher = create_teacher
      @people << teacher
      puts 'Teacher created successfully'
    else
      puts 'Invalid option'
    end
  end

  def create_student
    name = @app_interface.request_input('Name: ')
    age = @app_interface.request_input('Age: ').to_i
    classroom_name = @app_interface.request_input('Classroom: ')
    classroom = Classroom.new(classroom_name)
    parent_permission = @app_interface.request_yes_no('Has parent permission? [Y/N]: ')

    Student.new(name, age, classroom, parent_permission: parent_permission)
  end

  def create_teacher
    name = @app_interface.request_input('Name: ')
    age = @app_interface.request_input('Age: ').to_i
    specialization = @app_interface.request_input('Specialization: ')

    Teacher.new(name, age, specialization)
  end

  def create_book
    title = @app_interface.request_input('Title: ')
    author = @app_interface.request_input('Author: ')

    @books << Book.new(title, author)
    puts 'Book created successfully'
  end

  def create_rental
    book_index = @app_interface.select_from_list('Select a book', @books)
    person_index = @app_interface.select_from_list('Select a person', @people)
    date = @app_interface.request_input('Date: ')

    @rentals << Rental.new(date, @books[book_index], @people[person_index])
    puts 'Rental created successfully'
  end

  def list_rentals_for_person
    person_id = @app_interface.request_input('Enter person id: ').to_i

    rentals = @rentals.select { |rental| rental.person.id == person_id }

    if rentals.empty?
      puts 'No rentals found for the given person id.'
    else
      puts 'Rentals:'
      rentals.each do |rental|
        puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}"
      end
    end
  end

  def exit_app
    puts 'Exiting the application. Goodbye!'
    exit
  end
end
