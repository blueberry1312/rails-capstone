require 'rails_helper'

RSpec.describe 'Category integration tests', type: :feature do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create!(name: 'user', email: 'user@gmail.com', password: 'password')

    @category = Category.create!(name: 'Food', icon: 'food_icon.webp', author_id: @user.id)
    @atransaction = Atransaction.create!(name: 'Transaction', amount: 100, author_id: @user.id)
    @atransaction_category = AtransactionCategory.create!(category_id: @category.id, atransaction_id: @atransaction.id)

    login_as(@user, scope: :user)
  end

  describe 'index page' do
    before { visit categories_path }

    it 'should display the title "Categories"' do
      expect(page).to have_content('Categories')
    end

    it 'should display the category name' do
      expect(page).to have_content(@category.name)
    end

    it 'should display the category icon' do
      expect(page).to have_selector('img')
    end
  end

  describe 'show page' do
    before { visit category_path(@category) }

    it 'should display the title of the category' do
      expect(page).to have_content("#{@category.name} category")
    end

    it 'should display the category name' do
      expect(page).to have_content(@category.name)
    end

    it 'should display the category icon' do
      expect(page).to have_selector('img')
    end

    it 'should display the atransaction name' do
      expect(page).to have_content(@atransaction.name)
    end

    it 'should display the atransaction amount' do
      expect(page).to have_content(@atransaction.amount)
    end

    it 'should display a button to edit the category' do
      expect(page).to have_link('Edit category')
    end

    it 'should display a button to delete the category' do
      expect(page).to have_button('Delete category')
    end

    it 'should display a button to create a new atransaction' do
      expect(page).to have_link('Add a new transaction')
    end
  end

  describe 'new page' do
    before { visit new_category_path }

    it 'should display the title "New category"' do
      expect(page).to have_content('New category')
    end

    it 'should display the category name field' do
      expect(page).to have_field('category_name')
    end

    it 'should display 6 category icon fields to select from' do
      expect(page).to have_field('category_icon_food_icon_webp')
      expect(page).to have_field('category_icon_clothing_icon_webp')
      expect(page).to have_field('category_icon_entertainment_icon_webp')
      expect(page).to have_field('category_icon_health_icon_webp')
      expect(page).to have_field('category_icon_education_icon_webp')
      expect(page).to have_field('category_icon_other_icon_webp')
    end

    it 'should display the img of the 6 icons' do
      expect(page).to have_selector('img', count: 6)
    end
  end

  describe 'edit page' do
    before { visit edit_category_path(@category) }

    it 'should display the title "Edit category"' do
      expect(page).to have_content('Edit category')
    end

    it 'should display the category name field' do
      expect(page).to have_field('category_name')
    end

    it 'should display 6 category icon fields to select from' do
      expect(page).to have_field('category_icon_food_icon_webp')
      expect(page).to have_field('category_icon_clothing_icon_webp')
      expect(page).to have_field('category_icon_entertainment_icon_webp')
      expect(page).to have_field('category_icon_health_icon_webp')
      expect(page).to have_field('category_icon_education_icon_webp')
      expect(page).to have_field('category_icon_other_icon_webp')
    end

    it 'should display the img of the 9 icons' do
      expect(page).to have_selector('img', count: 6)
    end
  end
end
