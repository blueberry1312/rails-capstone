class AtransactionsController < ApplicationController
  before_action :set_atransaction, only: %i[show edit update destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @atransactions = Atransaction.all
  end

  def show; end

  def new
    @category = Category.find(params[:category_id])

    if @category.author_id != current_user.id
      redirect_to categories_path, notice: 'You are not allowed to create transactions in this category'
    end

    @atransaction = Atransaction.new
    @title = 'New transaction'
  end

  def edit; end

  def create
    @atransaction = Atransaction.new(author_id: current_user.id, **atransaction_params)

    respond_to do |format|
      if @atransaction.save
        @atransaction_category = AtransactionCategory.create(category_id: params[:category_id],
                                                             atransaction_id: @atransaction.id)

        format.html do
          redirect_to category_path(params[:category_id]), notice: 'Transaction was successfully created.'
        end
        format.json { render :show, status: :created, location: @atransaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @atransaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @atransaction.update(author_id: current_user.id, **atransaction_params)
        format.html { redirect_to category_path(params[:category_id]), notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @atransaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @atransaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @atransaction.destroy

    respond_to do |format|
      format.html { redirect_to category_path(params[:category_id]), notice: 'Transaction was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_atransaction
    @atransaction = Atransaction.find_by(id: params[:id])
    return if @atransaction

    redirect_to category_path(params[:category_id]), notice: 'Transaction not found.'
  end

  def atransaction_params
    params.require(:atransaction).permit(:name, :amount, category_ids: [])
  end
end
