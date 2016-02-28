class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if params[:sort_by] == "release_date" and params[:id] == "release_date_header"
      @movies = Movie.all.order(:release_date)
      @var = "hilite"
    elsif params[:sort_by] == "title" and params[:id] == "title_header"
      @movies = Movie.all.order(:title)
      @var = "hilite"
    else
      @movies = Movie.all
    end
  end

  def new
    # default: render 'new  ' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end
  
  def updateMovie
    
  end
  
  def updateMovies
    @input = params[:movie]
    if (@movie = Movie.find_by_title(@input[:name]))
      if (@input[:title] == "")
        @input[:title] = @movie[:title]
      end
      if (@input[:rating] == "")
        @input[:rating] = @movie[:rating]
      end
      if (@input[:release_date] == "")
        @input[:release_date] = @movie[:release_date]
      end
      @movie.update_attributes!(movie_params)
      flash[:notice] = "'#{@movie.title}'' has been successfully updated."
        redirect_to movies_path
    else
      flash[:notice] = "ERROR: Cannot find #{@input[:name]}."
      redirect_to updateMovie_movies_path
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def delRating
    
  end
  
  def delRatings
    @input = params[:movie]
    Movie.where(rating: @input[:rating]).each do |i|
      i.destroy
    end
    flash[:notice] = "Movies with #{@input[:rating]} rating have been successfully deleted."
    redirect_to movies_path
  end
  
  def delTitle
    
  end
  
  def delTitles
    @input = params[:movie]
    if (@movie = Movie.find_by_title(@input[:title]))
      @movie.destroy
      flash[:notice] = "#{@movie.title} has been successfully deleted."
      redirect_to movies_path
    else
      flash[:notice] = "ERROR: Cannot find #{@input[:title]}."
      redirect_to delTitle_movies_path
    end
  end

end
