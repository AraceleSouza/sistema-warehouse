require 'rails_helper'

describe 'User registers a supplier' do
  it 'from the menu' do
    # Arrange

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    # Assert
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('Razão Social')
    expect(page).to have_field('CNPJ')    
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('E-mail')

  end

  it 'successfully' do
    # Arrange

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome Fantasia', with: 'TECH VISION'
    fill_in 'Razão Social', with: 'World Technology Vision LTDA'
    fill_in 'CNPJ', with: '3447216000102'
    fill_in 'Endereço', with: 'Av das Flores, 500'
    fill_in 'Cidade', with: 'Cajamar'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'tech_vision@gmail.com'
    click_on 'Enviar'
    # Assert
    
    expect(page).to have_content('Fornecedor cadastrado com sucesso')
    expect(page).to have_content('World Technology Vision LTDA')
    expect(page).to have_content('CNPJ: 3447216000102')
    expect(page).to have_content('Endereço: Av das Flores, 500')
    expect(page).to have_content('E-mail: tech_vision@gmail.com')
    
  end

  it 'with incomplete data' do
    # Arrange

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'
    # Assert
    expect(page).to have_content 'Fornecedor não cadastrado'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
  end
end
