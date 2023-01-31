class BooksController < ApplicationController
 before_action :correct_user,   only: [:edit, :update, :destroy]
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end
  
  def show
    @books = Book.all
    @book_new  = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end
  
  def create
    @book_new = Book.new
    @books = Book.all
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = @user.id  
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      render :index
    end
  end
  
  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "Book was successfully updated."
    redirect_to book_path(@book)
    else
     render :edit
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
     redirect_to books_path
    end
  end

  private
  
    def correct_user 
      @book = Book.find(params[:id])
      redirect_to(books_path) unless current_user?(@book.user)
    end

    def current_user?(user)
      user == current_user
    end
  
    def book_params
      params.require(:book).permit(:title, :body, :user_id)
    end
    
    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end
end