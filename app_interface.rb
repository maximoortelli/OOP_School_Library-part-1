require_relative 'app'

class AppInterface
  ACTIONS = {
    1 => :list_books,
    2 => :list_people,
    3 => :create_person,
    4 => :create_book,
    5 => :create_rental,
    6 => :list_rentals_for_person,
    7 => :exit_app
  }.freeze

  def initialize(app)
    @app = app
  end

  def create_person_option
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    person_type = gets.chomp
    @app.create_person(person_type)
  end

  def run
    loop do
      option = display_menu
      handle_option(option)
    end
  end

  def display_menu
    puts "\nPlease choose an option:"
    ACTIONS.each { |key, value| puts "#{key} - #{value.to_s.tr('_', ' ')}" }
    print 'Option: '
    gets.chomp.to_i
  end

  def handle_option(option)
    action = ACTIONS[option]
    if action
      case action
      when :create_person
        create_person_option
      else
        @app.send(action)
      end
    else
      puts 'Invalid option. Please try again.'
    end
  end
end
