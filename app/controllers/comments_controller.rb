class CommentsController < ApplicationController
  def index
  	@comments = Comment.joins(:product).select('comments.comment, products.name AS product_name')
  end

  def new
  	@comment = Comment.new
  end

  def create
  	@c = params[:comment]
  	@id = @c[:id].to_i
  	@comment = Comment.create(comment: @c[:comment], Product_id: @id)
    redirect_to '/products/' + params[:comment][:id]
  end
end