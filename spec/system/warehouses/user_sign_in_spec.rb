require 'rails_helper'

describe 'User authenticates' do
  it 'successfully' do
    # Arrange
      User.create!(email: 'aracele@email.com', password: 'password')
    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'aracele@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    # Assert
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_link 'Sair'
      expect(page).to have_content 'aracele@email.com'
    end
  end
end