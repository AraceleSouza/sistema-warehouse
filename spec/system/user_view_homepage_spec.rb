require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it 'e vê nome da app' do
    # Arrange

    # Act
    visit('/')

    # Assert
    expect(page).to have_content('Galpões & Estoque')
  end
end