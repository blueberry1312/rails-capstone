class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @categories = Category.where(author_id: current_user.id)
    @title = 'Categories'
  end

  def show
    @category = Category.find(params[:id])
    @atransactions = AtransactionCategory.includes(:atransaction).where(category_id: params[:id]).map(&:atransaction)
      .sort_by(&:created_at).reverse
    @title = "#{@category.name} category"
  end

  def new
    @category = Category.new
    @title = 'New category'
  end

  def edit
    @title = 'Edit category'
  end

  def create
    @category = Category.new(author_id: current_user.id, **category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(author_id: current_user.id, **category_params)
        format.html { redirect_to category_url(@category), notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
