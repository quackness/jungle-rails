class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new(name: 'test')
    pp @category
  end

  def create
    @category = Category.new(product_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  
  end

  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end

end
