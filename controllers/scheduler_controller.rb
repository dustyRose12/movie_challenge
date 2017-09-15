require_relative '../config/ruby_manifest.rb'


class SchedulerController 
  attr_reader :load_view, :runner_view, :movie_loader, :today
  attr_accessor :finished, :movie_choice

  def initialize
    @load_view = LoadView.new
    @runner_view = RunnerView.new
    @movie_loader = MovieLoader.new
    @today = Time.now
    @finished = false
  end

  def run_program #This is the flow of your program, call other classes and methods to complete
    runner_view.reset_screen!
    load_view.ask_to_reload(today)
    reload_input = gets.chomp

    if reload_input == 'yes'
      movie_loader.compile_todays_list
      load_view.finished
    end

    until finished
      movie_list = File.read('movie_list.json')

      movies_array = JSON.parse(movie_list)

      # movies_hash.each do |movie|
      #   p movie["time"].split(' ')
      # end

      # movies_array.each do |movie|
      #   p movie["title"]
      # end

      runner_view.ask_if_user_is_finished
      user_choice = gets.chomp

      movie_titles =[]
      movie_times = []
      movie_ratings = []

      movies_array.each do |movie|
        movie_titles << movie["title"]
        movie_times << movie["time"].split(" ")
        movie_ratings << movie["rating"].split(" ").join(" ")
      end

      if user_choice == 'end'
        exit_program 
      elsif user_choice == 'all'
        movie_titles.each do |title|
          p title
        end
      elsif user_choice
        movie_choice = Movie.new(
                                                  title: user_choice, 
                                                  time: movie_times[movie_titles.index(user_choice)],
                                                  rating: movie_ratings[movie_titles.index(user_choice)]
                                                  ) 
        movie_choice.movie_schedule
      end

    end    
  end

  def exit_program
    self.finished = true
    runner_view.good_bye_message
  end
end
