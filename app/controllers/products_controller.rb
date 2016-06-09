class ProductsController < ApplicationController
	def index
		@products = Product.joins("LEFT JOIN 'categories' ON categories.id = products.category_id").select('products.*, categories.name AS cat')
	end

	def show
		@product = Product.joins("LEFT JOIN 'categories' ON categories.id = products.category_id").select('products.*, categories.name AS cat').find(params[:id])
		@comment = Comment.new
		@comments = Product.find(params[:id]).comments
	end

	def new
		@product = Product.new
	end

	def edit
		@product = Product.new
		@p = Product.joins("LEFT JOIN 'categories' ON categories.id = products.category_id").select('products.*, categories.name AS cat').find(params[:id])

	end

	def create
		@product = Product.create(product_params)
		if @product.save
			flash[:created] = "Your product has been created."
			redirect_to '/'
		else
			flash[:errors] = @product.errors.full_messages
			redirect_to 'products/new'
		end
	end

	def update
		@product = Product.find(params[:id])
		if @product.update(product_params)
			flash[:updated] = "Your product has been updated."
			redirect_to '/'
		else
			flash[:errors] = @product.errors.full_messages
			redirect_to '/products/#{@product.id}/edit'
		end
	end

	def destroy
		@products = Product.find(params[:id])

		if @product.destroy
			redirect_to '/'
		else
			flash[:errors] = "There was a problem."
			redirect_to '/'
		end
	end

	private
	def product_params
  		params.require(:product).permit(:name, :description, :pricing, :category_id)
	end
end
