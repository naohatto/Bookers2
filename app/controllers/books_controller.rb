class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:create] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.page(params[:page])
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.page(params[:page])
    @user = current_user
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to '/books'
    end
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:updateb] = 'You have updated book successfully.'
      redirect_to book_path(book.id)
    else
      @book = Book.find(params[:id])
      flash[:errorudb] = 'update error'
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
