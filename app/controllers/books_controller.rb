class BooksController < ApplicationController
  before_action :authenticate_user!
  #before_action :correct_user, only: [:edit, :update]
  
  
  def new
    @book = Book.new
  end



   def create
      @books = Book.all
      @book = Book.new(book_params)
      @book.user_id=current_user.id
      @user = current_user
      if @book.save
        flash[:notice] = "successfully"
          redirect_to book_path(@book)
      else
          flash[:notice] = "error"
          render :index
      end
   end




  def index
    @books = Book.all
    @book = Book.new
    @user = User.find_by_id(current_user.id)
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find_by_id(current_user.id)
  end

  def edit
    @book = Book.find(params[:id])
    
    if @book.user != current_user
      redirect_to books_path
      
      
    end

    
  end

def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
          redirect_to book_path, notice: "successfully"
    else
          #redirect_to book_path, notice: "error"
          flash[:notice] = "error"
          render :edit
    end
end

def destroy
  book = Book.find(params[:id])
  book.destroy
  redirect_to "/books"
end



  private
  # ストロングパラメータ

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    if currect_user != @book.user
       redirect_to "/books"
    end
  end



end
