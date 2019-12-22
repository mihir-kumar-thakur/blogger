class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
    @pagy, @posts = pagy(Post.published)
  end
end
