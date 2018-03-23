class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    id = params[:id]
    @movie = Movie.find(id)
  end

  def new
    @movie = Movie.new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    id = params[:id]
    @movie = Movie.find(id)
  end

  def update
    id = params[:id]
    @movie = Movie.find(id)
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."

    respond_to do |client_wants|
      client_wants.html { redirect_to movie_path(@movie) }
      client_wants.xml { render xml: @movie.to_xml }
    end


  end

  def destroy
    id = params[:id]
    @movie = Movie.find(id)
    @movie.destroy
    flash[:notice] = "Movie #{@movie.title} deleted."

    redirect_to movies_path
  end

  private
    def movie_params
      params.require(:movie).permit(:title, :rating, :release_date, :description)
    end

end
