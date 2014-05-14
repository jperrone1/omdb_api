class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  respond_to :json

  def index
    @movies = Movie.all
    respond_with(@movies)
    # respond_to do |format|
    #   format.html
    #   format.xml { render xml: @movies.to_xml }
    #   format.json { render json: @movies }
    # end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render json: @movie, status: :created, location: @movie }
      else
        format.html { render 'new' }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update
  #   if @movie.update(movie_params)
      
  #     format.json { render json: @movie, status: :updated, location: @movie }
  #     redirect_to @movie
  #   else
  #     render :edit
  #   end
  # end

  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update
  #   if @movie.update(movie_params)
  #     redirect_to @movie
  #   else
  #     render :edit
  #   end
  # end

  def destroy
    @movie.destroy
    redirect_to movies_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :year, :director, :rated, :poster)
    end
end
