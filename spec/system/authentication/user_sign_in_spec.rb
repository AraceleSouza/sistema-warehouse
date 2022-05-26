require 'rails_helper'

describe 'User authenticates' do
  it 'successfully' do
    # Arrange
      User.create!(name: 'Aracele Souza', email: 'aracele@email.com', password: 'password')
    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'aracele@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    # Assert
    expect(page).to have_content 'Login efetuado com sucesso.'
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Aracele Souza - aracele@email.com'
    end
  end  

  it 'and logout' do
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
    click_on 'Sair'
    # Assert
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'Aracele Souza - aracele@email.com'
  end
end