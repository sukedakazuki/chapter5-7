class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def show
    @book = Book.find(params[:id])
    @new = Book.new
    @comment = Comment.new
  end

  def index
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id, :star)
  end
  
  def is_matching_login_user
    @user = Book.find(params[:id])
    unless @user.user.id == current_user.id
      redirect_to books_path
    end
  end
end
