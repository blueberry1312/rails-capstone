class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @transactions = Transaction.all
  end

  def show; end

  def new
    @category = Category.find(params[:category_id])

    if @category.author_id != current_user.id
      redirect_to categories_path, notice: 'You are not allowed to create transactions in this category'
    end

    @transaction = Transaction.new
    @title = 'New transaction'
  end

  def edit; end

  def create
    @transaction = Transaction.new(author_id: current_user.id, **transaction_params)

    respond_to do |format|
      if @transaction.save
        @transaction_category = TransactionCategory.create(category_id: params[:category_id],
                                                           transaction_id: @transaction.id)

        format.html do
          redirect_to category_path(params[:category_id]), notice: 'Transaction was successfully created.'
        end
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @transaction.update(author_id: current_user.id, **transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transactione was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:name, :amount)
  end
end
