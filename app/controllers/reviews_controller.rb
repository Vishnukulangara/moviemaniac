class ReviewsController < ApplicationController

	before_action :authenticate_user!
	before_action :set_movie
	def new
	
		@review = Review.new
	end

	def edit
		@review = Review.find(params[:id])
	end

	def create
		@review = Review.new(review_params)
		@review.user_id = current_user.id
		@review.movie_id = @movie.id
		if @review.save
			redirect_to @movie
		else 
			render 'new'
		end
	end

	def update
		@review = Review.find(params[:id])
		if @review.update(review_params)
			redirect_to @movie
		else
			render 'edit'
		end
	end

	def destroy
		@review = Review.find(params[:id])
		@review.destroy
		redirect_to @movie
	end

	private 
		def review_params
			params.require(:review).permit(:review, :rating)
		end

		def set_movie
			@movie = Movie.find(params[:movie_id])
		end

end
