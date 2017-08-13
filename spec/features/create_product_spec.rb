require 'rails_helper'

RSpec.describe 'create product', type: :feature do
  it 'create product successfully' do
    visit root_path
    click_link 'New'
    expect(page).to have_content 'New Product'
    expect(page).to have_field 'Name'
    expect(page).to have_field 'Photo'
    fill_in 'Name', with: 'product name'
    attach_file stub_image
    click_button 'Create product'
    expect(page).to have_content 'create product successfully'
  end
end
