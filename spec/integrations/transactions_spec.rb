require 'rails_helper'

RSpec.describe 'Transactions integration tests', type: :feature do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create!(name: 'user', email: 'user@gmail.com', password: 'password')
    @category = Category.create!(name: 'Mc Donalds', icon: 'food_icon.webp', author_id: @user.id)

    login_as(@user, scope: :user)
  end

  describe 'new page' do
    before { visit new_category_atransaction_path(@category) }

    it 'should display the title "New transaction"' do
      expect(page).to have_content('New transaction')
    end

    it 'should display a form to create a new transaction' do
      expect(page).to have_selector('form')
    end
  end
end