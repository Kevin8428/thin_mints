class ArticlesController < ApplicationController
  include MeteredAccessHelper
  
  before_filter :end_of_meter

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])

    build_meter_cookie
  end
end
