require 'rails_helper'

RSpec.describe Atransaction, type: :model do
  before(:each) do
    @user = User.create(name: 'Testname', email: 'test@example.com', password: 'asdasd123')
    @atransaction = Atransaction.new(name: 'Example transaction', amount: 100, author_id: @user.id)
  end

  describe 'initialization' do
    it 'should be a transaction object' do
      expect(@atransaction).to be_a Atransaction
    end

    it 'should have attributes' do
      expect(@atransaction).to have_attributes(name: 'Example transaction', amount: 100, author_id: @user.id)
    end
  end

  describe 'validations' do
    before(:each) do
      expect(@atransaction).to be_valid
    end

    it 'should validate presence of name' do
      @atransaction.name = nil
      expect(@atransaction).not_to be_valid
    end

    it 'should validate length of name' do
      @atransaction.name = 'a'
      expect(@atransaction).not_to be_valid
      @atransaction.name = 'a' * 26
      expect(@atransaction).not_to be_valid
    end

    it 'should validate presence of amount' do
      @atransaction.amount = nil
      expect(@atransaction).not_to be_valid
    end

    it 'should validate numericality of amount' do
      @atransaction.amount = 'a'
      expect(@atransaction).not_to be_valid
      @atransaction.amount = -1
      expect(@atransaction).not_to be_valid
    end

    it 'should validate presence of author_id' do
      @atransaction.author_id = nil
      expect(@atransaction).not_to be_valid
    end
  end
end
