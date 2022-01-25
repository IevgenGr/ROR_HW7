class AuthorsController < ApplicationController
  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      session[:author_id] = @author.id
      redirect_to root_url, notice: 'Thank you for signing up!'
    else
      render 'new'
    end
  end
end

private

  def author_params
    params.require(:author).permit(:email, :last_name, :first_name, :password, :password_confirmation)
  end
