class MoviesController < ApplicationController
	before_action :authenticate_user! , except: [:index, :show]
	def index
		@movies = Movie.all.order("created_at DESC") 
	end

	def show
		@movie = Movie.find(params[:id])
		@reviews = Review.where(movie_id: @movie.id).order("created_at DESC")
	end

	def new
		@movie = current_user.movies.build
	end

	def edit
		@movie = Movie.find(params[:id])
	end

	def create
		@movie = current_user.movies.build(movie_params)
		if @movie.save
	    redirect_to @movie
	  else
	    render 'new'
	  end
	end

	def search
		@movies = Movie.where("movie LIKE ? OR director LIKE ? ","%#{params[:id]}%", "%#{params[:id]}%").order("created_at DESC")
	end

	def update
		@movie = Movie.find(params[:id])
		if @movie.user_id == current_user.id
			if @movie.update(movie_params)
		    redirect_to @movie
		  else
		    render 'edit'
		  end
		else 
			flash[:error] = "You are not authorized to edit this movie"
			redirect_to @movie
		end
	end

	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy
		redirect_to movies_path
	end

	private
		def movie_params
			params.require(:movie).permit(:movie, :description, :director, :cast, :duration, :year, :image)
		end

end
