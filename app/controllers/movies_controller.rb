# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController

  def index
    @all_ratings = Movie.ratings
    sort_order = params[:sort_by]
    if sort_order.blank? == true
      sort_order = session[:sort_by]
    else
      session[:sort_by] = sort_order
    end
    @prev_ratings = session[:ratings]
    @ratings = params[:ratings]
    if (@prev_ratings != @ratings)
      session[:ratings] = @ratings
    end
    if @ratings.blank? == false
        @movies = Movie.find_all_by_rating(@ratings.keys, :order =>sort_order)
        
    else 
      @movies = Movie.all({:order=>sort_order})
    end
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # Look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
