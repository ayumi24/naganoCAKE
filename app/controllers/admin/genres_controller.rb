class Admin::GenresController < ApplicationController
  def index
    @new_genre = Genre.new
    @genres = Genre.all
  end

  def create
    @new_genre = Genre.new(genre_params)
    @new_genre.save
    redirect_to admin_genres_path
  end

  def edit

  end

  def update
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
