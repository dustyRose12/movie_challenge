class Movie
  attr_reader :title, :time, :rating

  def initialize(input)
    @title = input[:title]
    @time = input[:time]
    @rating = input[:rating]
  end

  def movie_schedule
    puts @title
    puts @time
    puts @time.join(" ")
    puts "Rated " + @rating
    puts "-------------------------"
    puts "Weekday   |   Start   |    End"
    puts num_of_showings_weekdays


  end

  def num_of_showings_weekdays
    movie_minutes = @time[0].to_i * 60 + @time[2].to_i
    total_minutes = 705


  end



  def all_movies_schedule
  end
end